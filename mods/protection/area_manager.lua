protection.area_manager = {}
protection.area_markers = {}

local function area_manager_formspec_tab(pos, name)
    local meta = minetest.get_meta(pos)
    local selected_area_id = tonumber(meta:get_string("selected_area_id"))
    local area_data = areas.areas[selected_area_id]
    local area_surface = protection.calculate_surface(area_data.pos1, area_data.pos2)
    local area_volume = protection.calculate_volume(area_data.pos1, area_data.pos2)
    local areas_at_pos = {}
    local area_label_padding = 0.25
    local area_label_pos = 4.0
    local area_count = 0
    for _,area in pairs(areas:getAreasAtPos(pos)) do
        area_count = area_count + 1
        if (area_count < 6) then
            local area_label_y = area_label_pos + area_label_padding * area_count
            table.insert_all(areas_at_pos, {"label[0.5," .. area_label_y .. ";" .. minetest.colorize(protection.area_color, area.name) ..
                                            " (" ..  minetest.colorize(protection.name_color, area.owner) .. ")]"})
        end
    end
    if #areas_at_pos > 0 then
        areas_at_pos = table.concat(areas_at_pos, "")
    else
        areas_at_pos  = "label[0.5," .. area_label_pos + area_label_padding .. ";None]"
    end
    local selected_tab = meta:get_string("tab")
    local tab_switches = table.concat({
        "style[" .. selected_tab .. ";bgcolor=#AAAAAA]",
        "image_button[6.5,0.25;1.0,1.0;blocks_book.png^[hsl:0:-100:0;info;]",
        "tooltip[info;Area Info]",
        "image_button[6.5,1.5;1.0,1.0;gui_cube.png;edit;]",
        "tooltip[edit;Edit Area]"
    }, "")
    local info_tab = table.concat({
        "style_type[label;font_size=16]",
        "label[0.25,1.5;Corner 1: " .. minetest.colorize(protection.protection_color, area_data.pos1.x .. "," .. area_data.pos1.y .. ","  .. area_data.pos1.z) .. "]",
        "label[0.25,2.0;Corner 2: " .. minetest.colorize(protection.protection_color, area_data.pos2.x .. "," .. area_data.pos2.y .. ","  .. area_data.pos2.z) .. "]",
        "label[0.25,2.5;Area surface: " .. minetest.colorize(protection.warning_color, area_surface .. " nodes") .. "]",
        "label[0.25,3.0;Area volume: " .. minetest.colorize(protection.warning_color, area_volume .. " nodes") .. "]",
        "label[0.25,4.0;Areas in this block:]",
        "button[2.25,5.75;3.0,0.75;grid_toggle;Toggle protector grid]",
        areas_at_pos,
        tab_switches
    }, "")
    local area_open_status = minetest.colorize(protection.dim_color, "Closed")
    if (areas.areas[selected_area_id].open) then
        area_open_status = minetest.colorize(protection.true_color, "Open")
    end
    selected_area_name = areas.areas[selected_area_id].name
    local edit_tab = table.concat({
        "style_type[label,button;font_size=16]",
        "label[0.25,0.25;Selected " .. minetest.colorize(protection.area_color, "area") .. ": " ..  minetest.colorize(protection.area_color, selected_area_name) .. "]",
        "field[0.25,1.0;5.0,0.5;select_area;Select other " .. minetest.colorize(protection.protection_color, "ID") .. " in this position:;]",
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

local function area_manager_formspec(pos, player, add)
	local spos = pos.x..","..pos.y..","..pos.z
    local playername = player:get_player_name()
	local winv_listring = ""
    local manager_tab = area_manager_formspec_tab(pos, playername)
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
	local winv_formspec = {
		"image[0,0;7.75,7.75;winv_bg.png]",
		winv_listring,
        manager_tab,
		add
	}
	return winv.init_inventory(player, table.concat(winv_formspec, ""))
end

local function area_manager_show_formspec(pos, player, add)
	local playername = player:get_player_name()
	minetest.show_formspec(playername, "protection:area_manager", area_manager_formspec(pos, player, add))
end

local function pos_is_in_area(pos, area_id)
    local area_data = areas.areas[tonumber(area_id)]
    local pos_goe_pos1 = false
    local pos_loe_pos2 = false

    if (pos.x >= area_data.pos1.x) and (pos.y >= area_data.pos1.y) and (pos.z >= area_data.pos1.z) then
        pos_goe_pos1 = true
    end

    if (pos.x <= area_data.pos2.x) and (pos.y <= area_data.pos2.y) and (pos.z <= area_data.pos2.z) then
        pos_loe_pos2 = true
    end

    if pos_goe_pos1 and pos_loe_pos2 then
        return true
    else
        return false
    end
end

local function manager_place_grid(area_id, playername)
    local area_data = areas.areas[area_id]
    local area_bounds = {pos1 = area_data.pos1, pos2 = area_data.pos2}
    local cpos = {}
    cpos[1] = {x = area_bounds.pos1.x, y =  area_bounds.pos1.y, z = area_bounds.pos1.z}
    cpos[2] = {x = area_bounds.pos1.x, y =  area_bounds.pos1.y, z = area_bounds.pos2.z}
    cpos[3] = {x = area_bounds.pos2.x, y =  area_bounds.pos1.y, z = area_bounds.pos1.z}
    cpos[4] = {x = area_bounds.pos2.x, y =  area_bounds.pos1.y, z = area_bounds.pos2.z}
    cpos[5] = {x = area_bounds.pos1.x, y =  area_bounds.pos2.y, z = area_bounds.pos1.z}
    cpos[6] = {x = area_bounds.pos1.x, y =  area_bounds.pos2.y, z = area_bounds.pos2.z}
    cpos[7] = {x = area_bounds.pos2.x, y =  area_bounds.pos2.y, z = area_bounds.pos1.z}
    cpos[8] = {x = area_bounds.pos2.x, y =  area_bounds.pos2.y, z = area_bounds.pos2.z}

    local epos = {}

    epos[1] = {x = area_bounds.pos1.x - 0.5, y = (area_bounds.pos1.y + area_bounds.pos2.y) / 2, z = (area_bounds.pos1.z + area_bounds.pos2.z) / 2}
    epos[2] = {x = area_bounds.pos2.x + 0.5, y =  (area_bounds.pos1.y + area_bounds.pos2.y) / 2, z = (area_bounds.pos1.z + area_bounds.pos2.z) / 2}
    epos[3] = {x = (area_bounds.pos1.x + area_bounds.pos2.x) / 2, y =  (area_bounds.pos1.y + area_bounds.pos2.y) / 2, z = area_bounds.pos1.z - 0.5}
    epos[4] = {x = (area_bounds.pos1.x + area_bounds.pos2.x) / 2, y =  (area_bounds.pos1.y + area_bounds.pos2.y) / 2, z = area_bounds.pos2.z + 0.5}

    local x_side_length = math.abs(area_bounds.pos1.x - area_bounds.pos2.x) + 1
    local y_side_length = math.abs(area_bounds.pos1.y - area_bounds.pos2.y) + 1
    local z_side_length = math.abs(area_bounds.pos1.z - area_bounds.pos2.z) + 1
    local thickness = 0.1

    if protection.area_markers[playername] ~= nil then
        for i=1,8 do
            if protection.area_markers[playername]["corner" .. i] ~= nil then
                protection.area_markers[playername]["corner" .. i]:remove()
                protection.area_markers[playername]["corner" .. i] = nil
            end
        end
        for i=1,4 do
            if protection.area_markers[playername]["edge" .. i] ~= nil then
                protection.area_markers[playername]["edge" .. i]:remove()
                protection.area_markers[playername]["edge" .. i] = nil
            end
        end
    else
        protection.area_markers[playername] = {}
    end

    for i=1,8 do
        protection.area_markers[playername]["corner" .. i] = minetest.add_entity(cpos[i], "protection:pos")

        if protection.area_markers[playername]["corner" .. i] ~= nil then
            protection.area_markers[playername]["corner" .. i]:get_luaentity().player_name = playername
        end
    end
    for i=1,2 do
        protection.area_markers[playername]["edge" .. i] = minetest.add_entity(epos[i], "protection:protector_edge")
        if protection.area_markers[playername]["edge" .. i] ~= nil then
            protection.area_markers[playername]["edge" .. i]:set_properties({
                visual_size = {x = z_side_length, y = y_side_length},
                collisionbox = {-thickness, -y_side_length / 2, -z_side_length / 2, thickness, y_side_length / 2, z_side_length / 2}
            })
            protection.area_markers[playername]["edge" .. i]:set_yaw(math.pi / 2)
            protection.area_markers[playername]["edge" .. i]:get_luaentity().player_name = playername
        end
    end
    for i=3,4 do
        protection.area_markers[playername]["edge" .. i] = minetest.add_entity(epos[i], "protection:protector_edge")
        if protection.area_markers[playername]["edge" .. i] ~= nil then
            protection.area_markers[playername]["edge" .. i]:set_properties({
                visual_size = {x = x_side_length, y = y_side_length},
                collisionbox = {-x_side_length / 2, -y_side_length / 2, -thickness, x_side_length / 2, y_side_length / 2, thickness}
            })
            protection.area_markers[playername]["edge" .. i]:get_luaentity().player_name = playername
        end
    end
end

local function manager_remove_grid(name)
    local grid = protection.area_markers[name]

    if not grid then
        return
    end

    for i=1,8 do
        grid["corner"..i]:remove()
    end

    for i=1,4 do
        grid["edge"..i]:remove()
    end

    protection.area_markers[name] = nil
end

local function update_infotext(pos, area_id)
    local meta = minetest.get_meta(pos)
    local area_data = areas.areas[area_id]
    meta:set_string("infotext", minetest.colorize(protection.protection_color, "Area Manager") ..
                    "\nSelected Area: " .. minetest.colorize(protection.protection_color, area_id) ..
                    "\nOwner: " .. minetest.colorize(protection.name_color, area_data.owner) ..
                    "\nName: " .. minetest.colorize(protection.area_color, area_data.name))
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "protection:area_manager" or not player then
		return
	end
	local playername = player:get_player_name()
	local pos = protection.area_manager[playername]
	local meta = minetest.get_meta(pos)
    local selected_area_id = tonumber(meta:get_string("selected_area_id"))

    if fields.grid_toggle ~= nil then
        if protection.area_markers[playername] == nil then
            manager_place_grid(selected_area_id, playername)
        else
            manager_remove_grid(playername)
        end
    end

    if fields.key_enter_field == "select_area" then
        local area_id = tonumber(fields.select_area)
        if areas:isAreaOwner(area_id, playername) then
            if pos_is_in_area(pos, area_id) then
                meta:set_string("selected_area_id", area_id)
                update_infotext(pos, area_id)
                protector_show_formspec(pos, player)
            else
                minetest.chat_send_player(playername, protection.chat_message("manager", "error", "This area manager is not located in that area.", "Select an area which contains this area manager."))
            end
        else
            minetest.chat_send_player(playername, protection.chat_message("manager", "warning", "You do not own that area."))
        end
    end

    if fields.key_enter_field == "add_owner" then
        local new_owner = fields.add_owner
        if areas:player_exists(new_owner) then
            local selected_name = areas.areas[selected_area_id].name
            local area_data = areas.areas[selected_area_id]
            local area_id,aerror = areas:add(new_owner, selected_name, area_data.pos1, area_data.pos2, selected_area_id)
            if area_id ~= "" then
                marker_remove_grid(playername)
                minetest.chat_send_player(playername, protection.chat_message("manager", "success",
                                            "Successfuly shared area " .. minetest.colorize(protection.area_color, selected_name) ..
                                            " with " .. minetest.colorize(protection.name_color, new_owner) .. "."))
                areas:save()
                minetest.log("action", "Area Manager added owner, owner="..new_owner..
				" AreaName="..selected_name..
				" StartPos="..minetest.pos_to_string(area_data.pos1)..
				" EndPos="  ..minetest.pos_to_string(area_data.pos2))
                area_manager_show_formspec(pos, player)
            else
                minetest.chat_send_player(playername, protection.chat_message("manager", "error", "Failed to share area, " .. aerror .. "."))
            end
        else
            minetest.chat_send_player(playername, protection.chat_message("manager", "error", "Invalid player name.", "Possibly a typing mistake."))
        end
    end

    if fields.key_enter_field == "change_owner" then
        local new_owner = fields.change_owner
        if areas:player_exists(new_owner) then
            local selected_name = areas.areas[selected_area_id].name
            areas.areas[selected_area_id].owner = new_owner
            areas:save()
            minetest.log("action", "Area Manager changed owner, owner="..new_owner..
				" AreaName="..selected_name..
				" StartPos="..minetest.pos_to_string(area_data.pos1)..
				" EndPos="  ..minetest.pos_to_string(area_data.pos2))
            update_infotext(pos, selected_area_id)
            minetest.chat_send_player(playername, protection.chat_message("manager", "error", "Area " ..
                                        minetest.colorize(protection.area_color, selected_name) ..
                                        " is now owned by " .. minetest.colorize(protection.name_color, new_owner) .. "."))
            area_manager_show_formspec(pos, player)
        else
            minetest.chat_send_player(playername, protection.chat_message("manager", "error", "Invalid player name.", "Possibly a typing mistake."))
        end
    end

    if fields.key_enter_field == "rename" then
        local new_name = fields.rename
        local old_name = areas.areas[selected_area_id].name
        areas.areas[selected_area_id].name = new_name
        areas:save()
        minetest.log("action", "Area Manager renamed area, id=" .. selected_area_id .. " old name=".. old_name ..
				" new name="..new_name)
        update_infotext(pos, selected_area_id)
        minetest.chat_send_player(playername, protection.chat_message("manager", "success", "Renamed area " ..
                                    minetest.colorize(protection.area_color, old_name) ..
                                    " to " .. minetest.colorize(protection.area_color, new_name) .. "."))
        area_manager_show_formspec(pos, player)
    end

    if fields.open_toggle ~= nil then
        local open = not areas.areas[selected_area_id].open
        -- Save false as nil just like in the original areas chatcommand code
        areas.areas[selected_area_id].open = open or nil
        areas:save()
        area_manager_show_formspec(pos, player)
    end

    if fields.info ~= nil then
        meta:set_string("tab", "info")
        area_manager_show_formspec(pos, player)
    end

    if fields.edit ~= nil then
        meta:set_string("tab", "edit")
        area_manager_show_formspec(pos, player)
    end

	if not fields.quit then
		winv.node_receive_fields(player, formname, fields)
		if winv.node_refresh(player) then
			area_manager_show_formspec(pos, player)
		end
	end
end)

local function area_manager_on_construct(pos)
	local meta = minetest.get_meta(pos)
	meta:set_string("owner", "")
end

local function area_manager_after_place_node(pos, placer, itemstack, pointed_thing)
	local meta = minetest.get_meta(pos)
	local playername = placer:get_player_name()
    local selected_area = protection.find_owned_area(pos, playername)
	meta:set_string("owner", playername)
    meta:set_string("tab", "info")
    meta:set_string("selected_area_id", selected_area.id)
    meta:set_string("infotext", minetest.colorize(protection.protection_color, "Area Manager") ..
                    "\nSelected Area: " .. minetest.colorize(protection.protection_color, selected_area.id) ..
                    "\nOwner: " .. minetest.colorize(protection.name_color, selected_area.owner) ..
                    "\nName: " .. minetest.colorize(protection.area_color, selected_area.name))
end

minetest.register_node("protection:area_manager", {
    description = ccore.comment("Area Manager", "Displays area info and allows area modification"),
    drawtype = "mesh",
    mesh = "area_manager.obj",
    tiles = {"variations_wood.png^[sheet:3x3:1,0", "variations_steelblock.png^[sheet:3x3:1,0", "protection_manager.png"},
    groups = {dig_immediate = 2},
    selection_box = {
        type = "fixed",
        fixed = {-15/16, -8/16, -15/16, 15/16, 13/16, 16/16},
    },
    collision_box = {
        type = "fixed",
        fixed = {-15/16, -8/16, -15/16, 15/16, 13/16, 16/16},
    },
    paramtype = "light",
    paramtype2 = "facedir",
	sounds = default.node_sound_stone_defaults(),
    can_dig = function(pos, player)
        local meta = minetest.get_meta(pos)
        if (player:get_player_name() == meta:get_string("owner")) then
            return true
        else
            minetest.chat_send_player(player:get_player_name(), protection.chat_message("manager", "note", "Only the owner can remove an area manager.", "Maybe try asking them?"))
            return false
        end
    end,
    on_dig = function(pos, node, digger)
        local playername = digger:get_player_name()
        if protection.area_markers[playername] ~= nil then
            manager_remove_grid(playername)
        end
        minetest.node_dig(pos, node, digger)
    end,
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local name = clicker:get_player_name()
        local meta = minetest.get_meta(pos)
        local selected_area = areas.areas[tonumber(meta:get_string("selected_area_id"))]
        if selected_area == nil then
            minetest.chat_send_player(name, protection.chat_message("manager", "error", "Selected area does not exist.", "Perhaps it was deleted since this manager was placed, try placing it again."))
            selected_area = protection.find_owned_area(pos, name)
            if (selected_area.id == "undefined") then
                minetest.chat_send_player(name, protection.chat_message("manager", "error", "Can't find any relevant areas in this position.", "You probably do not own any areas at this exact position."))
                return itemstack
            else
                meta:set_string("selected_area_id", selected_area.id)
                update_infotext(pos, selected_area.id)
                protection.area_manager[name] = pos
                minetest.chat_send_player(name, protection.chat_message("manager", "note", "Selecting area " .. minetest.colorize(protection.area_color,selected_area.name) .. "."))
                area_manager_show_formspec(pos, clicker)
            end
        end
        if not pos_is_in_area(pos, meta:get_string("selected_area_id")) then
            minetest.chat_send_player(name, protection.chat_message("manager", "error", "Area manager is not in the selected area.", "Perhaps the area has been modified, or this ID has been given to another area."))
            return itemstack
        end

        if (name == meta:get_string("owner")) then
            protection.area_manager[name] = pos
            area_manager_show_formspec(pos, clicker)
        else
            minetest.chat_send_player(name, protection.chat_message("manager", "note", "Only the owner can interact with an area manager."))
            return itemstack
        end
    end,
    on_place = function(itemstack, placer, pointed_thing)
        local name = placer:get_player_name()
        local pos = pointed_thing.above
        local owned_area = protection.find_owned_area(pos, name)
        if owned_area.id == "undefined" then
            minetest.chat_send_player(name, protection.chat_message("manager", "note", "The area manager can only be placed in an area owned by you.", "You probably do not own any areas at this exact position."))
        else
            minetest.item_place(itemstack, placer, pointed_thing)
        end
    end,
    on_construct = area_manager_on_construct,
	after_place_node = area_manager_after_place_node,
})