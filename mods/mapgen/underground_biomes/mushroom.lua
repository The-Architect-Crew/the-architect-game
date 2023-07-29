mapgen.mushroom_top = -769
mapgen.mushroom_bottom = -1536

mapgen.mushroom_middle = (mapgen.mushroom_top + mapgen.mushroom_bottom) / 2

mapgen.mushroom_cavern_levels = {
    (mapgen.mushroom_top + mapgen.mushroom_middle) / 2,
    (((mapgen.mushroom_top + mapgen.mushroom_middle) / 2) + mapgen.mushroom_middle) / 2,
    mapgen.mushroom_middle,
    (((mapgen.mushroom_middle + mapgen.mushroom_bottom) / 2) + mapgen.mushroom_middle) / 2,
    (mapgen.mushroom_middle + mapgen.mushroom_bottom) / 2
}

mapgen.mushroom_base = "blocks:dirt_with_mycelia"

mapgen.register_mushroom_biomes = function()
	minetest.register_biome({
		name = "mushroom",
		node_stone = mapgen.mushroom_base,
		node_dungeon = "variations:stone_big_tile",
        node_dungeon_alt = "variations:stone_cross_tile",
		node_dungeon_stair = "variations:shapes_stone_tile_stair",
        node_cave_liquid = {"blocks:water_source", "blocks:lava_source"},
		y_max = mapgen.mushroom_top,
		y_min = mapgen.mushroom_middle,
		heat_point = 50,
		humidity_point = 50,
	})
    minetest.register_biome({
		name = "mushroom_cavern",
		node_stone = mapgen.mushroom_base,
		node_dungeon = "variations:stone_big_tile",
        node_dungeon_alt = "variations:stone_cross_tile",
		node_dungeon_stair = "variations:shapes_stone_tile_stair",
        node_cave_liquid = "air",
		y_max = mapgen.mushroom_middle,
		y_min = mapgen.mushroom_bottom,
		heat_point = 50,
		humidity_point = 50,
	})
end

mapgen.register_mushroom_ores = function()
    -- Caverns
    for i=1,#mapgen.mushroom_cavern_levels do
        minetest.register_ore({
            ore_type = "stratum",
            ore = "air",
            wherein = mapgen.mushroom_base,
            y_max = mapgen.mushroom_top,
            y_min = mapgen.mushroom_bottom,
            noise_params = {
                offset = mapgen.mushroom_cavern_levels[i],
                scale = 40,
                spread = {x = 256, y = 256, z = 256},
                seed = 9223 + mapgen.mushroom_cavern_levels[i],
                octaves = 5,
                persistence = 0.75
            },
            np_stratum_thickness = {
                offset = 0,
                scale = 192,
                spread = {x = 256, y = 256, z = 256},
                seed = 55234 + mapgen.mushroom_cavern_levels[i],
                octaves = 4,
                persistence = 0.5
            }
        })
    end
    -- Different mycelia
    minetest.register_ore({
        ore_type = "sheet",
        ore = "blocks:dirt_with_viridis_mycelia",
        wherein = mapgen.mushroom_base,
        y_max = mapgen.mushroom_top,
        y_min = mapgen.mushroom_bottom,
        column_height_min = 28,
        column_height_max = 32,
        column_midpoint_factor = 0.5,
        noise_params = {
            offset = 0,
            scale = 2,
            spread = {x = 256, y = 256, z = 256},
            seed = 723523,
            octaves = 5,
            persistence = 0.75,
            lacunarity = 2.0,
        },
    })
    minetest.register_ore({
        ore_type = "sheet",
        ore = "blocks:dirt_with_dark_mycelia",
        wherein = mapgen.mushroom_base,
        y_max = mapgen.mushroom_top,
        y_min = mapgen.mushroom_bottom,
        column_height_min = 12,
        column_height_max = 24,
        column_midpoint_factor = 0.5,
        noise_params = {
            offset = 0,
            scale = 2,
            spread = {x = 256, y = 256, z = 256},
            seed = 723523,
            octaves = 5,
            persistence = 0.75,
            lacunarity = 2.0,
        },
    })
    --[[
    minetest.register_ore({
        ore_type = "sheet",
        ore = "blocks:stone",
        wherein = "air",
        y_min = -31000,
        y_max = 31000,
        column_height_min = 28,
        column_height_max = 32,
        column_midpoint_factor = 0.5,
        noise_params = {
            offset = 0,
            scale = 2,
            spread = {x = 256, y = 256, z = 256},
            seed = 723523,
            octaves = 5,
            persistence = 0.75,
            lacunarity = 2.0,
        },
    })]]--
end

mapgen.mushroom_microbiome_base_nodes = {
    {base = "blocks:dirt_with_mycelia", floor = "blocks:dirt_firemoss_mushroom", ceiling = "blocks:dirt_firemoss_mushroom_ceiling"},
	{base = "blocks:dirt_with_mycelia", floor = "blocks:dirt_azure_mushroom", ceiling = "blocks:dirt_azure_mushroom_ceiling"},
}

mapgen.register_mushroom_decorations = function()
    mapgen.register_microbiome_base({
		y_min = mapgen.mushroom_bottom,
		y_max = mapgen.mushroom_top,
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
		base_nodes = mapgen.mushroom_microbiome_base_nodes,
	})
	minetest.register_decoration({
        deco_type = "simple",
        place_on = mapgen.mushroom_base,
        fill_ratio = 10.0,
        y_max = mapgen.mushroom_top,
        y_min = mapgen.mushroom_bottom,
        flags = "all_floors",
        decoration = "blocks:dirt_with_mushroom_grass",
    })
	minetest.register_decoration({
        deco_type = "simple",
        place_on = "blocks:dirt_with_viridis_mycelia",
        fill_ratio = 10.0,
        y_max = mapgen.mushroom_top,
        y_min = mapgen.mushroom_bottom,
        flags = "all_floors",
        decoration = "blocks:dirt_with_viridis_grass",
    })
    minetest.register_decoration({
        deco_type = "simple",
        place_on = "blocks:dirt_with_dark_mycelia",
        fill_ratio = 10.0,
        y_max = mapgen.mushroom_top,
        y_min = mapgen.mushroom_bottom,
        flags = "all_floors",
        decoration = "blocks:dirt_with_dark_grass",
    })
    -- Large Microbiome Mushrooms
    -- Azure
    for i=1,3 do
        minetest.register_decoration({
            deco_type = "schematic",
            place_on = "blocks:dirt_azure_mushroom",
            fill_ratio = 0.004,
            y_max = mapgen.mushroom_top,
            y_min = mapgen.mushroom_bottom,
            rotation = "random",
            flags = "all_floors, force_placement, place_center_x, place_center_z",
            schematic = "schematics/underground/azureshroom_segment" .. i .. ".mts",
            place_offset_y = -1,
        })
    end
    for i=1,2 do
        minetest.register_decoration({
            deco_type = "schematic",
            place_on = "blocks:dirt_azure_mushroom",
            fill_ratio = 0.003,
            y_max = mapgen.mushroom_top,
            y_min = mapgen.mushroom_bottom,
            rotation = "random",
            flags = "all_floors, force_placement, place_center_x, place_center_z",
            schematic = "schematics/underground/azureshroom_medium" .. i .. ".mts",
            place_offset_y = -1,
        })
    end
    minetest.register_decoration({
        deco_type = "schematic",
        place_on = "flora:dirt_azure_mushroom",
        fill_ratio = 0.001,
        y_max = mapgen.mushroom_top,
        y_min = mapgen.mushroom_bottom,
        flags = "all_floors, place_center_x, place_center_z",
        schematic = "schematics/underground/azureshroom_tall.mts",
    })
    minetest.register_decoration({
        deco_type = "schematic",
        place_on = "flora:azure_trunk",
        fill_ratio = 10.0,
        y_max = mapgen.mushroom_top,
        y_min = mapgen.mushroom_bottom,
        flags = "all_floors, place_center_x, place_center_z",
        schematic = "schematics/underground/azureshroom_cap.mts",
    })
    minetest.register_decoration({
        deco_type = "simple",
        place_on = "flora:azure_cap",
        fill_ratio = 10.0,
        y_max = mapgen.mushroom_top,
        y_min = mapgen.mushroom_bottom,
        flags = "all_ceilings",
        decoration = "flora:azure_vines",
        height = 1,
        height_max = 4
    })
    -- Fire
    for i=1,3 do
        minetest.register_decoration({
            deco_type = "schematic",
            place_on = "blocks:dirt_firemoss_mushroom",
            fill_ratio = 0.004,
            y_max = mapgen.mushroom_top,
            y_min = mapgen.mushroom_bottom,
            rotation = "random",
            flags = "all_floors, force_placement, place_center_x, place_center_z",
            schematic = "schematics/underground/fireshroom" .. i .. ".mts",
            place_offset_y = -2,
        })
    end
    minetest.register_decoration({
        deco_type = "simple",
        place_on = "flora:fireshroom_gills",
        fill_ratio = 10.0,
        y_max = mapgen.mushroom_top,
        y_min = mapgen.mushroom_bottom,
        flags = "all_ceilings",
        decoration = "flora:firevines",
        height = 1,
        height_max = 3
    })
    -- Microbiomes
    mapgen.place_microbiome_flora("fire_mushroom", {
        y_max = mapgen.mushroom_top,
        y_min = mapgen.mushroom_bottom,
		seed = 44143,
		surface_nodes = {"blocks:dirt_firemoss_mushroom"},
		small_plant_variation = true,
		grass_variation = true,
		grass = "flora:firegrass",
		small_plant = "flora:fireshroom",
		plant_rarity = 0.1,
		grass_rarity = 1,
		vines = "flora:firevines",
		vines_height = 16,
		moss = "flora:firemoss",
	})
	mapgen.place_microbiome_flora("azure_mushroom", {
        y_max = mapgen.mushroom_top,
        y_min = mapgen.mushroom_bottom,
		seed = 9923,
		surface_nodes = {"blocks:dirt_azure_mushroom"},
		small_plant_variation = true,
		grass_variation = true,
		grass = "flora:azure_grass",
		small_plant = "flora:azureshroom",
		plant_rarity = 0.1,
		grass_rarity = 1,
		large_plant = "flora:azure_plant",
		vines = "flora:azure_vines",
		vines_height = 16,
		moss = "flora:azure_moss",
	})
    -- Viridis Mushroom
    for i=1,3 do
        minetest.register_decoration({
            deco_type = "schematic",
            place_on = "blocks:dirt_with_viridis_grass",
            fill_ratio = 0.002,
            y_max = mapgen.mushroom_top,
            y_min = mapgen.mushroom_bottom,
            flags = "all_floors, force_placement, place_center_x, place_center_z",
            schematic = "schematics/underground/viridis" .. i .. ".mts",
            place_offset_y = -2,
        })
    end
    minetest.register_decoration({
        deco_type = "schematic",
        place_on = "blocks:dirt_with_viridis_mycelia",
        fill_ratio = 0.004,
        y_max = mapgen.mushroom_top,
        y_min = mapgen.mushroom_bottom,
        flags = "all_ceilings, force_placement, place_center_x, place_center_z",
        schematic = "schematics/underground/viridis_ceiling.mts",
        place_offset_y = -2,
    })
    for i=1,3 do
        minetest.register_decoration({
            deco_type = "simple",
            place_on = "blocks:dirt_with_viridis_grass",
            sidelen = 8,
            fill_ratio = 0.08,
            y_max = mapgen.mushroom_top,
            y_min = mapgen.mushroom_bottom,
            flags = "all_floors",
            decoration = "flora:viridis_ground_" .. i,
        })
        minetest.register_decoration({
            deco_type = "simple",
            place_on = "blocks:dirt_with_viridis_mycelia",
            sidelen = 8,
            fill_ratio = 0.08,
            y_max = mapgen.mushroom_top,
            y_min = mapgen.mushroom_bottom,
            flags = "all_ceilings",
            decoration = "flora:viridis_ceiling_" .. i,
        })
    end
    -- Darkshroom
    for i=1,3 do
        minetest.register_decoration({
            deco_type = "schematic",
            place_on = "blocks:dirt_with_dark_grass",
            fill_ratio = 0.002,
            y_max = mapgen.mushroom_top,
            y_min = mapgen.mushroom_bottom,
            flags = "all_floors, force_placement, place_center_x, place_center_z",
            schematic = "schematics/underground/darkshroom" .. i .. ".mts",
            place_offset_y = -2,
        })
    end
    minetest.register_decoration({
        deco_type = "schematic",
        place_on = "blocks:dirt_with_dark_mycelia",
        fill_ratio = 0.004,
        y_max = mapgen.mushroom_top,
        y_min = mapgen.mushroom_bottom,
        flags = "all_ceilings, force_placement, place_center_x, place_center_z",
        schematic = "schematics/underground/darkshroom_ceiling.mts",
        place_offset_y = -2,
    })
    minetest.register_decoration({
        deco_type = "simple",
        place_on = "flora:dark_cap_spike",
        fill_ratio = 10.0,
        y_max = mapgen.mushroom_top,
        y_min = mapgen.mushroom_bottom,
        flags = "all_ceilings",
        decoration = "flora:dark_spike",
    })
    -- Ghostshroom
    for i=1,3 do
        minetest.register_decoration({
            deco_type = "schematic",
            place_on = "blocks:dirt_with_viridis_grass",
            fill_ratio = 0.001,
            y_max = mapgen.mushroom_top,
            y_min = mapgen.mushroom_bottom,
            flags = "all_floors, force_placement, place_center_x, place_center_z",
            schematic = "schematics/underground/ghostshroom" .. i .. ".mts",
            place_offset_y = -2,
        })
    end
    minetest.register_decoration({
        deco_type = "schematic",
        place_on = "blocks:dirt_with_viridis_mycelia",
        fill_ratio = 0.002,
        y_max = mapgen.mushroom_top,
        y_min = mapgen.mushroom_bottom,
        flags = "all_ceilings, force_placement, place_center_x, place_center_z",
        schematic = "schematics/underground/ghostshroom_ceiling.mts",
        place_offset_y = -2,
    })
    minetest.register_decoration({
        deco_type = "simple",
        place_on = "flora:ghost_cap",
        fill_ratio = 10.0,
        y_max = mapgen.mushroom_top,
        y_min = mapgen.mushroom_bottom,
        flags = "all_ceilings",
        decoration = "flora:ghost_cilia",
        height = 3,
        height_max = 8
    })
    minetest.register_decoration({
        deco_type = "simple",
        place_on = "flora:ghost_cilia",
        fill_ratio = 10.0,
        y_max = mapgen.mushroom_top,
        y_min = mapgen.mushroom_bottom,
        flags = "all_ceilings",
        decoration = "flora:ghost_cilia_bottom",
    })
    for i=1,3 do
        minetest.register_decoration({
            deco_type = "simple",
            place_on = "blocks:dirt_with_viridis_grass",
            sidelen = 8,
            fill_ratio = 0.08,
            y_max = mapgen.mushroom_top,
            y_min = mapgen.mushroom_bottom,
            flags = "all_floors",
            decoration = "flora:ghost_ground_" .. i,
        })
        minetest.register_decoration({
            deco_type = "simple",
            place_on = "blocks:dirt_with_viridis_mycelia",
            sidelen = 8,
            fill_ratio = 0.08,
            y_max = mapgen.mushroom_top,
            y_min = mapgen.mushroom_bottom,
            flags = "all_ceilings",
            decoration = "flora:ghost_ceiling_" .. i,
        })
    end
    -- Amber mushrooms
    minetest.register_decoration({
        deco_type = "schematic",
        place_on = "blocks:dirt_azure_mushroom",
        fill_ratio = 0.0001,
        y_max = mapgen.mushroom_top,
        y_min = mapgen.mushroom_bottom,
        flags = "all_floors, force_placement, place_center_x, place_center_z",
        schematic = "schematics/underground/amber_mushroom_large.mts",
        place_offset_y = -3,
    })
    minetest.register_decoration({
        deco_type = "schematic",
        place_on = "blocks:dirt_azure_mushroom",
        fill_ratio = 0.0002,
        y_max = mapgen.mushroom_top,
        y_min = mapgen.mushroom_bottom,
        flags = "all_floors, force_placement, place_center_x, place_center_z",
        schematic = "schematics/underground/amber_mushroom_medium.mts",
        place_offset_y = -3,
    })
    minetest.register_decoration({
        deco_type = "schematic",
        place_on = "blocks:dirt_azure_mushroom",
        fill_ratio = 0.0003,
        y_max = mapgen.mushroom_top,
        y_min = mapgen.mushroom_bottom,
        flags = "all_floors, force_placement, place_center_x, place_center_z",
        schematic = "schematics/underground/amber_mushroom_small.mts",
        place_offset_y = -2,
    })
    minetest.register_decoration({
        deco_type = "schematic",
        place_on = "blocks:dirt_azure_mushroom_ceiling",
        fill_ratio = 0.0003,
        y_max = mapgen.mushroom_top,
        y_min = mapgen.mushroom_bottom,
        flags = "all_ceilings, force_placement, place_center_x, place_center_z",
        schematic = "schematics/underground/amber_mushroom_ceiling.mts",
        place_offset_y = -3,
    })
    -- Grass
    for i=1,5 do
        minetest.register_decoration({
            deco_type = "simple",
            place_on = "blocks:dirt_with_mushroom_grass",
            sidelen = 8,
            fill_ratio = 0.08,
            y_max = mapgen.mushroom_top,
            y_min = mapgen.mushroom_bottom,
            flags = "all_floors",
            decoration = "flora:mushroom_grass_tall_" .. i,
        })
        minetest.register_decoration({
            deco_type = "simple",
            place_on = "blocks:dirt_with_mushroom_grass",
            sidelen = 8,
            fill_ratio = 0.8,
            y_max = mapgen.mushroom_top,
            y_min = mapgen.mushroom_bottom,
            flags = "all_floors",
            decoration = "flora:mushroom_grass_" .. i,
        })
    end
    -- For testing
    --[[
	minetest.register_decoration({
        deco_type = "simple",
        place_on = "blocks:dirt_with_mushroom_grass",
        sidelen = 8,
        fill_ratio = 0.08,
        y_max = mapgen.mushroom_top,
        y_min = mapgen.mushroom_bottom,
        flags = "all_floors",
        decoration = "blocks:meselamp",
    })
    ]]--
end