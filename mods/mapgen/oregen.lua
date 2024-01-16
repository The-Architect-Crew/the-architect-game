--
-- Register ores
--

-- Mgv6

-- All mapgens except mgv6

function mapgen.register_ores()
	-- Stratum ores.
	-- These obviously first.
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
		y_min           = mapgen.sfcave_bottom,
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
		y_min           = mapgen.sfcave_bottom,
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
		y_min           = mapgen.sfcave_bottom,
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
		y_min           = mapgen.sfcave_bottom,
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
	-- Amber

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:mud_with_amber",
		wherein        = "blocks:mud",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 8,
		clust_size     = 3,
		y_max          = mapgen.terrain_ceiling,
		y_min          = mapgen.sfcave_top,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:sandstone_with_amber",
		wherein        = "blocks:sandstone",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 8,
		clust_size     = 3,
		y_max          = mapgen.terrain_ceiling,
		y_min          = mapgen.sfcave_top,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:sand_with_amber",
		wherein        = "blocks:sand",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 8,
		clust_size     = 3,
		y_max          = mapgen.terrain_ceiling,
		y_min          = mapgen.sfcave_top,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:dirt_with_amber",
		wherein        = "blocks:dirt",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 8,
		clust_size     = 3,
		y_max          = mapgen.terrain_ceiling,
		y_min          = mapgen.sfcave_top,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:dry_dirt_with_amber",
		wherein        = "blocks:dry_dirt",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 8,
		clust_size     = 3,
		y_max          = mapgen.terrain_ceiling,
		y_min          = mapgen.sfcave_top,
	})

	-- Coal

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_coal",
		wherein        = "blocks:stone",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 8,
		clust_size     = 3,
		y_max          = mapgen.terrain_ceiling,
		y_min          = mapgen.sfcave_bottom,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:sandstone_with_coal",
		wherein        = "blocks:sandstone",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 8,
		clust_size     = 3,
		y_max          = mapgen.terrain_ceiling,
		y_min          = mapgen.sfcave_bottom,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:desert_stone_with_coal",
		wherein        = "blocks:desert_stone",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 8,
		clust_size     = 3,
		y_max          = mapgen.terrain_ceiling,
		y_min          = mapgen.sfcave_bottom,
	})

	-- Tin

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_tin",
		wherein        = "blocks:stone",
		clust_scarcity = 13 * 13 * 13,
		clust_num_ores = 4,
		clust_size     = 3,
		y_max          = mapgen.sfcave_top,
		y_min          = mapgen.sfcave_bottom,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:desert_stone_with_tin",
		wherein        = "blocks:desert_stone",
		clust_scarcity = 13 * 13 * 13,
		clust_num_ores = 4,
		clust_size     = 3,
		y_max          = mapgen.sfcave_top,
		y_min          = mapgen.sfcave_bottom,
	})

	-- Copper

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_copper",
		wherein        = "blocks:stone",
		clust_scarcity = 12 * 12 * 12,
		clust_num_ores = 4,
		clust_size     = 3,
		y_max          = mapgen.sfcave_top,
		y_min          = mapgen.sfcave_bottom,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:desert_stone_with_copper",
		wherein        = "blocks:desert_stone",
		clust_scarcity = 12 * 12 * 12,
		clust_num_ores = 4,
		clust_size     = 3,
		y_max          = mapgen.sfcave_top,
		y_min          = mapgen.sfcave_bottom,
	})
end
