mapgen.sfcave_top = 16
mapgen.sfcave_bottom = -127

mapgen.sfcave_middle = (mapgen.sfcave_top + mapgen.sfcave_bottom) / 2

mapgen.sfcave_biome_base_nodes = {
	{base = "blocks:dirt", floor = "blocks:dirt_sfcave", ceiling = "blocks:dirt_sfcave_ceiling"},
	{base = "blocks:dry_dirt", floor = "blocks:dry_dirt_sfcave", ceiling = "blocks:dry_dirt_sfcave_ceiling"},
	{base = "blocks:permafrost", floor = "blocks:permafrost_sfcave", ceiling = "blocks:permafrost_sfcave_ceiling"}
}

mapgen.surface_nodes = {"blocks:stone", "blocks:dry_dirt", "blocks:dry_dirt_with_dry_grass", "blocks:dirt", "blocks:dirt_with_grass", "blocks:dirt_with_snow", "blocks:dirt_with_rainforest_litter", "blocks:dirt_with_coniferous_litter",
"blocks:desert_stone", "blocks:desert_sand", "blocks:desert_sandstone", "blocks:sandstone", "blocks:sand", "blocks:silver_sandstone", "blocks:silver_sand", "blocks:chalk", "blocks:cobble",
"blocks:cave_ice", "blocks:ice", "blocks:gravel", "blocks:snowblock", "blocks:permafrost", "blocks:permafrost_with_stones", "blocks:desert_cobble", "blocks:mossycobble", "blocks:dune_sand"} -- Hope I didn't miss any

mapgen.register_sfcave_biomes = function()
    -- Surface caves overlap with existing biomes and their underground variants.
end

mapgen.register_sfcave_ores = function()
	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "air",
		wherein         = mapgen.surface_nodes,
		clust_scarcity  = 1,
		y_min = mapgen.sfcave_bottom,
        y_max = mapgen.sfcave_top,
		noise_params    = {
			offset = mapgen.sfcave_middle,
			scale = 16,
			spread = {x = 16, y = 16, z = 16},
			seed = 262,
			octaves = 1,
			flags = "eased",
		},
		np_stratum_thickness = {
            offset = -0.8 * 144,
            scale = 144,
            spread = {x = 144, y = 144, z = 144},
            seed = 261,
            octaves = 2,
            persistence = 0.5,
            lacunarity = 3,
        }
	})
    mapgen.register_tapered_vein({
        ore = "air",
        wherein = mapgen.surface_nodes,
        y_max = mapgen.sfcave_top,
        y_min = mapgen.sfcave_bottom,
        noise_params = {
            offset = 0,
            scale = 1,
            spread = {x = 50, y = 50, z = 50},
            seed = 66234,
            octaves = 3,
            persistence = 0.75
        },
        taper_distance = 16,
    })
    -- Decorative Ores
    -- Useful ores are defined by each surface biome that the caves belong to
    -- Blob Ores
    minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:dirt",
		wherein = "blocks:stone",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 96,
		clust_size = 7,
		y_max = mapgen.sfcave_top,
		y_min = mapgen.sfcave_bottom,
        biomes = mapgen.lush_biomes,
	})
	minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:dirt",
		wherein = "blocks:stone",
		clust_scarcity = 4 * 4 * 4,
		clust_num_ores = 48,
		clust_size = 5,
		y_max = mapgen.sfcave_top,
		y_min = mapgen.sfcave_bottom,
        biomes = mapgen.lush_biomes,
	})
	minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:gravel",
		wherein = "blocks:stone",
		clust_scarcity = 6 * 6 * 6,
		clust_num_ores = 64,
		clust_size = 6,
		y_max = mapgen.sfcave_top,
		y_min = mapgen.sfcave_bottom,
	})
	minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:dry_dirt",
		wherein = "blocks:desert_stone",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 96,
		clust_size = 7,
		y_max = mapgen.sfcave_top,
		y_min = mapgen.sfcave_bottom,
        biomes = mapgen.hot_biomes,
	})
	minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:dry_dirt",
		wherein = "blocks:desert_stone",
		clust_scarcity = 4 * 4 * 4,
		clust_num_ores = 48,
		clust_size = 5,
		y_max = mapgen.sfcave_top,
		y_min = mapgen.sfcave_bottom,
        biomes = mapgen.hot_biomes,
	})
    minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:dry_dirt",
		wherein = "blocks:stone",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 96,
		clust_size = 7,
		y_max = mapgen.sfcave_top,
		y_min = mapgen.sfcave_bottom,
        biomes = mapgen.hot_biomes,
	})
	minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:dry_dirt",
		wherein = "blocks:stone",
		clust_scarcity = 4 * 4 * 4,
		clust_num_ores = 48,
		clust_size = 5,
		y_max = mapgen.sfcave_top,
		y_min = mapgen.sfcave_bottom,
        biomes = mapgen.hot_biomes,
	})
	minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:dark_dirt",
		wherein = "blocks:desert_stone",
		clust_scarcity = 6 * 6 * 6,
		clust_num_ores = 64,
		clust_size = 6,
		y_max = mapgen.sfcave_top,
		y_min = mapgen.sfcave_bottom,
        biomes = mapgen.hot_biomes,
	})
	minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:dry_dirt",
		wherein = "blocks:sandstone",
		clust_scarcity = 6 * 6 * 6,
		clust_num_ores = 48,
		clust_size = 5,
		y_max = mapgen.sfcave_top,
		y_min = mapgen.sfcave_bottom,
        biomes = mapgen.hot_biomes,
	})
	minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:dry_dirt",
		wherein = "blocks:sandstone",
		clust_scarcity = 4 * 4 * 4,
		clust_num_ores = 32,
		clust_size = 4,
		y_max = mapgen.sfcave_top,
		y_min = mapgen.sfcave_bottom,
        biomes = mapgen.hot_biomes,
	})
	minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:dry_dirt",
		wherein = "blocks:desert_sandstone",
		clust_scarcity = 6 * 6 * 6,
		clust_num_ores = 48,
		clust_size = 5,
		y_max = mapgen.sfcave_top,
		y_min = mapgen.sfcave_bottom,
        biomes = mapgen.hot_biomes,
	})
	minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:dry_dirt",
		wherein = "blocks:desert_sandstone",
		clust_scarcity = 4 * 4 * 4,
		clust_num_ores = 32,
		clust_size = 4,
		y_max = mapgen.sfcave_top,
		y_min = mapgen.sfcave_bottom,
        biomes = mapgen.hot_biomes,
	})
	minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:permafrost",
		wherein = "blocks:silver_sandstone",
		clust_scarcity = 6 * 6 * 6,
		clust_num_ores = 48,
		clust_size = 5,
		y_max = mapgen.sfcave_top,
		y_min = mapgen.sfcave_bottom,
        biomes = mapgen.frosty_biomes,
	})
	minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:permafrost",
		wherein = "blocks:silver_sandstone",
		clust_scarcity = 4 * 4 * 4,
		clust_num_ores = 32,
		clust_size = 4,
		y_max = mapgen.sfcave_top,
		y_min = mapgen.sfcave_bottom,
        biomes = mapgen.frosty_biomes,
	})
    minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:permafrost",
		wherein = "blocks:stone",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 96,
		clust_size = 7,
		y_max = mapgen.sfcave_top,
		y_min = mapgen.sfcave_bottom,
        biomes = mapgen.frosty_biomes,
	})
	minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:permafrost",
		wherein = "blocks:stone",
		clust_scarcity = 4 * 4 * 4,
		clust_num_ores = 48,
		clust_size = 5,
		y_max = mapgen.sfcave_top,
		y_min = mapgen.sfcave_bottom,
        biomes = mapgen.frosty_biomes,
	})
	minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:permafrost",
		wherein = {"blocks:ice", "blocks:cave_ice"},
		clust_scarcity = 6 * 6 * 6,
		clust_num_ores = 48,
		clust_size = 5,
		y_max = mapgen.sfcave_top,
		y_min = mapgen.sfcave_bottom,
        biomes = mapgen.frosty_biomes,
	})
	minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:permafrost",
		wherein = {"blocks:ice", "blocks:cave_ice"},
		clust_scarcity = 4 * 4 * 4,
		clust_num_ores = 32,
		clust_size = 4,
		y_max = mapgen.sfcave_top,
		y_min = mapgen.sfcave_bottom,
        biomes = mapgen.frosty_biomes,
	})
	minetest.register_ore({
		ore_type = "blob",
		ore = "blocks:snowblock",
		wherein = {"blocks:ice", "blocks:cave_ice"},
		clust_scarcity = 6 * 6 * 6,
		clust_num_ores = 64,
		clust_size = 6,
		y_max = mapgen.sfcave_top,
		y_min = mapgen.sfcave_bottom,
        biomes = mapgen.frosty_biomes,
	})
    -- Scatter Ores
    minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:mossy_stone",
		wherein        = "blocks:stone",
		clust_scarcity = 5 * 5 * 5,
		clust_num_ores = 24,
		clust_size     = 4,
		y_min = mapgen.sfcave_bottom,
        y_max = mapgen.sfcave_top,
		biomes = mapgen.lush_biomes,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_icy",
		wherein        = "blocks:stone",
		clust_scarcity = 5 * 5 * 5,
		clust_num_ores = 32,
		clust_size     = 5,
		y_min = mapgen.sfcave_bottom,
        y_max = mapgen.sfcave_top,
		biomes = mapgen.frosty_biomes,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:mossycobble",
		wherein        = "blocks:cobble",
		clust_scarcity = 5 * 5 * 5,
		clust_num_ores = 24,
		clust_size     = 4,
		y_min = mapgen.sfcave_bottom,
        y_max = mapgen.sfcave_top,
		biomes = mapgen.lush_biomes,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:mossy_desert_stone",
		wherein        = "blocks:desert_stone",
		clust_scarcity = 5 * 5 * 5,
		clust_num_ores = 24,
		clust_size     = 4,
		y_min = mapgen.sfcave_bottom,
        y_max = mapgen.sfcave_top,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:mossy_desert_cobble",
		wherein        = "blocks:desert_cobble",
		clust_scarcity = 5 * 5 * 5,
		clust_num_ores = 24,
		clust_size     = 4,
		y_min = mapgen.sfcave_bottom,
        y_max = mapgen.sfcave_top,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:mossy_sandstone",
		wherein        = "blocks:sandstone",
		clust_scarcity = 5 * 5 * 5,
		clust_num_ores = 24,
		clust_size     = 4,
		y_min = mapgen.sfcave_bottom,
        y_max = mapgen.sfcave_top,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:mossy_desert_sandstone",
		wherein        = "blocks:desert_sandstone",
		clust_scarcity = 5 * 5 * 5,
		clust_num_ores = 24,
		clust_size     = 4,
		y_min = mapgen.sfcave_bottom,
        y_max = mapgen.sfcave_top,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:mossy_silver_sandstone",
		wherein        = "blocks:silver_sandstone",
		clust_scarcity = 5 * 5 * 5,
		clust_num_ores = 24,
		clust_size     = 4,
		y_min = mapgen.sfcave_bottom,
        y_max = mapgen.sfcave_top,
	})
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_moonstone",
		wherein        = "blocks:stone",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 8,
		clust_size     = 6,
		y_min = mapgen.sfcave_bottom,
        y_max = mapgen.sfcave_top,
	})
	-- Ice
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:moonstone",
		wherein        = {"blocks:ice","blocks:cave_ice"},
		clust_scarcity = 12 * 12 * 12,
		clust_num_ores = 3,
		clust_size     = 4,
		y_min = mapgen.sfcave_bottom,
        y_max = mapgen.sfcave_top,
	})
end

mapgen.register_sfcave_decorations = function()
    mapgen.register_microbiome_base({
        y_min = mapgen.sfcave_bottom,
        y_max = mapgen.sfcave_top,
        fill_ratio = 10.0,
        base_nodes = mapgen.sfcave_biome_base_nodes
    })
    mapgen.place_microbiome_flora("moonstone", {
        y_min = mapgen.sfcave_bottom,
        y_max = mapgen.sfcave_top,
        seed = 162,
        surface_nodes = {"blocks:dirt_sfcave", "blocks:dirt_sfcave_ceiling"},
        small_plant_variation = true,
        grass_variation = true,
        grass = "flora:grass",
        small_plant = "flora:moonflower",
        plant_rarity = 0.15,
        grass_rarity = 1,
        vines = "flora:vines",
        vines_height = 8,
        secondary_vines = "flora:vines_moonstone",
        moss = "flora:vines_horizontal",
    })
    mapgen.place_microbiome_flora("moonstone_hot", {
        y_min = mapgen.sfcave_bottom,
        y_max = mapgen.sfcave_top,
        seed = 3444623,
        surface_nodes = {"blocks:dry_dirt_sfcave", "blocks:dry_dirt_sfcave_ceiling"},
        small_plant_variation = true,
        grass_variation = true,
        grass = "flora:dry_grass",
        small_plant = "flora:moonflower_dry",
        plant_rarity = 0.15,
        grass_rarity = 1,
        vines = "flora:vines_dry",
        vines_height = 8,
        secondary_vines = "flora:vines_dry_moonstone",
        moss = "flora:vines_dry_horizontal",
    })
    mapgen.place_microbiome_flora("moonstone_frosty", {
        y_min = mapgen.sfcave_bottom,
        y_max = mapgen.sfcave_top,
        seed = 82253663,
        surface_nodes = {"blocks:permafrost_sfcave", "blocks:permafrost_sfcave_ceiling"},
        small_plant_variation = true,
        grass_variation = true,
        grass = "flora:grass_frosty",
        small_plant = "flora:moonflower_frosty",
        plant_rarity = 0.15,
        grass_rarity = 1,
        vines = "flora:vines_frosty",
        vines_height = 8,
        secondary_vines = "flora:vines_frosty_moonstone",
        moss = "flora:vines_frosty_horizontal",
    })
    minetest.register_decoration({
        name = "sfcave_mossycobble",
        deco_type = "simple",
        place_on = {"blocks:stone"},
        fill_ratio = 10.0,
        y_min = mapgen.sfcave_bottom,
        y_max = mapgen.sfcave_top,
        spawn_by = "blocks:dirt_sfcave",
        num_spawn_by = 1,
        flags = "all_floors, force_placement",
        place_offset_y = -1,
        decoration = "blocks:mossycobble",
    })
end