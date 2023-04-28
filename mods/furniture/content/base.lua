-- Sound tables
furniture.storage_sounds = {
    default = {"doors_door_open", 0.06},
    wood = {"doors_door_open", 0.06},
    steelblock = {"doors_steel_door_open", 0.2}
}
furniture.door_open_sounds = {
    default = {"doors_door_open", 0.06},
    wood = {"doors_door_open", 0.06},
    steelblock = {"doors_steel_door_open", 0.2},
    glass = {"doors_glass_door_open", 0.3},
    obsidian_glass = {"doors_glass_door_open", 0.3},
}
furniture.door_close_sounds = {
    default = {"doors_door_close", 0.13},
    wood = {"doors_door_close", 0.13},
    steelblock = {"doors_steel_door_close", 0.2},
    glass = {"doors_glass_door_close", 0.25},
    obsidian_glass = {"doors_glass_door_close", 0.25},
}

-- Model Definitions
furniture.types = {
    {
        -- name - code name
        -- base - base model, no file extension (leave empty if same as name)
        -- description - description prefix
        -- active [true/false] - does this node swap with a different version when right clicked -- Using crates makes this exclusionary with storage
        -- special_materials - materials other than base, used for crafting (optional, order important)
        -- special_textures - textures other than base (optional, order important)
        -- special_textures_activated - textures other than base for the activated model (optional, order important)
        -- storage - number of rows of inventory, 8 slots each (optional)
        -- box - both the selection and the collision box
        -- box_activated - both the selection and the collision box for the activated counterpart
        -- activate_sound - table containing the blocks and mod-material-specific sounds that play upon activation
        -- deactivate_sound - table containing the blocks and mod-material-specific sounds that play upon activation of the active counterpart
        -- groups - groups which are added to the groups table of the resulting node, can override base node's groups (optional)
        -- groups_active - groups which are added to the groups table of the active node, can override base node's groups (optional)
        -- crafting - an array where each position corresponds to a cell in the crafting grid, values represent materials; 0 is empty, 1 is base and
        -- above are the other materials in the order from special_materials
        -- The following overrides can be applied to the base node, and/or to the active node by appending the _active suffix (all optional):
        -- alpha, sunlight_propagates, light_source, visual_scale, post_effect_color, walkable, pointable, diggable, climbable, move_resistance, buildable_to, floodable, drowning, damage per second.
    },
    {
        name = "chair",
        description = "Chair",
        box = {-0.3125, -0.5, -0.375, 0.3125, 0.6875, 0.3125},
        crafting = {
            {0, 0, 0, 1, 0},
            {0, 0, 0, 2, 0},
            {0, 1, 1, 1, 0},
            {0, 2, 0, 2, 0},
            {0, 2, 0, 2, 0},
        }
    },
    {
        name = "table_square",
        description = "Square Table",
        box = {-0.5, -0.5, -0.5, 0.5, 0.125, 0.5},
        crafting = {
            {0, 0, 0, 0, 0},
            {2, 1, 1, 1, 2},
            {0, 1, 1, 1, 0},
            {0, 2, 0, 2, 0},
            {0, 2, 0, 2, 0},
        }
    },
    {
        name = "table_round",
        description = "Round Table",
        box = {-0.5, -0.5, -0.5, 0.5, 0.125, 0.5},
        crafting = {
            {0, 0, 2, 0, 0},
            {0, 2, 1, 2, 0},
            {2, 1, 1, 1, 2},
            {0, 2, 2, 2, 0},
            {0, 2, 0, 2, 0},
        }
    },
    {
        name = "cabinet",
        description = "Cabinet",
        storage = 4,
        box = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
        activate_sound = furniture.storage_sounds,
        crafting = {
            {0, 0, 0, 0, 0},
            {2, 1, 1, 1, 0},
            {0, 1, 1, 1, 0},
            {2, 1, 1, 1, 0},
            {0, 2, 0, 2, 0},
        }
    },
    {
        name = "half_cabinet",
        description = "Half Cabinet",
        storage = 2,
        box = {-0.5, -2/16, -0.5, 0.5, 0.5, 0.5},
        activate_sound = furniture.storage_sounds,
        crafting = {
            {0, 0, 0, 0, 0},
            {2, 1, 1, 1, 0},
            {0, 1, 1, 1, 0},
            {0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0},
        }
    },
    {
        name = "wardrobe",
        description = "Wardrobe",
        storage = 8,
        box = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
        activate_sound = furniture.storage_sounds,
        crafting = {
            {2, 1, 1, 1, 2},
            {2, 1, 1, 1, 2},
            {2, 1, 1, 1, 2},
            {0, 1, 1, 1, 0},
            {2, 1, 1, 1, 2},
        }
    },
    {
        name = "window_glass",
        base = "window",
        description = "Glass Window",
        special_materials = "blocks:glass",
        special_textures = "blocks_glass.png",
        box = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125},
        crafting = {
            {1, 0, 2, 0, 1},
            {0, 3, 2, 3, 0},
            {2, 2, 2, 2, 2},
            {0, 3, 2, 3, 0},
            {1, 0, 2, 0, 1},
        }
    },
    {
        name = "window_obsidian_glass",
        base = "window",
        description = "Obisdian Glass Window",
        special_materials = "blocks:obsidian_glass",
        special_textures = "blocks_obsidian_glass.png",
        box = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125},
        crafting = {
            {1, 0, 2, 0, 1},
            {0, 3, 2, 3, 0},
            {2, 2, 2, 2, 2},
            {0, 3, 2, 3, 0},
            {1, 0, 2, 0, 1},
        }
    },
    {
        name = "window_amethyst",
        base = "window",
        description = "Amethyst Window",
        special_materials = "blocks:amethyst",
        special_textures = "variations_amethyst.png^[sheet:3x3:1,0",
        box = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125},
        crafting = {
            {1, 0, 2, 0, 1},
            {0, 3, 2, 3, 0},
            {2, 2, 2, 2, 2},
            {0, 3, 2, 3, 0},
            {1, 0, 2, 0, 1},
        }
    },
    {
        name = "window_garnet",
        base = "window",
        description = "Garnet Window",
        special_materials = "blocks:garnet",
        special_textures = "variations_garnet.png^[sheet:3x3:1,0",
        box = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125},
        crafting = {
            {1, 0, 2, 0, 1},
            {0, 3, 2, 3, 0},
            {2, 2, 2, 2, 2},
            {0, 3, 2, 3, 0},
            {1, 0, 2, 0, 1},
        }
    },
    {
        name = "window_amber_glass",
        base = "window",
        description = "Amber Glass Window",
        special_materials = "blocks:amber_glass",
        special_textures = "blocks_amber_glass.png",
        box = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125},
        crafting = {
            {1, 0, 2, 0, 1},
            {0, 3, 2, 3, 0},
            {2, 2, 2, 2, 2},
            {0, 3, 2, 3, 0},
            {1, 0, 2, 0, 1},
        }
    },
    {
        name = "window_amber_medieval_glass",
        base = "window",
        description = "Medieval Amber Glass Window",
        special_materials = "blocks:amber_medieval_glass",
        special_textures = "blocks_amber_glass_medieval.png",
        box = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125},
        crafting = {
            {1, 0, 2, 0, 1},
            {0, 3, 2, 3, 0},
            {2, 2, 2, 2, 2},
            {0, 3, 2, 3, 0},
            {1, 0, 2, 0, 1},
        }
    },
    {
        name = "window_medieval_glass",
        base = "window",
        description = "Medieval Glass Window",
        special_materials = "blocks:medieval_glass",
        special_textures = "blocks_medieval_glass.png",
        box = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125},
        crafting = {
            {1, 0, 2, 0, 1},
            {0, 3, 2, 3, 0},
            {2, 2, 2, 2, 2},
            {0, 3, 2, 3, 0},
            {1, 0, 2, 0, 1},
        }
    },
    {
        name = "shelf_small",
        description = "Small Empty Shelf",
        storage = 2,
        box = {-0.5, -0.5, -0.0625, 0.5, 0.5, 0.5},
        activate_sound = furniture.storage_sounds,
        crafting = {
            {0, 1, 1, 1, 0},
            {2, 0, 0, 0, 2},
            {2, 2, 2, 2, 2},
            {2, 0, 0, 0, 2},
            {0, 1, 1, 1, 0},
        }
    },
    {
        name = "shelf_node_small",
        description = "Small Full-Node Empty Shelf",
        storage = 3,
        box = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
        activate_sound = furniture.storage_sounds,
        crafting = {
            {0, 1, 1, 1, 0},
            {2, 1, 1, 1, 2},
            {2, 2, 2, 2, 2},
            {2, 1, 1, 1, 2},
            {0, 1, 1, 1, 0},
        }
    },
    {
        name = "shelf_small_book",
        base = "shelf_small_filled",
        description = "Small Bookshelf",
        special_materials = "blocks:book",
        special_textures = "furniture_bookshelf1.png",
        box = {-0.5, -0.5, -0.0625, 0.5, 0.5, 0.5},
        crafting = {
            {0, 1, 1, 1, 0},
            {2, 0, 3, 0, 2},
            {2, 2, 2, 2, 2},
            {2, 0, 3, 0, 2},
            {0, 1, 1, 1, 0},
        }
    },
    {
        name = "shelf_node_small_book",
        base = "shelf_node_small_filled",
        description = "Small Node-Sized Bookshelf",
        special_materials = "blocks:book",
        special_textures = "furniture_bookshelf1.png",
        box = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
        crafting = {
            {0, 1, 1, 1, 0},
            {2, 1, 3, 1, 2},
            {2, 2, 2, 2, 2},
            {2, 1, 3, 1, 2},
            {0, 1, 1, 1, 0},
        }
    },
    {
        name = "shelf_wide",
        description = "Wide Empty Shelf",
        storage = 4,
        box = {-1.0, -0.5, -0.0625, 1.0, 0.5, 0.5},
        activate_sound = furniture.storage_sounds,
        crafting = {
            {1, 1, 1, 1, 1},
            {2, 2, 0, 0, 2},
            {2, 2, 2, 2, 2},
            {2, 0, 0, 2, 2},
            {1, 1, 1, 1, 1},
        }
    },
    {
        name = "shelf_wide_book",
        base = "shelf_wide_filled",
        description = "Wide Bookshelf",
        special_materials = "blocks:book",
        special_textures = "furniture_bookshelf_wide1.png",
        box = {-1.0, -0.5, -0.0625, 1.0, 0.5, 0.5},
        crafting = {
            {1, 1, 1, 1, 1},
            {2, 2, 3, 3, 2},
            {2, 2, 2, 2, 2},
            {2, 3, 3, 2, 2},
            {1, 1, 1, 1, 1},
        }
    },
    -- Stonelike
    {
        name = "window_glass_thick",
        base = "window_thick",
        description = "Glass Window",
        special_materials = "blocks:glass",
        special_textures = "blocks_glass.png",
        box = {-0.5, -0.5, -0.1875, 0.5, 0.5, 0.1875},
        crafting = {
            {0, 1, 1, 1, 0},
            {1, 2, 2, 2, 1},
            {1, 2, 3, 2, 1},
            {1, 2, 2, 2, 1},
            {0, 1, 1, 1, 0},
        }
    },
    {
        name = "window_obsidian_glass_thick",
        base = "window_thick",
        description = "Obisidan Glass Window",
        special_materials = "blocks:obsidian_glass",
        special_textures = "blocks_obsidian_glass.png",
        box = {-0.5, -0.5, -0.1875, 0.5, 0.5, 0.1875},
        crafting = {
            {0, 1, 1, 1, 0},
            {1, 2, 2, 2, 1},
            {1, 2, 3, 2, 1},
            {1, 2, 2, 2, 1},
            {0, 1, 1, 1, 0},
        }
    },
    {
        name = "window_amethyst_thick",
        base = "window_thick",
        description = "Amethyst Window",
        special_materials = "blocks:amethyst",
        special_textures = "variations_amethyst.png^[sheet:3x3:1,0",
        box = {-0.5, -0.5, -0.1875, 0.5, 0.5, 0.1875},
        crafting = {
            {0, 1, 1, 1, 0},
            {1, 2, 2, 2, 1},
            {1, 2, 3, 2, 1},
            {1, 2, 2, 2, 1},
            {0, 1, 1, 1, 0},
        }
    },
    {
        name = "window_garnet_thick",
        base = "window_thick",
        description = "Garnet Window",
        special_materials = "blocks:garnet",
        special_textures = "variations_garnet.png^[sheet:3x3:1,0",
        box = {-0.5, -0.5, -0.1875, 0.5, 0.5, 0.1875},
        crafting = {
            {0, 1, 1, 1, 0},
            {1, 2, 2, 2, 1},
            {1, 2, 3, 2, 1},
            {1, 2, 2, 2, 1},
            {0, 1, 1, 1, 0},
        }
    },
    {
        name = "window_amber_glass_thick",
        base = "window_thick",
        description = "Amber Glass Window",
        special_materials = "blocks:amber_glass",
        special_textures = "blocks_amber_glass.png",
        box = {-0.5, -0.5, -0.1875, 0.5, 0.5, 0.1875},
        crafting = {
            {0, 1, 1, 1, 0},
            {1, 2, 2, 2, 1},
            {1, 2, 3, 2, 1},
            {1, 2, 2, 2, 1},
            {0, 1, 1, 1, 0},
        }
    },
    {
        name = "window_amber_medieval_glass_thick",
        base = "window_thick",
        description = "Medieval Amber Glass Window",
        special_materials = "blocks:amber_medieval_glass",
        special_textures = "blocks_amber_glass_medieval.png",
        box = {-0.5, -0.5, -0.1875, 0.5, 0.5, 0.1875},
        crafting = {
            {0, 1, 1, 1, 0},
            {1, 2, 2, 2, 1},
            {1, 2, 3, 2, 1},
            {1, 2, 2, 2, 1},
            {0, 1, 1, 1, 0},
        }
    },
    {
        name = "window_medieval_glass_thick",
        base = "window_thick",
        description = "Medieval Glass Window",
        special_materials = "blocks:medieval_glass",
        special_textures = "blocks_medieval_glass.png",
        box = {-0.5, -0.5, -0.1875, 0.5, 0.5, 0.1875},
        crafting = {
            {0, 1, 1, 1, 0},
            {1, 2, 2, 2, 1},
            {1, 2, 3, 2, 1},
            {1, 2, 2, 2, 1},
            {0, 1, 1, 1, 0},
        }
    },
    {
        name = "chair_thick",
        description = "Chair",
        box = {-6/16, -0.5, -5/16, 6/16, 0.5, 7/16},
        crafting = {
            {0, 0, 0, 1, 0},
            {0, 0, 0, 2, 0},
            {0, 1, 1, 1, 0},
            {0, 2, 1, 2, 0},
            {2, 2, 2, 2, 2},
        }
    },
    {
        name = "table_square_thick",
        description = "Square Table",
        box = {-0.5, -0.5, -0.5, 0.5, 0.125, 0.5},
        crafting = {
            {0, 0, 0, 0, 0},
            {2, 1, 1, 1, 2},
            {2, 1, 1, 1, 2},
            {0, 2, 1, 2, 0},
            {0, 2, 1, 2, 0},
        }
    },
    {
        name = "table_round_thick",
        description = "Round Table",
        box = {-0.5, -0.5, -0.5, 0.5, 0.125, 0.5},
        crafting = {
            {0, 0, 2, 0, 0},
            {0, 2, 1, 2, 0},
            {2, 1, 1, 1, 2},
            {2, 2, 2, 2, 2},
            {2, 2, 1, 2, 2},
        }
    },
    {
        name = "shelf_small_thick",
        description = "Small Empty Shelf",
        storage = 2,
        box = {-0.5, -0.5, -0.0625, 0.5, 0.5, 0.5},
        activate_sound = furniture.storage_sounds,
        crafting = {
            {0, 1, 1, 1, 0},
            {2, 0, 0, 0, 2},
            {2, 2, 2, 2, 2},
            {2, 0, 0, 0, 2},
            {0, 1, 1, 1, 0},
        }
    },
    {
        name = "shelf_small_thick_book",
        base = "shelf_small_filled_thick",
        description = "Small Bookshelf",
        special_materials = "blocks:book",
        special_textures = "furniture_bookshelf_thick1.png",
        box = {-0.5, -0.5, -0.0625, 0.5, 0.5, 0.5},
        crafting = {
            {0, 1, 1, 1, 0},
            {2, 0, 3, 0, 2},
            {2, 2, 2, 2, 2},
            {2, 0, 3, 0, 2},
            {0, 1, 1, 1, 0},
        }
    },
    {
        name = "shelf_node_small_thick_book",
        base = "shelf_node_small_filled_thick",
        description = "Small Node-Sized Bookshelf",
        special_materials = "blocks:book",
        special_textures = "furniture_bookshelf_thick1.png",
        box = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
        crafting = {
            {0, 1, 1, 1, 0},
            {2, 1, 3, 1, 2},
            {2, 2, 2, 2, 2},
            {2, 1, 3, 1, 2},
            {0, 1, 1, 1, 0},
        }
    },
    {
        name = "shelf_node_small_thick",
        description = "Small Node-Sized Empty Shelf",
        storage = 2,
        box = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
        activate_sound = furniture.storage_sounds,
        crafting = {
            {0, 1, 1, 1, 0},
            {2, 1, 1, 1, 2},
            {2, 2, 2, 2, 2},
            {2, 1, 1, 1, 2},
            {0, 1, 1, 1, 0},
        }
    },
    {
        name = "shelf_wide_thick",
        description = "Wide Empty Shelf",
        storage = 4,
        box = {-1.0, -0.5, -0.0625, 1.0, 0.5, 0.5},
        activate_sound = furniture.storage_sounds,
        crafting = {
            {1, 1, 1, 1, 1},
            {2, 2, 0, 0, 2},
            {2, 2, 2, 2, 2},
            {2, 0, 0, 2, 2},
            {1, 1, 1, 1, 1},
        }
    },
    {
        name = "shelf_wide_thick_book",
        base = "shelf_wide_filled_thick",
        description = "Wide Bookshelf",
        special_materials = "blocks:book",
        special_textures = "furniture_bookshelf_wide_thick1.png",
        box = {-1.0, -0.5, -0.0625, 1.0, 0.5, 0.5},
        crafting = {
            {1, 1, 1, 1, 1},
            {2, 2, 3, 3, 2},
            {2, 2, 2, 2, 2},
            {2, 3, 3, 2, 2},
            {1, 1, 1, 1, 1},
        }
    },
    {
        name = "cabinet_thick",
        description = "Cabinet",
        storage = 4,
        box = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
        activate_sound = furniture.storage_sounds,
        crafting = {
            {0, 0, 0, 0, 0},
            {2, 1, 1, 1, 0},
            {0, 1, 1, 1, 0},
            {2, 1, 1, 1, 0},
            {0, 2, 0, 2, 0},
        }
    },
    {
        name = "half_cabinet_thick",
        description = "Half Cabinet",
        storage = 2,
        box = {-0.5, -2/16, -0.5, 0.5, 0.5, 0.5},
        activate_sound = furniture.storage_sounds,
        crafting = {
            {0, 0, 0, 0, 0},
            {2, 1, 1, 1, 0},
            {0, 1, 1, 1, 0},
            {0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0},
        }
    },
    {
        name = "wardrobe_thick",
        description = "Wardrobe",
        storage = 8,
        box = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
        activate_sound = furniture.storage_sounds,
        crafting = {
            {2, 1, 1, 1, 2},
            {2, 1, 1, 1, 2},
            {2, 1, 1, 1, 2},
            {0, 1, 1, 1, 0},
            {2, 1, 1, 1, 2},
        }
    },
    -- Glasslike
    {
        name = "table_square_glass",
        description = "Square Table",
        box = {-0.5, -0.5, -0.5, 0.5, 0.125, 0.5},
        crafting = {
            {0, 0, 0, 0, 0},
            {2, 2, 2, 2, 2},
            {0, 1, 1, 1, 0},
            {0, 2, 0, 2, 0},
            {0, 2, 0, 2, 0},
        }
    },
    {
        name = "table_round_glass",
        description = "Round Table",
        box = {-0.5, -0.5, -0.5, 0.5, 0.125, 0.5},
        crafting = {
            {0, 0, 2, 0, 0},
            {0, 2, 2, 2, 0},
            {2, 2, 2, 2, 2},
            {0, 2, 2, 2, 0},
            {0, 2, 0, 2, 0},
        }
    },
    {
        name = "chair_glass",
        description = "Chair",
        box = {-5/16, -0.5, -3/16, 5/16, 11/16, 6/16},
        crafting = {
            {0, 0, 0, 2, 0},
            {0, 0, 0, 2, 0},
            {0, 1, 1, 1, 0},
            {0, 2, 0, 2, 0},
            {0, 2, 0, 2, 0},
        }
    },
    {
        name = "door_glass",
        description = "Door",
        generate_locked = true,
        active = true,
        box = {-0.5, -0.5, -0.5, 0.5, 1.5, -6/16},
        box_activated = {-0.5, -0.5, -0.5, -6/16, 1.5, 0.5},
        activate_sound = furniture.door_open_sounds,
        deactivate_sound = furniture.door_close_sounds,
        crafting = {
            {0, 1, 1, 1, 0},
            {0, 1, 1, 1, 0},
            {0, 2, 1, 1, 0},
            {0, 1, 1, 1, 0},
            {0, 1, 1, 1, 0},
        }
    },
    {
        name = "door_flipped_glass",
        description = "Door (flipped)",
        generate_locked = true,
        active = true,
        box = {-0.5, -0.5, -0.5, 0.5, 1.5, -6/16},
        box_activated = {0.5, -0.5, -0.5, 6/16, 1.5, 0.5},
        activate_sound = furniture.door_open_sounds,
        deactivate_sound = furniture.door_close_sounds,
        crafting = {
            {0, 1, 1, 1, 0},
            {0, 1, 1, 1, 0},
            {0, 1, 1, 2, 0},
            {0, 1, 1, 1, 0},
            {0, 1, 1, 1, 0},
        }
    },
    -- Universal
    {
        name = "mirror",
        description = "Mirror",
        special_materials = "blocks:glass",
        special_textures = "furniture_glass_full.png",
        box = {-4/16, -7/16, 6/16, 4/16, 7/16, 8/16},
        crafting = {
            {0, 2, 2, 2, 0},
            {2, 0, 0, 0, 2},
            {2, 0, 3, 0, 2},
            {2, 0, 0, 0, 2},
            {0, 2, 2, 2, 0},
        }
    },
    {
        name = "flowerpot",
        description = "Flowerpot",
        special_materials = "blocks:dirt",
        special_textures = "blocks_dirt.png",
        box = {-7/16, -8/16, -7/16, 7/16, 8/16, 7/16},
        crafting = {
            {0, 2, 3, 2, 0},
            {0, 2, 1, 2, 0},
            {2, 1, 2, 1, 2},
            {2, 1, 2, 1, 2},
            {0, 2, 0, 2, 0},
        }
    },
    {
        name = "door",
        description = "Door",
        generate_locked = true,
        active = true,
        box = {-0.5, -0.5, -0.5, 0.5, 1.5, -4/16},
        box_activated = {-0.5, -0.5, -0.5, -4/16, 1.5, 0.5},
        activate_sound = furniture.door_open_sounds,
        sunlight_propagates = false,
        sunlight_propagates_active = true,
        deactivate_sound = furniture.door_close_sounds,
        crafting = {
            {0, 1, 1, 1, 0},
            {0, 1, 1, 1, 0},
            {0, 2, 1, 1, 0},
            {0, 1, 1, 1, 0},
            {0, 1, 1, 1, 0},
        }
    },
    {
        name = "door_flipped",
        description = "Door (flipped)",
        generate_locked = true,
        active = true,
        box = {-0.5, -0.5, -0.5, 0.5, 1.5, -4/16},
        box_activated = {0.5, -0.5, -0.5, 4/16, 1.5, 0.5},
        activate_sound = furniture.door_open_sounds,
        sunlight_propagates = false,
        sunlight_propagates_active = true,
        deactivate_sound = furniture.door_close_sounds,
        crafting = {
            {0, 1, 1, 1, 0},
            {0, 1, 1, 1, 0},
            {0, 1, 1, 2, 0},
            {0, 1, 1, 1, 0},
            {0, 1, 1, 1, 0},
        }
    }
}

-- Sets
furniture.woodlike_set = {
    "chair",
    "table_square",
    "table_round",
    "shelf_small",
    "shelf_node_small",
    "shelf_wide",
    "window_glass",
    "window_obsidian_glass",
    "window_amethyst",
    "window_garnet",
    "window_amber_glass",
    "window_amber_medieval_glass",
    "window_medieval_glass",
    "cabinet",
    "half_cabinet",
    "wardrobe",
    "mirror",
    "flowerpot",
    "door",
    "door_flipped",
    "shelf_small_book",
    "shelf_node_small_book",
    "shelf_wide_book",
}

furniture.stonelike_set = {
    "chair_thick",
    "table_square_thick",
    "table_round_thick",
    "shelf_small_thick",
    "shelf_node_small_thick",
    "shelf_wide_thick",
    "cabinet_thick",
    "half_cabinet_thick",
    "wardrobe_thick",
    "window_glass_thick",
    "window_obsidian_glass_thick",
    "window_amethyst_thick",
    "window_garnet_thick",
    "window_amber_glass_thick",
    "window_amber_medieval_glass_thick",
    "window_medieval_glass_thick",
    "mirror",
    "flowerpot",
    "door",
    "door_flipped",
    "shelf_small_thick_book",
    "shelf_node_small_thick_book",
    "shelf_wide_thick_book",
}

furniture.glasslike_set = {
    "table_square_glass",
    "table_round_glass",
    "chair_glass",
    "door_glass",
    "door_flipped_glass",
}