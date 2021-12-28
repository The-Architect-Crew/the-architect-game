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
    -- Wrap messages longer than 64 chars per line at first space found, else don't wrap.
    local lines = 1
    if string.len(message) > 64 then
        lines = math.floor(string.len(message)/64)
    end
    if lines > 1 then
        for n = 1,lines do
            local start, stop = string.find(message, " ", n*64)
                if start ~= nil then
                    message = message:sub(0, start) .. "\n" .. message:sub(stop)
                end
        end
    end
    -- Create HUD
    local id = player:hud_add({
        hud_elem_type = "text",
		number = 0xFFFFFF,
		position = {x=0.5, y=0.9},
		offset = {x=-264, y=0},
		text = message,
		scale = {x=0, y=60},
		alignment = {x=1, y=-1},
    });
    --store notification id
    ccore.notify_ids[playername] = id;
    -- Handle notification expiration
    if timeout == nil or type(timeout) ~= "number" then
        timeout = 12  -- use default
    end
    -- Handle notification timeout
    minetest.after(timeout, function()
        if ccore.notify_ids[playername] == id then
            player:hud_remove(id)
            ccore.notify_ids[playername] = nil
        end
    end);
end