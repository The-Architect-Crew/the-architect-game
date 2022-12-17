-- Dont forget to set cloud radius to 26 in minetest's settings

skygen = {}
skygen.storage = minetest.get_mod_storage()
skygen.start = 1
skygen.save_timer = 0
skygen.save_interval = 1000
skygen.sky_state = {}
skygen.active = true
skygen.scale_sun_moon = "true"

skygen.sky_biome_start = 512

skygen.events = {"test"} -- Add event names here

skygen.skybox_names = {"test_sky", "sky"} -- Add skybox names here

skygen.skyboxes = {}
skygen.event_data = {}

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

if skygen.storage:get_string("event") == "" then
    skygen.storage:set_string("event", "none")
end

minetest.register_on_joinplayer(function(player)
    name = player:get_player_name()
    if skygen.storage:get_string(name .. "_star_coloring") == "" then
        skygen.storage:set_string(name .. "_star_coloring", "true")
    end
    if skygen.storage:get_string(name .. "_scaling") == "" then
        skygen.storage:set_string(name .. "_scaling", "true")
    end
    if skygen.storage:get_int(name .. "_shadow_intensity") == "" then
        skygen.storage:set_int(name .. "_shadow_intensity", 0.33)
    end
    player:set_lighting({ shadows = { intensity = skygen.storage:get_int(name .. "_shadow_intensity") }
	})
end)

minetest.register_on_leaveplayer(function(player)
    name = player:get_player_name()
    if skygen.storage:get_string(name .. "_sky_state") == "skybox" then
        skygen.storage:set_string(name .. "_sky_state", "skybox_reset")
    elseif skygen.storage:get_string(name .. "_sky_state") == "inactive" then
        skygen.storage:set_string(name .. "_sky_state", "inactive_reset")
    end
end)

skygen.sky_globalstep = function(players)
    for i=1, #players do
        local player = players[i]
        local player_name = player:get_player_name()
        if (skygen.storage:get_string(player_name .. "_sky_state") == "skybox_reset") then -- Player has reconnected in the meantime and the skybox has to be set anew
            skygen.set_skybox(player, skygen.storage:get_string(player_name .. "_skybox"))
        elseif (skygen.storage:get_string(player_name .. "_sky_state") == "inactive_reset") then
            skygen.deactivate(player_name)
        elseif (player:get_pos().y > skygen.sky_biome_start) then
            if (skygen.storage:get_string(player_name .. "_skybox") == "sky") then
                return
            else
                skygen.set_skybox(player, "sky")
            end
        elseif (player:get_pos().y < skygen.sky_biome_start) and (skygen.storage:get_string(player_name .. "_skybox") == "sky") then
            skygen.biome_mode(player_name)
        elseif (skygen.storage:get_string(player_name .. "_sky_state") == "skybox") or (skygen.storage:get_string(player_name .. "_sky_state") == "inactive") then
            return
        else
            local biome_data = skygen.fetch_biome(player)
            local biome_name = biome_data[1]
            local previous_biome_name = skygen.previous_biome[player_name]
            if (skygen.storage:get_string(player_name .. "_sky_state") == "") then
                skygen.storage:set_string(player_name .. "_sky_state", "biome")
            end
            if skygen.storage:get_string(player_name .. "_sky_state") == "transition" then
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
        if skygen.storage:get_string("event") == "none" then
            skygen.sky_globalstep(players)
        else
            for i=1,#skygen.events do
                if skygen.storage:get_string("event") == skygen.events[i] then
                    for j=1, #skygen.biome_names do
                        local event = skygen.storage:get_string("event")
                        local biome_name = skygen.biome_names[j]
                        local biome_colors = skygen.biomes[biome_name].colors
                        local event_biome_colors = {}
                        event_biome_colors[1] = skygen.colorize(biome_colors[1], skygen.event_data[event].color, 0.75) -- Day
                        event_biome_colors[2] = skygen.colorize(biome_colors[2], skygen.event_data[event].color, 0.75) -- Day Horizon
                        event_biome_colors[3] = skygen.colorize(biome_colors[3], skygen.event_data[event].color_sun, 0.75) -- Sun
                        event_biome_colors[4] = skygen.colorize(biome_colors[4], skygen.event_data[event].color_moon, 0.75) -- Moon
                        event_biome_colors[5] = skygen.colorize(biome_colors[5], skygen.event_data[event].color, 0.75) -- Indoors
                        event_biome_colors[6] = skygen.colorize(biome_colors[6], skygen.event_data[event].color_sun, 0.75) -- Dawn
                        event_biome_colors[7] = skygen.colorize(biome_colors[7], skygen.event_data[event].color_sun, 0.75) -- Dawn Horizon
                        event_biome_colors[8] = skygen.colorize(biome_colors[8], skygen.event_data[event].color_night, 0.75) -- Night
                        event_biome_colors[9] = skygen.colorize(biome_colors[9], skygen.event_data[event].color_night, 0.75) -- Night Horizon
                        skygen.biomes[biome_name].event_colors = event_biome_colors
                    end
                end
            end
            skygen.sky_globalstep(players)
        end
    else
        skygen.sky_globalstep(players)
    end
end)

skygen.deactivate = function(player)
    skygen.storage:set_string(player .. "_sky_state", "inactive")
    local player_obj = minetest.get_player_by_name(player)
    player_obj:set_sky()
    player_obj:set_sun()
    player_obj:set_stars(skygen.default_star_params)
    player_obj:set_moon()
    player_obj:set_clouds()
    player_obj:override_day_night_ratio(nil)
end

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
        elseif parameters[1] == "shadow" then
            skygen.storage:set_int(name .. "_shadow_intensity", parameters[2])
            minetest.get_player_by_name(name):set_lighting({
                shadows = { intensity = parameters[2] }
            })
        elseif parameters[1] == "toggle_star_color" then
            if skygen.storage:get_string(name .. "_star_coloring") == "true" then
                skygen.storage:set_string(name .. "_star_coloring", "false")
            elseif skygen.storage:get_string(name .. "_star_coloring") == "false" then
                skygen.storage:set_string(name .. "_star_coloring", "true")
            end
        elseif parameters[1] == "toggle_scaling" then
            if skygen.storage:get_string(name .. "_scaling") == "true" then
                skygen.storage:set_string(name .. "_scaling", "false")
            elseif skygen.storage:get_string(name .. "_scaling") == "false" then
                skygen.storage:set_string(name .. "_scaling", "true")
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
            if skygen.storage:get_string("event") ~= "none" then
                local previous_event = skygen.event_data[skygen.storage:get_string("event")].description
                minetest.chat_send_all("The " .. previous_event .. " has ended!")
                skygen.storage:set_string("event", "none")
                skygen.start = 1
            end
        else
            for i=1,#skygen.events do
                if skygen.events[i] == param then
                    local new_event = skygen.event_data[param].description
                    skygen.storage:set_string("event", param)
                    skygen.start = 1
                    minetest.chat_send_all("The " .. new_event .. " has arrived!")
                end
            end
        end
    end
})
