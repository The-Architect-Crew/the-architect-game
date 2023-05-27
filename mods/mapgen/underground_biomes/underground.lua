mapgen.underground_top = mapgen.underground_start
mapgen.underground_bottom = -768

mapgen.underground_middle = (mapgen.underground_top + mapgen.underground_bottom) / 2

mapgen.underground_cavern_level = (mapgen.underground_middle + mapgen.underground_bottom) / 2

mapgen.underground_water_height = 48

mapgen.underground_stone_nodes = {"blocks:stone", "blocks:ice", "blocks:sandstone", "blocks:desert_stone"}

mapgen.register_underground_biomes = function()
    minetest.register_biome({
		name = "icesheet_underground",
		node_stone = "blocks:ice",
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = mapgen.underground_start,
		y_min = mapgen.underground_bottom,
		heat_point = 0,
		humidity_point = 65,
	})
    minetest.register_biome({
		name = "tundra_underground",
		node_stone = "blocks:stone",
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = mapgen.underground_start,
		y_min = mapgen.underground_bottom,
		heat_point = 0,
		humidity_point = 40,
	})
    minetest.register_biome({
		name = "taiga_underground",
		node_stone = "blocks:stone",
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = mapgen.underground_start,
		y_min = mapgen.underground_bottom,
		heat_point = 25,
		humidity_point = 65,
	})
    minetest.register_biome({
		name = "snowy_grassland_underground",
		node_stone = "blocks:stone",
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = mapgen.underground_start,
		y_min = mapgen.underground_bottom,
        heat_point = 15,
		humidity_point = 35,
	})
    minetest.register_biome({
		name = "grassland_underground",
		node_stone = "blocks:stone",
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = mapgen.underground_start,
		y_min = mapgen.underground_bottom,
		heat_point = 45,
		humidity_point = 35,
	})
    minetest.register_biome({
		name = "chalk_grassland_underground",
		node_stone = "blocks:stone",
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = mapgen.underground_start,
		y_min = mapgen.underground_bottom,
		heat_point = 45,
		humidity_point = 33,
	})
    minetest.register_biome({
		name = "coniferous_forest_underground",
		node_stone = "blocks:stone",
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = mapgen.underground_start,
		y_min = mapgen.underground_bottom,
		heat_point = 32,
		humidity_point = 65,
	})
    minetest.register_biome({
		name = "deciduous_forest_underground",
		node_stone = "blocks:stone",
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = mapgen.underground_start,
		y_min = mapgen.underground_bottom,
		heat_point = 60,
		humidity_point = 65,
	})
    minetest.register_biome({
		name = "desert_underground",
		node_stone = "blocks:desert_stone",
		node_dungeon = "blocks:desert_stone",
		node_dungeon_stair = "blocks:shapes_desert_stone_stair",
		y_max = mapgen.underground_start,
        y_min = mapgen.underground_bottom,
		heat_point = 85,
		humidity_point = 0,
	})
    minetest.register_biome({
		name = "sandstone_desert_underground",
		node_stone = "blocks:sandstone",
		node_dungeon = "blocks:sandstonebrick",
		node_dungeon_stair = "blocks:shapes_sandstone_block_stair",
		y_max = mapgen.underground_start,
        y_min = mapgen.underground_bottom,
		heat_point = 45,
		humidity_point = 0,
	})
    minetest.register_biome({
		name = "cold_desert_underground",
		node_stone = "blocks:stone",
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = mapgen.underground_start,
		y_min = mapgen.underground_bottom,
		heat_point = 20,
		humidity_point = 0,
	})
    minetest.register_biome({
		name = "savanna_underground",
		node_stone = "blocks:stone",
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = mapgen.underground_start,
		y_min = mapgen.underground_bottom,
		heat_point = 89,
		humidity_point = 48,
	})
    minetest.register_biome({
		name = "rainforest_underground",
		node_stone = "blocks:stone",
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = mapgen.underground_start,
		y_min = mapgen.underground_bottom,
		heat_point = 86,
		humidity_point = 70,
	})
end

mapgen.register_underground_ores = function()
    -- Cavern
    minetest.register_ore({
        ore_type = "stratum",
        ore = "air",
        wherein = mapgen.underground_stone_nodes,
		y_max = mapgen.underground_top,
        y_min = mapgen.underground_bottom,
        noise_params = {
            offset = mapgen.underground_cavern_level,
            scale = 128,
            spread = {x = 200, y = 200, z = 200},
            seed = 61,
            octaves = 5,
            persistence = 0.5
        },
            np_stratum_thickness = {
            offset = 96,
            scale = 128,
            spread = {x = 50, y = 50, z = 50},
            seed = 884,
            octaves = 4,
            persistence = 0.75
        }
    })
    minetest.register_ore({
        ore_type = "stratum",
        ore = "blocks:water_source",
        wherein = "air",
        y_max = mapgen.underground_bottom + mapgen.underground_water_height,
        y_min = mapgen.underground_bottom,
    })
    -- Caves
    mapgen.register_tapered_vein({
        ore = "air",
        wherein = mapgen.underground_stone_nodes,
        y_max = mapgen.underground_top,
        y_min = mapgen.underground_middle,
        noise_params = {
            offset = 0,
            scale = 1,
            spread = {x = 50, y = 50, z = 50},
            seed = 66234,
            octaves = 3,
            persistence = 0.75
        },
        taper_distance = 32,
    })
end

mapgen.register_underground_decorations = function()
end