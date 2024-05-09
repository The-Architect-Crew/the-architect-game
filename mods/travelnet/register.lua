function travelnet.on_construct(pos)
	local meta = minetest.get_meta(pos)
	meta:set_string("lock", "lock")
	meta:set_string("owner", "")
	locks.init_infotext(pos, "TravelNet")
end

function travelnet.after_place_node(pos, placer, itemstack, pointed_thing)
	local meta = minetest.get_meta(pos)
	local playername = placer:get_player_name()
	meta:set_string("owner", playername)
    meta:set_string("selected_tab", "travel")
    meta:set_int("attached_network", 0)
    meta:set_int("created_station", 0)
	locks.init_infotext(pos, "TravelNet")
end

for i=1,#travelnet.materials do
    local material = travelnet.materials[i]
    local secondary_material = false

    if type(material) == "table" then
        secondary_material = material[2]
        material = material[1]
    end
    local sname = string.match(material, ':(.*)')
    local material_definition = minetest.registered_nodes[material]
    local description = ccore.strip_newlines(material_definition.description)
    local groups = ccore.groups_copy(material_definition.groups)
    groups.dig_immediate = 3
    local sounds = material_definition.sounds

    if secondary_material then
        secondary_material = string.match(secondary_material, ':(.*)')
    else
        secondary_material = "steelblock"
    end

    minetest.register_node("travelnet:station_" .. sname, {
        drawtype = "mesh",
        mesh = "travelnet_station.obj",
        description = description .. " TravelNet",
        tiles = {"variations_" .. sname .. ".png^[sheet:3x3:1,0", "variations_" .. secondary_material .. ".png^[sheet:3x3:1,0",
                    "blocks_glass_frosted.png", {
                        name = "travelnet_station_special.png",
                        backface_culling = true,
                        animation = {
                            type = "vertical_frames",
                            aspect_w = 16,
                            aspect_h = 16,
                            length = 2.0,
                        }
                    }
                },
        use_texture_alpha = "blend",
        groups = groups,
        sounds = sounds,
        selection_box = {
            type = "fixed",
            fixed = {
                {-11/16,-8/16,-8/16,9/16,41/16,8/16},
            }
        },
        collision_box = {
            type = "fixed",
            fixed = {
                {-8/16,-8/16,-8/16,-7/16,24/16,8/16},
                {7/16,-8/16,-8/16,8/16,24/16,8/16},
                {-8/16,-8/16,8/16,8/16,24/16,8/16},
                {-8/16,-8/16,-8/16,8/16,-8/16,8/16},
                {-8/16,20/16,-8/16,8/16,41/16,8/16},
            }
        },
        paramtype = "light",
        paramtype2 = "facedir",
        on_construct = travelnet.on_construct,
        after_place_node = travelnet.after_place_node,
        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
            local playername = clicker:get_player_name()
            local meta = minetest.get_meta(pos)

            if not meta or meta and meta:get_string("owner") == "" then
                travelnet.on_construct(pos)
                travelnet.after_place_node(pos, clicker, itemstack, pointed_thing)
            end

            if not locks.can_access(pos, clicker) then
                return itemstack
            end

            if meta:get_int("created_station") == 0 then
                if meta:get_string("owner") == playername then
                    local available_networks = travelnet.get_available_network_ids(playername)
                    if (available_networks[1] ~= nil) and (meta:get_int("attached_network") == 0) then
                        meta:set_int("attached_network", 1)
                        meta:set_int("station_netid", tonumber(available_networks[1]))
                    end
                    travelnet.pos[playername] = pos
                    travelnet.show_create_station_formspec(pos, clicker)
                else
                    minetest.chat_send_player(playername, travelnet.chat_message("warning", "This TravelNet station has not yet been configured by the owner."))
                    return itemstack
                end
            elseif (meta:get_int("created_station") == 1) and (meta:get_int("attached_network") == 1) then
                travelnet.show_formspec(pos, clicker)
                travelnet.pos[playername] = pos
            end
        end,
        on_dig = function(pos, node, digger)
            local playername = digger:get_player_name()
            local meta = minetest.get_meta(pos)
            if meta:get_int("created_station") == 1 then
                if meta:get_string("owner") == playername then
                    local statid = meta:get_int("station_id")
                    local netid = meta:get_int("station_netid")
                    travelnet.delete_station(statid, netid)
                    minetest.node_dig(pos, node, digger)
                else
                    minetest.chat_send_player(playername, travelnet.chat_message("warning", "Only the owner can remove a travelnet."))
                end
            else
                minetest.node_dig(pos, node, digger)
            end
        end,
    })
end