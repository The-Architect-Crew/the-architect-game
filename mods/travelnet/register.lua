function travelnet.on_construct(pos)
	local meta = minetest.get_meta(pos)
	meta:set_string("lock", "lock")
	meta:set_string("owner", "")
    meta:set_string("editors", "")
	locks.init_infotext(pos, "TravelNet")
end

function travelnet.after_place_node(pos, placer, itemstack, pointed_thing)
	local meta = minetest.get_meta(pos)
	local playername = placer:get_player_name()
	meta:set_string("owner", playername)
    meta:set_string("editors", playername)
    meta:set_string("selected_tab", "travel")
    meta:set_int("attached_network", 0)
    meta:set_int("created_station", 0)
	locks.init_infotext(pos, "TravelNet")
end

minetest.register_node("travelnet:station", {
    drawtype = "mesh",
    mesh = "travelnet_station.obj",
    description = "TravelNet",
    tiles = {"travelnet_station.png"},
    groups = {dig_immediate = 3},
    sounds = default.sounds_stone_defaults,
    selection_box = {
        type = "fixed",
        fixed = {
            {-8/16,-8/16,-8/16,8/16,41/16,8/16},
        }
    },
    collision_box = {
        type = "fixed",
        fixed = {
            {-8/16,-8/16,-8/16,-8/16,24/16,8/16},
            {8/16,-8/16,-8/16,8/16,24/16,8/16},
            {-8/16,-8/16,8/16,8/16,24/16,8/16},
            {-8/16,-8/16,-8/16,8/16,-8/16,8/16},
            {-8/16,20/16,-8/16,8/16,41/16,8/16},
        }
    },
    paramtype = "light",
    paramtype2 = "facedir",
    on_construct = on_construct,
    after_place_node = after_place_node,
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local playername = clicker:get_player_name()
        local meta = minetest.get_meta(pos)

        if not meta or meta and meta:get_string("owner") == "" then
            travelnet.on_construct(pos)
            travelnet.after_place_node(pos, clicker, itemstack, pointed_thing)
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
                minetest.chat_send_player(playername, "This TravelNet station has not yet been configured by the owner.")
                return itemstack
            end
        elseif (meta:get_int("created_station") == 1) and (meta:get_int("attached_network") == 1) then
            if not locks.can_access(pos, clicker) then
                return itemstack
            end
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
                minetest.chat_send_player(playername, "Only the owner can remove a travelnet.")
            end
        else
            minetest.node_dig(pos, node, digger)
        end
    end,
})