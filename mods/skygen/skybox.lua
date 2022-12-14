-- Functions and data related to the skybox mode

skygen.skybox_status = {}

skygen.set_skybox = function(player, skybox)
    skygen.skybox_status[player:get_player_name()] = skybox
    skygen.sky_state[player:get_player_name()] = "skybox"
    local skybox_data = skygen.skyboxes[skybox]
    local skybox_textures = {}
    for i=1,6 do
        skybox_textures[i] = "skygen_" .. skybox .. i .. ".png"
    end
    player:set_sky({
        type = "skybox",
        base_color = skybox_data.color,
        textures = skybox_textures,
        clouds =  skybox_data.clouds,         
    })
    if skybox_data.time ~= nil then
        player:override_day_night_ratio(skybox_data.time / 12000)
    end
    if skybox_data.change_sun == true then
        local sun_texture = ""
        local sunrisebg_texture = ""
        if skybox_data.sun_texture == "default" then
            sun_texture = "sun.png"
        else
            sun_texture = "skygen_" .. skybox .. "_sun.png"
        end
        if (skybox_data.sunrisebg_texture == "default") or (skybox_data.sunrisebg_texture == nil) then
            sunrisebg_texture = "sunrisebg.png"
        else
            sunrisebg_texture = "skygen_" .. skybox .. "_sunrisebg.png"
        end
        player:set_sun({
            texture = sun_texture,
            sunrise = sunrisebg_texture,
            sunrise_visible = skybox_data.sunrise_visible,
            scale = skybox_data.sun_scale,
        })
    elseif skybox_data.change_sun == "none" then
        player:set_sun({
            visible = false,
            sunrise_visible = false,
        })
    end
    if skybox_data.change_moon == true then
        local moon_texture = ""
        if skybox_data.moon_texture == "default" then
            moon_texture = "moon.png"
        else
            moon_texture = "skygen_" .. skybox .. "_moon.png"
        end
        player:set_moon({
            texture = moon_texture,
            scale = skybox_data.moon_scale,
        })
    elseif skybox_data.change_moon == "none" then
        player:set_moon({
            visible = false,
        })
    end
    if skybox_data.change_stars == true then
        player:set_stars({
            count = skybox_data.star_count,
            color = skybox_data.star_color,
            scale = skybox_data.star_scale,
        })
    elseif skybox_data.change_stars == "none" then
        player:set_stars({
            visible = false,
        })
    end
    if skybox_data.change_clouds == true then
        player:set_clouds({
            density = skybox_data.cloud_density,
            color = skybox_data.cloud_color,
            ambient = skybox_data.cloud_ambient,
            height = skybox_data.cloud_height,
            thickness = skybox_data.cloud_thickness,
            speed = skybox_data.cloud_speed,
        })
    elseif skybox_data.change_clouds == "none" then
        player:set_clouds({
            density = 0,
        })
    end
end

skygen.biome_mode = function(player)
    skygen.skybox_status[player] = "none"
    skygen.sky_state[player] = "biome"
    skygen.previous_biome[player] = nil
    player_obj = minetest.get_player_by_name(player)
    player_obj:override_day_night_ratio(nil)
    player_obj:set_sun()
    player_obj:set_moon()
    player_obj:set_stars(skygen.default_star_params)
end
