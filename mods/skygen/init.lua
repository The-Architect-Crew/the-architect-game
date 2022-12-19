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
    -- Recovery Variables
    if skygen.storage:get_string(name .. "_sky_state") == "skybox" then
        skygen.storage:set_string(name .. "_sky_state", "skybox_reset")
    elseif skygen.storage:get_string(name .. "_sky_state") == "inactive" then
        skygen.storage:set_string(name .. "_sky_state", "inactive_reset")
    elseif skygen.storage:get_string(name .. "_sky_state") == "transition" then
        skygen.storage:set_string(name .. "_sky_state", "biome")
    end
    -- Customization Variables
    if skygen.storage:get_string(name .. "_star_coloring") == "" then
        skygen.storage:set_string(name .. "_star_coloring", "true")
    end
    if skygen.storage:get_string(name .. "_scaling") == "" then
        skygen.storage:set_string(name .. "_scaling", "true")
    end
    if skygen.storage:get_int(name .. "_shadow_intensity") == "" then
        skygen.storage:set_int(name .. "_shadow_intensity", 0.33)
    end
    if (skygen.storage:get_string(name .. "_sky_state") == "") then
        skygen.storage:set_string(name .. "_sky_state", "biome")
    end
    player:set_lighting({ shadows = { intensity = skygen.storage:get_int(name .. "_shadow_intensity") } })
end)

minetest.register_on_leaveplayer(function(player)
    name = player:get_player_name()
    if skygen.storage:get_string(name .. "_sky_state") == "skybox" then
        skygen.storage:set_string(name .. "_sky_state", "skybox_reset")
    elseif skygen.storage:get_string(name .. "_sky_state") == "inactive" then
        skygen.storage:set_string(name .. "_sky_state", "inactive_reset")
    elseif skygen.storage:get_string(name .. "_sky_state") == "transition" then
        skygen.storage:set_string(name .. "_sky_state", "biome")
    end
end)

skygen.sky_globalstep = function(players)
    for i=1, #players do
        local player = players[i]
        local player_name = player:get_player_name()
        local sky_state = skygen.storage:get_string(player_name .. "_sky_state")
        local active_skybox = skygen.storage:get_string(player_name .. "_skybox")

        -- Sky Biome Override
        local playheight = player:get_pos().y
        if (playheight > skygen.sky_biome_start) then
            if (active_skybox == "sky") and (sky_state == "skybox") then
                return
            else
                skygen.save_on_override(player)
                skygen.set_skybox(player, "sky")
            end
        elseif (playheight < skygen.sky_biome_start) then
            if (active_skybox == "sky") and (sky_state == "skybox") then
                skygen.recover_from_override(player)
            end
        end

        -- The Loop
        if (sky_state == "skybox_reset") then
            skygen.set_skybox(player, skygen.storage:get_string(player_name .. "_skybox"))
            return
        elseif (sky_state == "inactive_reset") then
            skygen.deactivate(player_name)
            return
        elseif (sky_state == "biome") then
            local biome_data = skygen.fetch_biome(player)
            local biome_name = biome_data[1]
            local previous_biome_name = skygen.previous_biome[player_name]
            if previous_biome_name == biome_name then
                return
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
    if skygen.start == 1 then
        skygen.start = 0
        skygen.build_color_tables()
    end
    skygen.sky_globalstep(players)
end)

skygen.save_on_override = function(player)
    local player_name = player:get_player_name()
    local sky_state = skygen.storage:get_string(player_name .. "_sky_state")
    local saved_state
    if sky_state == "skybox" then
        saved_state = "skybox_reset"
        local backup_skybox = skygen.storage:get_string(player_name .. "_skybox")
        skygen.storage:set_string(player_name .. "_backup_skybox", backup_skybox)
    elseif sky_state == "inactive" then
        saved_state = "inactive_reset"
    else
        saved_state = sky_state
    end
    skygen.storage:set_string(player_name .. "_backup_state", saved_state) -- Save the selection before the override
end

skygen.recover_from_override = function(player)
    local player_name = player:get_player_name()
    local backup_state = skygen.storage:get_string(player_name .. "_backup_state")
    local backup_skybox = skygen.storage:get_string(player_name .. "_backup_skybox")
    skygen.storage:set_string(player_name .. "_sky_state", backup_state) -- Apply selection from before the override
    if backup_state == "skybox_reset" then -- Saved skybox in this case (state saved as skybox_reset above)
        skygen.storage:set_string(player_name .. "_skybox", backup_skybox)
    else
        skygen.storage:set_string(player_name .. "_skybox", "none")
    end
    if skygen.storage:get_string(player_name .. "_backup_state") == "biome"  then
        skygen.biome_mode(player_name)
    end
end

skygen.build_color_tables = function()
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
    if skygen.storage:get_string("event") ~= "none" then
        for i=1,#skygen.events do
            if skygen.storage:get_string("event") == skygen.events[i] then
                for j=1, #skygen.biome_names do
                    local event = skygen.storage:get_string("event")
                    local biome_name = skygen.biome_names[j]
                    local biome_colors = skygen.biomes[biome_name].colors
                    local event_biome_colors = {}
                    event_biome_colors[1] = skygen.colorize(biome_colors[1], skygen.event_data[event].color, 0.5) -- Day
                    event_biome_colors[2] = skygen.colorize(biome_colors[2], skygen.event_data[event].color, 0.5) -- Day Horizon
                    event_biome_colors[3] = skygen.colorize(biome_colors[3], skygen.event_data[event].color_sun, 0.5) -- Sun
                    event_biome_colors[4] = skygen.colorize(biome_colors[4], skygen.event_data[event].color_moon, 0.5) -- Moon
                    event_biome_colors[5] = skygen.colorize(biome_colors[5], skygen.event_data[event].color, 0.5) -- Indoors
                    event_biome_colors[6] = skygen.colorize(biome_colors[6], skygen.event_data[event].color_sun, 0.5) -- Dawn
                    event_biome_colors[7] = skygen.colorize(biome_colors[7], skygen.event_data[event].color_sun, 0.5) -- Dawn Horizon
                    event_biome_colors[8] = skygen.colorize(biome_colors[8], skygen.event_data[event].color_night, 0.5) -- Night
                    event_biome_colors[9] = skygen.colorize(biome_colors[9], skygen.event_data[event].color_night, 0.5) -- Night Horizon
                    skygen.biomes[biome_name].event_colors = event_biome_colors
                end
            end
        end
    end
end

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
