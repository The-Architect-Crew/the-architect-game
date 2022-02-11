--
-- Register ores
--

-- Mgv6

function mapgen.register_mgv6_ores()
	-- Blob ore
	-- These first to avoid other ores in blobs
	-- Clay
	-- This first to avoid clay in sand blobs
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:clay",
		wherein         = {"blocks:sand"},
		clust_scarcity  = 16 * 16 * 16,
		clust_size      = 5,
		y_max           = 0,
		y_min           = -15,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = -316,
			octaves = 1,
			persist = 0.0
		},
	})
	-- Sand
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:sand",
		wherein         = {"blocks:stone", "blocks:desert_stone"},
		clust_scarcity  = 16 * 16 * 16,
		clust_size      = 5,
		y_max           = 0,
		y_min           = -31,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 2316,
			octaves = 1,
			persist = 0.0
		},
	})
	-- Dirt
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:dirt",
		wherein         = {"blocks:stone"},
		clust_scarcity  = 16 * 16 * 16,
		clust_size      = 5,
		y_max           = 31000,
		y_min           = -31,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 17676,
			octaves = 1,
			persist = 0.0
		},
	})
	-- Gravel
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:gravel",
		wherein         = {"blocks:stone"},
		clust_scarcity  = 16 * 16 * 16,
		clust_size      = 5,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 766,
			octaves = 1,
			persist = 0.0
		},
	})
	-- Scatter ores
	-- Coal
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_coal",
		wherein        = "blocks:stone",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 9,
		clust_size     = 3,
		y_max          = 31000,
		y_min          = 1025,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_coal",
		wherein        = "blocks:stone",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 8,
		clust_size     = 3,
		y_max          = 64,
		y_min          = -31000,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_coal",
		wherein        = "blocks:stone",
		clust_scarcity = 24 * 24 * 24,
		clust_num_ores = 27,
		clust_size     = 6,
		y_max          = 0,
		y_min          = -31000,
	})
	-- Iron
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_iron",
		wherein        = "blocks:stone",
		clust_scarcity = 9 * 9 * 9,
		clust_num_ores = 12,
		clust_size     = 3,
		y_max          = 31000,
		y_min          = 1025,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_iron",
		wherein        = "blocks:stone",
		clust_scarcity = 7 * 7 * 7,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = 0,
		y_min          = -31000,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_iron",
		wherein        = "blocks:stone",
		clust_scarcity = 24 * 24 * 24,
		clust_num_ores = 27,
		clust_size     = 6,
		y_max          = -64,
		y_min          = -31000,
	})
	-- Copper
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_copper",
		wherein        = "blocks:stone",
		clust_scarcity = 9 * 9 * 9,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = 31000,
		y_min          = 1025,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_copper",
		wherein        = "blocks:stone",
		clust_scarcity = 12 * 12 * 12,
		clust_num_ores = 4,
		clust_size     = 3,
		y_max          = -16,
		y_min          = -63,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_copper",
		wherein        = "blocks:stone",
		clust_scarcity = 9 * 9 * 9,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = -64,
		y_min          = -31000,
	})
	-- Tin
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_tin",
		wherein        = "blocks:stone",
		clust_scarcity = 10 * 10 * 10,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = 31000,
		y_min          = 1025,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_tin",
		wherein        = "blocks:stone",
		clust_scarcity = 13 * 13 * 13,
		clust_num_ores = 4,
		clust_size     = 3,
		y_max          = -32,
		y_min          = -127,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_tin",
		wherein        = "blocks:stone",
		clust_scarcity = 10 * 10 * 10,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = -128,
		y_min          = -31000,
	})
	-- Gold
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_gold",
		wherein        = "blocks:stone",
		clust_scarcity = 13 * 13 * 13,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = 31000,
		y_min          = 1025,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_gold",
		wherein        = "blocks:stone",
		clust_scarcity = 15 * 15 * 15,
		clust_num_ores = 3,
		clust_size     = 2,
		y_max          = -64,
		y_min          = -255,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_gold",
		wherein        = "blocks:stone",
		clust_scarcity = 13 * 13 * 13,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = -256,
		y_min          = -31000,
	})
	-- Mese crystal
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_mese",
		wherein        = "blocks:stone",
		clust_scarcity = 14 * 14 * 14,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = 31000,
		y_min          = 1025,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_mese",
		wherein        = "blocks:stone",
		clust_scarcity = 18 * 18 * 18,
		clust_num_ores = 3,
		clust_size     = 2,
		y_max          = -64,
		y_min          = -255,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_mese",
		wherein        = "blocks:stone",
		clust_scarcity = 14 * 14 * 14,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = -256,
		y_min          = -31000,
	})
	-- Diamond
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_diamond",
		wherein        = "blocks:stone",
		clust_scarcity = 15 * 15 * 15,
		clust_num_ores = 4,
		clust_size     = 3,
		y_max          = 31000,
		y_min          = 1025,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_diamond",
		wherein        = "blocks:stone",
		clust_scarcity = 17 * 17 * 17,
		clust_num_ores = 4,
		clust_size     = 3,
		y_max          = -128,
		y_min          = -255,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_diamond",
		wherein        = "blocks:stone",
		clust_scarcity = 15 * 15 * 15,
		clust_num_ores = 4,
		clust_size     = 3,
		y_max          = -256,
		y_min          = -31000,
	})
	-- Mese block
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:mese",
		wherein        = "blocks:stone",
		clust_scarcity = 36 * 36 * 36,
		clust_num_ores = 3,
		clust_size     = 2,
		y_max          = 31000,
		y_min          = 1025,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:mese",
		wherein        = "blocks:stone",
		clust_scarcity = 36 * 36 * 36,
		clust_num_ores = 3,
		clust_size     = 2,
		y_max          = -1024,
		y_min          = -31000,
	})
	-- Silver
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_silver",
		wherein        = "blocks:stone",
		clust_scarcity = 11 * 11 * 11,
		clust_num_ores = 4,
		clust_size     = 11,
		y_max          = -512,
		y_min          = -31000,
	})
	-- Mithril
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_mithril",
		wherein        = "blocks:stone",
		clust_scarcity = 11 * 11 * 11,
		clust_num_ores = 1,
		clust_size     = 11,
		y_max          = -2,
		y_min          = -31000,
	})
end


-- All mapgens except mgv6

function mapgen.register_ores()
	-- Stratum ores.
	-- These obviously first.
	-- Basalt Surface Layers
	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "blocks:basalt",
		wherein         = {"blocks:stone", "blocks:desert_stone", "blocks:sandstone", "blocks:desert_sandstone", "blocks:silver_sandstone"},
		clust_scarcity  = 1,
		y_max           = 256,
		y_min           = -256,
		noise_params    = {
			offset = -24,
			scale = 128,
			spread = {x = 128, y = 128, z = 128},
			seed = 93364,
			octaves = 1,
		},
		np_stratum_thickness = {
			offset = 0,
			scale = 8,
			spread = {x = 12, y = 12, z = 12},
			seed = 624,
			octaves = 1,
		},
	})
	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "blocks:basalt",
		wherein         = {"blocks:stone", "blocks:desert_stone", "blocks:sandstone", "blocks:desert_sandstone", "blocks:silver_sandstone"},
		clust_scarcity  = 1,
		y_max           = 256,
		y_min           = -256,
		noise_params    = {
			offset = -32,
			scale = 80,
			spread = {x = 128, y = 128, z = 128},
			seed = 364,
			octaves = 1,
		},
		np_stratum_thickness = {
			offset = 0,
			scale = 8,
			spread = {x = 24, y = 24, z = 24},
			seed = 62,
			octaves = 1,
		},
	})
	-- Coal Surface Strata
	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "blocks:stone_with_coalblock",
		wherein         = {"blocks:stone", "blocks:desert_stone", "blocks:sandstone", "blocks:desert_sandstone", "blocks:silver_sandstone"},
		clust_scarcity  = 1,
		y_max           = 512,
		y_min           = 0,
		noise_params    = {
			offset = 128,
			scale = 64,
			spread = {x = 64, y = 64, z = 64},
			seed = 90122,
			octaves = 1,
		},
		np_stratum_thickness = {
			offset = 0,
			scale = 4,
			spread = {x = 8, y = 8, z = 8},
			seed = 7345,
			octaves = 1,
		},
	})
	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "blocks:stone_with_coalblock",
		wherein         = {"blocks:stone", "blocks:desert_stone", "blocks:sandstone", "blocks:desert_sandstone", "blocks:silver_sandstone"},
		clust_scarcity  = 2,
		y_max           = 128,
		y_min           = -32,
		noise_params    = {
			offset = 32,
			scale = 48,
			spread = {x = 64, y = 64, z = 64},
			seed = 99935,
			octaves = 1,
		},
		np_stratum_thickness = {
			offset = 0,
			scale = 5,
			spread = {x = 8, y = 8, z = 8},
			seed = 753334,
			octaves = 1,
		},
	})
	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "blocks:stone_with_coalblock",
		wherein         = {"blocks:stone", "blocks:desert_stone", "blocks:sandstone", "blocks:desert_sandstone", "blocks:silver_sandstone"},
		clust_scarcity  = 2,
		y_max           = 0,
		y_min           = -128,
		noise_params    = {
			offset = -32,
			scale = 48,
			spread = {x = 64, y = 64, z = 64},
			seed = 662233,
			octaves = 1,
		},
		np_stratum_thickness = {
			offset = 0,
			scale = 6,
			spread = {x = 8, y = 8, z = 8},
			seed = 555234,
			octaves = 1,
		},
	})
	--	Marble Underground Layers
	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "blocks:marble",
		wherein         = {"blocks:stone"},
		clust_scarcity  = 1,
		y_max           = -64,
		y_min           = -512,
		noise_params    = {
			offset = -256,
			scale = 80,
			spread = {x = 80, y = 80, z = 80},
			seed = 6644434,
			octaves = 1,
		},
		np_stratum_thickness = {
			offset = 0,
			scale = 128,
			spread = {x = 12, y = 12, z = 12},
			seed = 265,
			octaves = 1,
		},
	})
	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "blocks:marble",
		wherein         = {"blocks:stone"},
		clust_scarcity  = 1,
		y_max           = -256,
		y_min           = -1024,
		noise_params    = {
			offset = -768,
			scale = 128,
			spread = {x = 80, y = 80, z = 80},
			seed = 664,
			octaves = 1,
		},
		np_stratum_thickness = {
			offset = 0,
			scale = 128,
			spread = {x = 12, y = 12, z = 12},
			seed = 23,
			octaves = 1,
		},
	})
	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "blocks:marble",
		wherein         = {"blocks:stone"},
		clust_scarcity  = 1,
		y_max           = -256,
		y_min           = -1538,
		noise_params    = {
			offset = -1024,
			scale = 192,
			spread = {x = 80, y = 80, z = 80},
			seed = 663344,
			octaves = 1,
		},
		np_stratum_thickness = {
			offset = 0,
			scale = 128,
			spread = {x = 12, y = 12, z = 12},
			seed = 243,
			octaves = 1,
		},
	})
	-- Marble Deep Layer
	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "blocks:marble",
		wherein         = {"blocks:stone"},
		clust_scarcity  = 1,
		y_max           = -768,
		y_min           = -2000,
		noise_params    = {
			offset = -1538,
			scale = 256,
			spread = {x = 96, y = 96, z = 96},
			seed = 3344,
			octaves = 1,
		},
		np_stratum_thickness = {
			offset = 0,
			scale = 256,
			spread = {x = 24, y = 24, z = 24},
			seed = 24,
			octaves = 1,
		},
	})
	-- Granite Surface Rocks
	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "blocks:granite",
		wherein         = {"air", "blocks:dirt", "blocks:dirt_with_grass", "blocks:stone", "blocks:sand", "blocks:desertsand", "blocks:silver_sand", "blocks:water_source", "blocks:desert_stone", "blocks:sandstone", "blocks:desert_sandstone", "blocks:silver_sandstone", "blocks:dry_dirt", "blocks:dirt_with_dry_grass", "blocks:dirt_with_snow", "blocks:snow", "blocks:dirt_with_rainforest_litter", "blocks:dirt_with_coniferous_litter"},
		clust_scarcity  = 1,
		y_max           = 768,
		y_min           = -256,
		noise_params    = {
			offset = -64,
			scale = 64,
			spread = {x = 64, y = 64, z = 64},
			seed = 5342,
			octaves = 1,
		},
		np_stratum_thickness = {
			offset = -116,
			scale = 160,
			spread = {x = 32, y = 32, z = 32},
			seed = 7733,
			octaves = 1,
			persist = 1.5,
		},
	})
	-- Granite Underground Strata
	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "blocks:granite",
		wherein         = {"blocks:stone"},
		clust_scarcity  = 1,
		y_max           = 0,
		y_min           = -1280,
		noise_params    = {
			offset = -512,
			scale = 128,
			spread = {x = 80, y = 80, z = 80},
			seed = 62623,
			octaves = 1,
		},
		np_stratum_thickness = {
			offset = 0,
			scale = 128,
			spread = {x = 16, y = 16, z = 16},
			seed = 809,
			octaves = 1,
		},
	})
	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "blocks:granite",
		wherein         = {"blocks:stone"},
		clust_scarcity  = 1,
		y_max           = -768,
		y_min           = -2000,
		noise_params    = {
			offset = -1280,
			scale = 192,
			spread = {x = 80, y = 80, z = 80},
			seed = 354,
			octaves = 1,
		},
		np_stratum_thickness = {
			offset = 4,
			scale = 128,
			spread = {x = 16, y = 16, z = 16},
			seed = 8834,
			octaves = 1,
		},
	})
	-- Obsidian Deep Strata
	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "blocks:obsidian",
		wherein         = {"blocks:stone", "air"},
		clust_scarcity  = 1,
		y_max           = -1700,
		y_min           = -2048,
		noise_params    = {
			offset = -1964,
			scale = 32,
			spread = {x = 64, y = 64, z = 64},
			seed = 55465,
			octaves = 1,
		},
		np_stratum_thickness = {
			offset = 16,
			scale = 16,
			spread = {x = 16, y = 16, z = 16},
			seed = 99204,
			octaves = 1,
		},
	})
	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "blocks:obsidian",
		wherein         = {"blocks:stone"},
		clust_scarcity  = 1,
		y_max           = -1700,
		y_min           = -2048,
		noise_params    = {
			offset = -2048,
			scale = 32,
			spread = {x = 64, y = 64, z = 64},
			seed = 5625,
			octaves = 1,
		},
		np_stratum_thickness = {
			offset = 0,
			scale = 16,
			spread = {x = 16, y = 16, z = 16},
			seed = 99204,
			octaves = 1,
		},
	})
	-- World Boundary Caves
	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "air",
		wherein         = {"blocks:stone", "blocks:water_source", "blocks:lava_source"},
		clust_scarcity  = 1,
		y_max           = -1500,
		y_min           = -2048,
		noise_params    = {
			offset = -2000,
			scale = 32,
			spread = {x = 64, y = 64, z = 64},
			seed = 55465,
			octaves = 1,
		},
		stratum_thickness = 64,
	})
	-- World Boundary Lava
	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "blocks:lava_source",
		wherein         = {"air"},
		clust_scarcity  = 1,
		y_max           = -1700,
		y_min           = -2048,
		noise_params    = {
			offset = -2048,
			scale = 0,
			spread = {x = 64, y = 64, z = 64},
			seed = 72234,
			octaves = 1,
		},
		stratum_thickness = 40,
	})
	-- World Boundary Placeholder
	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "blocks:obsidian",
		wherein         = {"blocks:lava_source", "blocks:stone"},
		clust_scarcity  = 1,
		y_max           = -1700,
		y_min           = -2048,
		noise_params    = {
			offset = -2047,
			scale = 1,
			spread = {x = 64, y = 64, z = 64},
			seed = 72234,
			octaves = 1,
		},
		stratum_thickness = 2,
	})
	-- Decorative Strata from MTG
	-- Silver sandstone
	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "blocks:silver_sandstone",
		wherein         = {"blocks:stone"},
		clust_scarcity  = 1,
		y_max           = 46,
		y_min           = 10,
		noise_params    = {
			offset = 28,
			scale = 16,
			spread = {x = 128, y = 128, z = 128},
			seed = 90122,
			octaves = 1,
		},
		stratum_thickness = 4,
		biomes = {"cold_desert"},
	})
	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "blocks:silver_sandstone",
		wherein         = {"blocks:stone"},
		clust_scarcity  = 1,
		y_max           = 42,
		y_min           = 6,
		noise_params    = {
			offset = 24,
			scale = 16,
			spread = {x = 128, y = 128, z = 128},
			seed = 90122,
			octaves = 1,
		},
		stratum_thickness = 2,
		biomes = {"cold_desert"},
	})
	-- Desert sandstone
	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "blocks:desert_sandstone",
		wherein         = {"blocks:desert_stone"},
		clust_scarcity  = 1,
		y_max           = 46,
		y_min           = 10,
		noise_params    = {
			offset = 28,
			scale = 16,
			spread = {x = 128, y = 128, z = 128},
			seed = 90122,
			octaves = 1,
		},
		stratum_thickness = 4,
		biomes = {"desert"},
	})
	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "blocks:desert_sandstone",
		wherein         = {"blocks:desert_stone"},
		clust_scarcity  = 1,
		y_max           = 42,
		y_min           = 6,
		noise_params    = {
			offset = 24,
			scale = 16,
			spread = {x = 128, y = 128, z = 128},
			seed = 90122,
			octaves = 1,
		},
		stratum_thickness = 2,
		biomes = {"desert"},
	})
	-- Sandstone
	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "blocks:sandstone",
		wherein         = {"blocks:desert_stone"},
		clust_scarcity  = 1,
		y_max           = 39,
		y_min           = 3,
		noise_params    = {
			offset = 21,
			scale = 16,
			spread = {x = 128, y = 128, z = 128},
			seed = 90122,
			octaves = 1,
		},
		stratum_thickness = 2,
		biomes = {"desert"},
	})
	-- Blob ore.
	-- These before scatter ores to avoid other ores in blobs.
	-- Iron "Meteorites", at least thats the idea
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:stone_with_iron",
		wherein         = {"blocks:stone", "blocks:dirt", "blocks:dirt_with_grass", "blocks:dirt_with_snow", "blocks:dry_dirt", "blocks:dirt_with_dry_grass"},
		clust_scarcity  = 64 * 64 * 64,
		clust_size      = 8,
		y_max           = 256,
		y_min           = -16,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.2,
			scale = 0.2,
			spread = {x = 16, y = 16, z = 16},
			seed = 162,
			octaves = 1,
			persist = 0.0
		},
	})
	-- Serpentine
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:serpentine",
		wherein         = {"blocks:stone"},
		clust_scarcity  = 64 * 64 * 64,
		clust_size      = 18,
		y_max           = 0,
		y_min           = -2048,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.5,
			spread = {x = 6, y = 6, z = 6},
			seed = 7134,
			octaves = 1,
			persist = 0.0
		},
	})
	-- Porphyry
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:porphyry",
		wherein         = {"blocks:stone"},
		clust_scarcity  = 80 * 80 * 80,
		clust_size      = 11,
		y_max           = -1024,
		y_min           = -2048,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.25,
			spread = {x = 6, y = 6, z = 6},
			seed = 7243,
			octaves = 1,
			persist = 0.0
		},
	})
	-- Chalk
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:chalk",
		wherein         = {"blocks:sand", "blocks:dirt", "blocks:dry_dirt"},
		clust_scarcity  = 8 * 8 * 8,
		clust_size      = 12,
		y_max           = 2,
		y_min           = -128,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.5,
			spread = {x = 4, y = 4, z = 4},
			seed = 72344,
			octaves = 1,
			persist = 0.0
		},
	})
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:chalk",
		wherein         = {"blocks:stone", "blocks:sandstone", "blocks:desert_sandstone", "blocks:silver_sandstone", "blocks:desert_stone"},
		clust_scarcity  = 24 * 24 * 24,
		clust_size      = 8,
		y_max           = 512,
		y_min           = -256,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.25,
			scale = 0.25,
			spread = {x = 8, y = 8, z = 8},
			seed = 78224,
			octaves = 1,
			persist = 0.0
		},
	})
	-- Mud
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:mud",
		wherein         = {"blocks:sand"},
		clust_scarcity  = 6 * 6 * 6,
		clust_size      = 8,
		y_max           = 8,
		y_min           = -1,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.25,
			spread = {x = 4, y = 4, z = 4},
			seed = 7226654,
			octaves = 1,
			persist = 0.0
		},
	})
	-- Clay
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:clay",
		wherein         = {"blocks:sand"},
		clust_scarcity  = 16 * 16 * 16,
		clust_size      = 5,
		y_max           = 0,
		y_min           = -15,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = -316,
			octaves = 1,
			persist = 0.0
		},
	})
	-- Silver sand
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:silver_sand",
		wherein         = {"blocks:stone"},
		clust_scarcity  = 16 * 16 * 16,
		clust_size      = 5,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 2316,
			octaves = 1,
			persist = 0.0
		},
	})
	-- Dirt
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:dirt",
		wherein         = {"blocks:stone"},
		clust_scarcity  = 16 * 16 * 16,
		clust_size      = 5,
		y_max           = 31000,
		y_min           = -31,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 17676,
			octaves = 1,
			persist = 0.0
		},
		-- Only where default:dirt is present as surface material
		biomes = {"taiga", "snowy_grassland", "grassland", "coniferous_forest",
				"deciduous_forest", "deciduous_forest_shore", "rainforest",
				"rainforest_swamp"}
	})
	-- Gravel
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:gravel",
		wherein         = {"blocks:stone"},
		clust_scarcity  = 16 * 16 * 16,
		clust_size      = 5,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 766,
			octaves = 1,
			persist = 0.0
		},
	})
	-- Sheet ores
	-- Basalt
	minetest.register_ore({
		ore_type        = "sheet",
		ore             = "blocks:basalt",
		wherein         = {"blocks:stone", "blocks:sandstone", "blocks:desert_sandstone", "blocks:silver_sandstone", "blocks:desert_stone"},
		y_max           = 40,
		y_min           = -1024,
		noise_threshold = 0.5,
		column_height_max = 3,
		column_height_min = 3,
		noise_params    = {
			offset = -1,
			scale = 4,
			spread = {x = 50, y = 50, z = 1},
			seed = 8223,
			octaves = 1,
			persist = 0.70
		},
	})
	-- Slate
	minetest.register_ore({
		ore_type        = "sheet",
		ore             = "blocks:slate",
		wherein         = {"blocks:stone"},
		y_max           = -128,
		y_min           = -1024,
		noise_threshold = 1.0,
		column_height_max = 1,
		column_height_min = 1,
		noise_params    = {
			offset = -1,
			scale = 8,
			spread = {x = 50, y = 50, z = 1},
			seed = 662,
			octaves = 1,
			persist = 0.70
		},
	})
	-- Obsidian
	minetest.register_ore({
		ore_type        = "sheet",
		ore             = "blocks:obsidian",
		wherein         = {"blocks:stone"},
		y_max           = 0,
		y_min           = -2048,
		noise_threshold = 6,
		column_height_max = 1,
		column_height_min = 1,
		noise_params    = {
			offset = 0,
			scale = 8,
			spread = {x = 50, y = 50, z = 1},
			seed = 6722,
			octaves = 1,
			persist = 0.70
		},
	})
	-- Iron
	minetest.register_ore({
		ore_type        = "sheet",
		ore             = "blocks:stone_with_iron",
		wherein         = {"blocks:stone"},
		y_max           = 64,
		y_min           = -128,
		noise_threshold = 6,
		column_height_max = 1,
		column_height_min = 1,
		noise_params    = {
			offset = 0,
			scale = 8,
			spread = {x = 25, y = 25, z = 1},
			seed = 723,
			octaves = 1,
			persist = 0.70
		},
	})
	minetest.register_ore({
		ore_type        = "sheet",
		ore             = "blocks:desert_stone_with_iron",
		wherein         = {"blocks:desert_stone"},
		y_max           = 64,
		y_min           = -128,
		noise_threshold = 6,
		column_height_max = 1,
		column_height_min = 1,
		noise_params    = {
			offset = 0,
			scale = 8,
			spread = {x = 25, y = 25, z = 1},
			seed = 723,
			octaves = 1,
			persist = 0.70
		},
	})
	minetest.register_ore({
		ore_type        = "sheet",
		ore             = "blocks:sandstone_with_iron",
		wherein         = {"blocks:sandstone"},
		y_max           = 64,
		y_min           = -128,
		noise_threshold = 6,
		column_height_max = 1,
		column_height_min = 1,
		noise_params    = {
			offset = 0,
			scale = 8,
			spread = {x = 25, y = 25, z = 1},
			seed = 723,
			octaves = 1,
			persist = 0.70
		},
	})
	minetest.register_ore({
		ore_type        = "sheet",
		ore             = "blocks:desert_sandstone_with_iron",
		wherein         = {"blocks:desert_sandstone"},
		y_max           = 64,
		y_min           = -128,
		noise_threshold = 6,
		column_height_max = 1,
		column_height_min = 1,
		noise_params    = {
			offset = 0,
			scale = 8,
			spread = {x = 25, y = 25, z = 1},
			seed = 723,
			octaves = 1,
			persist = 0.70
		},
	})
	minetest.register_ore({
		ore_type        = "sheet",
		ore             = "blocks:silver_sandstone_with_iron",
		wherein         = {"blocks:silver_sandstone"},
		y_max           = 64,
		y_min           = -128,
		noise_threshold = 6,
		column_height_max = 1,
		column_height_min = 1,
		noise_params    = {
			offset = 0,
			scale = 8,
			spread = {x = 25, y = 25, z = 1},
			seed = 723,
			octaves = 1,
			persist = 0.70
		},
	})
	-- Turquoise
    minetest.register_ore({
		ore_type        = "sheet",
		ore             = "blocks:turquoise",
		wherein         = {"blocks:stone"},
		y_max           = -32,
		y_min           = -512,
		noise_threshold = 10,
		column_height_max = 2,
		column_height_min = 2,
		noise_params    = {
			offset = 0,
			scale = 12,
			spread = {x = 25, y = 25, z = 25},
			seed = 63,
			octaves = 1,
			persist = 0.0
		},
	})
	minetest.register_ore({
		ore_type        = "sheet",
		ore             = "blocks:turquoise",
		wherein         = {"blocks:stone"},
		y_max           = -32,
		y_min           = -2048,
		noise_threshold = 10,
		column_height_max = 2,
		column_height_min = 2,
		noise_params    = {
			offset = 0,
			scale = 12,
			spread = {x = 25, y = 25, z = 25},
			seed = 723445,
			octaves = 1,
			persist = 0.0
		},
	})
	-- Malachite
    minetest.register_ore({
		ore_type        = "sheet",
		ore             = "blocks:malachite",
		wherein         = {"blocks:stone"},
		y_max           = -1024,
		y_min           = -2048,
		noise_threshold = 18,
		column_height_max = 8,
		column_height_min = 1,
		noise_params    = {
			offset = 0,
			scale = 24,
			spread = {x = 25, y = 25, z = 25},
			seed = 92463,
			octaves = 1,
			persist = 0.0
		},
	})
	-- Serpentine
	minetest.register_ore({
		ore_type        = "sheet",
		ore             = "blocks:serpentine",
		wherein         = {"blocks:stone"},
		y_max           = 0,
		y_min           = -2048,
		noise_threshold = 18,
		column_height_max = 3,
		column_height_min = 3,
		noise_params    = {
			offset = 0,
			scale = 24,
			spread = {x = 25, y = 25, z = 25},
			seed = 623,
			octaves = 1,
			persist = 0.0
		},
	})
	-- Lapis Lazuli
	minetest.register_ore({
		ore_type        = "sheet",
		ore             = "blocks:lapis_lazuli",
		wherein         = {"blocks:stone"},
		y_max           = -1536,
		y_min           = -2048,
		noise_threshold = 20,
		column_height_max = 4,
		column_height_min = 3,
		noise_params    = {
			offset = 0,
			scale = 24,
			spread = {x = 25, y = 25, z = 25},
			seed = 92463,
			octaves = 1,
			persist = 0.0
		},
	})
	-- Scatter ores
	-- Coal
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_coal",
		wherein        = "blocks:stone",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 8,
		clust_size     = 3,
		y_max          = 128,
		y_min          = -192,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_coal",
		wherein        = "blocks:stone",
		clust_scarcity = 12 * 12 * 12,
		clust_num_ores = 24,
		clust_size     = 5,
		y_max          = 31000,
		y_min          = -31000,
	})
	-- Tin

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:granite_with_tin",
		wherein        = "blocks:granite",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 4,
		clust_size     = 5,
		y_max          = 64,
		y_min          = -2048,
	})

	-- Copper

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_copper",
		wherein        = "blocks:stone",
		clust_scarcity = 12 * 12 * 12,
		clust_num_ores = 4,
		clust_size     = 3,
		y_max          = -64,
		y_min          = -127,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_copper",
		wherein        = "blocks:stone",
		clust_scarcity = 9 * 9 * 9,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = -128,
		y_min          = -31000,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:malachite_with_copper",
		wherein        = "blocks:malachite",
		clust_scarcity = 6 * 6 * 6,
		clust_num_ores = 4,
		clust_size     = 4,
		y_max          = -1024,
		y_min          = -2048,
	})
	-- Iron
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_iron",
		wherein        = "blocks:stone",
		clust_scarcity = 7 * 7 * 7,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = 512,
		y_min          = -255,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:desert_stone_with_iron",
		wherein        = "blocks:desert_stone",
		clust_scarcity = 7 * 7 * 7,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = 512,
		y_min          = -255,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:sandstone_with_iron",
		wherein        = "blocks:sandstone",
		clust_scarcity = 7 * 7 * 7,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = 512,
		y_min          = -255,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:desert_sandstone_with_iron",
		wherein        = "blocks:desert_sandstone",
		clust_scarcity = 7 * 7 * 7,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = 512,
		y_min          = -255,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:silver_sandstone_with_iron",
		wherein        = "blocks:silver_sandstone",
		clust_scarcity = 7 * 7 * 7,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = 512,
		y_min          = -255,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_iron",
		wherein        = "blocks:stone",
		clust_scarcity = 12 * 12 * 12,
		clust_num_ores = 29,
		clust_size     = 5,
		y_max          = -256,
		y_min          = -31000,
	})
	-- Gold
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:sandstone_with_gold",
		wherein        = "blocks:sandstone",
		clust_scarcity = 13 * 13 * 13,
		clust_num_ores = 3,
		clust_size     = 3,
		y_max          = 512,
		y_min          = -256,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:silver_sandstone_with_gold",
		wherein        = "blocks:silver_sandstone",
		clust_scarcity = 13 * 13 * 13,
		clust_num_ores = 3,
		clust_size     = 3,
		y_max          = 512,
		y_min          = -256,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:desert_sandstone_with_gold",
		wherein        = "blocks:desert_sandstone",
		clust_scarcity = 13 * 13 * 13,
		clust_num_ores = 3,
		clust_size     = 3,
		y_max          = 512,
		y_min          = -256,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_gold",
		wherein        = "blocks:stone",
		clust_scarcity = 15 * 15 * 15,
		clust_num_ores = 3,
		clust_size     = 2,
		y_max          = -256,
		y_min          = -511,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_gold",
		wherein        = "blocks:stone",
		clust_scarcity = 13 * 13 * 13,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = -512,
		y_min          = -31000,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:granite_with_gold",
		wherein        = "blocks:granite",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 3,
		clust_size     = 5,
		y_max          = -256,
		y_min          = -2048,
	})
	-- Electrum
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_electrum",
		wherein        = "blocks:stone",
		clust_scarcity = 16 * 16 * 16,
		clust_num_ores = 3,
		clust_size     = 5,
		y_max          = -1024,
		y_min          = -2048,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:granite_with_electrum",
		wherein        = "blocks:granite",
		clust_scarcity = 16 * 16 * 16,
		clust_num_ores = 4,
		clust_size     = 8,
		y_max          = -1536,
		y_min          = -2048,
	})
	-- Mese crystal
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_mese",
		wherein        = "blocks:stone",
		clust_scarcity = 14 * 14 * 14,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = 31000,
		y_min          = 1025,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_mese",
		wherein        = "blocks:stone",
		clust_scarcity = 18 * 18 * 18,
		clust_num_ores = 3,
		clust_size     = 2,
		y_max          = -512,
		y_min          = -1023,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_mese",
		wherein        = "blocks:stone",
		clust_scarcity = 14 * 14 * 14,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = -1024,
		y_min          = -31000,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:marble_with_mese",
		wherein        = "blocks:marble",
		clust_scarcity = 12 * 12 * 12,
		clust_num_ores = 4,
		clust_size     = 3,
		y_max          = 0,
		y_min          = -2048,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:mese",
		wherein        = "blocks:marble",
		clust_scarcity = 16 * 16 * 16,
		clust_num_ores = 3,
		clust_size     = 2,
		y_max          = 0,
		y_min          = -2048,
	})
	-- Diamond
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_diamond",
		wherein        = "blocks:stone",
		clust_scarcity = 17 * 17 * 17,
		clust_num_ores = 4,
		clust_size     = 3,
		y_max          = -512,
		y_min          = -1024,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_diamond",
		wherein        = "blocks:stone",
		clust_scarcity = 15 * 15 * 15,
		clust_num_ores = 4,
		clust_size     = 3,
		y_max          = -1024,
		y_min          = -2048,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:granite_with_diamond",
		wherein        = "blocks:granite",
		clust_scarcity = 15 * 15 * 15,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = -1024,
		y_min          = -2048,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:obsidian_with_diamond",
		wherein        = "blocks:obsidian",
		clust_scarcity = 15 * 15 * 15,
		clust_num_ores = 3,
		clust_size     = 2,
		y_max          = -1024,
		y_min          = -2048,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:basalt_with_diamond",
		wherein        = "blocks:basalt",
		clust_scarcity = 16 * 16 * 16,
		clust_num_ores = 2,
		clust_size     = 2,
		y_max          = -512,
		y_min          = -2048,
	})
	-- Mese block
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:mese",
		wherein        = "blocks:stone",
		clust_scarcity = 36 * 36 * 36,
		clust_num_ores = 3,
		clust_size     = 2,
		y_max          = 31000,
		y_min          = 1025,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:mese",
		wherein        = "blocks:stone",
		clust_scarcity = 36 * 36 * 36,
		clust_num_ores = 3,
		clust_size     = 2,
		y_max          = -2048,
		y_min          = -4095,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:mese",
		wherein        = "blocks:stone",
		clust_scarcity = 28 * 28 * 28,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = -4096,
		y_min          = -31000,
	})
	-- Amber
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:coal_with_amber",
		wherein        = "blocks:stone_with_coalblock",
		clust_scarcity = 4 * 4 * 4,
		clust_num_ores = 9,
		clust_size     = 4,
		y_max          = 768,
		y_min          = -256,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_amber",
		wherein        = "blocks:stone",
		clust_scarcity = 12 * 12 * 12,
		clust_num_ores = 6,
		clust_size     = 4,
		y_max          = 768,
		y_min          = -256,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:sandstone_with_amber",
		wherein        = "blocks:sandstone",
		clust_scarcity = 12 * 12 * 12,
		clust_num_ores = 8,
		clust_size     = 4,
		y_max          = 768,
		y_min          = -256,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:desert_sandstone_with_amber",
		wherein        = "blocks:desert_sandstone",
		clust_scarcity = 12 * 12 * 12,
		clust_num_ores = 8,
		clust_size     = 4,
		y_max          = 768,
		y_min          = -256,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:silver_sandstone_with_amber",
		wherein        = "blocks:silver_sandstone",
		clust_scarcity = 12 * 12 * 12,
		clust_num_ores = 8,
		clust_size     = 4,
		y_max          = 768,
		y_min          = -256,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:mud_with_amber",
		wherein        = "blocks:mud",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 4,
		clust_size     = 2,
		y_max          = 4,
		y_min          = -4,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:dirt_with_amber",
		wherein        = "blocks:dirt",
		clust_scarcity = 16 * 16 * 16,
		clust_num_ores = 6,
		clust_size     = 6,
		y_max          = 768,
		y_min          = -128,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:sand_with_amber",
		wherein        = "blocks:sand",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 6,
		clust_size     = 3,
		y_max          = 6,
		y_min          = -2,
	})
	-- Silver
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_silver",
		wherein        = "blocks:stone",
		clust_scarcity = 11 * 11 * 11,
		clust_num_ores = 4,
		clust_size     = 11,
		y_max          = -512,
		y_min          = -31000,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:granite_with_silver",
		wherein        = "blocks:granite",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 4,
		clust_size     = 11,
		y_max          = -512,
		y_min          = -31000,
	})
	-- Mithril
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_mithril",
		wherein        = "blocks:stone",
		clust_scarcity = 11 * 11 * 11,
		clust_num_ores = 1,
		clust_size     = 11,
		y_max          = -1024,
		y_min          = -31000,
	})
	-- Amethyst
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:marble_with_amethyst",
		wherein        = "blocks:marble",
		clust_scarcity = 12 * 12 * 12,
		clust_num_ores = 7,
		clust_size     = 6,
		y_max          = 0,
		y_min          = -2048,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:granite_with_amethyst",
		wherein        = "blocks:marble",
		clust_scarcity = 12 * 12 * 12,
		clust_num_ores = 4,
		clust_size     = 5,
		y_max          = 32,
		y_min          = -2048,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:slate_with_amethyst",
		wherein        = "blocks:slate",
		clust_scarcity = 14 * 14 * 14,
		clust_num_ores = 4,
		clust_size     = 5,
		y_max          = 32,
		y_min          = -2048,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:sandstone_with_amethyst",
		wherein        = "blocks:sandstone",
		clust_scarcity = 16 * 16 * 16,
		clust_num_ores = 3,
		clust_size     = 4,
		y_max          = 512,
		y_min          = -256,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:silver_sandstone_with_amethyst",
		wherein        = "blocks:silver_sandstone",
		clust_scarcity = 16 * 16 * 16,
		clust_num_ores = 3,
		clust_size     = 4,
		y_max          = 512,
		y_min          = -256,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:desert_sandstone_with_amethyst",
		wherein        = "blocks:desert_sandstone",
		clust_scarcity = 16 * 16 * 16,
		clust_num_ores = 3,
		clust_size     = 4,
		y_max          = 512,
		y_min          = -256,
	})
	-- Garnet
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:marble_with_garnet",
		wherein        = "blocks:marble",
		clust_scarcity = 12 * 12 * 12,
		clust_num_ores = 6,
		clust_size     = 8,
		y_max          = 0,
		y_min          = -2048,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:slate_with_garnet",
		wherein        = "blocks:slate",
		clust_scarcity = 12 * 12 * 12,
		clust_num_ores = 6,
		clust_size     = 8,
		y_max          = 0,
		y_min          = -2048,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:granite_with_garnet",
		wherein        = "blocks:granite",
		clust_scarcity = 16 * 16 * 16,
		clust_num_ores = 6,
		clust_size     = 8,
		y_max          = 0,
		y_min          = -2048,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:basalt_with_garnet",
		wherein        = "blocks:basalt",
		clust_scarcity = 16 * 16 * 16,
		clust_num_ores = 6,
		clust_size     = 8,
		y_max          = 0,
		y_min          = -2048,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:obsidian_with_garnet",
		wherein        = "blocks:obsidian",
		clust_scarcity = 16 * 16 * 16,
		clust_num_ores = 6,
		clust_size     = 8,
		y_max          = 0,
		y_min          = -2048,
	})
	--Lapis Lazuli
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:marble_with_lapis",
		wherein        = "blocks:marble",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 12,
		clust_size     = 8,
		y_max          = 0,
		y_min          = -2048,
	})
end
