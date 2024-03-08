furniture.medieval_content = {
       {
        name = "wall_sconce",
        special_textures = {{
            name = "blocks_embers_animated.png",
            animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0}
        },{
            name = "blocks_fire_animated.png",
            animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0}
        }},
        special_materials = "blocks:coal_lump",
        description = "Wall Sconce",
        light_source = 8,
        box = {-2/16, -6/16, 8/16, 2/16, 4/16, 3/16},
        sunlight_propagates = true,
        crafting = {
            {0, 3, 3, 3, 0},
            {0, 2, 2, 0, 0},
            {0, 2, 1, 0, 0},
            {0, 0, 1, 2, 0},
            {0, 0, 1, 0, 0},
        }
    },
    {
        name = "brazier",
        special_textures = {{
            name = "blocks_embers_animated.png",
            animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0}
        },{
            name = "blocks_fire_animated.png",
            animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0}
        }},
        special_materials = "blocks:coalblock",
        description = "Brazier",
        light_source = 12,
        box = {-7/16, -8/16, -7/16, 7/16, 3/16, 7/16},
        sunlight_propagates = true,
        crafting = {
            {0, 0, 0, 0, 0},
            {1, 3, 3, 3, 1},
            {0, 1, 1, 1, 0},
            {0, 1, 1, 1, 0},
            {2, 2, 0, 2, 2},
        }
    }
}

furniture.medieval_lighting = {
    "wall_sconce",
    "brazier"
}

furniture.table_append(furniture.stonelike_set, furniture.medieval_lighting)

furniture.table_append(furniture.types, furniture.medieval_content)