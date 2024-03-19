protection.protector = {}
protection.protector_markers = {}

local function protector_formspec_tab(pos, name)
    local meta = minetest.get_meta(pos)
    local block_data = protection.get_grid_block(pos)
    local protection_cost = protection.calculate_cost(block_data.pos1, block_data.pos2)
    local area_surface = protection.calculate_surface(block_data.pos1, block_data.pos2)
    local area_volume = protection.calculate_volume(block_data.pos1, block_data.pos2)
    local areas_at_pos = {}
    local selected_area_id = tonumber(meta:get_string("selected_area_id"))
    local area_label_padding = 0.25
    local area_label_pos = 4.0
    local area_count = 0
    for _,area in pairs(areas:getAreasAtPos(pos)) do
        area_count = area_count + 1
        if (area_count < 6) then
            local area_label_y = area_label_pos + area_label_padding * area_count
            table.insert_all(areas_at_pos, {"label[0.5," .. area_label_y .. ";" ..  minetest.colorize(protection.area_color, area.name) ..
                                            " (" ..  minetest.colorize(protection.name_color, area.owner) .. ")]"})
        end
    end
    if #areas_at_pos > 0 then
        areas_at_pos = table.concat(areas_at_pos, "")
    else
        areas_at_pos  = "label[0.5," .. area_label_pos + area_label_padding .. ";" .. minetest.colorize(protection.dim_color, "None") .. "]"
    end
    local protection_cost_label = ""
    local protection_input = ""
    if selected_area_id == nil then
        protection_cost_label = "label[0.25,3.5;Protection cost: " ..  minetest.colorize(protection.price_color, protection_cost .. " lost mese") .. "]"
        protection_input = "field[0.25,7.0;7.0,0.5;protect;Protect this block as:;]"
    end
    local selected_tab = meta:get_string("tab")
    local tab_switches = table.concat({
        "style[" .. selected_tab .. ";bgcolor=#AAAAAA]",
        "image_button[6.5,0.25;1.0,1.0;blocks_book.png^[hsl:0:-100:0;info;]",
        "tooltip[info;Block Area Info]",
        "image_button[6.5,1.5;1.0,1.0;gui_cube.png;edit;]",
        "tooltip[edit;Edit Block Area]"
    }, "")
    local info_tab = table.concat({
        "style_type[label;font_size=16]",
        "label[0.25,0.75;Block area location (center): " .. minetest.colorize(protection.protection_color, block_data.center.x .. "," .. block_data.center.y .. "," .. block_data.center.z) .. "]",
        "label[0.25,1.5;Corner 1: " .. minetest.colorize(protection.protection_color, block_data.pos1.x .. "," .. block_data.pos1.y .. ","  .. block_data.pos1.z) .. "]",
        "label[0.25,2.0;Corner 2: " .. minetest.colorize(protection.protection_color, block_data.pos2.x .. "," .. block_data.pos2.y .. ","  .. block_data.pos2.z) .. "]",
        "label[0.25,2.5;Area surface: " .. minetest.colorize(protection.warning_color, area_surface .. " nodes") .. "]",
        "label[0.25,3.0;Area volume: " .. minetest.colorize(protection.warning_color, area_volume .. " nodes") .. "]",
        protection_cost_label,
        "label[0.25,4.0;Areas in this block:]",
        "button[2.25,5.75;3.0,0.75;grid_toggle;Toggle protector grid]",
        areas_at_pos,
        protection_input,
        tab_switches
    }, "")
    local area_open_status = minetest.colorize(protection.dim_color, "Undefined")
    local selected_area_name = minetest.colorize(protection.dim_color, "No area selected.")
    if selected_area_id ~= nil then
        if (areas.areas[selected_area_id].open) then
            area_open_status = minetest.colorize(protection.true_color, "Open")
        else
            area_open_status = minetest.colorize(protection.dim_color, "Closed")
        end
        selected_area_name = minetest.colorize(protection.area_color, areas.areas[selected_area_id].name)
    end
    local edit_tab = table.concat({
        "style_type[label,button;font_size=16]",
        "label[0.25,0.25;Selected Area: " ..  minetest.colorize(protection.area_color, selected_area_name) .. "]",
        "field[0.25,1.0;5.0,0.5;select_area;Select other " .. minetest.colorize(protection.protection_color, "ID") .. " in this block:;]",
        "field_close_on_enter[select_area;false]",
        "field[0.25,2.0;5.0,0.5;add_owner;Add " .. minetest.colorize(protection.name_color, "owner") .. ":;]",
        "field_close_on_enter[add_owner;false]",
        "field[0.25,3.0;5.0,0.5;rename;Rename " .. minetest.colorize(protection.area_color, "area") .. " to:;]",
        "field_close_on_enter[rename;false]",
        "field[0.25,4.0;5.0,0.5;change_owner;Change " .. minetest.colorize(protection.name_color, "owner") .. " to:;]",
        "field_close_on_enter[change_owner;false]",
        "button[1.75,5.25;4.5,0.5;open_toggle;Area interact status: " .. area_open_status .. "]",
        tab_switches
    }, "")
    local tab = {}
    if selected_tab == "info" then
        tab = info_tab
    elseif selected_tab == "edit" then
        tab = edit_tab
    end
    return tab
end

local function protector_formspec(pos, player, add)
	local spos = pos.x..","..pos.y..","..pos.z
    local playername = player:get_player_name()
	local winv_listring = ""
    local right_inv = winv.get_inventory(player, "right")
    if right_inv == "player" then
        winv_listring =
            "listring[current_player;main]"..
            "listring[nodemeta:"..spos..";input]"..
            "listring[current_player;main]"..
            "listring[nodemeta:"..spos..";output]"
    elseif right_inv == "crafting" then
        winv_listring =
            "listring[nodemeta:"..spos..";input]"..
            "listring[detached:winv_craft_"..playername..";input]"..
            "listring[nodemeta:"..spos..";input]"..
            "listring[nodemeta:"..spos..";output]"..
            "listring[detached:winv_craft_"..playername..";input]"..
            "listring[detached:winv_craft_"..playername..";output]"
    elseif right_inv == "craftguide" then
        winv_listring =
            "listring[detached:winv_creative_"..playername..";main]"..
            "listring[nodemeta:"..spos..";input]"..
            "listring[detached:trash;main]"..
            "listring[nodemeta:"..spos..";output]"..
            "listring[detached:trash;main]"
    end
    local selected_tab = protector_formspec_tab(pos, playername)
	local winv_formspec = {
		"image[0,0;7.75,7.75;winv_bg.png]",
        selected_tab,
		winv_listring,
		add
	}
	return winv.init_inventory(player, table.concat(winv_formspec, ""))
end

local function protector_show_formspec(pos, player, add)
	local playername = player:get_player_name()
	minetest.show_formspec(playername, "protection:protector", protector_formspec(pos, player, add))
end

local function protector_on_construct(pos)
	local meta = minetest.get_meta(pos)
	meta:set_string("owner", "")
end

local function protector_after_place_node(pos, placer, itemstack, pointed_thing)
	local meta = minetest.get_meta(pos)
	local playername = placer:get_player_name()
    local block_data = protection.get_grid_block(pos)
    local block_area = protection.find_block_area(pos)
    local owned_block_area = protection.find_block_area(pos, playername)
	meta:set_string("owner", playername)
    meta:set_string("tab", "info")
    meta:set_string("selected_area_id", owned_block_area.id)
    meta:set_string("infotext", minetest.colorize(protection.protection_color, "Protector Station") ..
                    "\nBlock area: " .. minetest.colorize(protection.protection_color, block_data.center.x .. "," .. block_data.center.y .. "," .. block_data.center.z) ..
                    "\nOwner: " .. minetest.colorize(protection.name_color, block_area.owner) ..
                    "\nName: " .. minetest.colorize(protection.area_color, block_area.name))
end

local function update_infotext(pos, area_id)
    local meta = minetest.get_meta(pos)
    local block_data = protection.get_grid_block(pos)
    local block_area = protection.find_block_area(pos)
    meta:set_string("infotext", minetest.colorize(protection.protection_color, "Protector Station") ..
                    "\nBlock area: " .. minetest.colorize(protection.protection_color, block_data.center.x .. "," .. block_data.center.y .. "," .. block_data.center.z) ..
                    "\nOwner: " .. minetest.colorize(protection.name_color, block_area.owner) ..
                    "\nName: " .. minetest.colorize(protection.area_color, block_area.name))
end

function protection.area_compare_pos(area1, area2)
    if protection.pos_compare(area1.pos1, area2.pos1) and protection.pos_compare(area1.pos2, area2.pos2) then
        return true
    elseif protection.pos_compare(area1.pos1, area2.pos2) and protection.pos_compare(area1.pos2, area2.pos1) then
        return true
    end
    return false
end

local function area_is_block(pos, area_id)
    local block_data = protection.get_grid_block(pos)
    local area_data = areas.areas[area_id]
    return protection.area_compare_pos(area_data, block_data)
end

local function protect_block(pos, name, area_name, parent_id)
    local block_data = protection.get_grid_block(pos)
    local protection_possible, error_msg = areas:canPlayerAddArea(block_data.pos1, block_data.pos2, name)
    local area_id = ""
    if protection_possible then
        area_id = areas:add(name, area_name, block_data.pos1, block_data.pos2, parent_id)
		areas:save()
    else
        minetest.chat_send_player(name, protection.chat_message("protector", "error", "Failed to protect block area, " .. error_msg))
    end
    return area_id
end


local function protector_place_grid(pos, playername)
    local block_data = protection.get_grid_block(pos)
    local cpos = {}
    cpos[1] = {x = block_data.pos1.x, y =  block_data.pos1.y, z = block_data.pos1.z}
    cpos[2] = {x = block_data.pos1.x, y =  block_data.pos1.y, z = block_data.pos2.z}
    cpos[3] = {x = block_data.pos2.x, y =  block_data.pos1.y, z = block_data.pos1.z}
    cpos[4] = {x = block_data.pos2.x, y =  block_data.pos1.y, z = block_data.pos2.z}
    cpos[5] = {x = block_data.pos1.x, y =  block_data.pos2.y, z = block_data.pos1.z}
    cpos[6] = {x = block_data.pos1.x, y =  block_data.pos2.y, z = block_data.pos2.z}
    cpos[7] = {x = block_data.pos2.x, y =  block_data.pos2.y, z = block_data.pos1.z}
    cpos[8] = {x = block_data.pos2.x, y =  block_data.pos2.y, z = block_data.pos2.z}

    local epos = {}

    epos[1] = {x = block_data.pos1.x - 0.5, y = (block_data.pos1.y + block_data.pos2.y) / 2, z = (block_data.pos1.z + block_data.pos2.z) / 2}
    epos[2] = {x = block_data.pos2.x + 0.5, y =  (block_data.pos1.y + block_data.pos2.y) / 2, z = (block_data.pos1.z + block_data.pos2.z) / 2}
    epos[3] = {x = (block_data.pos1.x + block_data.pos2.x) / 2, y =  (block_data.pos1.y + block_data.pos2.y) / 2, z = block_data.pos1.z - 0.5}
    epos[4] = {x = (block_data.pos1.x + block_data.pos2.x) / 2, y =  (block_data.pos1.y + block_data.pos2.y) / 2, z = block_data.pos2.z + 0.5}

    local xz_side_length = protection.grid_xz + 1
    local y_side_length = protection.grid_y + 1
    local thickness = 0.1

    if protection.protector_markers[playername] ~= nil then
        for i=1,8 do
            if protection.protector_markers[playername]["corner" .. i] ~= nil then
                protection.protector_markers[playername]["corner" .. i]:remove()
                protection.protector_markers[playername]["corner" .. i] = nil
            end
        end
        for i=1,4 do
            if protection.protector_markers[playername]["edge" .. i] ~= nil then
                protection.protector_markers[playername]["edge" .. i]:remove()
                protection.protector_markers[playername]["edge" .. i] = nil
            end
        end
    else
        protection.protector_markers[playername] = {}
    end

    for i=1,8 do
        protection.protector_markers[playername]["corner" .. i] = minetest.add_entity(cpos[i], "protection:pos")

        if protection.protector_markers[playername]["corner" .. i] ~= nil then
            protection.protector_markers[playername]["corner" .. i]:get_luaentity().player_name = playername
        end
    end
    for i=1,2 do
        protection.protector_markers[playername]["edge" .. i] = minetest.add_entity(epos[i], "protection:protector_edge")
        if protection.protector_markers[playername]["edge" .. i] ~= nil then
            protection.protector_markers[playername]["edge" .. i]:set_properties({
                visual_size = {x = xz_side_length, y = y_side_length},
                collisionbox = {-thickness, -y_side_length / 2, -xz_side_length / 2, thickness, y_side_length / 2, xz_side_length / 2}
            })
            protection.protector_markers[playername]["edge" .. i]:set_yaw(math.pi / 2)
            protection.protector_markers[playername]["edge" .. i]:get_luaentity().player_name = playername
        end
    end
    for i=3,4 do
        protection.protector_markers[playername]["edge" .. i] = minetest.add_entity(epos[i], "protection:protector_edge")
        if protection.protector_markers[playername]["edge" .. i] ~= nil then
            protection.protector_markers[playername]["edge" .. i]:set_properties({
                visual_size = {x = xz_side_length, y = y_side_length},
                collisionbox = {-xz_side_length / 2, -y_side_length / 2, -thickness, xz_side_length / 2, y_side_length / 2, thickness}
            })
            protection.protector_markers[playername]["edge" .. i]:get_luaentity().player_name = playername
        end
    end
end

local function protector_remove_grid(name)
    local grid = protection.protector_markers[name]

    if not grid then
        return
    end

    for i=1,8 do
        grid["corner"..i]:remove()
    end

    for i=1,4 do
        grid["edge"..i]:remove()
    end

    protection.protector_markers[name] = nil
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "protection:protector" or not player then
		return
	end
	local playername = player:get_player_name()
	local pos = protection.protector[playername]
	local meta = minetest.get_meta(pos)
    local selected_area_id = tonumber(meta:get_string("selected_area_id"))
    local block_data = protection.get_grid_block(pos)

    if fields.key_enter_field == "protect" then
        local mese_cost = protection.calculate_cost(block_data.pos1, block_data.pos2)
        if protection.take_mese(player, mese_cost) ~= false then
            local area_name = fields.protect
            local can_add,aerror = areas:canPlayerAddArea(block_data.pos1, block_data.pos2, playername)
            if can_add then
                local area_id = protect_block(pos, playername, area_name)
                meta:set_string("selected_area_id", area_id)
                update_infotext(pos, area_id)
                minetest.log("action", "Protector protected an area, owner="..playername..
				" AreaName="..area_name..
				" StartPos="..minetest.pos_to_string(block_data.pos1)..
				" EndPos="  ..minetest.pos_to_string(block_data.pos2))
                minetest.chat_send_player(playername, protection.chat_message("protector", "success", "Succesfully protected block area " ..
                                            minetest.colorize(protection.area_color, area_name) ..
                                            " at the cost of " .. minetest.colorize(protection.price_color, mese_cost .. " lost mese") .. "."))
            else
                minetest.chat_send_player(playername, protection.chat_message("protector", "error", "Could not protect block area, " .. aerror .. "."))
            end
        else
            minetest.chat_send_player(playername, protection.chat_message("protector", "note", "Insufficient funds."))
        end
        protector_show_formspec(pos, player)
    end

    if fields.grid_toggle ~= nil then
        if protection.protector_markers[playername] == nil then
            protector_place_grid(pos, playername)
        else
            protector_remove_grid(playername)
        end
    end

    if fields.key_enter_field == "select_area" then
        local area_id = tonumber(fields.select_area)
        if areas:isAreaOwner(area_id, playername) then
            if area_is_block(pos, area_id) then
                meta:set_string("selected_area_id", area_id)
                update_infotext(pos, area_id)
                protector_show_formspec(pos, player)
            else
                minetest.chat_send_player(playername, protection.chat_message("protector", "error", "That area does not belong to this block."))
            end
        else
            minetest.chat_send_player(playername, protection.chat_message("protector", "error", "You do not own that area."))
        end
    end

    if fields.key_enter_field == "add_owner" then
        if selected_area_id ~= nil then
            local new_owner = fields.add_owner
            if areas:player_exists(new_owner) then
                local selected_name = areas.areas[selected_area_id].name
                protect_block(pos, new_owner, selected_name, selected_area_id)
                update_infotext(pos, selected_area_id)
                minetest.log("action", "Protector added owner, owner=".. new_owner ..
				" AreaName="..selected_name..
				" StartPos="..minetest.pos_to_string(block_data.pos1)..
				" EndPos="  ..minetest.pos_to_string(block_data.pos2))
                protector_show_formspec(pos, player)
            else
                minetest.chat_send_player(playername, protection.chat_message("protector", "error", "Invalid player name.", "Possibly a typing mistake."))
            end
        else
            minetest.chat_send_player(playername, protection.chat_message("protector", "error", "No block area selected."))
        end
    end

    if fields.key_enter_field == "change_owner" then
        if selected_area_id ~= nil then
            local new_owner = fields.change_owner
            if areas:player_exists(new_owner) then
                local selected_name = areas.areas[selected_area_id].name
                areas.areas[selected_area_id].owner = new_owner
                areas:save()
                minetest.log("action", "Protector changed owner, owner=".. new_owner ..
				" AreaName="..selected_name..
				" StartPos="..minetest.pos_to_string(block_data.pos1)..
				" EndPos="  ..minetest.pos_to_string(block_data.pos2))
                minetest.chat_send_player(playername, protection.chat_message("protector", "success", "Block area " ..
                                            minetest.colorize(protection.area_color, selected_name) .. " is now owned by " ..
                                            minetest.colorize(protection.name_color, new_owner) .. "."))
                update_infotext(pos, selected_area_id)
                protector_show_formspec(pos, player)
            else
                minetest.chat_send_player(playername, protection.chat_message("protector", "error", "Invalid player name.", "Possibly a typing mistake."))
            end
        else
            minetest.chat_send_player(playername, protection.chat_message("protector", "error", "No block area selected."))
        end
    end

    if fields.key_enter_field == "rename" then
        if selected_area_id ~= nil then
            local new_name = fields.rename
            local old_name = areas.areas[selected_area_id].name
            areas.areas[selected_area_id].name = new_name
            areas:save()
            minetest.log("action", "Protector renamed area, id=" .. selected_area_id .. " old name=".. old_name ..
            " new name="..new_name)
            minetest.chat_send_player(playername, protection.chat_message("protector", "success", "Renamed area " ..
                                        minetest.colorize(protection.area_color, old_name) .. " to " ..
                                        minetest.colorize(protection.area_color, new_name) .. "."))
            update_infotext(pos, selected_area_id)
            protector_show_formspec(pos, player)
        else
            minetest.chat_send_player(playername, protection.chat_message("protector", "error", "No block area selected."))
        end
    end

    if fields.open_toggle ~= nil then
        if selected_area_id ~= nil then
            local open = not areas.areas[selected_area_id].open
            -- Save false as nil just like in the original areas chatcommand code
            areas.areas[selected_area_id].open = open or nil
            areas:save()
            protector_show_formspec(pos, player)
        end
    end

    if fields.info ~= nil then
        meta:set_string("tab", "info")
        protector_show_formspec(pos, player)
    end

    if fields.edit ~= nil then
        meta:set_string("tab", "edit")
        protector_show_formspec(pos, player)
    end

	if not fields.quit then
		winv.node_receive_fields(player, formname, fields)
		if winv.node_refresh(player) then
			protector_show_formspec(pos, player)
		end
	end
end)

minetest.register_node("protection:protector", {
    description = ccore.comment("Protector Station", "Protects based on a fixed grid of " .. protection.grid_xz .. "x" .. protection.grid_y .. "x" .. protection.grid_xz),
    drawtype = "mesh",
    mesh = "protector.obj",
    tiles = {"variations_steelblock.png^[sheet:3x3:1,0", "variations_wood.png^[sheet:3x3:1,0", "protection_protector.png"},
    groups = {dig_immediate = 3},
    selection_box = {
        type = "fixed",
        fixed = {-9/16, -8/16, -9/16, 9/16, 14/16, 9/16},
    },
    collision_box = {
        type = "fixed",
        fixed = {-9/16, -8/16, -9/16, 9/16, 14/16, 9/16},
    },
    paramtype = "light",
    paramtype2 = "facedir",
	sounds = default.node_sound_stone_defaults(),
    can_dig = function(pos, player)
        local meta = minetest.get_meta(pos)
        if (player:get_player_name() == meta:get_string("owner")) then
            return true
        else
            minetest.chat_send_player(player:get_player_name(), protection.chat_message("protector", "note", "Only the owner can remove a protector station.", "Maybe try asking them?"))
            return false
        end
    end,
    on_dig = function(pos, node, digger)
        local playername = digger:get_player_name()
        if protection.protector_markers[playername] ~= nil then
            protector_remove_grid(playername)
        end
        minetest.node_dig(pos, node, digger)
    end,
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local name = clicker:get_player_name()
        local meta = minetest.get_meta(pos)
        if (name == meta:get_string("owner")) then
            protection.protector[name] = pos
            protector_show_formspec(pos, clicker)
        else
            minetest.chat_send_player(name, protection.chat_message("protector", "note", "Only the owner can interact with a protector block."))
            return itemstack
        end
    end,
    on_construct = protector_on_construct,
	after_place_node = protector_after_place_node,
})