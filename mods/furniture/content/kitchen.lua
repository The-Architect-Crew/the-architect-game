furniture.kitchen_content = {
    -- Woodlike
    {
        name = "cabinet_sink",
        description = "Cabinet with Sink",
        storage = 3,
        special_materials = "blocks:steel_ingot",
        special_textures = "variations_steelblock.png^[sheet:3x3:1,0",
        box = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
        activate_sound = furniture.storage_sounds,
        crafting = {
            {0, 0, 0, 0, 0},
            {3, 3, 3, 3, 0},
            {0, 1, 1, 1, 0},
            {2, 1, 1, 1, 0},
            {0, 2, 0, 2, 0},
        }
    },
    -- Stonelike
    {
        name = "cabinet_thick_sink",
        description = "Cabinet with Sink",
        storage = 3,
        special_materials = "blocks:steel_ingot",
        special_textures = "variations_steelblock.png^[sheet:3x3:1,0",
        box = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
        activate_sound = furniture.storage_sounds,
        crafting = {
            {0, 0, 0, 0, 0},
            {3, 3, 3, 3, 0},
            {0, 1, 1, 1, 0},
            {2, 1, 1, 1, 0},
            {0, 2, 0, 2, 0},
        }
    },
    -- Appliances
    {
        name = "teapot",
        description = "Teapot",
        box = {-6/16, -8/16, -3/16, 5/16, 1/16, 3/16},
        sunlight_propagates = true,
        crafting = {
            {0, 0, 2, 0, 0},
            {2, 2, 2, 2, 0},
            {0, 2, 1, 2, 0},
            {0, 2, 1, 0, 0},
            {0, 0, 0, 0, 0},
        }
    },
    {
        name = "toaster",
        description = "Toaster",
        box = {-5/16, -8/16, -3/16, 7/16, -2/16, 3/16},
        sunlight_propagates = true,
        special_textures = "furniture_assembler_void.png",
        crafting = {
            {0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0},
            {0, 2, 2, 2, 0},
            {0, 2, 1, 1, 2},
            {0, 2, 1, 1, 0},
        }
    },
    {
        name = "dining_set",
        description = "Dining Set",
        box = {-9/16, -8/16, -8/16, 9/16, -5/16, 8/16},
        sunlight_propagates = true,
        crafting = {
            {2, 0, 0, 0, 2},
            {1, 2, 2, 2, 1},
            {1, 2, 2, 2, 2},
            {2, 2, 2, 2, 2},
            {2, 0, 0, 0, 2},
        }
    },
    {
        name = "cooking_pot_small",
        description = "Small Cooking Pot",
        box = {-3/16, -8/16, -8/16, 3/16, -3/16, 8/16},
        sunlight_propagates = true,
        crafting = {
            {0, 2, 2, 2, 0},
            {0, 2, 2, 2, 0},
            {0, 2, 2, 2, 0},
            {0, 0, 2, 0, 0},
            {0, 0, 2, 0, 0},
        }
    },
    {
        name = "cooking_pot_large",
        description = "Large Cooking Pot",
        box = {-7/16, -8/16, -5/16, 7/16, 1/16, 5/16},
        sunlight_propagates = true,
        crafting = {
            {0, 2, 2, 2, 0},
            {2, 2, 2, 2, 2},
            {2, 0, 1, 0, 2},
            {2, 2, 2, 2, 2},
            {0, 2, 2, 2, 0},
        }
    },
    {
        name = "cooking_pan",
        description = "Cooking Pan",
        box = {-4/16, -8/16, -8/16, 4/16, -6/16, 8/16},
        sunlight_propagates = true,
        crafting = {
            {0, 2, 2, 2, 0},
            {0, 2, 1, 2, 0},
            {0, 2, 2, 2, 0},
            {0, 0, 2, 0, 0},
            {0, 0, 2, 0, 0},
        }
    }
}

furniture.kitchen_wood_pieces = {
    "cabinet_sink"
}

furniture.kitchen_stone_pieces = {
    "cabinet_thick_sink"
}

furniture.house_appliances = {
    "teapot",
    "toaster",
    "dining_set",
    "cooking_pot_small",
    "cooking_pot_large",
    "cooking_pan"
}

furniture.table_append(furniture.woodlike_set, furniture.kitchen_wood_pieces)
furniture.table_append(furniture.stonelike_set, furniture.kitchen_stone_pieces)

furniture.table_append(furniture.types, furniture.kitchen_content)
