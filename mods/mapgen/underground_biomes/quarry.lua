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
		node_dungeon_stair = "variations:shapes_stone_big_tile_stair",
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
		node_dungeon_stair = "variations:shapes_stone_big_tile_stair",
        node_cave_liquid = "air",
		y_max = mapgen.quarry_middle,
		y_min = mapgen.quarry_bottom,
		heat_point = 50,
		humidity_point = 50,
	})
end

mapgen.register_quarry_ores = function()
    -- Cavern
    minetest.register_ore({
        ore_type = "stratum",
        ore = "air",
        wherein = "blocks:stone",
        y_max = mapgen.quarry_middle,
		y_min = mapgen.quarry_bottom,
        noise_params = {
            offset = mapgen.quarry_cavern_level,
            scale = 64,
            spread = {x = 200, y = 200, z = 200},
            seed = 61,
            octaves = 5,
            persistence = 0.5,
            flags = "noeased"
        },
        np_stratum_thickness = {
            offset = 64,
            scale = 128,
            spread = {x = 100, y = 100, z = 100},
            seed = 884,
            octaves = 1,
            persistence = 0.5,
            lacunatiry = 1.5,
            flags = "noeased"
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
end

mapgen.register_quarry_terrain_decorations = function()
    minetest.register_decoration({
        deco_type = "schematic",
        place_on = "blocks:stone",
        fill_ratio = 0.0001,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_middle,
        flags = "force_placement, all_floors, all_ceilings place_center_x, place_center_y, place_center_z",
        schematic = "schematics/underground/quarry_terrain_large1.mts",
        replacements = {["default:sandstone"] = "air"},
        rotation = "random"
    })
    for i=2,7 do
        minetest.register_decoration({
            deco_type = "schematic",
            place_on = "blocks:stone",
            fill_ratio = 0.0008 - (i * 0.0001),
            y_max = mapgen.quarry_top,
            y_min = mapgen.quarry_middle,
            flags = "force_placement, all_floors, all_ceilings place_center_x, place_center_y, place_center_z",
            schematic = "schematics/underground/quarry_terrain_large" .. i .. ".mts",
            replacements = {["default:sandstone"] = "air"},
            rotation = "random"
        })
    end
    for i=1,6 do
        minetest.register_decoration({
            deco_type = "schematic",
            place_on = "blocks:stone",
            fill_ratio = 0.0024  - (i * 0.0002),
            y_max = mapgen.quarry_top,
            y_min = mapgen.quarry_middle,
            flags = "force_placement, all_floors, all_ceilings place_center_x, place_center_y, place_center_z",
            schematic = "schematics/underground/quarry_terrain_small" .. i .. ".mts",
            replacements = {["default:sandstone"] = "air"},
            rotation = "random"
        })
    end
end