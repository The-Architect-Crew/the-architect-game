skygen.skyboxes.test_sky = {
    description = "Test", -- Shown when the sky is set to this

    color = '#402639', -- Main Skybox Color, colorizes the fog
    clouds = true,
    time = 5000, -- Time of the day when the skybox is set (0-12000), remove the line for default cycle

    change_sun = true, -- Use "none" to remove, false for default. Same for below
    sunrise_visible = false,
    sun_scale = 8,
    change_moon = "none",
    -- moon_scale
    change_stars = "none",
    -- star_count
    -- star_color
    -- star_scale
    change_clouds = "none",
    -- cloud_density
    -- cloud_color
    -- cloud_ambient
    -- cloud_height
    -- cloud_thickness
    -- cloud_speed
}