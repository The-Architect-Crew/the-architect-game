furniture.steampunk_content = {
    {
        name = "gas_lamp_wall",
        description = "Gas Wall Lamp",
        box = {-3/16, -7/16, -3/16, 3/16, 8/16, 8/16},
        sunlight_propagates = true,
        light_source = 8,
        special_materials = "blocks:glass",
        special_textures = {"blocks_glass.png", {
            name = "furniture_gaslamp_animated.png",
            animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0}
        }},
        crafting = {
            {0, 3, 0, 3, 0},
            {0, 3, 0, 3, 0},
            {0, 2, 2, 2, 0},
            {0, 0, 2, 0, 0},
            {0, 0, 2, 2, 0},
        }
    },
    {
        name = "gas_lamp_big_base",
        description = "Big Gas Lamp Base",
        box = {-4/16, -8/16, -4/16, 4/16, 8/16, 4/16},
        sunlight_propagates = true,
        crafting = {
            {0, 0, 0, 0, 0},
            {0, 0, 2, 0, 0},
            {0, 0, 2, 0, 0},
            {0, 2, 2, 2, 0},
            {0, 2, 2, 2, 0},
        }
    },
    {
        name = "gas_lamp_big_lantern",
        description = "Big Gas Lamp Lantern",
        box = {-8/16, -8/16, -8/16, 8/16, 8/16, 8/16},
        sunlight_propagates = true,
        light_source = 12,
        special_materials = "blocks:glass",
        special_textures = {"blocks_glass.png", {
            name = "furniture_gaslamp_animated.png",
            animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0}
        }},
        crafting = {
            {0, 0, 3, 0, 0},
            {3, 0, 3, 0, 3},
            {3, 2, 2, 2, 3},
            {2, 0, 2, 0, 2},
            {0, 0, 2, 0, 0},
        }
    },
    {
        name = "gas_lamp_street_base",
        description = "Gas Street Lamp Base",
        box = {-8/16, -8/16, -6/16, 8/16, 8/16, 6/16},
        sunlight_propagates = true,
        crafting = {
            {0, 0, 0, 0, 0},
            {0, 0, 2, 0, 0},
            {0, 2, 2, 2, 0},
            {0, 2, 1, 2, 0},
            {0, 2, 1, 2, 0},
        }
    },
    {
        name = "gas_lamp_street_lantern",
        description = "Gas Street Lamp Lantern",
        box = {-4/16, -8/16, -4/16, 4/16, 8/16, 4/16},
        sunlight_propagates = true,
        light_source = 12,
        special_materials = "blocks:glass",
        special_textures = {"blocks_glass.png", {
            name = "furniture_gaslamp_animated.png",
            animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0}
        }},
        crafting = {
            {0, 3, 3, 3, 0},
            {0, 3, 3, 3, 0},
            {0, 3, 3, 3, 0},
            {0, 2, 1, 2, 0},
            {0, 0, 2, 0, 0},
        }
    },
    {
        name = "gas_lamp_pole",
        description = "Gas Lamp Pole",
        box = {-1/16, -8/16, -1/16, 1/16, 8/16, 1/16},
        sunlight_propagates = true,
        crafting = {
            {0, 0, 2, 0, 0},
            {0, 0, 2, 0, 0},
            {0, 0, 2, 0, 0},
            {0, 0, 2, 0, 0},
            {0, 0, 2, 0, 0},
        }
    },
    {
        name = "gas_lamp_pole_x",
        description = "Gas Lamp Pole",
        box = {-8/16, -8/16, -1/16, 8/16, 8/16, 1/16},
        sunlight_propagates = true,
        crafting = {
            {0, 0, 2, 0, 0},
            {0, 0, 2, 0, 0},
            {2, 2, 2, 2, 2},
            {0, 0, 2, 0, 0},
            {0, 0, 2, 0, 0},
        }
    },
    {
        name = "gas_lamp_pole_t",
        description = "Gas Lamp Pole",
        box = {-8/16, -8/16, -1/16, 8/16, 1/16, 1/16},
        sunlight_propagates = true,
        crafting = {
            {0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0},
            {2, 2, 2, 2, 2},
            {0, 0, 2, 0, 0},
            {0, 0, 2, 0, 0},
        }
    },
    {
        name = "gas_lamp_pole_corner",
        description = "Gas Lamp Pole",
        box = {-1/16, -1/16, -1/16, 8/16, 8/16, 1/16},
        sunlight_propagates = true,
        crafting = {
            {0, 0, 2, 0, 0},
            {0, 0, 2, 0, 0},
            {0, 0, 2, 2, 2},
            {0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0},
        }
    },
    {
        name = "gas_lamp_pole_star",
        description = "Gas Lamp Pole",
        box = {-8/16, -8/16, -8/16, 8/16, 8/16, 8/16},
        sunlight_propagates = true,
        crafting = {
            {2, 0, 2, 0, 2},
            {0, 2, 2, 2, 0},
            {2, 2, 2, 2, 2},
            {0, 2, 2, 2, 0},
            {2, 0, 2, 0, 2},
        }
    },
    {
        name = "gas_lamp_pole_halfstar",
        description = "Gas Lamp Pole",
        box = {-8/16, -8/16, -8/16, 8/16, 8/16, 1/16},
        sunlight_propagates = true,
        crafting = {
            {0, 0, 2, 0, 2},
            {0, 0, 2, 2, 0},
            {2, 2, 2, 2, 2},
            {0, 2, 2, 0, 0},
            {2, 0, 2, 0, 0},
        }
    }
}

furniture.steampunk_set = {
    "gas_lamp_wall",
    "gas_lamp_big_base",
    "gas_lamp_big_lantern",
    "gas_lamp_street_base",
    "gas_lamp_street_lantern",
    "gas_lamp_pole",
    "gas_lamp_pole_x",
    "gas_lamp_pole_t",
    "gas_lamp_pole_corner",
    "gas_lamp_pole_star",
    "gas_lamp_pole_halfstar",
}

furniture.table_append(furniture.types, furniture.steampunk_content)