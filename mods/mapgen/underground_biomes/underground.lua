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
	-- Decorative Ores
	minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:cobble",
		wherein = "blocks:stone",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 96,
		clust_size = 7,
		y_max = mapgen.underground_top,
		y_min = mapgen.underground_bottom,
	})
	minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:cobble",
		wherein = "blocks:stone",
		clust_scarcity = 4 * 4 * 4,
		clust_num_ores = 48,
		clust_size = 5,
		y_max = mapgen.underground_top,
		y_min = mapgen.underground_bottom,
	})
	minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:desert_cobble",
		wherein = "blocks:desert_stone",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 96,
		clust_size = 7,
		y_max = mapgen.underground_top,
		y_min = mapgen.underground_bottom,
	})
	minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:desert_cobble",
		wherein = "blocks:desert_stone",
		clust_scarcity = 4 * 4 * 4,
		clust_num_ores = 48,
		clust_size = 5,
		y_max = mapgen.underground_top,
		y_min = mapgen.underground_bottom,
	})
	minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:sand",
		wherein = "blocks:sandstone",
		clust_scarcity = 6 * 6 * 6,
		clust_num_ores = 48,
		clust_size = 5,
		y_max = mapgen.underground_top,
		y_min = mapgen.underground_bottom,
	})
	minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:sand",
		wherein = "blocks:sandstone",
		clust_scarcity = 4 * 4 * 4,
		clust_num_ores = 32,
		clust_size = 4,
		y_max = mapgen.underground_top,
		y_min = mapgen.underground_bottom,
	})
	minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:desert_sand",
		wherein = "blocks:desert_sandstone",
		clust_scarcity = 6 * 6 * 6,
		clust_num_ores = 48,
		clust_size = 5,
		y_max = mapgen.underground_top,
		y_min = mapgen.underground_bottom,
	})
	minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:desert_sand",
		wherein = "blocks:desert_sandstone",
		clust_scarcity = 4 * 4 * 4,
		clust_num_ores = 32,
		clust_size = 4,
		y_max = mapgen.underground_top,
		y_min = mapgen.underground_bottom,
	})
	minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:silver_sand",
		wherein = "blocks:silver_sandstone",
		clust_scarcity = 6 * 6 * 6,
		clust_num_ores = 48,
		clust_size = 5,
		y_max = mapgen.underground_top,
		y_min = mapgen.underground_bottom,
	})
	minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:silver_sand",
		wherein = "blocks:silver_sandstone",
		clust_scarcity = 4 * 4 * 4,
		clust_num_ores = 32,
		clust_size = 4,
		y_max = mapgen.underground_top,
		y_min = mapgen.underground_bottom,
	})
	minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:cracked_ice",
		wherein = {"blocks:ice", "blocks:cave_ice"},
		clust_scarcity = 6 * 6 * 6,
		clust_num_ores = 48,
		clust_size = 5,
		y_max = mapgen.underground_top,
		y_min = mapgen.underground_bottom,
	})
	minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:cracked_ice",
		wherein = {"blocks:ice", "blocks:cave_ice"},
		clust_scarcity = 4 * 4 * 4,
		clust_num_ores = 32,
		clust_size = 4,
		y_max = mapgen.underground_top,
		y_min = mapgen.underground_bottom,
	})
end

mapgen.register_underground_decorations = function()
	mapgen.register_microbiome_base({
		y_min = mapgen.underground_bottom,
		y_max = mapgen.underground_top,
		noise_params = {
			offset = -1.0,
			scale = 1.0,
			spread = {x = 100, y = 100, z = 100},
			seed = 354,
			octaves = 4,
			persistence = 0.75,
			lacunarity = 4,
			flags = "eased"
		},
		base_nodes = {
			{base = "blocks:stone", floor = "blocks:stone_firemoss", ceiling = "blocks:stone_firemoss_ceiling"},
			{base = "blocks:cobble", floor = "blocks:cobble_firemoss", ceiling = "blocks:cobble_firemoss_ceiling"},
			{base = "blocks:desert_stone", floor = "blocks:desert_stone_firemoss", ceiling = "blocks:desert_stone_firemoss_ceiling"},
			{base = "blocks:desert_cobble", floor = "blocks:desert_cobble_firemoss", ceiling = "blocks:desert_cobble_firemoss_ceiling"},
			{base = "blocks:sandstone", floor = "blocks:sandstone_azure", ceiling = "blocks:sandstone_azure_ceiling"},
			{base = "blocks:sand", floor = "blocks:sand_azure", ceiling = "blocks:sand_azure_ceiling"},
			{base = "blocks:desert_sandstone", floor = "blocks:desert_sandstone_azure", ceiling = "blocks:desert_sandstone_azure_ceiling"},
			{base = "blocks:desert_sand", floor = "blocks:desert_sand_azure", ceiling = "blocks:desert_sand_azure_ceiling"},
			{base = "blocks:silver_sandstone", floor = "blocks:silver_sandstone_azure", ceiling = "blocks:silver_sandstone_azure_ceiling"},
			{base = "blocks:silver_sand", floor = "blocks:silver_sand_azure", ceiling = "blocks:silver_sand_azure_ceiling"},
			{base = "blocks:ice", floor = "blocks:ice_azure", ceiling = "blocks:ice_azure_ceiling"},
			{base = "blocks:cave_ice", floor = "blocks:ice_azure", ceiling = "blocks:ice_azure_ceiling"},
			{base = "blocks:cracked_ice", floor = "blocks:cracked_ice_azure", ceiling = "blocks:cracked_ice_azure_ceiling"},
		}
	})
	mapgen.place_microbiome_flora("fire_underground", {
        y_max = mapgen.underground_top,
        y_min = mapgen.underground_bottom,
		seed = 262,
		surface_nodes = {"blocks:cobble_firemoss", "blocks:stone_firemoss"},
		small_plant_variation = true,
		grass_variation = true,
		grass = "flora:firegrass",
		small_plant = "flora:fireshroom",
		plant_rarity = 0.1,
		grass_rarity = 1,
		large_plant = "flora:fireplant",
		secondary_large_plant = "blocks:garnet",
		vines = "flora:firevines",
		vines_height = 16,
		moss = "flora:firemoss",
	})
	mapgen.place_microbiome_flora("azure_underground", {
        y_max = mapgen.underground_top,
        y_min = mapgen.underground_bottom,
		seed = 263,
		surface_nodes = {"blocks:desert_stone_azure", "blocks:desert_cobble_azure",
		"blocks:sandstone_azure", "blocks:sand_azure",
		"blocks:desert_sandstone", "blocks:desert_sand_azure",
		"blocks:silver_sandstone_azure", "blocks:silver_sand_azure",
		"blocks:ice_azure", "blocks:cracked_ice_azure"},
		small_plant_variation = true,
		grass_variation = true,
		grass = "flora:azure_grass",
		small_plant = "flora:azureshroom",
		plant_rarity = 0.1,
		grass_rarity = 1,
		large_plant = "flora:azure_plant",
		secondary_large_plant = "blocks:lapis_lazuli",
		vines = "flora:azure_vines",
		vines_height = 16,
		moss = "flora:azure_moss",
	})
	-- For testing
    --[[
	minetest.register_decoration({
        deco_type = "simple",
        place_on = "blocks:stone",
        sidelen = 8,
        fill_ratio = 0.04,
        y_max = mapgen.underground_top,
        y_min = mapgen.underground_bottom,
        flags = "all_floors",
        decoration = "blocks:meselamp",
    })]]--
end