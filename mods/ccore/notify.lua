ccore.notify_ids = {}

minetest.register_on_leaveplayer(function(player, timed_out)
    local name = player:get_player_name()
    ccore.notify_ids[name] = nil
end)

-- Test notification. Greets player on joining.
minetest.register_on_joinplayer(function(player, last_login)
    local playername = player:get_player_name()
    ccore.notify(playername, "Welcome "..playername.."!", 8)
end)
