protection.markers = {}

local function marker_formspec(pos, player, area_bounds)
	local spos = pos.x..","..pos.y..","..pos.z
    local playername = player:get_player_name()
    local meta = minetest.get_meta(pos)
	local winv_listring = ""
    local right_inv = winv.get_inventory(player, "right")
    local y_input = ""
    local protect_input = ""
    local error_msg = ""
    local area_protectable, aerror = areas:canPlayerAddArea(area_bounds.pos1, area_bounds.pos2, playername)
    local area_surface = protection.calculate_surface(area_bounds.pos1, area_bounds.pos2)
    local area_volume = protection.calculate_volume(area_bounds.pos1, area_bounds.pos2)
    local protection_cost = protection.calculate_cost(area_bounds.pos1, area_bounds.pos2)

    if area_protectable then
        y_input = "field[0.25,6.0;4.0,0.5;y_height;Set area height: ;" .. meta:get_string("area_height") .. "]" .. "field_close_on_enter[y_height;false]"
        protect_input = "field[0.25,7.0;7.0,0.5;protect;Protect this area as: ;]"
    else
        error_msg = "label[0.25,7.0;" .. aerror .. "]"
    end

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
        "style_type[label;font_size=16]",
        "label[0.25,1.0;Area bounds: " .. protection.pos_to_string(area_bounds.pos1) .. " " .. protection.pos_to_string(area_bounds.pos2) .. "]",
        "label[0.25,2.0;Area surface: " .. area_surface .. " nodes]",
        "label[0.25,2.5;Area volume: " .. area_volume .. " nodes]",
        "label[0.25,3.5;Protection cost: " .. protection_cost .. " lost mese]",
        y_input,
        protect_input,
        error_msg,
        winv_listring
	}
	return winv.init_inventory(player, table.concat(winv_formspec, ""))
end

local function marker_show_formspec(pos, player, area_bounds)
    local playername = player:get_player_name()
    minetest.show_formspec(playername, "protection:marker_form", marker_formspec(pos, player, area_bounds))
end

local function marker_on_construct(pos)
    local meta = minetest.get_meta(pos)
    meta:set_string("owner", "")
end

local function marker_after_place_node(pos, placer, itemstack, pointed_thing)
    local meta = minetest.get_meta(pos)
    local playername = placer:get_player_name()
    meta:set_string("owner", playername)
    meta:set_string("area_height", "10")
    meta:set_string("infotext", "Marker owned by: " .. playername .. "\nBase height: " .. pos.y)
end

local function area_from_markers(marker1, marker2, marker3, marker4)
    local pos1 = {}
    local pos2 = {}
    pos1.x = math.min(math.min(marker1.x, marker2.x), math.min(marker3.x, marker4.x))
    pos1.y = math.min(math.min(marker1.y, marker2.y), math.min(marker3.y, marker4.y))
    pos1.z = math.min(math.min(marker1.z, marker2.z), math.min(marker3.z, marker4.z))

    pos2.x = math.max(math.max(marker1.x, marker2.x), math.max(marker3.x, marker4.x))
    pos2.y = math.max(math.max(marker1.y, marker2.y), math.max(marker3.y, marker4.y))
    pos2.z = math.max(math.max(marker1.z, marker2.z), math.max(marker3.z, marker4.z))

    return {pos1 = pos1, pos2 = pos2}
end

local function marker_locate_others(pos, playername)
    local marker_search_distance = 64
    local x_marker = false
    local z_marker = false
    local last_marker
    local node
    local area_bounds = nil
    local markers = {}

    for i=1,marker_search_distance do
        node = minetest.get_node({x = pos.x + i, y = pos.y, z = pos.z})
        if node.name == "protection:marker" then
            local meta = minetest.get_meta({x = pos.x + i, y = pos.y, z = pos.z})
            if meta:get_string("owner") == playername then
                x_marker = {x = pos.x + i, y = pos.y, z = pos.z}
                break
            end
        end
        node = minetest.get_node({x = pos.x - i, y = pos.y, z = pos.z})
        if node.name == "protection:marker" then
            local meta = minetest.get_meta({x = pos.x - i, y = pos.y, z = pos.z})
            if meta:get_string("owner") == playername then
                x_marker = {x = pos.x - i, y = pos.y, z = pos.z}
                break
            end
        end
    end

    for i=1,marker_search_distance do
        node = minetest.get_node({x = pos.x, y = pos.y, z = pos.z + i})
        if node.name == "protection:marker" then
            local meta = minetest.get_meta({x = pos.x, y = pos.y, z = pos.z + i})
            if meta:get_string("owner") == playername then
                z_marker = {x = pos.x, y = pos.y, z = pos.z + i}
                break
            end
        end
        node = minetest.get_node({x = pos.x, y = pos.y, z = pos.z - i})
        if node.name == "protection:marker" then
            local meta = minetest.get_meta({x = pos.x, y = pos.y, z = pos.z - i})
            if meta:get_string("owner") == playername then
                z_marker = {x = pos.x, y = pos.y, z = pos.z - i}
                break
            end
        end
    end

    if (x_marker ~= false) and (z_marker ~= false) then
        if minetest.get_node({x = x_marker.x, y = pos.y, z = z_marker.z}).name == "protection:marker" then
            local meta = minetest.get_meta({x = x_marker.x, y = pos.y, z = z_marker.z})
            if meta:get_string("owner") == playername then
                last_marker = {x = x_marker.x, y = pos.y, z = z_marker.z}
                area_bounds = area_from_markers(pos, x_marker, z_marker, last_marker)
                markers = {pos, x_marker, z_marker, last_marker}
            end
        end
    end

    return area_bounds, markers
end


local function set_bounds(markers, bounds)
    for _,pos in ipairs(markers) do
        local meta = minetest.get_meta(pos)
        meta:set_string("pos1x", bounds.pos1.x)
        meta:set_string("pos1y", bounds.pos1.y)
        meta:set_string("pos1z", bounds.pos1.z)
        meta:set_string("pos2x", bounds.pos2.x)
        meta:set_string("pos2y", bounds.pos2.y)
        meta:set_string("pos2z", bounds.pos2.z)
    end
end

local function get_bounds(pos)
    local meta = minetest.get_meta(pos)
    local pos1 = {}
    local pos2 = {}
    local bounds

    pos1.x = tonumber(meta:get_string("pos1x"))
    pos1.y = tonumber(meta:get_string("pos1y"))
    pos1.z = tonumber(meta:get_string("pos1z"))

    pos2.x = tonumber(meta:get_string("pos2x"))
    pos2.y = tonumber(meta:get_string("pos2y"))
    pos2.z = tonumber(meta:get_string("pos2z"))

    bounds = {pos1 = pos1, pos2 = pos2}

    return bounds
end

local function sync_set_string(markers, string, value)
    for _,pos in ipairs(markers) do
        local meta = minetest.get_meta(pos)
        meta:set_string(string, value)
    end
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "protection:marker_form" or not player then
		return
	end
	local playername = player:get_player_name()
    local markers = protection.markers[playername]
    local pos = markers[1]-- Since they're synced it doesnt matter which one
    local meta = minetest.get_meta(pos)

    if fields.key_enter_field == "y_height" then
        local y_height = fields.y_height
        if tonumber(y_height) ~= nil then
            if tonumber(y_height) > 0 then
                local area_bounds = get_bounds(pos)
                sync_set_string(markers, "area_height", y_height)
                area_bounds.pos2.y = area_bounds.pos2.y + tonumber(meta:get_string("area_height")) - 1
                marker_show_formspec(pos, player, area_bounds)
            else
                minetest.chat_send_player(playername, "[Area Marker]: Area height must be positive.")
            end
        else
            minetest.chat_send_player(playername, "[Area Marker]: Invalid area height.")
        end
    end

    if fields.key_enter_field == "protect" then
        local area_name = fields.protect
        local area_bounds = get_bounds(pos)
        area_bounds.pos2.y = area_bounds.pos2.y + tonumber(meta:get_string("area_height")) - 1
        local area_id = areas:add(playername, area_name, area_bounds.pos1, area_bounds.pos2, nil)
        if area_id ~= "" then
            minetest.chat_send_player(playername, "[Area Marker]: Successfully protected area " .. area_name .. " with an id " .. area_id .. ".")
            areas:save()
        end
    end

	if not fields.quit then
		winv.node_receive_fields(player, formname, fields)
		if winv.node_refresh(player) then
			protector_show_formspec(pos, player)
		end
	end
end)

minetest.register_node("protection:marker", {
    description = "Marker",
    drawtype = "mesh",
    mesh = "marker.obj",
    tiles = {"variations_steelblock.png^[sheet:3x3:1,0",
        {
            name = "protection_marker_animated.png",
            backface_culling = true,
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 4.0,
            }
        }
    },
    light_source = 8,
    paramtype = light,
    sunlight_propagates = true,
    groups = {dig_immediate = 3},
    selection_box = {
        type = "fixed",
        fixed = {-5/16, -8/16, -5/16, 5/16, 24/16, 5/16},
    },
    collision_box = {
        type = "fixed",
        fixed = {-5/16, -8/16, -5/16, 9/16, 24/16, 5/16},
    },
    sounds = default.node_sound_stone_defaults(),
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local name = clicker:get_player_name()
        local meta = minetest.get_meta(pos)
        if (name == meta:get_string("owner")) then
            local area_bounds, markers = marker_locate_others(pos, name)
            if area_bounds ~= nil then
                set_bounds(markers, area_bounds)
                area_bounds.pos2.y = area_bounds.pos2.y + tonumber(meta:get_string("area_height")) - 1
                protection.markers[name] = markers
                marker_show_formspec(pos, clicker, area_bounds)
            else
                minetest.chat_send_player(name, "[Area Marker]: Error: Ensure that the markers form a square and are at the same base height.")
            end
        else
            minetest.chat_send_player(name, "[Area Marker]: Only the owner can interact with this marker.")
            return itemstack
        end
    end,
    on_construct = marker_on_construct,
	after_place_node = marker_after_place_node,
})