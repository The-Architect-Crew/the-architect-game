mapgen.quarry_top = -1537
mapgen.quarry_bottom = -2304

mapgen.quarry_middle = (mapgen.quarry_top + mapgen.quarry_bottom) / 2

mapgen.quarry_cavern_level = (mapgen.quarry_middle + mapgen.quarry_bottom) / 2

mapgen.quarry_base = "blocks:stone"

mapgen.register_quarry_biomes = function()
	minetest.register_biome({
		name = "quarry",
		node_stone = mapgen.quarry_base,
		node_dungeon = "variations:stone_big_tile",
        node_dungeon_alt = "variations:stone_cross_tile",
		node_dungeon_stair = "variations:shapes_stone_tile_stair",
        node_cave_liquid = {"blocks:water_source", "blocks:lava_source"},
		y_max = mapgen.quarry_top,
		y_min = mapgen.quarry_middle,
		heat_point = 50,
		humidity_point = 50,
	})
    minetest.register_biome({
		name = "quarry_cavern",
		node_stone = mapgen.quarry_base,
		node_dungeon = "variations:stone_big_tile",
        node_dungeon_alt = "variations:stone_cross_tile",
		node_dungeon_stair = "variations:shapes_stone_tile_stair",
        node_cave_liquid = "air",
		y_max = mapgen.quarry_middle,
		y_min = mapgen.quarry_bottom,
		heat_point = 50,
		humidity_point = 50,
	})
end

mapgen.register_quarry_ores = function()
    -- Cavern Base
    minetest.register_ore({
        ore_type = "stratum",
        ore = "air",
        wherein = "blocks:stone",
        y_max = mapgen.quarry_middle,
		y_min = mapgen.quarry_bottom,
        noise_params = {
            offset = mapgen.quarry_cavern_level,
            scale = 16,
            spread = {x = 200, y = 200, z = 200},
            seed = 61,
            octaves = 5,
            persistence = 0.5,
            flags = "noeased"
        },
        np_stratum_thickness = {
            offset = 0,
            scale = 8,
            spread = {x = 6, y = 6, z = 6},
            seed = 884,
            octaves = 2,
            persistence = 0.5,
            flags = "absolute"
        }
    })
    -- Blobs for schematic caves
    minetest.register_ore({
        ore_type = "blob",
        ore = "air",
        wherein = "blocks:stone",
        clust_scarcity = 16 * 16 * 16,
        clust_num_ores = 8,
        clust_size = 3,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_middle
    })
    -- Small Ores
    minetest.register_ore({
        ore_type = "blob",
        ore = "blocks:stone_with_coal",
        wherein = "blocks:stone",
        clust_scarcity = 6 * 6 * 6,
        clust_num_ores = 27,
        clust_size = 3,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
    })
    minetest.register_ore({
        ore_type = "blob",
        ore = "blocks:stone_with_tin",
        wherein = "blocks:stone",
        clust_scarcity = 12 * 12 * 12,
        clust_num_ores = 32,
        clust_size = 4,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
    })
    minetest.register_ore({
        ore_type = "blob",
        ore = "blocks:stone_with_copper",
        wherein = "blocks:stone",
        clust_scarcity = 12 * 12 * 12,
        clust_num_ores = 32,
        clust_size = 4,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
    })
    minetest.register_ore({
        ore_type = "blob",
        ore = "blocks:stone_with_iron",
        wherein = "blocks:stone",
        clust_scarcity = 8 * 8 * 8,
        clust_num_ores = 32,
        clust_size = 4,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
    })
    minetest.register_ore({
        ore_type = "blob",
        ore = "blocks:stone_with_silver",
        wherein = "blocks:stone",
        clust_scarcity = 8 * 8 * 8,
        clust_num_ores = 24,
        clust_size = 3,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
    })
    minetest.register_ore({
        ore_type = "blob",
        ore = "blocks:stone_with_gold",
        wherein = "blocks:stone",
        clust_scarcity = 12 * 12 * 12,
        clust_num_ores = 24,
        clust_size = 3,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
    })
    minetest.register_ore({
        ore_type = "vein",
        ore = "blocks:stone_with_mithril",
        wherein = "blocks:stone",
        clust_scarcity = 12 * 12 * 12,
        clust_num_ores = 24,
        clust_size = 3,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
        noise_threshold = 1.3,
        noise_params = {
            offset = 0,
            scale = 32,
            spread = {x = 250, y = 250, z = 250},
            seed = 2443,
            octaves = 4,
            persistence = 0.75
        }
    })
    -- Large ores
    minetest.register_ore({
        ore_type = "blob",
        ore = "blocks:basalt",
        wherein = "blocks:stone",
        clust_scarcity = 14 * 14 * 14,
        clust_num_ores = 48,
        clust_size = 6,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
    })
    minetest.register_ore({
        ore_type = "blob",
        ore = "blocks:slate",
        wherein = "blocks:stone",
        clust_scarcity = 12 * 12 * 12,
        clust_num_ores = 32,
        clust_size = 6,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
    })
    -- Decorative Ores
    minetest.register_ore({
        ore_type = "blob",
        ore = "blocks:cobble",
        wherein = "blocks:stone",
        clust_scarcity = 8 * 8 * 8,
        clust_num_ores = 96,
        clust_size = 7,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
    })
    minetest.register_ore({
        ore_type = "blob",
        ore = "blocks:cobble",
        wherein = "blocks:stone",
        clust_scarcity = 4 * 4 * 4,
        clust_num_ores = 48,
        clust_size = 5,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
    })
    minetest.register_ore({
        ore_type = "blob",
        ore = "blocks:gravel",
        wherein = "blocks:stone",
        clust_scarcity = 8 * 8 * 8,
        clust_num_ores = 64,
        clust_size = 6,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
    })
    minetest.register_ore({
        ore_type = "blob",
        ore = "blocks:silver_sand",
        wherein = "blocks:stone",
        clust_scarcity = 8 * 8 * 8,
        clust_num_ores = 48,
        clust_size = 5,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
    })
    minetest.register_ore({
        ore_type = "blob",
        ore = "blocks:silver_sandstone",
        wherein = "blocks:stone",
        clust_scarcity = 10 * 10 * 10,
        clust_num_ores = 48,
        clust_size = 5,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
    })
    minetest.register_ore({
        ore_type = "blob",
        ore = "blocks:clay",
        wherein = "blocks:stone",
        clust_scarcity = 12 * 12 * 12,
        clust_num_ores = 64,
        clust_size = 6,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
    })
    -- Lost Mese
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:lost_mese",
		wherein        = mapgen.quarry_base,
		clust_scarcity = mapgen.lost_mese_ore_params.scarcity,
		clust_num_ores = mapgen.lost_mese_ore_params.num_ores,
		clust_size     = mapgen.lost_mese_ore_params.clust_size,
		y_max          = mapgen.quarry_top,
		y_min          = mapgen.quarry_bottom,
	})
end

mapgen.register_quarry_decorations = function()
    -- Caves
    minetest.register_decoration({
        deco_type = "schematic",
        place_on = "blocks:stone",
        fill_ratio = 0.0001,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_middle,
        flags = "force_placement, all_floors, all_ceilings, place_center_x, place_center_y, place_center_z",
        schematic = "schematics/underground/quarry_terrain_large1.mts",
        replacements = {["default:sandstone"] = "air"},
        rotation = "random"
    })
    for i=2,7 do
        minetest.register_decoration({
            deco_type = "schematic",
            place_on = "blocks:stone",
            fill_ratio = 0.0006 - (i * 0.00005),
            y_max = mapgen.quarry_top,
            y_min = mapgen.quarry_middle,
            flags = "force_placement, all_floors, all_ceilings, place_center_x, place_center_y, place_center_z",
            schematic = "schematics/underground/quarry_terrain_large" .. i .. ".mts",
            replacements = {["default:sandstone"] = "air"},
            rotation = "random"
        })
    end
    for i=1,6 do
        minetest.register_decoration({
            deco_type = "schematic",
            place_on = "blocks:stone",
            fill_ratio = 0.0016  - (i * 0.00005),
            y_max = mapgen.quarry_top,
            y_min = mapgen.quarry_middle,
            flags = "force_placement, all_floors, all_ceilings, place_center_x, place_center_y, place_center_z",
            schematic = "schematics/underground/quarry_terrain_small" .. i .. ".mts",
            replacements = {["default:sandstone"] = "air"},
            rotation = "random"
        })
    end
    -- Cavern
    minetest.register_decoration({
        deco_type = "schematic",
        place_on = "blocks:stone",
        fill_ratio = 0.0024,
        y_max = mapgen.quarry_middle,
        y_min = mapgen.quarry_bottom,
        flags = "force_placement, all_floors, all_ceilings, place_center_x, place_center_y, place_center_z",
        schematic = "schematics/underground/quarry_terrain_cavern1.mts",
        replacements = {["default:sandstone"] = "air"},
        rotation = "random"
    })
    for i=2,8 do
        minetest.register_decoration({
            deco_type = "schematic",
            place_on = "blocks:stone",
            fill_ratio = 0.0006  - (i * 0.00006),
            y_max = mapgen.quarry_middle,
            y_min = mapgen.quarry_bottom,
            flags = "force_placement, all_floors, all_ceilings, place_center_x, place_center_y, place_center_z",
            schematic = "schematics/underground/quarry_terrain_cavern" .. i .. ".mts",
            replacements = {["default:sandstone"] = "air"},
            rotation = "random"
        })
    end
    -- For testing
--[[
    minetest.register_decoration({
        deco_type = "simple",
        place_on = "blocks:stone",
        sidelen = 8,
        fill_ratio = 0.04,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
        flags = "all_floors",
        decoration = "blocks:meselamp",
    })]]--
    mapgen.register_stalagmites("blocks:stone", {min = mapgen.quarry_bottom, max = mapgen.quarry_top}, 0.25, 22543, "quarry")
end