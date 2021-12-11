local notify_ids = {}

-- Support HUD notifications under weildhand with timeout. Leave timeout nil to use default of 12 seconds
function core._notify(playername, message, timeout)
    assert(type(timeout) == nil or timeout > 0, "Invalid value: timeout must be a number > 0 or leave nil for default")
    local player = minetest.get_player_by_name(playername)
    -- TODO implement queue of notifications to manage smooth transitioning and avoid missed notifications due to being replaced too quickly
    -- For now replace current notification
    if notify_ids[playername] ~= nil then
        local id = notify_ids[playername]
        player:hud_remove(id)
    end
    -- Create and store HUD 
    local id = player:hud_add({
        hud_elem_type = "text",
		name = "Wield",
		number = 0xFFFFFF,
		position = {x=0.7, y=1},
		offset = {x=0, y=-8},
		text = message,
		scale = {x=200, y=60},
		alignment = {x=1, y=-1},
    });
    notify_ids[playername] = id;
    -- Handle notification expiration
    if timeout == nil then
        timeout = 12
    end
    minetest.after(timeout, function()
        if notify_ids[playername] == id then
            player:hud_remove(id)
        end
    end);
end

minetest.register_on_leaveplayer(function(player, timed_out)
    local name = player:get_player_name()
    notify_ids[name] = nil
end)

-- Test notification
minetest.register_on_joinplayer(function(player, last_login)
    playername = player:get_player_name()
    core._notify(playername, "Welcome "..playername.."!", 8)
end)
