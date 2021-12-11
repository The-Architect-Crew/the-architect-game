-- Public functions for shared use by mods
-- Support HUD notifications under weildhand with timeout. Leave timeout nil to use default of 12 seconds
ccore.notify = function(playername, message, timeout)
    assert(timeout == nil or timeout > 0, "Invalid value: timeout must be a number > 0 or leave nil for default")
    local player = minetest.get_player_by_name(playername)
    -- TODO: Implement queue of notifications to manage smooth transitioning
    -- avoid missed notifications due to being replaced too quickly
    -- For now replace current notification
    if ccore.notify_ids[playername] ~= nil then
        local id = ccore.notify_ids[playername]
        player:hud_remove(id)
    end
    -- Create and store HUD
    local id = player:hud_add({
        hud_elem_type = "text",
		number = 0xFFFFFF,
		position = {x=0.7, y=1},
		offset = {x=0, y=-8},
		text = message,
		scale = {x=200, y=60},
		alignment = {x=1, y=-1},
    });
    ccore.notify_ids[playername] = id;
    -- Handle notification expiration
    if timeout == nil or type(timeout) ~= "number" then
        timeout = 12  -- use default
    end
    minetest.after(timeout, function()
        if ccore.notify_ids[playername] == id then
            player:hud_remove(id)
            ccore.notify_ids[playername] = nil
        end
    end);
end