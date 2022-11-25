local replacer = {}
replacer.blacklist = {}
-- Black list example
-- replacer.blacklist["tnt:boom"] = true

minetest.register_tool("tools:replacer", {
    description = "Node replacement tool",
    inventory_image = "tools_replacer.png",
    stack_max = 1, -- it has to store information - thus only one can be stacked
    liquids_pointable = true, -- it is ok to paint in/with water
    node_placement_prediction = nil,
    metadata = "blocks:dirt", -- default replacement: common dirt
    on_place = function(itemstack, placer, pointed_thing)
        if (placer == nil or pointed_thing == nil) then
            return itemstack -- nothing consumed
        end
        local name = placer:get_player_name()
        if (pointed_thing.type ~= "node") then
            ccore.notify(name, "  Error: No node selected.");
            return nil;
        end
        local mode = replacer.get_mode(placer)
        local keys = placer:get_player_control()
        if mode == "legacy" then
            if (not (keys["sneak"])) then
                return replacer.replace(itemstack, placer, pointed_thing, 0);
            end
            local pos = minetest.get_pointed_thing_position(pointed_thing, false);
            local node = minetest.get_node_or_nil(pos);
            local metadata = "blocks:dirt 0 0";
            if (node ~= nil and node.name) then
                metadata = node.name .. ' ' .. node.param1 .. ' ' .. node.param2;
            end
            itemstack:set_metadata(metadata);
            ccore.notify(name, "Node replacement tool set to: '" .. metadata .. "'.");
            return itemstack; -- nothing consumed but data changed
        end
        -- just place the stored node if now new one is to be selected
        if (not (keys["sneak"])) then
            return replacer.replace(itemstack, placer, pointed_thing, 0)
        else
            return replacer.replace(itemstack, placer, pointed_thing, false)
        end
    end,
    on_use = function(itemstack, user, pointed_thing)
        local name = user:get_player_name()
        local keys = user:get_player_control()
        local mode = replacer.get_mode(user)
        if (pointed_thing.type ~= "node") then
            ccore.notify(name, "  Error: No node selected.")
            return nil
        end
        if mode == "legacy" then
            return replacer.replace(itemstack, user, pointed_thing, false);
        end
        if (keys["sneak"]) then
            local pos = minetest.get_pointed_thing_position(pointed_thing, false)
            local node = minetest.get_node_or_nil(pos)
            local metadata = "blocks:dirt 0 0"
            if (node ~= nil and node.name) then
                metadata = node.name .. ' ' .. node.param1 .. ' ' .. node.param2
            end
            itemstack:set_metadata(metadata)

            ccore.notify(name, "Node replacement tool set to: '" .. metadata .. "'.")

            return itemstack -- nothing consumed but data changed
        else
            return replacer.replace(itemstack, user, pointed_thing, false)
        end
    end
})

replacer.replace = function(itemstack, user, pointed_thing, mode)
    if (user == nil or pointed_thing == nil) then
        return nil
    end
    local name = user:get_player_name()
    if (pointed_thing.type ~= "node") then
        ccore.notify(name, "  Error: No node.")
        return nil
    end

    local pos = minetest.get_pointed_thing_position(pointed_thing, mode)
    local node = minetest.get_node_or_nil(pos)
    if (node == nil) then
        ccore.notify(name, "Error: Target node not yet loaded. Please wait a moment for the server to catch up.")
        return nil
    end

    local item = itemstack:to_table()
    -- make sure it is defined
    if (not (item["metadata"]) or item["metadata"] == "") then
        item["metadata"] = "blocks:dirt 0 0"
    end
    -- regain information about nodename, param1 and param2
    local daten = item["metadata"]:split(" ")
    -- the old format stored only the node name
    if (#daten < 3) then
        daten[2] = "0"
        daten[3] = "0"
    end
    -- if someone else owns that node then we can not change it
    if replacer.node_is_owned(pos, user) then
        return nil
    end
    if (node.name and node.name ~= "" and replacer.blacklist[node.name]) then
        ccore.notify(name, "Replacing blocks of the type '" .. (node.name or "?") ..
            "' is not allowed. Replacement failed.")
        return nil
    end
    if (replacer.blacklist[daten[1]]) then
        ccore.notify(name, "Placing blocks of the type '" .. (daten[1] or "?") ..
            "' with the replacer is not allowed. Replacement failed.")
        return nil
    end
    -- Place innactive crafting stations when active ones are selected.
    if (daten[1]:find("_active") ~= nil) then
        daten[1] = daten[1]:gsub("_active", "")
        item["metadata"] = daten[1] .. " " .. daten[2] .. " " .. daten[3]
    end
    -- Do not replace if there is nothing to be done
    if (node.name == daten[1]) then
        -- the node itshelf remains the same, but the orientation was changed
        if (node.param1 == daten[2] and node.param2 == daten[3]) then
            return nil
        end
    end
    -- Do not replace node that has inventory that is not empty
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local inv_lists = inv:get_lists()
    for listname, inv_list in pairs(inv_lists) do
        if (inv:is_empty(listname) == false) then
            ccore.notify(name,
                "Replacing a node containing items in inventory is not allowed. Replacement failed"
            )
                return nil
        end
    end
    -- in survival mode, the player has to provide the node he wants to place
    if (not (minetest.settings:get_bool("creative_mode")) and not (minetest.check_player_privs(name, {
        creative = true
    }))) then
        -- players usually don't carry dirt_with_grass around it's safe to assume normal dirt here
        -- fortunately, dirt and dirt_with_grass does not make use of rotation
        if (
            daten[1] == "blocks:dirt_with_grass"
            or daten[1] == "blocks:dirt_with_grass_footsteps"
            or daten[1] == "blocks:dirt_with_dry_grass"
            or daten[1] == "blocks:dirt_with_rainforest_litter"
            or daten[1] == "blocks:dirt_with_coniferous_litter"
            or daten[1] == "blocks:dirt_with_snow"
            or daten[1] == "blocks:dirt_with_grass_sfcave"
        ) then
            daten[1] = "blocks:dirt"
            item["metadata"] = "blocks:dirt 0 0"
        elseif (daten[1] == "blocks:dry_dirt_with_dry_grass"
            or daten[1] == "blocks:dry_dirt_with_dry_grass_sfcave"
        ) then
            daten[1] = "blocks:dry_dirt"
            item["metadata"] = "blocks:dry_dirt 0 0"
        elseif (daten[1] == "blocks:chalk_with_grass") then
            daten[1] = "blocks:chalk"
            item["metadata"] = "blocks:chalk 0 0"
        elseif (
            daten[1] == "blocks:permafrost_with_moss"
            or daten[1] == "blocks:permafrost_with_snow"
            or daten[1] == "blocks:permafrost_with_bone_roots"
            or daten[1] == "blocks:permafrost_with_stones"
        ) then
            daten[1] = "blocks:permafrost"
            item["metadata"] = "blocks:permafrost 0 0"
        elseif (
            daten[1] == "blocks:cave_ice"
            or daten[1] == "blocks:cracked_ice"
        ) then
            daten[1] = "blocks:ice"
            item["metadata"] = "blocks:ice 0 0"
        end
        --does the player carry at least one of the desired nodes with him?
        if (not (user:get_inventory():contains_item("main", daten[1]))) then
            ccore.notify(name, "You have no further '" .. (daten[1] or "?") .. "'. Replacement failed.")
            return nil
        end
        -- give the player the item by simulating digging if possible
        if (node.name ~= "air" and node.name ~= "ignore" and node.name ~= "blocks:lava_source" and node.name ~=
            "blocks:lava_flowing" and node.name ~= "blocks:river_water_source" and node.name ~=
            "blocks:river_water_flowing" and node.name ~= "blocks:water_source" and node.name ~=
            "blocks:water_flowing") then
            minetest.node_dig(pos, node, user)
            local digged_node = minetest.get_node_or_nil(pos)
            if (not (digged_node) or digged_node.name == node.name) then
                ccore.notify(name, "Replacing '" .. (node.name or "air") .. "' with '" .. (item["metadata"] or "?") ..
                    "' failed.\nUnable to remove old node.")
                return nil
            end
        end
        -- consume the item
        user:get_inventory():remove_item("main", daten[1] .. " 1")
    end

    minetest.add_node(pos, {
        name = daten[1],
        param1 = daten[2],
        param2 = daten[3]
    })
    -- Handle after_place_node such as for handling node metadata.
    if (minetest.registered_nodes[daten[1]].after_place_node ~= nil) then
        minetest.registered_nodes[daten[1]].after_place_node(pos, user, itemstack, pointed_thing)
    end
    return nil -- no item shall be removed from inventory
end
-- protection checking from Vanessa Ezekowitz' homedecor mod
replacer.node_is_owned = function(pos, placer)
    if (not (placer) or not (pos)) then
        return true
    end
    local pname = placer:get_player_name()
    if (type(minetest.is_protected) == "function") then
        local res = minetest.is_protected(pos, pname)
        if (res) then
            ccore.notify(pname, "Cannot replace node. It is protected.")
        end
        return res
    end
    return false
end

-- Handle mode setting/getting
replacer.set_mode = function(player, mode_name)
    if mode_name ~= "legacy" and mode_name ~= "paint" then
        return ccore.notify(player:get_player_name(), "Invalid replacer mode!")
    end
    local meta = player:get_meta()
    meta:set_string('tools:replacer_mode', mode_name)
    ccore.notify(player:get_player_name(), "Replacer set to " .. mode_name .. " mode.")
end

replacer.get_mode = function(player)
    local meta = player:get_meta()
    local mode_name = meta:get_string("tools:replacer_mode")
    if mode_name == nil then
        mode_name = "paint"
        replacer.set_mode(player, mode_name)
    end
    return mode_name
end

-- Chat command to set mode
minetest.register_chatcommand("replacer_mode", {
    params = "<mode_name>",
    description = "Sets replacer mode. Modes include 'legacy' or 'paint'",
    func = function(name, param)
        if param ~= "legacy" and param ~= "paint" then
            return minetest.chat_send_player(name, "Invalid replacer mode: 'legacy' or 'paint'")
        end
        replacer.set_mode(minetest.get_player_by_name(name), param)
    end
})

-- Crafting
minetest.register_craft({
    output = 'tools:replacer',
    recipe = {{'blocks:chest', '', ''}, {'', 'blocks:stick', ''}, {'', '', 'blocks:chest'}}
})

