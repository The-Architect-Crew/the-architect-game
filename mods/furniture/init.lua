furniture = {}

local path = minetest.get_modpath("furniture")

furniture.craftstation_materials = {
    "blocks:wood",
    "blocks:stone",
    "blocks:sandstone",
    "blocks:obsidian",
    "blocks:basalt",
    "blocks:concrete",
    {"blocks:marble", "blocks:goldblock"},
    {"blocks:rustblock", "blocks:rustblock"}
}

-- These are furniture in the sense that they're models
dofile(path.."/assembler.lua")
dofile(path.."/cutter.lua")
dofile(path.."/engraver.lua")
dofile(path.."/tablesaw.lua")

-- Anything that contains crafting registrations has to go after craftstations
dofile(path.."/steampunk.lua")

-- And these are furniture since players can't get the stuff otherwise
dofile(path.."/craftitems.lua")
dofile(path.."/crafts.lua")

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
            {0, 0, 0, 0, 2},
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
    },
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
    "shelf_wide_book"
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
    "door_flipped"
}

furniture.glasslike_set = {
    "table_square_glass",
    "table_round_glass",
    "chair_glass",
    "door_glass",
    "door_flipped_glass",
}

-- Helper functions
furniture.table_contains = function(term, table)
    if (table == nil) then
        return true
    else
        for i=1, #table do
            if (term == table[i]) then
                return true
            end
        end
    end
end

furniture.table_copy = function(table)
    local copy = {}
    for table_key, table_value in pairs(table) do
        copy[table_key] = table_value
    end
    return copy
end

furniture.dictionary_append = function(table, input_table)
    for intable_key, intable_value in pairs(input_table) do
        table[intable_key] = intable_value
    end
end

furniture.table_append = function(table, input_table)
    local table_len = #table
    for i=1,table_len do
        table[table_len + i] = input_table[i]
    end
end

-- Furniture registration
function furniture.register(base_node, limit, materials, texture)
    for i=1, #furniture.types do
        local fdef = furniture.types[i]
        if furniture.table_contains(fdef.name, limit) then
            furniture.assemble_node(base_node, i, materials, texture)
            furniture.register_crafting(base_node, i, materials, false)
            if fdef.generate_locked then
                furniture.register_crafting(base_node, i, materials, true)
            end
        end
    end
end

function furniture.assemble_node(base_node, tablep, materials, texture)
    local fdef = furniture.types[tablep]
    local base_definition = minetest.registered_nodes[base_node]
    local sname = string.match(base_node, ':(.*)')
    local modname = string.match(base_node, '(.*):')
    local esname = modname .. "_" .. sname -- For avoiding name conflicts in the sound tables
    local furniture_name = "furniture:" .. modname .. "_" .. fdef.name .. "_" .. sname -- To avoid potential conflicts in mod support
    if modname == "blocks" then
        furniture_name = "furniture:" .. fdef.name .. "_" .. sname
        esname = sname
    end
    local furniture_description =  base_definition.description .. " " .. fdef.description
    local furniture_mesh = (fdef.base or fdef.name) .. ".obj"
    local tiles = {texture or base_definition.tiles[1]}
    local sunlight
    if (fdef.sunlight_propagates) then
        sunlight = fdef.sunlight_propagates
    else
        sunlight = true
    end
    local sounds = base_definition.sounds
    local collision_box = {type = "fixed", fixed = fdef.box}
    local groups = furniture.table_copy(base_definition.groups)
    if fdef.groups then
        furniture.dictionary_append(groups, fdef.groups)
    end
    local activate_sound
    local gain
    if fdef.activate_sound then
        if type(fdef.activate_sound[esname]) == "table" then
            activate_sound = fdef.activate_sound[esname][1] or fdef.activate_sound.default[1]
            gain = fdef.activate_sound[esname][2] or fdef.activate_sound.default[2]
        else
            activate_sound = fdef.activate_sound[esname] or fdef.activate_sound.default
            gain = 0.06
        end
    end
    local deactivate_sound
    local gain_active
    if fdef.deactivate_sound then
        if type(fdef.deactivate_sound[esname]) == "table" then
            deactivate_sound = fdef.deactivate_sound[esname][1] or fdef.deactivate_sound.default[1]
            gain_active = fdef.deactivate_sound[esname][2] or fdef.deactivate_sound.default[2]
        else
            deactivate_sound = fdef.deactivate_sound[esname] or fdef.deactivate_sound.default
            gain_active = 0.13
        end
    end

    -- Active versions
    local furniture_mesh_active = (fdef.base or fdef.name) .. "_activated.obj"
    local tiles_active = furniture.table_copy(tiles)
    local collision_box_active = {type = "fixed", fixed = fdef.box_activated}
    local groups_active = furniture.table_copy(groups)
    groups_active.not_in_creative_inventory = 1
    if fdef.groups_active then
        furniture.dictionary_append(groups_active, fdef.groups_active)
    end
    local sunlight_active
    if (fdef.sunlight_propagates_active) then
        sunlight_active = fdef.sunlight_propagates_active
    else
        sunlight_active = true
    end

    -- Textures
    local alpha = "opaque"
    if (type(fdef.special_textures) == "table") then
        for i=1, #fdef.special_textures do
            tiles[i+1] = fdef.special_textures[i]
        end
        alpha = "blend" -- Since we can't figure if any special texture has transparency
    elseif (type(fdef.special_textures) == "string") then
        tiles[2] = fdef.special_textures
        alpha = "blend"
    end

    if fdef.active then
        if (type(fdef.special_textures_active) == "table") then
            for i=1, #fdef.special_textures_active do
                tiles_active[i+1] = fdef.special_textures_active[i]
            end
            alpha = "blend"
        elseif (type(fdef.special_textures_active) == "string") then
            tiles_active[2] = fdef.special_textures_active
            alpha = "blend"
        end
    end

    -- Declare function storage
    local on_rightclick
    local on_rightclick_active

    local after_place_node_locked
    local on_rightclick_locked
    local on_rightclick_active_locked
    local can_dig_locked = false

    if fdef.generate_locked then
        after_place_node_locked = function(pos, placer)
            local meta = minetest.get_meta(pos)
            local playername = placer:get_player_name()
            meta:set_string("owner", playername)
            meta:set_string("infotext", "Locked " .. furniture_description .. "\nOwned by " .. playername .. ".")
        end
        on_rightclick_locked = function(pos, node, player)
            local meta = minetest.get_meta(pos)
            local owner = meta:get_string("owner")
            local playername = player:get_player_name()
            if playername == owner then
                minetest.swap_node(pos, {name = furniture_name .. "_activated_locked", param2 = node.param2})
                minetest.sound_play(activate_sound, {pos = pos, gain = gain, max_hear_distance = 10}, true)
            end
        end
        on_rightclick_active_locked = function(pos, node, player)
            local meta = minetest.get_meta(pos)
            local owner = meta:get_string("owner")
            local playername = player:get_player_name()
            if playername == owner then
                minetest.swap_node(pos, {name = furniture_name .. "_locked", param2 = node.param2})
                minetest.sound_play(deactivate_sound, {pos = pos, gain = gain_active, max_hear_distance = 10}, true)
            end
        end
    end

    if fdef.active then
        on_rightclick = function(pos, node)
            minetest.swap_node(pos, {name = furniture_name .. "_activated", param2 = node.param2})
            minetest.sound_play(activate_sound, {pos = pos, gain = gain, max_hear_distance = 10}, true)
        end
        on_rightclick_active = function(pos, node)
            minetest.swap_node(pos, {name = furniture_name, param2 = node.param2})
            minetest.sound_play(deactivate_sound, {pos = pos, gain = gain_active, max_hear_distance = 10}, true)
        end
    end

    -- Assemble node(s)

    if (fdef.storage) then
       crates:register_storage(furniture_name, {
            description = furniture_description,
            columns = fdef.storage,
            tiles = tiles,
            sorting = true,
            portable = fdef.portable,
            --dyeable = fdef.dyeable, -- Don't think it'll work cause of the texturing approach
            --dyemod = dfef.dyemod, -- Don't think it'll work cause of the texturing approach
            colorlabel = fdef.colorlabel,
            lock_order = {"lock", "protect", "public", "mail"},
            groups = groups,
            drawtype = 'mesh',
            mesh = furniture_mesh,
            collision_box = collision_box,
            selection_box = collision_box,
            use_texture_alpha = fdef.alpha or alpha,
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = sunlight,
            sounds = sounds,
            light_source = fdef.light_source or base_definition.light_source,
            visual_scale = fdef.visual_scale or base_definition.visual_scale,
            post_effect_color = fdef.post_effect_color or base_definition.post_effect_color,
            walkable = fdef.walkable or base_definition.walkable,
            pointable = fdef.pointable or base_definition.pointable,
            diggable = fdef.diggable or base_definition.diggable,
            climbable = fdef.climbable or base_definition.climbable,
            move_resistance = fdef.move_resistance or base_definition.move_resistance,
            buildable_to = fdef.buildable_to or base_definition.buildable_to,
            floodable = fdef.floodable or base_definition.floodable,
            drowning = fdef.drowning or base_definition.drowning,
            damage_per_second = fdef.damage_per_second or base_definition.damage_per_second,
        })
    else
        minetest.register_node(furniture_name, {
            description = furniture_description,
            tiles = tiles,
            groups = groups,
            drawtype = 'mesh',
            mesh = furniture_mesh,
            collision_box = collision_box,
            selection_box = collision_box,
            use_texture_alpha = fdef.alpha or alpha,
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = sunlight,
            sounds = sounds,
            on_rightclick = on_rightclick,
            light_source = fdef.light_source or base_definition.light_source,
            visual_scale = fdef.visual_scale or base_definition.visual_scale,
            post_effect_color = fdef.post_effect_color or base_definition.post_effect_color,
            walkable = fdef.walkable or base_definition.walkable,
            pointable = fdef.pointable or base_definition.pointable,
            diggable = fdef.diggable or base_definition.diggable,
            climbable = fdef.climbable or base_definition.climbable,
            move_resistance = fdef.move_resistance or base_definition.move_resistance,
            buildable_to = fdef.buildable_to or base_definition.buildable_to,
            floodable = fdef.floodable or base_definition.floodable,
            drowning = fdef.drowning or base_definition.drowning,
            damage_per_second = fdef.damage_per_second or base_definition.damage_per_second
        })
        if fdef.active then
            minetest.register_node(furniture_name .. "_activated", {
                description = furniture_description,
                tiles = tiles_active,
                groups = groups_active,
                drawtype = 'mesh',
                mesh = furniture_mesh_active,
                collision_box = collision_box_active,
                selection_box = collision_box_active,
                use_texture_alpha = fdef.alpha_active or alpha,
                paramtype = "light",
                paramtype2 = "facedir",
                sunlight_propagates = sunlight_active,
                sounds = sounds,
                drops = furniture_name,
                on_rightclick = on_rightclick_active,
                light_source = fdef.light_source_active or base_definition.light_source,
                visual_scale = fdef.visual_scale_active or base_definition.visual_scale,
                post_effect_color = fdef.post_effect_color_active or base_definition.post_effect_color,
                walkable = fdef.walkable_active or base_definition.walkable,
                pointable = fdef.pointable_active or base_definition.pointable,
                diggable = fdef.diggable_active or base_definition.diggable,
                climbable = fdef.climbable_active or base_definition.climbable,
                move_resistance = fdef.move_resistance_active or base_definition.move_resistance,
                buildable_to = fdef.buildable_to_active or base_definition.buildable_to,
                floodable = fdef.floodable_active or base_definition.floodable,
                drowning = fdef.drowning_active or base_definition.drowning,
                damage_per_second = fdef.damage_per_second_active or base_definition.damage_per_second
            })
        end
        if fdef.generate_locked then
            minetest.register_node(furniture_name .. "_locked", {
                description = "Locked " .. furniture_description,
                tiles = tiles,
                groups = groups,
                drawtype = 'mesh',
                mesh = furniture_mesh,
                collision_box = collision_box,
                selection_box = collision_box,
                use_texture_alpha = fdef.alpha or alpha,
                paramtype = "light",
                paramtype2 = "facedir",
                sunlight_propagates = sunlight,
                sounds = sounds,
                after_place_node = after_place_node_locked,
                on_rightclick = on_rightclick_locked,
                light_source = fdef.light_source or base_definition.light_source,
                visual_scale = fdef.visual_scale or base_definition.visual_scale,
                post_effect_color = fdef.post_effect_color or base_definition.post_effect_color,
                walkable = fdef.walkable or base_definition.walkable,
                pointable = fdef.pointable or base_definition.pointable,
                diggable = fdef.diggable or base_definition.diggable,
                climbable = fdef.climbable or base_definition.climbable,
                move_resistance = fdef.move_resistance or base_definition.move_resistance,
                buildable_to = fdef.buildable_to or base_definition.buildable_to,
                floodable = fdef.floodable or base_definition.floodable,
                drowning = fdef.drowning or base_definition.drowning,
                damage_per_second = fdef.damage_per_second or base_definition.damage_per_second
            })
            minetest.register_node(furniture_name .. "_activated_locked", {
                description = "Locked " .. furniture_description,
                tiles = tiles_active,
                groups = groups_active,
                drawtype = 'mesh',
                mesh = furniture_mesh_active,
                collision_box = collision_box_active,
                selection_box = collision_box_active,
                use_texture_alpha = fdef.alpha_active or alpha,
                paramtype = "light",
                paramtype2 = "facedir",
                sunlight_propagates = sunlight_active,
                sounds = sounds,
                drops = furniture_name,
                after_place_node = after_place_node_locked,
                on_rightclick = on_rightclick_active_locked,
                can_dig = can_dig_locked,
                light_source = fdef.light_source_active or base_definition.light_source,
                visual_scale = fdef.visual_scale_active or base_definition.visual_scale,
                post_effect_color = fdef.post_effect_color_active or base_definition.post_effect_color,
                walkable = fdef.walkable_active or base_definition.walkable,
                pointable = fdef.pointable_active or base_definition.pointable,
                diggable = fdef.diggable_active or base_definition.diggable,
                climbable = fdef.climbable_active or base_definition.climbable,
                move_resistance = fdef.move_resistance_active or base_definition.move_resistance,
                buildable_to = fdef.buildable_to_active or base_definition.buildable_to,
                floodable = fdef.floodable_active or base_definition.floodable,
                drowning = fdef.drowning_active or base_definition.drowning,
                damage_per_second = fdef.damage_per_second_active or base_definition.damage_per_second
            })
        end
    end
end

-- Furniture crafting
function furniture.register_crafting(base_node, i, materials_in, locked)
    local materials = furniture.table_copy(materials_in)
    local fdef = furniture.types[i]
    local sname = string.match(base_node, ':(.*)')
    local modname = string.match(base_node, '(.*):')
    local furniture_name = "furniture:" .. modname .. "_" .. fdef.name .. "_" .. sname
    if modname == "blocks" then
        furniture_name = "furniture:" .. fdef.name .. "_" .. sname
    end
    if locked then
        workbench:register_craft({
            type = "furniture",
            output = {
                {furniture_name .. "_locked"}
            },
            input = {
                {"furniture:lock", furniture_name},
            },
        })
    else
        if (type(fdef.special_materials) == "table") then -- Append special material(s) to the end
            for j=1,#fdef.special_materials do
                materials[#materials+j] = fdef.special_materials[j]
            end
        elseif (type(fdef.special_materials) == "string") then
            materials[#materials+1] = fdef.special_materials
        end
        materials[0] = ""
        if fdef.crafting then
            local recipe = {{}, {}, {}, {}, {}}
            for rw=1,5 do
                for cl=1,5 do
                    recipe[rw][cl] = materials[fdef.crafting[rw][cl]] or ""
                end
            end
            workbench:register_craft({
                type = "furniture",
                output = {
                    {furniture_name}
                },
                input = recipe,
            })
        end
    end
end

-- Locking

-- Craftitems
minetest.register_craftitem("furniture:lock", {
	description = "Locking Mechanism",
	inventory_image = "furniture_lock.png",
})
-- Crafting
minetest.register_craft({
	output = "furniture:lock",
	recipe = {
        {"", "default:steel_ingot", ""},
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
	}
})

furniture.register("blocks:wood", furniture.woodlike_set, {"blocks:wood", "blocks:stick"}, "variations_wood.png^[sheet:3x3:1,0")
furniture.register("blocks:acacia_wood", furniture.woodlike_set, {"blocks:acacia_wood", "blocks:stick"}, "variations_acacia_wood.png^[sheet:3x3:1,0")
furniture.register("blocks:aspen_wood", furniture.woodlike_set, {"blocks:aspen_wood", "blocks:stick"}, "variations_aspen_wood.png^[sheet:3x3:1,0")
furniture.register("blocks:junglewood", furniture.woodlike_set, {"blocks:junglewood", "blocks:stick"}, "variations_junglewood.png^[sheet:3x3:1,0")
furniture.register("blocks:mushroom_wood", furniture.woodlike_set, {"blocks:mushroom_wood", "blocks:stick"}, "variations_mushroom_wood.png^[sheet:3x3:1,0")
furniture.register("blocks:pine_wood", furniture.woodlike_set, {"blocks:pine_wood", "blocks:stick"}, "variations_pine_wood.png^[sheet:3x3:1,0")
furniture.register("blocks:cherry_wood", furniture.woodlike_set, {"blocks:cherry_wood", "blocks:stick"}, "variations_cherry_wood.png^[sheet:3x3:1,0")
furniture.register("blocks:steelblock", furniture.woodlike_set, {"blocks:steelblock", "blocks:steel_ingot"}, "variations_steelblock.png^[sheet:3x3:1,0")
furniture.register("blocks:rustblock", furniture.woodlike_set, {"blocks:rustblock", "blocks:steel_ingot"}, "furniture_rustblock_clean.png") -- Fix crafting later

furniture.register("blocks:stone", furniture.stonelike_set, {"blocks:stone", "blocks:shapes_stone_slab"}, "variations_stone.png^[sheet:3x3:1,0")
furniture.register("blocks:desert_stone", furniture.stonelike_set, {"blocks:desert_stone", "blocks:shapes_desert_stone_slab"}, "variations_desert_stone.png^[sheet:3x3:1,0")
furniture.register("blocks:basalt", furniture.stonelike_set, {"blocks:basalt", "blocks:shapes_basalt_slab"}, "variations_basalt.png^[sheet:3x3:1,0")
furniture.register("blocks:sandstone", furniture.stonelike_set, {"blocks:sandstone", "blocks:shapes_sandstone_slab"}, "variations_sandstone.png^[sheet:3x3:1,0")
furniture.register("blocks:marble", furniture.stonelike_set, {"blocks:marble", "blocks:shapes_marble_slab"}, "variations_marble.png^[sheet:3x3:1,0")

furniture.register("blocks:amber", furniture.stonelike_set, {"blocks:amber", "blocks:shapes_amber_slab"}, "variations_amber.png^[sheet:3x3:1,0")

furniture.register("blocks:glass", furniture.glasslike_set, {"blocks:glass", "blocks:sand"}, "blocks_glass.png")
furniture.register("blocks:obsidian_glass", furniture.glasslike_set, {"blocks:obsidian_glass", "blocks:obsidian_shard"}, "blocks_obsidian_glass.png")
furniture.register("blocks:amethyst", furniture.glasslike_set, {"blocks:amethyst", "blocks:amethyst_crystal"}, "variations_amethyst.png^[sheet:3x3:1,0")
furniture.register("blocks:garnet", furniture.glasslike_set, {"blocks:garnet", "blocks:garnet_crystal"}, "variations_garnet.png^[sheet:3x3:1,0")