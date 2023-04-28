furniture.bathroom_content = {
    {
        name = "bathroom_faucet",
        description = "Bathroom Faucet",
        box = {-4/16, -6/16, 8/16, 4/16, 3/16, 3/16},
        crafting = {
            {0, 0, 2, 0, 0},
            {0, 0, 2, 0, 0},
            {0, 1, 2, 1, 0},
            {0, 2, 2, 2, 0},
            {0, 0, 0, 0, 0},
        }
    },
    {
        name = "shower_tray",
        description = "Shower Tray",
        box = {-8/16, -8/16, -8/16, 8/16, -5/16, 8/16},
        crafting = {
            {0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0},
            {2, 2, 2, 2, 2},
            {2, 2, 1, 2, 2},
        }
    },
    {
        name = "showerhead",
        description = "Showerhead",
        box = {-2/16, 6/16, 8/16, 2/16, 3/16, -1/16},
        crafting = {
            {0, 0, 0, 0, 0},
            {0, 0, 2, 2, 2},
            {0, 2, 1, 2, 0},
            {0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0},
        }
    },
    {
        name = "bathroom_sink",
        description = "Bathroom Sink",
        box = {-4/16, -8/16, 8/16, 4/16, 9/16, 0/16},
        crafting = {
            {2, 2, 2, 2, 2},
            {0, 0, 1, 0, 0},
            {0, 0, 2, 0, 0},
            {0, 0, 2, 0, 0},
            {0, 2, 2, 2, 0},
        }
    },
    {
        name = "toilet",
        description = "Toilet",
        special_textures = {
            {
                name = "blocks_water_source_animated.png",
                backface_culling = false,
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 2.0,
                },
            },
        },
        box = {-4/16, -8/16, 7/16, 4/16, 15/16, -6/16},
        crafting = {
            {0, 0, 2, 2, 0},
            {0, 2, 2, 1, 2},
            {0, 0, 2, 2, 0},
            {0, 2, 2, 2, 0},
            {2, 2, 1, 1, 2},
        }
    },
    {
        name = "toilet_paper",
        description = "Toilet Paper Holder",
        special_textures = "blocks_wool_white.png",
        special_materials = "blocks:paper",
        box = {-3/16, -4/16, 8/16, 3/16, -1/16, 4/16},
        crafting = {
            {0, 0, 0, 0, 0},
            {0, 2, 0, 2, 0},
            {0, 2, 3, 2, 0},
            {0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0},
        }
    },
    {
        name = "towel_rod",
        description = "Towel Rod",
        special_textures = "blocks_wool_white.png",
        special_materials = "blocks:wool_white",
        box = {-7/16, -7/16, 8/16, 7/16, 2/16, 4/16},
        crafting = {
            {0, 0, 0, 0, 0},
            {2, 0, 0, 0, 2},
            {2, 3, 3, 3, 2},
            {0, 3, 3, 3, 0},
            {0, 0, 0, 0, 0},
        }
    },
}

furniture.bathroom_set = {
    "bathroom_faucet",
    "shower_tray",
    "bathroom_sink",
    "showerhead",
    "bathroom_sink",
    "toilet",
    "toilet_paper",
    "towel_rod"
}

furniture.table_append(furniture.types, furniture.bathroom_content)