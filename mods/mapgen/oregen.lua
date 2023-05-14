--
-- Register ores
--

-- Mgv6

-- All mapgens except mgv6

mapgen.surface_nodes = {"blocks:stone", "blocks:dry_dirt", "blocks:dry_dirt_with_dry_grass", "blocks:dirt", "blocks:dirt_with_grass", "blocks:dirt_with_snow", "blocks:dirt_with_rainforest_litter", "blocks:dirt_with_coniferous_litter",
"blocks:desert_stone", "blocks:desert_sand", "blocks:desert_sandstone", "blocks:sandstone", "blocks:sand", "blocks:silver_sandstone", "blocks:silver_sand", "blocks:chalk", "blocks:cobble",
"blocks:cave_ice", "blocks:ice", "blocks:gravel", "blocks:snowblock", "blocks:permafrost", "blocks:permafrost_with_stones", "blocks:desert_cobble", "blocks:mossycobble", "blocks:dune_sand"} -- Hope I didn't miss any

function mapgen.register_ores()
	-- Stratum ores.
	-- These obviously first.

	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "air",
		wherein         = mapgen.surface_nodes,
		clust_scarcity  = 1,
		y_max           = -32,
		y_min           = -128,
		noise_params    = {
			offset = mapgen.sfcaves_level,
			scale = 16,
			spread = {x = 16, y = 16, z = 16},
			seed = 262,
			octaves = 1,
			flags = "eased",
		},
		np_stratum_thickness = mapgen.surface_cave_np,
	})

	for i=1, #blocks.stone_colors do
		for j=1,8 do
			minetest.register_ore({
				ore_type        = "stratum",
				ore             = "blocks:stone_" .. blocks.stone_colors[i][1],
				wherein         = {"blocks:sandstone", "blocks:sand"},
				y_max           = 128,
				y_min           = -32,
				noise_threshold = 0.75,
				noise_params    = {
					offset = 132 - ((#blocks.stone_colors*j) - i),
					scale = 1.0,
					spread = {x = 64, y = 64, z = 64},
					seed = 47756 + j,
					octaves = 1,
					persist = 0.0,
				},
				np_stratum_thickness = {
					offset = -4,
					scale = 5,
					spread = {x = 128, y = 128, z = 128},
					seed = 77822344,
					octaves = 1,
				},
			})
		end
	end
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
	-- Effectively these define the "underground" sub-biome, stone-based first
	-- Stone-based biomes are divided into lush and icy.
	-- Lush biomes' underground has dirt
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:dirt",
		wherein         = {"blocks:stone"},
		clust_scarcity  = 6 * 6 * 6,
		clust_size      = 4,
		y_max           = mapgen.sfcave_limit,
		y_min           = mapgen.underground_limit,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.75,
			scale = 1.0,
			spread = {x = 4, y = 4, z = 4},
			seed = 462,
			octaves = 1,
			persist = 0.0,
			flags = "absvalue",
		},
		biomes = mapgen.lush_biomes,
	})
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:dirt",
		wherein         = {"blocks:stone"},
		clust_scarcity  = 6 * 6 * 6,
		clust_size      = 2,
		y_max           = mapgen.sfcave_limit,
		y_min           = mapgen.underground_limit,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.75,
			scale = 1.0,
			spread = {x = 6, y = 6, z = 6},
			seed = 722345,
			octaves = 1,
			persist = 0.0,
			flags = "absvalue",
		},
		biomes = mapgen.lush_biomes,
	})
	-- Icy biomes' underground has permafrost
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:permafrost",
		wherein         = {"blocks:stone"},
		clust_scarcity  = 6 * 6 * 6,
		clust_size      = 4,
		y_max           = mapgen.sfcave_limit,
		y_min           = mapgen.underground_limit,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.75,
			scale = 1.0,
			spread = {x = 4, y = 4, z = 4},
			seed = 462,
			octaves = 1,
			persist = 0.0,
			flags = "absvalue",
		},
		biomes = mapgen.icy_biomes,
	})
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:permafrost",
		wherein         = {"blocks:stone"},
		clust_scarcity  = 6 * 6 * 6,
		clust_size      = 2,
		y_max           = mapgen.sfcave_limit,
		y_min           = mapgen.underground_limit,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.75,
			scale = 1.0,
			spread = {x = 6, y = 6, z = 6},
			seed = 722345,
			octaves = 1,
			persist = 0.0,
			flags = "absvalue",
		},
		biomes = mapgen.icy_biomes,
	})

	-- Cracked ice as a base for sub biomes in Icesheet
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:cracked_ice",
		wherein         = {"blocks:ice", "blocks:cave_ice"},
		clust_scarcity  = 6 * 6 * 6,
		clust_size      = 4,
		y_max           = 512,
		y_min           = mapgen.underground_limit,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.75,
			scale = 1.0,
			spread = {x = 4, y = 4, z = 4},
			seed = 48822,
			octaves = 1,
			persist = 0.0,
			flags = "absvalue",
		},
	})
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:cracked_ice",
		wherein         = {"blocks:ice", "blocks:cave_ice"},
		clust_scarcity  = 6 * 6 * 6,
		clust_size      = 2,
		y_max           = 512,
		y_min           = mapgen.underground_limit,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.75,
			scale = 1.0,
			spread = {x = 6, y = 6, z = 6},
			seed = 7266125,
			octaves = 1,
			persist = 0.0,
			flags = "absvalue",
		},
	})
	-- Cobble is present in both lush and icy stone biomes
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:cobble",
		wherein         = {"blocks:stone"},
		clust_scarcity  = 8 * 8 * 8,
		clust_size      = 6,
		y_max           = 0,
		y_min           = mapgen.underground_limit,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.75,
			scale = 1.0,
			spread = {x = 4, y = 4, z = 4},
			seed = 82,
			octaves = 1,
			persist = 0.0,
			flags = "absvalue",
		},
	})
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:cobble",
		wherein         = {"blocks:stone"},
		clust_scarcity  = 12 * 12 * 12,
		clust_size      = 8,
		y_max           = mapgen.underground_limit,
		y_min           = mapgen.world_bottom,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.25,
			spread = {x = 8, y = 8, z = 8},
			seed = 8862,
			octaves = 1,
			persist = 0.0
		},
	})
	-- Underground, sandstone-based
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:dry_dirt",
		wherein         = {"blocks:sandstone"},
		clust_scarcity  = 6 * 6 * 6,
		clust_size      = 5,
		y_max           = mapgen.sfcave_limit,
		y_min           = mapgen.underground_limit,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.75,
			scale = 1.0,
			spread = {x = 4, y = 4, z = 4},
			seed = 462,
			octaves = 1,
			persist = 0.0,
			flags = "absvalue",
		},
	})
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:dry_dirt",
		wherein         = {"blocks:sandstone"},
		clust_scarcity  = 6 * 6 * 6,
		clust_size      = 4,
		y_max           = mapgen.sfcave_limit,
		y_min           = mapgen.underground_limit,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.75,
			scale = 1.0,
			spread = {x = 6, y = 6, z = 6},
			seed = 722345,
			octaves = 1,
			persist = 0.0,
			flags = "absvalue",
		},
	})
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:sand",
		wherein         = {"blocks:sandstone"},
		clust_scarcity  = 8 * 8 * 8,
		clust_size      = 3,
		y_max           = mapgen.sfcave_limit,
		y_min           = mapgen.underground_limit,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.75,
			scale = 1.0,
			spread = {x = 4, y = 4, z = 4},
			seed = 82,
			octaves = 1,
			persist = 0.0,
			flags = "absvalue",
		},
	})
	-- Then desert sandstone
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:dry_dirt",
		wherein         = {"blocks:desert_sandstone"},
		clust_scarcity  = 6 * 6 * 6,
		clust_size      = 5,
		y_max           = mapgen.sfcave_limit,
		y_min           = mapgen.underground_limit,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.75,
			scale = 1.0,
			spread = {x = 4, y = 4, z = 4},
			seed = 462,
			octaves = 1,
			persist = 0.0,
			flags = "absvalue",
		},
	})
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:dry_dirt",
		wherein         = {"blocks:desert_sandstone"},
		clust_scarcity  = 6 * 6 * 6,
		clust_size      = 4,
		y_max           = mapgen.sfcave_limit,
		y_min           = mapgen.underground_limit,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.75,
			scale = 1.0,
			spread = {x = 6, y = 6, z = 6},
			seed = 722345,
			octaves = 1,
			persist = 0.0,
			flags = "absvalue",
		},
	})
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:desert_sand",
		wherein         = {"blocks:desert_sandstone"},
		clust_scarcity  = 8 * 8 * 8,
		clust_size      = 3,
		y_max           = 0,
		y_min           = mapgen.underground_limit,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.75,
			scale = 1.0,
			spread = {x = 4, y = 4, z = 4},
			seed = 82,
			octaves = 1,
			persist = 0.0,
			flags = "absvalue",
		},
	})
	-- And silver sandstone
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:gravel",
		wherein         = {"blocks:silver_sandstone"},
		clust_scarcity  = 6 * 6 * 6,
		clust_size      = 4,
		y_max           = 0,
		y_min           = mapgen.underground_limit,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.75,
			scale = 1.0,
			spread = {x = 4, y = 4, z = 4},
			seed = 462,
			octaves = 1,
			persist = 0.0,
			flags = "absvalue",
		},
	})
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:gravel",
		wherein         = {"blocks:silver_sandstone"},
		clust_scarcity  = 6 * 6 * 6,
		clust_size      = 2,
		y_max           = 0,
		y_min           = mapgen.underground_limit,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.75,
			scale = 1.0,
			spread = {x = 6, y = 6, z = 6},
			seed = 722345,
			octaves = 1,
			persist = 0.0,
			flags = "absvalue",
		},
	})
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:silver_sand",
		wherein         = {"blocks:silver_sandstone"},
		clust_scarcity  = 8 * 8 * 8,
		clust_size      = 3,
		y_max           = 0,
		y_min           = mapgen.underground_limit,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.75,
			scale = 1.0,
			spread = {x = 4, y = 4, z = 4},
			seed = 82,
			octaves = 1,
			persist = 0.0,
			flags = "absvalue",
		},
	})
	-- And finally, desert stone
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:dry_dirt",
		wherein         = {"blocks:desert_stone"},
		clust_scarcity  = 6 * 6 * 6,
		clust_size      = 5,
		y_max           = mapgen.sfcave_limit,
		y_min           = mapgen.underground_limit,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.75,
			scale = 1.0,
			spread = {x = 4, y = 4, z = 4},
			seed = 462,
			octaves = 1,
			persist = 0.0,
			flags = "absvalue",
		},
	})
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:dry_dirt",
		wherein         = {"blocks:desert_stone"},
		clust_scarcity  = 6 * 6 * 6,
		clust_size      = 4,
		y_max           = mapgen.sfcave_limit,
		y_min           = mapgen.underground_limit,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.75,
			scale = 1.0,
			spread = {x = 6, y = 6, z = 6},
			seed = 722345,
			octaves = 1,
			persist = 0.0,
			flags = "absvalue",
		},
	})
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:desert_cobble",
		wherein         = {"blocks:desert_stone"},
		clust_scarcity  = 8 * 8 * 8,
		clust_size      = 3,
		y_max           = 0,
		y_min           = mapgen.underground_limit,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.75,
			scale = 1.0,
			spread = {x = 4, y = 4, z = 4},
			seed = 82,
			octaves = 1,
			persist = 0.0,
			flags = "absvalue",
		},
	})
	-- Underground, savanna
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:dry_dirt",
		wherein         = {"blocks:stone"},
		clust_scarcity  = 6 * 6 * 6,
		clust_size      = 5,
		y_max           = mapgen.sfcave_limit,
		y_min           = mapgen.underground_limit,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.75,
			scale = 1.0,
			spread = {x = 4, y = 4, z = 4},
			seed = 462,
			octaves = 1,
			persist = 0.0,
			flags = "absvalue",
		},
		biomes = mapgen.hot_biomes,
	})
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:dry_dirt",
		wherein         = {"blocks:stone"},
		clust_scarcity  = 6 * 6 * 6,
		clust_size      = 4,
		y_max           = mapgen.sfcave_limit,
		y_min           = mapgen.underground_limit,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.75,
			scale = 1.0,
			spread = {x = 6, y = 6, z = 6},
			seed = 722345,
			octaves = 1,
			persist = 0.0,
			flags = "absvalue",
		},
		biomes = mapgen.hot_biomes,
	})
	-- Chalk
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:chalk",
		wherein         = {"blocks:stone", "blocks:sandstone", "blocks:desert_sandstone", "blocks:silver_sandstone", "blocks:dry_dirt"},
		clust_scarcity  = 16 * 16 * 16,
		clust_size      = 8,
		y_max           = 2,
		y_min           = -64,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.5,
			spread = {x = 8, y = 8, z = 8},
			seed = 72344,
			octaves = 1,
			persist = 0.0
		},
	})
	-- Decoration for chalk_grassland biome
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:chalk",
		wherein         = {"blocks:chalk_with_grass"},
		y_max           = 119,
		y_min           = 20,
		clust_size		= 8,
		clust_scarcity 	= 6 * 6 * 6,
		noise_threshold = -0.55,
		noise_params    = {
			offset = -0.3,
			scale = -0.75,
			spread = {x = 1024, y = 1024, z = 1024},
			seed = 5520,
			octaves = 6,
			persist = 0.0,
		},
	})
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:chalk",
		wherein         = {"blocks:chalk_with_grass"},
		y_max           = 19,
		y_min           = 9,
		clust_size		= 7,
		clust_scarcity 	= 11 * 11 * 11,
		noise_threshold = -0.5,
		noise_params    = {
			offset = -0.3,
			scale = -0.75,
			spread = {x = 1024, y = 1024, z = 1024},
			seed = 5520,
			octaves = 3,
			persist = 0.0,
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
		wherein         = {"blocks:stone", "blocks:chalk"},
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
		-- Only in lush biomes
		biomes = mapgen.lush_biomes,
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
	-- Tundra bone tree biome
	minetest.register_ore({
		ore_type        = "blob",
		ore             = "blocks:permafrost_with_bone_roots",
		wherein         = {"blocks:permafrost_with_stones"},
		clust_scarcity  = 24 * 24 * 24,
		clust_size      = 10,
		y_max           = 50,
		y_min           = mapgen.underground_start,
		noise_threshold = 0.0,
		noise_params    = {
			offset = -3.25,
			scale = 4.0,
			spread = {x = 100, y = 100, z = 100},
			seed = 662444,
			octaves = 1,
			persist = 0.0,
			flags = "eased",
		},
		biomes = {"tundra"},
	})
	-- Sheet ores
	-- Mud
	minetest.register_ore({
		ore_type        = "sheet",
		ore             = "blocks:mud",
		wherein         = {"blocks:dirt", "blocks:dirt_with_rainforest_litter", "blocks:dirt_with_grass", "blocks:dirt_with_dry_grass", "blocks:dry_dirt", "blocks:dry_dirt_with_dry_grass"},
		column_height_max = 3,
		column_midpoint_factor = 0,
		y_max           = 5,
		y_min           = -5,
		noise_threshold = 0.6,
		noise_params    = {
			offset = 0.5,
			scale = 0.25,
			spread = {x = 3, y = 3, z = 3},
			seed = 66549,
			octaves = 1,
			persist = 0.0
		},
	})
	-- Mineral Salt
	minetest.register_ore({
		ore_type = "sheet",
		ore = "blocks:mineral_salt",
		wherein = { "blocks:desert_stone", "blocks:desert_sandstone", "blocks:sandstone"},
		y_min = -128,
		y_max = 512,
		column_height_min = 3,
		column_height_max = 7,
		noise_threshold = 0.2,
		noise_params = {
			offset = 0,
			scale = 2,
			spread = {x = 60, y = 60, z = 3},
			seed = 3953,
			octaves = 1,
			persist = 0.5
		}
	})
	-- Basalt
	minetest.register_ore({
		ore_type        = "sheet",
		ore             = "blocks:basalt",
		wherein         = {"blocks:stone", "blocks:sandstone", "blocks:desert_sandstone", "blocks:silver_sandstone", "blocks:desert_stone"},
		y_max           = 10,
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
		wherein         = {"blocks:stone", "blocks:sandstone"},
		y_max           = 128,
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
	-- Sandstone sheets in sand to allow for spawning of surface "stalagmites"
	minetest.register_ore({
		ore_type        = "sheet",
		ore             = "blocks:sandstone",
		wherein         = {"blocks:sand"},
		y_max           = 512,
		y_min           = -64,
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
		biomes = {"sandstone_desert", "sandstone_desert_ocean", "desert_ocean"},
	})
	minetest.register_ore({
		ore_type        = "sheet",
		ore             = "blocks:desert_sandstone",
		wherein         = {"blocks:desert_sand"},
		y_max           = 512,
		y_min           = -64,
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
	minetest.register_ore({
		ore_type        = "sheet",
		ore             = "blocks:silver_sandstone",
		wherein         = {"blocks:silver_sand"},
		y_max           = 512,
		y_min           = -64,
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
	-- Scatter ores
	-- Decorative stuff that we don't want to actually influence the gameplay so it goes last
	-- Surface caves
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:mossy_stone",
		wherein        = "blocks:stone",
		clust_scarcity = 5 * 5 * 5,
		clust_num_ores = 24,
		clust_size     = 4,
		y_max          = 8,
		y_min          = mapgen.underground_start - 8,
		biomes = mapgen.lush_biomes,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_icy",
		wherein        = "blocks:stone",
		clust_scarcity = 5 * 5 * 5,
		clust_num_ores = 32,
		clust_size     = 5,
		y_max          = 8,
		y_min          = mapgen.underground_start - 8,
		biomes = mapgen.icy_biomes,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:mossycobble",
		wherein        = "blocks:cobble",
		clust_scarcity = 5 * 5 * 5,
		clust_num_ores = 24,
		clust_size     = 4,
		y_max          = 8,
		y_min          = mapgen.underground_start - 8,
		biomes = mapgen.lush_biomes,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:mossy_desert_stone",
		wherein        = "blocks:desert_stone",
		clust_scarcity = 5 * 5 * 5,
		clust_num_ores = 24,
		clust_size     = 4,
		y_max          = 8,
		y_min          = mapgen.underground_start - 8,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:mossy_desert_cobble",
		wherein        = "blocks:desert_cobble",
		clust_scarcity = 5 * 5 * 5,
		clust_num_ores = 24,
		clust_size     = 4,
		y_max          = 8,
		y_min          = mapgen.underground_start - 8,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:mossy_sandstone",
		wherein        = "blocks:sandstone",
		clust_scarcity = 5 * 5 * 5,
		clust_num_ores = 24,
		clust_size     = 4,
		y_max          = 8,
		y_min          = mapgen.underground_start - 8,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:mossy_desert_sandstone",
		wherein        = "blocks:desert_sandstone",
		clust_scarcity = 5 * 5 * 5,
		clust_num_ores = 24,
		clust_size     = 4,
		y_max          = 8,
		y_min          = mapgen.underground_start - 8,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:mossy_silver_sandstone",
		wherein        = "blocks:silver_sandstone",
		clust_scarcity = 5 * 5 * 5,
		clust_num_ores = 24,
		clust_size     = 4,
		y_max          = 8,
		y_min          = mapgen.underground_start - 8,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_moonstone",
		wherein        = "blocks:stone",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 8,
		clust_size     = 6,
		y_max          = 0,
		y_min          = mapgen.underground_start - 8,
	})
	-- Ice
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:moonstone",
		wherein        = {"blocks:ice","blocks:cave_ice"},
		clust_scarcity = 12 * 12 * 12,
		clust_num_ores = 3,
		clust_size     = 4,
		y_max          = 0,
		y_min          = mapgen.underground_start - 8,
	})
end
