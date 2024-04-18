
function tavelnet.travelnet_on_construct(pos)
	local meta = minetest.get_meta(pos)
	meta:set_string("lock", "lock")
	meta:set_string("owner", "")
    meta:set_string("editors", "")
	locks.init_infotext(pos, "TravelNet")
end

function tavelnet.travelnet_after_place_node(pos, placer, itemstack, pointed_thing)
	local meta = minetest.get_meta(pos)
	local playername = placer:get_player_name()
	meta:set_string("owner", playername)
    meta:set_string("editors", playername)
    meta:set_int("attached_network", 0)
    meta:set_int("created_station", 0)
	locks.init_infotext(pos, "TravelNet")
end

minetest.register_node("furniture:travelnet", {
    description = "TravelNet",
    tiles = {"blocks_stone.png"},
    groups = {dig_immediate = 3},
    sounds = default.sounds_stone_defaults,
    on_construct = travelnet_on_construct,
    after_place_node = travelnet_after_place_node,
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local playername = clicker:get_player_name()
        local meta = minetest.get_meta(pos)

        if not meta or meta and meta:get_string("owner") == "" then
            travelnet.travelnet_on_construct(pos)
            travelnet.travelnet_after_place_node(pos, clicker, itemstack, pointed_thing)
        end

        if meta:get_int("attached_network") == 0 then
            if meta:get_string("owner") == playername then
                travelnet[playername] = pos
                travelnet.travelnet_show_attach_network_formspec(pos, clicker)
            else
                minetest.chat_send_player(playername, "This TravelNet station has not yet been configured by the owner.")
                return itemstack
            end
        elseif meta:get_int("created_station") == 0 then
            if meta:get_string("owner") == playername then
                travelnet[playername] = pos
                travelnet.travelnet_show_create_station_formspec(pos, clicker)
            else
                minetest.chat_send_player(playername, "This TravelNet station has not yet been configured by the owner.")
                return itemstack
            end
        elseif (meta:get_int("created_station") == 1) and (meta:get_int("attached_network") == 1) then
            if not locks.can_access(pos, clicker) then
                return itemstack
            end
            travelnet.travelnet_show_formspec(pos, clicker)
            travelnet[playername] = pos
        end
    end,
})