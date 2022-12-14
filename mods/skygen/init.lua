-- Dont forget to set cloud radius to 26 in minetest's settings

skygen = {}
skygen.start = 1
skygen.save_timer = 0
skygen.save_interval = 1000
skygen.sky_state = {}
skygen.active = true
skygen.event = "none"
skygen.scale_sun_moon = "true"

skygen.sky_biome_start = 512

skygen.events = {"test"} -- Add event names here

skygen.skybox_names = {"test_sky", "sky"} -- Add skybox names here

skygen.skyboxes = {}
skygen.event_data = {}
skygen.save_file = minetest.get_worldpath() .. "/skygen"
skygen.event_save_file = minetest.get_worldpath() .. "/skygen_event"

skygen.colorize_stars = true

skygen.default_star_params = {
    visible = true,
    count = 1000,
    star_color = "#ebebff69",
    scale = 1,
}

local path = minetest.get_modpath("skygen")
local skybox_path = path .. "/skyboxes"
dofile(path.."/colors.lua")
dofile(path.."/biome.lua")
dofile(path.."/skybox.lua")
dofile(path.."/events.lua")

for i=1,#skygen.skybox_names do
    dofile(skybox_path .. "/" .. skygen.skybox_names[i] .. "/skydef.lua")
end

function skygen.load_saves()
    local event_input = io.open(skygen.event_save_file, "r")
    if not event_input then
		return
	else
        skygen.event = event_input:read("*a")
    end
    event_input:close()
	local input = io.open(skygen.save_file, "r")
	if not input then
		return
	end
	-- Iterate over all recorded states in the format "player state skybox" for each line
	for name, state, skybox in input:read("*a"):gmatch("([%w_-]+)%s([%w_-]+)%s([%w_-]+)[\r\n]") do
        if state == "skybox" then
            state = "skybox_reset"
        elseif state == "inactive" then
            state = "inactive_reset"
        end
		skygen.sky_state[name] = state
        skygen.skybox_status[name] = skybox
	end
	input:close()
end

function skygen.save()
    local data = {}
    local output = io.open(skygen.save_file, "w")
    if output then
        local s
        for i, v in pairs(skygen.sky_state) do
            s = skygen.skybox_status[i]
            if not s then
                s = "none"
            end
            table.insert(data, string.format("%s %s %s\n", i, v, s))
        end
        output:write(table.concat(data))
        io.close(output)
        return true
    end
    return true
end

function skygen.event_save()
    local output = io.open(skygen.event_save_file, "w")
    if output then
        output:write(skygen.event)
        io.close(output)
        return true
    end
    return true
end

skygen.load_saves()
minetest.register_on_shutdown(function()
    skygen.save()
    skygen.event_save()
end)

minetest.register_on_leaveplayer(function(player)
    if skygen.sky_state[player:get_player_name()] == "skybox" then
        skygen.sky_state[player:get_player_name()] = "skybox_reset"
    elseif skygen.sky_state[player:get_player_name()] == "inactive" then
        skygen.sky_state[player:get_player_name()] = "inactive_reset"
    end
end)

skygen.sky_globalstep = function(players)
    for i=1, #players do
        local player = players[i]
        local player_name = player:get_player_name()
        if (skygen.sky_state[player_name] == "skybox_reset") then -- Player has reconnected in the meantime and the skybox has to be set anew
            skygen.set_skybox(player, skygen.skybox_status[player_name])
        elseif (skygen.sky_state[player_name] == "inactive_reset") then
            skygen.deactivate(player_name)
        elseif (player:get_pos().y > skygen.sky_biome_start) then
            if (skygen.skybox_status[player_name] == "sky") then
                return
            else
                skygen.set_skybox(player, "sky")
            end
        elseif (player:get_pos().y < skygen.sky_biome_start) and (skygen.skybox_status[player_name] == "sky") then
            skygen.biome_mode(player_name)
        elseif (skygen.sky_state[player_name] == "skybox") or (skygen.sky_state[player_name] == "inactive") then
            return
        else
            local biome_data = skygen.fetch_biome(player)
            local biome_name = biome_data[1]
            local previous_biome_name = skygen.previous_biome[player_name]
            if (skygen.sky_state[player_name] == nil) then
                skygen.sky_state[player_name] = "biome"
            end
            if skygen.sky_state[player_name] == "transition" then
                return
            elseif biome_name == previous_biome_name then
                skygen.set_clouds(player, biome_name) -- Cause minetest resets them every now and then
            elseif previous_biome_name == nil then
                skygen.previous_biome[player_name] = biome_name
                skygen.set_sky(player, biome_name)
                skygen.set_all(player, biome_name)
            else
                --minetest.chat_send_player(player_name, "Change Init: " .. previous_biome_name .. " to " .. biome_name) -- Debug
                skygen.set_sky(player, biome_name)
                skygen.init_transition(player, previous_biome_name, biome_name)
            end
        end
    end
end

minetest.register_globalstep(function()
    local players = minetest.get_connected_players()
    if skygen.start == 1 then -- Build the virtual table
        skygen.start = 0
        for i=1, #skygen.biome_names do
            local biome_name = skygen.biome_names[i]
            local biome_colors = skygen.biomes[biome_name].colors
            if not (biome_colors[5]) then
                biome_colors[5] = {128, 128, 128}
            end
            biome_colors[6] = skygen.colorize(biome_colors[2], biome_colors[3], 0.75) -- Dawn
            biome_colors[7] = skygen.colorize(biome_colors[1], biome_colors[3], 0.75) -- Dawn Horizon
            biome_colors[8] = skygen.colorize(biome_colors[1], biome_colors[4], 0.75) -- Night
            biome_colors[9] = skygen.colorize(biome_colors[2], biome_colors[4], 0.75) -- Night Horizon
        end
        if skygen.event == "none" then
            skygen.sky_globalstep(players)
        else
            for i=1,#skygen.events do
                if skygen.event == skygen.events[i] then
                    for j=1, #skygen.biome_names do
                        local biome_name = skygen.biome_names[j]
                        local biome_colors = skygen.biomes[biome_name].colors
                        local event_biome_colors = {}
                        event_biome_colors[1] = skygen.colorize(biome_colors[1], skygen.event_data[skygen.event].color, 0.75) -- Day
                        event_biome_colors[2] = skygen.colorize(biome_colors[2], skygen.event_data[skygen.event].color, 0.75) -- Day Horizon
                        event_biome_colors[3] = skygen.colorize(biome_colors[3], skygen.event_data[skygen.event].color_sun, 0.75) -- Sun
                        event_biome_colors[4] = skygen.colorize(biome_colors[4], skygen.event_data[skygen.event].color_moon, 0.75) -- Moon
                        event_biome_colors[5] = skygen.colorize(biome_colors[5], skygen.event_data[skygen.event].color, 0.75) -- Indoors
                        event_biome_colors[6] = skygen.colorize(biome_colors[6], skygen.event_data[skygen.event].color_sun, 0.75) -- Dawn
                        event_biome_colors[7] = skygen.colorize(biome_colors[7], skygen.event_data[skygen.event].color_sun, 0.75) -- Dawn Horizon
                        event_biome_colors[8] = skygen.colorize(biome_colors[8], skygen.event_data[skygen.event].color_night, 0.75) -- Night
                        event_biome_colors[9] = skygen.colorize(biome_colors[9], skygen.event_data[skygen.event].color_night, 0.75) -- Night Horizon
                        skygen.biomes[biome_name].event_colors = event_biome_colors
                    end
                end
            end
            skygen.sky_globalstep(players)
        end
    else
        skygen.sky_globalstep(players)
        if (skygen.save_timer > skygen.save_interval) then
            skygen.save()
            skygen.event_save()
            skygen.save_timer = 0
        else
            skygen.save_timer = skygen.save_timer + 1
        end
    end
end)

skygen.deactivate = function(player)
    skygen.sky_state[player] = "inactive"
    local player_obj = minetest.get_player_by_name(player)
    player_obj:set_sky()
    player_obj:set_sun()
    player_obj:set_stars(skygen.default_star_params)
    player_obj:set_moon()
    player_obj:set_clouds()
    player_obj:override_day_night_ratio(nil)
end

minetest.register_on_joinplayer(function(player)
	player:set_lighting({
		shadows = { intensity = 0.33 }
	})
end)

minetest.register_chatcommand("skygen", {
    params = "<state> <skybox>",
    description = "SkyGen settings; \"off\" to disable; \"biome\" for default; \"skybox skybox_name\" for skybox mode",
    func = function(name, param)
        local parameters = {}
        local p = 1
        for iterator in param:gmatch("%g+") do
            parameters[p] = iterator
            p = p + 1
        end
        if parameters[1] == "off" then
            skygen.deactivate(name)
            minetest.chat_send_player(name, "The sky is now set to be Minetest default")
        elseif parameters[1] == "biome" then
            skygen.biome_mode(name)
            minetest.chat_send_player(name, "The sky is now set to be biome-adaptive")
        elseif parameters[1] == "skybox" then
            for i=1, #skygen.skybox_names do
                if skygen.skybox_names[i] == parameters[2] then
                    local sky_description = skygen.skyboxes[parameters[2]].description
                    skygen.set_skybox(minetest.get_player_by_name(name), parameters[2])
                    minetest.chat_send_player(name, "The sky is now set to be a skybox, " .. sky_description)
                end
            end
        end
    end
})

minetest.register_chatcommand("skygen_event", {
    params = "<event_name>",
    description = "Initiate an event",
    privs = {server=true},
    func = function(name, param)
        if param == "deactivate" then
            if skygen.event ~= "none" then
                local previous_event = skygen.event_data[skygen.event].description
                minetest.chat_send_all("The " .. previous_event .. " has ended!")
                skygen.event = "none"
                skygen.start = 1
            end
        else
            for i=1,#skygen.events do
                if skygen.events[i] == param then
                    local new_event = skygen.event_data[param].description
                    skygen.event = param
                    skygen.start = 1
                    minetest.chat_send_all("The " .. new_event .. " has arrived!")
                end
            end
        end
    end
})
