mapgen.quarry_top = -1537
mapgen.quarry_bottom = -2304

mapgen.quarry_schematic_margin = 128

mapgen.quarry_middle = (mapgen.quarry_top + mapgen.quarry_bottom) / 2

mapgen.quarry_cavern_level = (mapgen.quarry_middle + mapgen.quarry_bottom) / 2

mapgen.quarry_schematic_upper_margin = mapgen.quarry_top - mapgen.quarry_schematic_margin
mapgen.quarry_schematic_lower_margin = mapgen.quarry_bottom + mapgen.quarry_schematic_margin

mapgen.quarry_base = "blocks:stone"

mapgen.quarry_strata = {}
mapgen.quarry_strata_materials = {"blocks:stone_dark_grey", "blocks:stone_grey", "blocks:stone_white", "blocks:stone_black"}

mapgen.quarry_extended_base = {"blocks:stone", "blocks:stone_dark_grey", "blocks:stone_grey", "blocks:stone_white", "blocks:stone_black"}

mapgen.quarry_terrain_schem_base = {"variations:stone_big_tile", "blocks:stone", "blocks:stone_dark_grey", "blocks:stone_grey", "blocks:stone_white", "blocks:stone_black"}

local random = PcgRandom(262)
local offset = mapgen.quarry_top

while offset > mapgen.quarry_bottom do
    local strata_big_jump = random:next(0, 1)
    if strata_big_jump == 1 then
        offset = offset - random:next(4, 12)
    else
        offset = offset - random:next(1, 4)
    end
    local material_choice = random:next(1, #mapgen.quarry_strata_materials)
    table.insert_all(mapgen.quarry_strata, {{offset = offset, material = mapgen.quarry_strata_materials[material_choice]}})
end

mapgen.register_quarry_biomes = function()
	minetest.register_biome({
		name = "quarry",
		node_stone = mapgen.quarry_base,
		node_dungeon = "variations:stone_big_tile",
        node_dungeon_alt = "variations:stone_cross_tile",
		node_dungeon_stair = "variations:shapes_stone_tile_stair",
        node_cave_liquid = "air",
		y_max = mapgen.quarry_top,
		y_min = mapgen.quarry_bottom,
		heat_point = 50,
		humidity_point = 50,
	})
end

mapgen.register_quarry_ores = function()
    -- Decorative (and balancing) strata
    for _,stratum_data in ipairs(mapgen.quarry_strata) do
        minetest.register_ore({
            ore_type = "stratum",
            ore = stratum_data.material,
            wherein = "blocks:stone",
            y_max = mapgen.quarry_middle,
            y_min = mapgen.quarry_bottom,
            noise_params = {
                offset = stratum_data.offset,
                scale = 8,
                spread = {x = 32, y = 32, z = 32},
                seed = 262,
                octaves = 2,
                persistence = 0.5,
                flags = "noeased"
            },
            stratum_thickness = 0.5
        })
    end
    -- Blobs for schematic caves
    minetest.register_ore({
        ore_type = "blob",
        ore = "air",
        wherein = mapgen.quarry_extended_base,
        clust_scarcity = 16 * 16 * 16,
        clust_num_ores = 8,
        clust_size = 3,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom
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
        wherein = mapgen.quarry_extended_base,
        clust_scarcity = 8 * 8 * 8,
        clust_num_ores = 96,
        clust_size = 7,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
    })
    minetest.register_ore({
        ore_type = "blob",
        ore = "blocks:cobble",
        wherein = mapgen.quarry_extended_base,
        clust_scarcity = 4 * 4 * 4,
        clust_num_ores = 48,
        clust_size = 5,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
    })
    minetest.register_ore({
        ore_type = "blob",
        ore = "blocks:gravel",
        wherein = mapgen.quarry_extended_base,
        clust_scarcity = 8 * 8 * 8,
        clust_num_ores = 64,
        clust_size = 6,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
    })
    minetest.register_ore({
        ore_type = "blob",
        ore = "blocks:silver_sand",
        wherein = mapgen.quarry_extended_base,
        clust_scarcity = 8 * 8 * 8,
        clust_num_ores = 48,
        clust_size = 5,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
    })
    minetest.register_ore({
        ore_type = "blob",
        ore = "blocks:silver_sandstone",
        wherein = mapgen.quarry_extended_base,
        clust_scarcity = 10 * 10 * 10,
        clust_num_ores = 48,
        clust_size = 5,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
    })
    minetest.register_ore({
        ore_type = "blob",
        ore = "blocks:clay",
        wherein = mapgen.quarry_extended_base,
        clust_scarcity = 12 * 12 * 12,
        clust_num_ores = 64,
        clust_size = 6,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
    })
    -- Decoration
    minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:stone_with_rune_vertical",
		wherein        = "blocks:stone",
		clust_scarcity = 6 * 6 * 6,
		clust_num_ores = 4,
		clust_size     = 4,
		y_max          = mapgen.quarry_top,
		y_min          = mapgen.quarry_bottom,
	})
    -- Lost Mese
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "blocks:lost_mese",
		wherein        = mapgen.quarry_extended_base,
		clust_scarcity = mapgen.lost_mese_ore_params.scarcity,
		clust_num_ores = mapgen.lost_mese_ore_params.num_ores,
		clust_size     = mapgen.lost_mese_ore_params.clust_size,
		y_max          = mapgen.quarry_top,
		y_min          = mapgen.quarry_bottom,
	})
end

mapgen.register_quarry_decorations = function()
    for i=1,4 do
        minetest.register_decoration({
            deco_type = "schematic",
            place_on = mapgen.quarry_extended_base,
            fill_ratio = 0.0005,
            y_max = mapgen.quarry_schematic_upper_margin,
            y_min = mapgen.quarry_schematic_lower_margin,
            flags = "force_placement, all_floors, all_ceilings, place_center_x, place_center_y, place_center_z",
            schematic = "schematics/underground/quarry_tunnels" .. i .. "_large.mts",
            replacements = {["default:sandstone"] = "air"},
            rotation = "random"
        })
    end
    for i=1,6 do
        minetest.register_decoration({
            deco_type = "schematic",
            place_on = mapgen.quarry_extended_base,
            fill_ratio = 0.0001,
            y_max = mapgen.quarry_schematic_upper_margin,
            y_min = mapgen.quarry_schematic_lower_margin,
            flags = "force_placement, all_floors, all_ceilings, place_center_x, place_center_y, place_center_z",
            schematic = "schematics/underground/quarry_terrain_small" .. i .. ".mts",
            replacements = {["default:sandstone"] = "air"},
            rotation = "random"
        })
    end
    for i=1,4 do
        minetest.register_decoration({
            deco_type = "schematic",
            place_on = mapgen.quarry_terrain_schem_base,
            fill_ratio = 0.0002,
            y_max = mapgen.quarry_schematic_upper_margin,
            y_min = mapgen.quarry_schematic_lower_margin,
            flags = "force_placement, all_floors, all_ceilings, place_center_x, place_center_y, place_center_z",
            schematic = "schematics/underground/quarry_tunnels" .. i .. ".mts",
            replacements = {["default:sandstone"] = "air", ["default:sand"] = "variations:stone_big_tile"},
            rotation = "random"
        })
    end
    for i=1,4 do
        minetest.register_decoration({
            deco_type = "schematic",
            place_on = mapgen.quarry_terrain_schem_base,
            fill_ratio = 0.0005,
            y_max = mapgen.quarry_schematic_upper_margin,
            y_min = mapgen.quarry_schematic_lower_margin,
            flags = "force_placement, all_floors, all_ceilings, place_center_x, place_center_y, place_center_z",
            schematic = "schematics/underground/quarry_tunnels" .. i .. "_small.mts",
            replacements = {["default:sandstone"] = "air"},
            rotation = "random"
        })
    end
    for i=1,3 do
        minetest.register_decoration({
            deco_type = "schematic",
            place_on = {"variations:stone_big_tile"},
            noise_params = {
                offset = 0,
                scale = 0.0005,
                spread = {x = 32, y = 128, z = 32},
                seed = 53933 + i,
                octaves = 4,
                persistence = 0.3,
                lacunarity = 1.5,
                flags = "noeased"
            },
            y_max = mapgen.quarry_schematic_upper_margin,
            y_min = mapgen.quarry_schematic_lower_margin,
            flags = "force_placement, all_floors, place_center_x, place_center_z",
            schematic = "schematics/underground/quarry_landmark" .. i .. ".mts",
            replacements = {["blocks:sandstone"] = "air"},
            place_offset_y = -2,
            rotation = "random"
        })
    end
    for i=1,3 do
        minetest.register_decoration({
            deco_type = "schematic",
            place_on = {"variations:stone_big_tile"},
            noise_params = {
                offset = 0,
                scale = 0.0015,
                spread = {x = 32, y = 128, z = 32},
                seed = 525 + i,
                octaves = 4,
                persistence = 0.3,
                lacunarity = 1.5,
                flags = "noeased"
            },
            y_max = mapgen.quarry_schematic_upper_margin,
            y_min = mapgen.quarry_schematic_lower_margin,
            flags = "force_placement, all_floors, place_center_x, place_center_z",
            schematic = "schematics/underground/quarry_room" .. i .. ".mts",
            replacements = {["blocks:sandstone"] = "air"},
            place_offset_y = -1,
            rotation = "random"
        })
    end
    for i=1,3 do
        minetest.register_decoration({
            deco_type = "schematic",
            place_on = {"variations:stone_big_tile"},
            noise_params = {
                offset = 0,
                scale = 0.05,
                spread = {x = 32, y = 128, z = 32},
                seed = 532214 + i,
                octaves = 4,
                persistence = 0.5,
                lacunarity = 1.5,
                flags = "noeased"
            },
            y_max = mapgen.quarry_schematic_upper_margin,
            y_min = mapgen.quarry_schematic_lower_margin,
            flags = "force_placement, all_floors, place_center_x, place_center_z",
            schematic = "schematics/underground/quarry_furniture" .. i .. ".mts",
            replacements = {["blocks:sandstone"] = "air"},
            rotation = "random"
        })
    end
    for i=1,3 do
        minetest.register_decoration({
            deco_type = "schematic",
            place_on = {"variations:stone_big_tile"},
            fill_ratio = 0.003,
            y_max = mapgen.quarry_schematic_upper_margin,
            y_min = mapgen.quarry_schematic_lower_margin,
            flags = "force_placement, all_floors, place_center_x, place_center_z",
            schematic = "schematics/underground/quarry_stairs" .. i .. ".mts",
            replacements = {["blocks:sandstone"] = "air"},
            place_offset_y = -1,
            rotation = "random"
        })
    end
    minetest.register_decoration({
        deco_type = "simple",
        place_on = "variations:stone_big_tile",
        spawn_by = "variations:stone_big_tile",
        check_offset = -1,
        num_spawn_by = 8,
        sidelen = 8,
        fill_ratio = 0.05,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
        flags = "all_ceilings, force_placement",
        decoration = "blocks:stone_with_rune",
        place_offset_y = -1,
    })
    minetest.register_decoration({
        deco_type = "simple",
        place_on = {"blocks:stone_with_rune"},
        fill_ratio = 10.0,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
        flags = "all_floors, force_placement",
        decoration = "variations:stone_big_tile",
        place_offset_y = -1,
    })
    minetest.register_decoration({
        deco_type = "simple",
        place_on = {"blocks:stone_with_rune_vertical"},
        fill_ratio = 10.0,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
        flags = "all_floors, all_ceilings, force_placement",
        decoration = "variations:stone_big_tile",
        place_offset_y = -1,
    })
    minetest.register_decoration({
        deco_type = "simple",
        place_on = "variations:stone_big_tile",
        fill_ratio = 0.95,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
        flags = "all_floors, force_placement",
        decoration = "variations:stone_brick",
        place_offset_y = -1,
    })
    minetest.register_decoration({
        deco_type = "simple",
        place_on = "blocks:stone",
        fill_ratio = 0.25,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
        flags = "all_floors, force_placement",
        decoration = "variations:stone_big_tile",
        place_offset_y = -1,
    })
    minetest.register_decoration({
        deco_type = "simple",
        place_on = "blocks:stone",
        fill_ratio = 0.5,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
        flags = "all_floors, force_placement",
        decoration = "variations:stone_brick",
        place_offset_y = -1,
    })
    minetest.register_decoration({
        deco_type = "simple",
        place_on = "blocks:stone",
        fill_ratio = 0.5,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
        flags = "all_ceilings, force_placement",
        decoration = "variations:stone_big_tile",
        place_offset_y = -1,
    })
    minetest.register_decoration({
        deco_type = "simple",
        place_on = "variations:stone_big_tile",
        fill_ratio = 0.01,
        y_max = mapgen.quarry_top,
        y_min = mapgen.quarry_bottom,
        flags = "all_floors, force_placement",
        decoration = "quests:quarry_loot_chest",
    })
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