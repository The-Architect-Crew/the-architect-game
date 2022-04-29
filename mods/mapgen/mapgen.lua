--
-- Register biomes
--

-- All mapgens except mgv6

function mapgen.register_biomes()

	-- Icesheet

	minetest.register_biome({
		name = "icesheet",
		node_dust = "blocks:snowblock",
		node_top = "blocks:snowblock",
		depth_top = 1,
		node_filler = "blocks:snowblock",
		depth_filler = 3,
		node_stone = "blocks:cave_ice",
		node_water_top = "blocks:ice",
		depth_water_top = 10,
		node_river_water = "blocks:ice",
		node_riverbed = "blocks:gravel",
		depth_riverbed = 2,
		node_dungeon = "blocks:ice",
		node_dungeon_stair = "blocks:shapes_ice_stair",
		y_max = 31000,
		y_min = -8,
		heat_point = 0,
		humidity_point = 73,
	})

	minetest.register_biome({
		name = "icesheet_ocean",
		node_dust = "blocks:snowblock",
		node_top = "blocks:sand",
		depth_top = 1,
		node_filler = "blocks:sand",
		depth_filler = 3,
		node_water_top = "blocks:ice",
		depth_water_top = 10,
		node_cave_liquid = "blocks:water_source",
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = -9,
		y_min = mapgen.underground_limit + 1,
		heat_point = 0,
		humidity_point = 73,
	})

	minetest.register_biome({
		name = "icesheet_under",
		node_cave_liquid = {"blocks:water_source", "blocks:lava_source"},
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = mapgen.underground_limit,
		y_min = -31000,
		heat_point = 0,
		humidity_point = 73,
	})

	-- Tundra

	minetest.register_biome({
		name = "tundra_highland",
		node_dust = "blocks:snow",
		node_riverbed = "blocks:gravel",
		depth_riverbed = 2,
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_mossycobble_stair",
		y_max = 31000,
		y_min = 47,
		heat_point = 0,
		humidity_point = 40,
	})

	minetest.register_biome({
		name = "tundra",
		node_top = "blocks:permafrost_with_stones",
		depth_top = 1,
		node_filler = "blocks:permafrost",
		depth_filler = 1,
		node_riverbed = "blocks:gravel",
		depth_riverbed = 2,
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		vertical_blend = 4,
		y_max = 46,
		y_min = 2,
		heat_point = 0,
		humidity_point = 40,
	})

	minetest.register_biome({
		name = "tundra_beach",
		node_top = "blocks:gravel",
		depth_top = 1,
		node_filler = "blocks:gravel",
		depth_filler = 2,
		node_riverbed = "blocks:gravel",
		depth_riverbed = 2,
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		vertical_blend = 1,
		y_max = 1,
		y_min = -3,
		heat_point = 0,
		humidity_point = 40,
	})

	minetest.register_biome({
		name = "tundra_ocean",
		node_top = "blocks:sand",
		depth_top = 1,
		node_filler = "blocks:sand",
		depth_filler = 3,
		node_riverbed = "blocks:gravel",
		depth_riverbed = 2,
		node_cave_liquid = "blocks:water_source",
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		vertical_blend = 1,
		y_max = -4,
		y_min = mapgen.underground_limit + 1,
		heat_point = 0,
		humidity_point = 40,
	})

	minetest.register_biome({
		name = "tundra_under",
		node_cave_liquid = {"blocks:water_source", "blocks:lava_source"},
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = mapgen.underground_limit,
		y_min = -31000,
		heat_point = 0,
		humidity_point = 40,
	})

	-- Taiga

	minetest.register_biome({
		name = "taiga",
		node_dust = "blocks:snow",
		node_top = "blocks:dirt_with_snow",
		depth_top = 1,
		node_filler = "blocks:dirt",
		depth_filler = 3,
		node_riverbed = "blocks:sand",
		depth_riverbed = 2,
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = 31000,
		y_min = 4,
		heat_point = 25,
		humidity_point = 70,
	})

	minetest.register_biome({
		name = "taiga_ocean",
		node_dust = "blocks:snow",
		node_top = "blocks:sand",
		depth_top = 1,
		node_filler = "blocks:sand",
		depth_filler = 3,
		node_riverbed = "blocks:sand",
		depth_riverbed = 2,
		node_cave_liquid = "blocks:water_source",
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		vertical_blend = 1,
		y_max = 3,
		y_min = mapgen.underground_limit + 1,
		heat_point = 25,
		humidity_point = 70,
	})

	minetest.register_biome({
		name = "taiga_under",
		node_cave_liquid = {"blocks:water_source", "blocks:lava_source"},
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = mapgen.underground_limit,
		y_min = -31000,
		heat_point = 25,
		humidity_point = 70,
	})

	-- Snowy grassland

	minetest.register_biome({
		name = "snowy_grassland",
		node_dust = "blocks:snow",
		node_top = "blocks:dirt_with_snow",
		depth_top = 1,
		node_filler = "blocks:dirt",
		depth_filler = 1,
		node_riverbed = "blocks:sand",
		depth_riverbed = 2,
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = 31000,
		y_min = 4,
		heat_point = 20,
		humidity_point = 35,
	})

	minetest.register_biome({
		name = "snowy_grassland_ocean",
		node_dust = "blocks:snow",
		node_top = "blocks:sand",
		depth_top = 1,
		node_filler = "blocks:sand",
		depth_filler = 3,
		node_riverbed = "blocks:sand",
		depth_riverbed = 2,
		node_cave_liquid = "blocks:water_source",
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		vertical_blend = 1,
		y_max = 3,
		y_min = mapgen.underground_limit + 1,
		heat_point = 20,
		humidity_point = 35,
	})

	minetest.register_biome({
		name = "snowy_grassland_under",
		node_cave_liquid = {"blocks:water_source", "blocks:lava_source"},
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = mapgen.underground_limit,
		y_min = -31000,
		heat_point = 20,
		humidity_point = 35,
	})

	-- Grassland

	minetest.register_biome({
		name = "grassland",
		node_top = "blocks:dirt_with_grass",
		depth_top = 1,
		node_filler = "blocks:dirt",
		depth_filler = 1,
		node_riverbed = "blocks:sand",
		depth_riverbed = 2,
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = 31000,
		y_min = 6,
		heat_point = 50,
		humidity_point = 35,
	})

	minetest.register_biome({
		name = "grassland_dunes",
		node_top = "blocks:sand",
		depth_top = 1,
		node_filler = "blocks:sand",
		depth_filler = 2,
		node_riverbed = "blocks:sand",
		depth_riverbed = 2,
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		vertical_blend = 1,
		y_max = 5,
		y_min = 4,
		heat_point = 50,
		humidity_point = 35,
	})

	minetest.register_biome({
		name = "grassland_ocean",
		node_top = "blocks:sand",
		depth_top = 1,
		node_filler = "blocks:sand",
		depth_filler = 3,
		node_riverbed = "blocks:sand",
		depth_riverbed = 2,
		node_cave_liquid = "blocks:water_source",
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = 3,
		y_min = mapgen.underground_limit + 1,
		heat_point = 50,
		humidity_point = 35,
	})

	minetest.register_biome({
		name = "grassland_under",
		node_cave_liquid = {"blocks:water_source", "blocks:lava_source"},
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = mapgen.underground_limit,
		y_min = -31000,
		heat_point = 50,
		humidity_point = 35,
	})

	-- Coniferous forest

	minetest.register_biome({
		name = "coniferous_forest",
		node_top = "blocks:dirt_with_coniferous_litter",
		depth_top = 1,
		node_filler = "blocks:dirt",
		depth_filler = 3,
		node_riverbed = "blocks:sand",
		depth_riverbed = 2,
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = 31000,
		y_min = 6,
		heat_point = 45,
		humidity_point = 70,
	})

	minetest.register_biome({
		name = "coniferous_forest_dunes",
		node_top = "blocks:sand",
		depth_top = 1,
		node_filler = "blocks:sand",
		depth_filler = 3,
		node_riverbed = "blocks:sand",
		depth_riverbed = 2,
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		vertical_blend = 1,
		y_max = 5,
		y_min = 4,
		heat_point = 45,
		humidity_point = 70,
	})

	minetest.register_biome({
		name = "coniferous_forest_ocean",
		node_top = "blocks:sand",
		depth_top = 1,
		node_filler = "blocks:sand",
		depth_filler = 3,
		node_riverbed = "blocks:sand",
		depth_riverbed = 2,
		node_cave_liquid = "blocks:water_source",
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = 3,
		y_min = mapgen.underground_limit + 1,
		heat_point = 45,
		humidity_point = 70,
	})

	minetest.register_biome({
		name = "coniferous_forest_under",
		node_cave_liquid = {"blocks:water_source", "blocks:lava_source"},
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = mapgen.underground_limit,
		y_min = -31000,
		heat_point = 45,
		humidity_point = 70,
	})

	-- Deciduous forest

	minetest.register_biome({
		name = "deciduous_forest",
		node_top = "blocks:dirt_with_grass",
		depth_top = 1,
		node_filler = "blocks:dirt",
		depth_filler = 3,
		node_riverbed = "blocks:sand",
		depth_riverbed = 2,
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = 31000,
		y_min = 1,
		heat_point = 60,
		humidity_point = 68,
	})

	minetest.register_biome({
		name = "deciduous_forest_shore",
		node_top = "blocks:dirt",
		depth_top = 1,
		node_filler = "blocks:dirt",
		depth_filler = 3,
		node_riverbed = "blocks:sand",
		depth_riverbed = 2,
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = 0,
		y_min = -1,
		heat_point = 60,
		humidity_point = 68,
	})

	minetest.register_biome({
		name = "deciduous_forest_ocean",
		node_top = "blocks:sand",
		depth_top = 1,
		node_filler = "blocks:sand",
		depth_filler = 3,
		node_riverbed = "blocks:sand",
		depth_riverbed = 2,
		node_cave_liquid = "blocks:water_source",
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		vertical_blend = 1,
		y_max = -2,
		y_min = mapgen.underground_limit + 1,
		heat_point = 60,
		humidity_point = 68,
	})

	minetest.register_biome({
		name = "deciduous_forest_under",
		node_cave_liquid = {"blocks:water_source", "blocks:lava_source"},
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = mapgen.underground_limit,
		y_min = -31000,
		heat_point = 60,
		humidity_point = 68,
	})

	-- Desert

	minetest.register_biome({
		name = "desert",
		node_top = "blocks:desert_sand",
		depth_top = 1,
		node_filler = "blocks:desert_sand",
		depth_filler = 1,
		node_stone = "blocks:desert_stone",
		node_riverbed = "blocks:sand",
		depth_riverbed = 2,
		node_dungeon = "blocks:desert_stone",
		node_dungeon_stair = "blocks:shapes_desert_stone_stair",
		y_max = 31000,
		y_min = 4,
		heat_point = 92,
		humidity_point = 16,
	})

	minetest.register_biome({
		name = "desert_ocean",
		node_top = "blocks:sand",
		depth_top = 1,
		node_filler = "blocks:sand",
		depth_filler = 3,
		node_stone = "blocks:desert_stone",
		node_riverbed = "blocks:sand",
		depth_riverbed = 2,
		node_cave_liquid = "blocks:water_source",
		node_dungeon = "blocks:desert_stone",
		node_dungeon_stair = "blocks:shapes_desert_stone_stair",
		vertical_blend = 1,
		y_max = 3,
		y_min = mapgen.underground_limit + 1,
		heat_point = 92,
		humidity_point = 16,
	})

	minetest.register_biome({
		name = "desert_under",
		node_cave_liquid = {"blocks:water_source", "blocks:lava_source"},
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = mapgen.underground_limit,
		y_min = -31000,
		heat_point = 92,
		humidity_point = 16,
	})

	-- Sandstone desert

	minetest.register_biome({
		name = "sandstone_desert",
		node_top = "blocks:sand",
		depth_top = 1,
		node_filler = "blocks:sand",
		depth_filler = 1,
		node_stone = "blocks:sandstone",
		node_riverbed = "blocks:sand",
		depth_riverbed = 2,
		node_dungeon = "blocks:sandstonebrick",
		node_dungeon_stair = "blocks:shapes_sandstone_block_stair",
		y_max = 31000,
		y_min = 4,
		heat_point = 60,
		humidity_point = 0,
	})

	minetest.register_biome({
		name = "sandstone_desert_ocean",
		node_top = "blocks:sand",
		depth_top = 1,
		node_filler = "blocks:sand",
		depth_filler = 3,
		node_stone = "blocks:sandstone",
		node_riverbed = "blocks:sand",
		depth_riverbed = 2,
		node_cave_liquid = "blocks:water_source",
		node_dungeon = "blocks:sandstonebrick",
		node_dungeon_stair = "blocks:shapes_sandstone_block_stair",
		y_max = 3,
		y_min = mapgen.underground_limit + 1,
		heat_point = 60,
		humidity_point = 0,
	})

	minetest.register_biome({
		name = "sandstone_desert_under",
		node_cave_liquid = {"blocks:water_source", "blocks:lava_source"},
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = mapgen.underground_limit,
		y_min = -31000,
		heat_point = 60,
		humidity_point = 0,
	})

	-- Cold desert

	minetest.register_biome({
		name = "cold_desert",
		node_top = "blocks:silver_sand",
		depth_top = 1,
		node_filler = "blocks:silver_sand",
		depth_filler = 1,
		node_riverbed = "blocks:sand",
		depth_riverbed = 2,
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = 31000,
		y_min = 4,
		heat_point = 40,
		humidity_point = 0,
	})

	minetest.register_biome({
		name = "cold_desert_ocean",
		node_top = "blocks:sand",
		depth_top = 1,
		node_filler = "blocks:sand",
		depth_filler = 3,
		node_riverbed = "blocks:sand",
		depth_riverbed = 2,
		node_cave_liquid = "blocks:water_source",
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		vertical_blend = 1,
		y_max = 3,
		y_min = mapgen.underground_limit + 1,
		heat_point = 40,
		humidity_point = 0,
	})

	minetest.register_biome({
		name = "cold_desert_under",
		node_cave_liquid = {"blocks:water_source", "blocks:lava_source"},
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = mapgen.underground_limit,
		y_min = -31000,
		heat_point = 40,
		humidity_point = 0,
	})

	-- Savanna

	minetest.register_biome({
		name = "savanna",
		node_top = "blocks:dry_dirt_with_dry_grass",
		depth_top = 1,
		node_filler = "blocks:dry_dirt",
		depth_filler = 1,
		node_riverbed = "blocks:sand",
		depth_riverbed = 2,
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = 31000,
		y_min = 1,
		heat_point = 89,
		humidity_point = 42,
	})

	minetest.register_biome({
		name = "savanna_shore",
		node_top = "blocks:dry_dirt",
		depth_top = 1,
		node_filler = "blocks:dry_dirt",
		depth_filler = 3,
		node_riverbed = "blocks:sand",
		depth_riverbed = 2,
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = 0,
		y_min = -1,
		heat_point = 89,
		humidity_point = 42,
	})

	minetest.register_biome({
		name = "savanna_ocean",
		node_top = "blocks:sand",
		depth_top = 1,
		node_filler = "blocks:sand",
		depth_filler = 3,
		node_riverbed = "blocks:sand",
		depth_riverbed = 2,
		node_cave_liquid = "blocks:water_source",
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		vertical_blend = 1,
		y_max = -2,
		y_min = mapgen.underground_limit + 1,
		heat_point = 89,
		humidity_point = 42,
	})

	minetest.register_biome({
		name = "savanna_under",
		node_cave_liquid = {"blocks:water_source", "blocks:lava_source"},
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = mapgen.underground_limit,
		y_min = -31000,
		heat_point = 89,
		humidity_point = 42,
	})

	-- Rainforest

	minetest.register_biome({
		name = "rainforest",
		node_top = "blocks:dirt_with_rainforest_litter",
		depth_top = 1,
		node_filler = "blocks:dirt",
		depth_filler = 3,
		node_riverbed = "blocks:sand",
		depth_riverbed = 2,
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = 31000,
		y_min = 1,
		heat_point = 86,
		humidity_point = 65,
	})

	minetest.register_biome({
		name = "rainforest_swamp",
		node_top = "blocks:dirt",
		depth_top = 1,
		node_filler = "blocks:dirt",
		depth_filler = 3,
		node_riverbed = "blocks:sand",
		depth_riverbed = 2,
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = 0,
		y_min = -1,
		heat_point = 86,
		humidity_point = 65,
	})

	minetest.register_biome({
		name = "rainforest_ocean",
		node_top = "blocks:sand",
		depth_top = 1,
		node_filler = "blocks:sand",
		depth_filler = 3,
		node_riverbed = "blocks:sand",
		depth_riverbed = 2,
		node_cave_liquid = "blocks:water_source",
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		vertical_blend = 1,
		y_max = -2,
		y_min = mapgen.underground_limit + 1,
		heat_point = 86,
		humidity_point = 65,
	})

	minetest.register_biome({
		name = "rainforest_under",
		node_cave_liquid = {"blocks:water_source", "blocks:lava_source"},
		node_dungeon = "blocks:cobble",
		node_dungeon_alt = "blocks:mossycobble",
		node_dungeon_stair = "blocks:shapes_cobble_stair",
		y_max = mapgen.underground_limit,
		y_min = -31000,
		heat_point = 86,
		humidity_point = 65,
	})
end


--
-- Register decorations
--

-- Mgv6

function mapgen.register_mgv6_decorations()

	-- Papyrus

	minetest.register_decoration({
		name = "flora:papyrus",
		deco_type = "simple",
		place_on = {"blocks:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.3,
			scale = 0.7,
			spread = {x = 100, y = 100, z = 100},
			seed = 354,
			octaves = 3,
			persist = 0.7
		},
		y_max = 1,
		y_min = 1,
		decoration = "flora:papyrus",
		height = 2,
		height_max = 4,
		spawn_by = "blocks:water_source",
		num_spawn_by = 1,
	})

	-- Cacti

	minetest.register_decoration({
		name = "flora:cactus",
		deco_type = "simple",
		place_on = {"blocks:desert_sand"},
		sidelen = 16,
		noise_params = {
			offset = -0.012,
			scale = 0.024,
			spread = {x = 100, y = 100, z = 100},
			seed = 230,
			octaves = 3,
			persist = 0.6
		},
		y_max = 30,
		y_min = 1,
		decoration = "flora:cactus",
		height = 3,
	        height_max = 4,
	})

	-- Long grasses

	for length = 1, 5 do
		minetest.register_decoration({
			name = "flora:grass_"..length,
			deco_type = "simple",
			place_on = {"blocks:dirt_with_grass"},
			sidelen = 16,
			noise_params = {
				offset = 0,
				scale = 0.007,
				spread = {x = 100, y = 100, z = 100},
				seed = 329,
				octaves = 3,
				persist = 0.6
			},
			y_max = 30,
			y_min = 1,
			decoration = "flora:grass_"..length,
		})
	end

	-- Dry shrubs

	minetest.register_decoration({
		name = "flora:dry_shrub",
		deco_type = "simple",
		place_on = {"blocks:desert_sand", "blocks:dirt_with_snow"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.035,
			spread = {x = 100, y = 100, z = 100},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		y_max = 30,
		y_min = 1,
		decoration = "flora:dry_shrub",
		param2 = 4,
	})
end


-- All mapgens except mgv6

local function register_grass_decoration(offset, scale, length)
	minetest.register_decoration({
		name = "flora:grass_" .. length,
		deco_type = "simple",
		place_on = {"blocks:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = offset,
			scale = scale,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"grassland", "deciduous_forest"},
		y_max = 31000,
		y_min = 1,
		decoration = "flora:grass_" .. length,
	})
end

local function register_dry_grass_decoration(offset, scale, length)
	minetest.register_decoration({
		name = "flora:dry_grass_" .. length,
		deco_type = "simple",
		place_on = {"blocks:dry_dirt_with_dry_grass"},
		sidelen = 16,
		noise_params = {
			offset = offset,
			scale = scale,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"savanna"},
		y_max = 31000,
		y_min = 1,
		decoration = "flora:dry_grass_" .. length,
	})
end

local function register_fern_decoration(seed, length)
	minetest.register_decoration({
		name = "flora:fern_" .. length,
		deco_type = "simple",
		place_on = {"blocks:dirt_with_coniferous_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.2,
			spread = {x = 100, y = 100, z = 100},
			seed = seed,
			octaves = 3,
			persist = 0.7
		},
		biomes = {"coniferous_forest"},
		y_max = 31000,
		y_min = 6,
		decoration = "flora:fern_" .. length,
	})
end


function mapgen.register_decorations()
	-- Savanna bare dirt patches.
	-- Must come before all savanna decorations that are placed on dry grass.
	-- Noise is similar to long dry grass noise, but scale inverted, to appear
	-- where long dry grass is least dense and shortest.

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"blocks:dry_dirt_with_dry_grass"},
		sidelen = 4,
		noise_params = {
			offset = -1.5,
			scale = -1.5,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 4,
			persist = 1.0
		},
		biomes = {"savanna"},
		y_max = 31000,
		y_min = 1,
		decoration = "blocks:dry_dirt",
		place_offset_y = -1,
		flags = "force_placement",
	})

	-- Apple tree and log

	minetest.register_decoration({
		name = "mapgen:apple_tree",
		deco_type = "schematic",
		place_on = {"blocks:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0.024,
			scale = 0.015,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"deciduous_forest"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("flora") .. "/schematics/apple_tree.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})

	minetest.register_decoration({
		name = "mapgen:apple_log",
		deco_type = "schematic",
		place_on = {"blocks:dirt_with_grass"},
		place_offset_y = 1,
		sidelen = 16,
		noise_params = {
			offset = 0.0012,
			scale = 0.0007,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"deciduous_forest"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("flora") .. "/schematics/apple_log.mts",
		flags = "place_center_x",
		rotation = "random",
		spawn_by = "blocks:dirt_with_grass",
		num_spawn_by = 8,
	})

	-- Emergent jungle tree
	-- Due to 32 node height, altitude is limited and prescence depends on chunksize

	local chunksize = tonumber(minetest.get_mapgen_setting("chunksize"))
	if chunksize >= 5 then
		minetest.register_decoration({
			name = "mapgen:emergent_jungle_tree",
			deco_type = "schematic",
			place_on = {"blocks:dirt_with_rainforest_litter"},
			sidelen = 80,
			noise_params = {
				offset = 0.0,
				scale = 0.0025,
				spread = {x = 250, y = 250, z = 250},
				seed = 2685,
				octaves = 3,
				persist = 0.7
			},
			biomes = {"rainforest"},
			y_max = 32,
			y_min = 1,
			schematic = minetest.get_modpath("flora") ..
					"/schematics/emergent_jungle_tree.mts",
			flags = "place_center_x, place_center_z",
			rotation = "random",
			place_offset_y = -4,
		})
	end

	-- Jungle tree and log

	minetest.register_decoration({
		name = "mapgen:jungle_tree",
		deco_type = "schematic",
		place_on = {"blocks:dirt_with_rainforest_litter"},
		sidelen = 80,
		fill_ratio = 0.1,
		biomes = {"rainforest"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("flora") .. "/schematics/jungle_tree.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})

	-- Swamp jungle trees

	minetest.register_decoration({
		name = "mapgen:jungle_tree(swamp)",
		deco_type = "schematic",
		place_on = {"blocks:dirt"},
		sidelen = 16,
		-- Noise tuned to place swamp trees where papyrus is absent
		noise_params = {
			offset = 0.0,
			scale = -0.1,
			spread = {x = 200, y = 200, z = 200},
			seed = 354,
			octaves = 1,
			persist = 0.5
		},
		biomes = {"rainforest_swamp"},
		y_max = 0,
		y_min = -1,
		schematic = minetest.get_modpath("flora") .. "/schematics/jungle_tree.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})

	minetest.register_decoration({
		name = "mapgen:jungle_log",
		deco_type = "schematic",
		place_on = {"blocks:dirt_with_rainforest_litter"},
		place_offset_y = 1,
		sidelen = 80,
		fill_ratio = 0.005,
		biomes = {"rainforest"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("flora") .. "/schematics/jungle_log.mts",
		flags = "place_center_x",
		rotation = "random",
		spawn_by = "blocks:dirt_with_rainforest_litter",
		num_spawn_by = 8,
	})

	-- Taiga and temperate coniferous forest pine tree, small pine tree and log

	minetest.register_decoration({
		name = "mapgen:pine_tree",
		deco_type = "schematic",
		place_on = {"blocks:dirt_with_snow", "blocks:dirt_with_coniferous_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0.010,
			scale = 0.048,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"taiga", "coniferous_forest"},
		y_max = 31000,
		y_min = 4,
		schematic = minetest.get_modpath("flora") .. "/schematics/pine_tree.mts",
		flags = "place_center_x, place_center_z",
	})

	minetest.register_decoration({
		name = "mapgen:small_pine_tree",
		deco_type = "schematic",
		place_on = {"blocks:dirt_with_snow", "blocks:dirt_with_coniferous_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0.010,
			scale = -0.048,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"taiga", "coniferous_forest"},
		y_max = 31000,
		y_min = 4,
		schematic = minetest.get_modpath("flora") .. "/schematics/small_pine_tree.mts",
		flags = "place_center_x, place_center_z",
	})

	minetest.register_decoration({
		name = "mapgen:pine_log",
		deco_type = "schematic",
		place_on = {"blocks:dirt_with_snow", "blocks:dirt_with_coniferous_litter"},
		place_offset_y = 1,
		sidelen = 80,
		fill_ratio = 0.0018,
		biomes = {"taiga", "coniferous_forest"},
		y_max = 31000,
		y_min = 4,
		schematic = minetest.get_modpath("flora") .. "/schematics/pine_log.mts",
		flags = "place_center_x",
		rotation = "random",
		spawn_by = {"blocks:dirt_with_snow", "blocks:dirt_with_coniferous_litter"},
		num_spawn_by = 8,
	})

	-- Acacia tree and log

	minetest.register_decoration({
		name = "mapgen:acacia_tree",
		deco_type = "schematic",
		place_on = {"blocks:dry_dirt_with_dry_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.002,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"savanna"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("flora") .. "/schematics/acacia_tree.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})

	minetest.register_decoration({
		name = "mapgen:acacia_log",
		deco_type = "schematic",
		place_on = {"blocks:dry_dirt_with_dry_grass"},
		place_offset_y = 1,
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.001,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"savanna"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("flora") .. "/schematics/acacia_log.mts",
		flags = "place_center_x",
		rotation = "random",
		spawn_by = "blocks:dry_dirt_with_dry_grass",
		num_spawn_by = 8,
	})

	-- Aspen tree and log

	minetest.register_decoration({
		name = "mapgen:aspen_tree",
		deco_type = "schematic",
		place_on = {"blocks:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0.0,
			scale = -0.015,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"deciduous_forest"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("flora") .. "/schematics/aspen_tree.mts",
		flags = "place_center_x, place_center_z",
	})

	minetest.register_decoration({
		name = "mapgen:aspen_log",
		deco_type = "schematic",
		place_on = {"blocks:dirt_with_grass"},
		place_offset_y = 1,
		sidelen = 16,
		noise_params = {
			offset = 0.0,
			scale = -0.0008,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"deciduous_forest"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("flora") .. "/schematics/aspen_log.mts",
		flags = "place_center_x",
		rotation = "random",
		spawn_by = "blocks:dirt_with_grass",
		num_spawn_by = 8,
	})

	-- Large cactus

	minetest.register_decoration({
		name = "mapgen:large_cactus",
		deco_type = "schematic",
		place_on = {"blocks:desert_sand"},
		sidelen = 16,
		noise_params = {
			offset = -0.0003,
			scale = 0.0009,
			spread = {x = 200, y = 200, z = 200},
			seed = 230,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"desert"},
		y_max = 31000,
		y_min = 4,
		schematic = minetest.get_modpath("flora") .. "/schematics/large_cactus.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})

	-- Cactus

	minetest.register_decoration({
		name = "mapgen:cactus",
		deco_type = "simple",
		place_on = {"blocks:desert_sand"},
		sidelen = 16,
		noise_params = {
			offset = -0.0003,
			scale = 0.0009,
			spread = {x = 200, y = 200, z = 200},
			seed = 230,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"desert"},
		y_max = 31000,
		y_min = 4,
		decoration = "flora:cactus",
		height = 2,
		height_max = 5,
	})

	-- Papyrus

	-- Dirt version for rainforest swamp

	minetest.register_decoration({
		name = "mapgen:papyrus_on_dirt",
		deco_type = "schematic",
		place_on = {"blocks:dirt"},
		sidelen = 16,
		noise_params = {
			offset = -0.3,
			scale = 0.7,
			spread = {x = 200, y = 200, z = 200},
			seed = 354,
			octaves = 3,
			persist = 0.7
		},
		biomes = {"rainforest_swamp"},
		y_max = 0,
		y_min = 0,
		schematic = minetest.get_modpath("flora") .. "/schematics/papyrus_on_dirt.mts",
	})

	-- Dry dirt version for savanna shore

	minetest.register_decoration({
		name = "mapgen:papyrus_on_dry_dirt",
		deco_type = "schematic",
		place_on = {"blocks:dry_dirt"},
		sidelen = 16,
		noise_params = {
			offset = -0.3,
			scale = 0.7,
			spread = {x = 200, y = 200, z = 200},
			seed = 354,
			octaves = 3,
			persist = 0.7
		},
		biomes = {"savanna_shore"},
		y_max = 0,
		y_min = 0,
		schematic = minetest.get_modpath("flora") ..
			"/schematics/papyrus_on_dry_dirt.mts",
	})

	-- Bush

	minetest.register_decoration({
		name = "mapgen:bush",
		deco_type = "schematic",
		place_on = {"blocks:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.004,
			scale = 0.01,
			spread = {x = 100, y = 100, z = 100},
			seed = 137,
			octaves = 3,
			persist = 0.7,
		},
		biomes = {"grassland", "deciduous_forest"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("flora") .. "/schematics/bush.mts",
		flags = "place_center_x, place_center_z",
	})

	-- Blueberry bush

	minetest.register_decoration({
		name = "mapgen:blueberry_bush",
		deco_type = "schematic",
		place_on = {"blocks:dirt_with_grass", "blocks:dirt_with_snow"},
		sidelen = 16,
		noise_params = {
			offset = -0.004,
			scale = 0.01,
			spread = {x = 100, y = 100, z = 100},
			seed = 697,
			octaves = 3,
			persist = 0.7,
		},
		biomes = {"grassland", "snowy_grassland"},
		y_max = 31000,
		y_min = 1,
		place_offset_y = 1,
		schematic = minetest.get_modpath("flora") .. "/schematics/blueberry_bush.mts",
		flags = "place_center_x, place_center_z",
	})

	-- Acacia bush

	minetest.register_decoration({
		name = "mapgen:acacia_bush",
		deco_type = "schematic",
		place_on = {"blocks:dry_dirt_with_dry_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.004,
			scale = 0.01,
			spread = {x = 100, y = 100, z = 100},
			seed = 90155,
			octaves = 3,
			persist = 0.7,
		},
		biomes = {"savanna"},
		y_max = 31000,
		y_min = 1,
		schematic = minetest.get_modpath("flora") .. "/schematics/acacia_bush.mts",
		flags = "place_center_x, place_center_z",
	})

	-- Pine bush

	minetest.register_decoration({
		name = "mapgen:pine_bush",
		deco_type = "schematic",
		place_on = {"blocks:dirt_with_snow"},
		sidelen = 16,
		noise_params = {
			offset = -0.004,
			scale = 0.01,
			spread = {x = 100, y = 100, z = 100},
			seed = 137,
			octaves = 3,
			persist = 0.7,
		},
		biomes = {"taiga", "snowy_grassland"},
		y_max = 31000,
		y_min = 4,
		schematic = minetest.get_modpath("flora") .. "/schematics/pine_bush.mts",
		flags = "place_center_x, place_center_z",
	})

	-- Grasses

	register_grass_decoration(-0.03,  0.09,  5)
	register_grass_decoration(-0.015, 0.075, 4)
	register_grass_decoration(0,      0.06,  3)
	register_grass_decoration(0.015,  0.045, 2)
	register_grass_decoration(0.03,   0.03,  1)

	-- Dry grasses

	register_dry_grass_decoration(0.01, 0.05,  5)
	register_dry_grass_decoration(0.03, 0.03,  4)
	register_dry_grass_decoration(0.05, 0.01,  3)
	register_dry_grass_decoration(0.07, -0.01, 2)
	register_dry_grass_decoration(0.09, -0.03, 1)

	-- Ferns

	register_fern_decoration(14936, 3)
	register_fern_decoration(801,   2)
	register_fern_decoration(5,     1)

	-- Junglegrass

	minetest.register_decoration({
		name = "mapgen:junglegrass",
		deco_type = "simple",
		place_on = {"blocks:dirt_with_rainforest_litter"},
		sidelen = 80,
		fill_ratio = 0.1,
		biomes = {"rainforest"},
		y_max = 31000,
		y_min = 1,
		decoration = "flora:junglegrass",
	})

	-- Dry shrub

	minetest.register_decoration({
		name = "mapgen:dry_shrub",
		deco_type = "simple",
		place_on = {"blocks:desert_sand",
			"blocks:sand", "blocks:silver_sand"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.02,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"desert", "sandstone_desert", "cold_desert"},
		y_max = 31000,
		y_min = 2,
		decoration = "flora:dry_shrub",
		param2 = 4,
	})

	-- Marram grass

	minetest.register_decoration({
		name = "mapgen:marram_grass",
		deco_type = "simple",
		place_on = {"blocks:sand"},
		sidelen = 4,
		noise_params = {
			offset = -0.7,
			scale = 4.0,
			spread = {x = 16, y = 16, z = 16},
			seed = 513337,
			octaves = 1,
			persist = 0.0,
			flags = "absvalue, eased"
		},
		biomes = {"coniferous_forest_dunes", "grassland_dunes"},
		y_max = 6,
		y_min = 4,
		decoration = {
			"flora:marram_grass_1",
			"flora:marram_grass_2",
			"flora:marram_grass_3",
		},
	})

	-- Tundra moss

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"blocks:permafrost_with_stones"},
		sidelen = 4,
		noise_params = {
			offset = -0.8,
			scale = 2.0,
			spread = {x = 100, y = 100, z = 100},
			seed = 53995,
			octaves = 3,
			persist = 1.0
		},
		biomes = {"tundra"},
		y_max = 50,
		y_min = 2,
		decoration = "blocks:permafrost_with_moss",
		place_offset_y = -1,
		flags = "force_placement",
	})

	-- Tundra patchy snow

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {
			"blocks:permafrost_with_moss",
			"blocks:permafrost_with_stones",
			"blocks:stone",
			"blocks:gravel"
		},
		sidelen = 4,
		noise_params = {
			offset = 0,
			scale = 1.0,
			spread = {x = 100, y = 100, z = 100},
			seed = 172555,
			octaves = 3,
			persist = 1.0
		},
		biomes = {"tundra", "tundra_beach"},
		y_max = 50,
		y_min = 1,
		decoration = "blocks:snow",
	})

	-- Coral reef

	minetest.register_decoration({
		name = "mapgen:corals",
		deco_type = "simple",
		place_on = {"blocks:sand"},
		place_offset_y = -1,
		sidelen = 4,
		noise_params = {
			offset = -4,
			scale = 4,
			spread = {x = 50, y = 50, z = 50},
			seed = 7013,
			octaves = 3,
			persist = 0.7,
		},
		biomes = {
			"desert_ocean",
			"savanna_ocean",
			"rainforest_ocean",
		},
		y_max = -2,
		y_min = -8,
		flags = "force_placement",
		decoration = {
			"flora:coral_green", "flora:coral_pink",
			"flora:coral_cyan", "flora:coral_brown",
			"flora:coral_orange", "flora:coral_skeleton",
		},
	})

	-- Kelp

	minetest.register_decoration({
		name = "mapgen:kelp",
		deco_type = "simple",
		place_on = {"blocks:sand"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 0.1,
			spread = {x = 200, y = 200, z = 200},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -10,
		flags = "force_placement",
		decoration = "flora:sand_with_kelp",
		param2 = 48,
		param2_max = 96,
	})
end