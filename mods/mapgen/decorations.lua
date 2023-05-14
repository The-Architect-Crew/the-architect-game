mapgen.register_microbiome_decorations = function(base_name, data)
	local height_min = data.height_min
	local height_max = data.height_max
	local seed = data.seed
	local base_node = data.base_node
	local surface_node = data.surface_node
	local small_plant_variation = true
	local grass_variation = true

	if (data.small_plant_variation == false) then
		small_plant_variation = false
	end

	if (data.grass_variation == false) then
		grass_variation = false
	end

	local grass = data.grass_node
	local small_plant = data.main_small_plant
	local secondary_small_plant = data.secondary_small_plant 	-- Optional
	local large_plant = data.main_large_plant					-- Optional
	local secondary_large_plant = data.secondary_large_plant	-- Optional
	local vines = data.main_vines
	local secondary_vines = data.secondary_vines				-- Optional
	local moss = data.moss

	local surface_fill = 0
	local np_surface = nil
	local np_ceiling = {
		offset = -4,
		scale = 4,
		spread = {x = 96, y = 96, z = 96},
		seed = 2522323233 + seed,
		octaves = 1,
		flags = "eased",
	}
	if data.surface_coverage == "full" then
		surface_fill = 10.0
		np_ceiling = {
			offset = -0.55,
			scale = 1,
			spread = {x = 2, y = 2, z = 2},
			seed = 2522323233 + seed,
			octaves = 1,
			flags = "absolute",
		}
	else
		np_surface = np_ceiling
		np_surface.offset = np_surface.offset + data.surface_coverage
	end

	-- Surface node, like dirt with grass for example
	for i=1,#base_node do
		minetest.register_decoration({
			name = base_name .. "_" .. surface_node[i] .. "_surface",
			deco_type = "simple",
			place_on = {base_node[i]},
			fill_ratio = surface_fill,
			noise_params = np_surface,
			y_max = height_max,
			y_min = height_min,
			spawn_by = "air",
			num_spawn_by = 3,
			flags = "all_floors, force_placement",
			place_offset_y = -1, -- Requires force_placement
			decoration = surface_node[i],
		})
	end

	-- Large plants
	if (large_plant) then
		minetest.register_decoration({
			name = base_name .. "_" .. large_plant .. "_large_plant",
			deco_type = "simple",
			place_on = surface_node,
			sidelen = 12,
			fill_ratio = data.plant_rarity/2,
			y_max = height_max,
			y_min = height_min,
			flags = "all_floors",
			height = 3,
			height_max = 8,
			param2 = 0,
			param2_max = 3,
			decoration = large_plant,
		})
	end
	if (secondary_large_plant) then
		minetest.register_decoration({
			name = base_name .. "_" .. secondary_large_plant .. "_secondary_large_plant",
			deco_type = "simple",
			place_on = surface_node,
			sidelen = 12,
			fill_ratio = data.plant_rarity/2,
			y_max = height_max,
			y_min = height_min,
			flags = "all_floors",
			height = 3,
			height_max = 8,
			param2 = 0,
			param2_max = 3,
			decoration = secondary_large_plant,
		})
	end

	-- Vines
	minetest.register_decoration({
		name = base_name .. "_" .. vines .. "_vines",
		deco_type = "simple",
		place_on = base_node,
		noise_params = np_ceiling,
		y_max = height_max,
		y_min = height_min,
		flags = "all_ceilings",
		height = 3,
		height_max = 8,
		decoration = vines,
	})
	if (secondary_vines) then
		minetest.register_decoration({
			name = base_name .. "_" .. secondary_vines .. "_secondary_vines",
			deco_type = "simple",
			place_on = base_node,
			noise_params = np_ceiling,
			y_max = height_max,
			y_min = height_min,
			flags = "all_ceilings",
			height = 3,
			height_max = 8,
			decoration = secondary_vines,
		})
	end

	-- Moss

	minetest.register_decoration({
		name = base_name .. "_" .. moss .. "_moss",
		deco_type = "simple",
		place_on = base_node,
		noise_params = np_ceiling,
		y_max = height_max,
		y_min = height_min,
		flags = "all_ceilings",
		decoration = moss,
	})

	if (small_plant_variation) then
		for i=1,5 do
			-- Small plants
			minetest.register_decoration({
				name = base_name .. "_" .. small_plant .. "_" .. i .. "_small_plant_" .. i,
				deco_type = "simple",
				place_on = surface_node,
				fill_ratio = data.plant_rarity/5,
				y_max = height_max,
				y_min = height_min,
				flags = "all_floors",
				decoration = small_plant .. "_" .. i,
			})
			if (secondary_small_plant) then
				minetest.register_decoration({
					name = base_name .. "_" .. secondary_small_plant .. "_" .. i .. "_secondary_small_plant_" .. i,
					deco_type = "simple",
					place_on = surface_node,
					fill_ratio = data.plant_rarity/5,
					y_max = height_max,
					y_min = height_min,
					flags = "all_floors",
					decoration = secondary_small_plant .. "_" .. i,
				})
			end
		end
	else
		-- Small plants
		minetest.register_decoration({
			name = base_name .. "_" .. small_plant .. "_small_plant",
			deco_type = "simple",
			place_on = surface_node,
			fill_ratio = data.plant_rarity,
			y_max = height_max,
			y_min = height_min,
			flags = "all_floors",
			decoration = small_plant,
		})
		if (secondary_small_plant) then
			minetest.register_decoration({
				name = base_name .. "_" .. secondary_small_plant .. "_secondary_small_plant",
				deco_type = "simple",
				place_on = surface_node,
				fill_ratio = data.plant_rarity,
				y_max = height_max,
				y_min = height_min,
				flags = "all_floors",
				decoration = secondary_small_plant,
			})
		end
	end

	if (grass_variation) then
		for i=1,5 do
			-- Grass
			minetest.register_decoration({
				name = base_name .. "_" .. grass .. "_" .. i .. "_grass_" .. i,
				deco_type = "simple",
				place_on = surface_node,
				fill_ratio = data.grass_rarity/5,
				y_max = height_max,
				y_min = height_min,
				flags = "all_floors",
				decoration = grass .. "_" .. i,
			})
		end
	else
		-- Grass
		minetest.register_decoration({
			name = base_name .. "_" .. grass .. "_grass",
			deco_type = "simple",
			place_on = surface_node,
			fill_ratio = data.grass_rarity,
			y_max = height_max,
			y_min = height_min,
			flags = "all_floors",
			decoration = grass,
		})
	end
end

mapgen.register_microbiome_decorations("fire", {
	height_min = mapgen.world_bottom,
	height_max = mapgen.underground_start,
	seed = 262,
	base_node = {"blocks:cobble"}, -- surface_node matches the base_node, they also have to be the same length
	surface_node = {"blocks:cobble_firemoss"},
	surface_coverage = 1.95,
	grass_node = "flora:firegrass",
	main_small_plant = "flora:fireshroom",
	--secondary_small_plant
	plant_rarity = 0.1,
	grass_rarity = 1,
	main_large_plant = "flora:fireplant",
	secondary_large_plant = "blocks:garnet",
	main_vines = "flora:firevines",
	--secondary_vines
	moss = "flora:firemoss",
})

mapgen.register_microbiome_decorations("azure", {
	height_min = mapgen.world_bottom,
	height_max = mapgen.underground_start,
	seed = 263,
	base_node = {"blocks:desert_cobble", "blocks:sand", "blocks:desert_sand", "blocks:silver_sand", "blocks:dry_dirt"},
	surface_node = {"blocks:desert_cobble_azure", "blocks:sand_azure", "blocks:desert_sand_azure", "blocks:silver_sand_azure", "blocks:dry_dirt_azure"},
	surface_coverage = 1.5,
	grass_node = "flora:azure_grass",
	main_small_plant = "flora:azureshroom",
	--secondary_small_plant
	plant_rarity = 0.1,
	grass_rarity = 1,
	main_large_plant = "flora:azure_plant",
	secondary_large_plant = "blocks:lapis_lazuli",
	main_vines = "flora:azure_vines",
	--secondary_vines
	moss = "flora:azure_moss",
})

mapgen.register_microbiome_decorations("moonstone", {
	height_min = mapgen.underground_start,
	height_max = mapgen.sfcave_limit,
	seed = 162,
	base_node = {"blocks:dirt"},
	surface_node = {"blocks:dirt_with_grass_sfcave"},
	surface_coverage = "full",
	grass_node = "flora:grass",
	main_small_plant = "flora:moonflower",
	--secondary_small_plant
	plant_rarity = 0.15,
	grass_rarity = 1,
	--main_large_plant
	--secondary_large_plant
	main_vines = "flora:vines",
	secondary_vines = "flora:vines_moonstone",
	moss = "flora:vines_horizontal",
})

mapgen.register_microbiome_decorations("hot", {
	height_min = mapgen.underground_start,
	height_max = mapgen.sfcave_limit,
	seed = 3444623,
	base_node = {"blocks:dry_dirt"},
	surface_node = {"blocks:dry_dirt_with_dry_grass_sfcave"},
	surface_coverage = "full",
	grass_node = "flora:dry_grass",
	main_small_plant = "flora:moonflower_dry",
	--secondary_small_plant
	plant_rarity = 0.15,
	grass_rarity = 1,
	--main_large_plant
	--secondary_large_plant
	main_vines = "flora:vines_dry",
	secondary_vines = "flora:vines_dry_moonstone",
	moss = "flora:vines_dry_horizontal",
})

mapgen.register_microbiome_decorations("frosty", {
	height_min = mapgen.underground_start,
	height_max = mapgen.sfcave_limit,
	seed = 82253663,
	base_node = {"blocks:permafrost"},
	surface_node = {"blocks:permafrost_with_snow"},
	surface_coverage = "full",
	grass_node = "flora:grass_frosty",
	main_small_plant = "flora:moonflower_frosty",
	secondary_small_plant = "blocks:snow",
	plant_rarity = 0.15,
	grass_rarity = 1,
	--main_large_plant
	--secondary_large_plant
	main_vines = "flora:vines_frosty",
	secondary_vines = "flora:vines_frosty_moonstone",
	moss = "flora:vines_frosty_horizontal",
})
mapgen.register_microbiome_decorations("hell", {
	small_plant_variation = false,
	grass_variation = false,
	height_min = mapgen.world_bottom,
	height_max = mapgen.hell_level,
	seed = 7734,
	base_node = {"blocks:obsidian", "blocks:dark_dirt"}, -- surface_node matches the base_node, they also have to be the same length
	surface_node = {"blocks:embers", "blocks:embers"},
	surface_coverage = 5.0,
	grass_node = "blocks:fire",
	main_small_plant = "blocks:pyre",
	--secondary_small_plant
	plant_rarity = 0.005,
	grass_rarity = 0.05,
	main_large_plant = "variations:obsidian_big_tile";
	--secondary_large_plant
	main_vines = "blocks:obsidian",
	--secondary_vines
	moss = "blocks:obsidian",
})
--[[
-- Should be the mese biome, but there are too many exceptions
mapgen.register_microbiome_decorations("mese", {
	height_min = mapgen.world_bottom,
	height_max = mapgen.underground_limit,
	seed = 26262,
	base_node = {"blocks:stone"}, -- surface_node matches the base_node, they also have to be the same length
	surface_node = {"blocks:stone_mese_circuits"},
	surface_coverage = 2.5,
	grass_node = "flora:grass_mese",
	main_small_plant = "flora:flower_mese",
	--secondary_small_plant
	plant_rarity = 0.002,
	grass_rarity = 1,
	--main_large_plant = "flora:plant_garnet",
	--secondary_large_plant = "blocks:garnet",
	main_vines = "flora:vines_mese",
	--secondary_vines
	moss = "flora:moss_mese",
})]]--

-- Mese micro-biome

mapgen.mese_biome_base_noise = {
	offset = -2.35,
	scale = 4,
	spread = {x = 50, y = 50, z = 50},
	seed = 26262,
	octaves = 1,
	flags = "eased",
}

-- Two base nodes, one for the ground decorations and one for ceiling ones

minetest.register_decoration({
	name = "mese_surface",
	deco_type = "simple",
	place_on = {"blocks:stone"},
	noise_params = mapgen.mese_biome_base_noise,
	y_max = mapgen.underground_limit,
	y_min = mapgen.world_bottom,
	spawn_by = "air",
	num_spawn_by = 3,
	flags = "all_floors, force_placement",
	place_offset_y = -1,
	decoration = "blocks:stone_mese_circuits",
})

minetest.register_decoration({
	name = "mese_ceiling",
	deco_type = "simple",
	place_on = {"blocks:stone"},
	noise_params = mapgen.mese_biome_base_noise,
	y_max = mapgen.underground_limit,
	y_min = mapgen.world_bottom,
	spawn_by = "air",
	num_spawn_by = 3,
	flags = "all_ceilings, force_placement",
	place_offset_y = -1,
	decoration = "blocks:stone_mese_circuits_under",
})

minetest.register_decoration({
	name = "mese_surface_marble",
	deco_type = "simple",
	place_on = {"blocks:marble"},
	noise_params = mapgen.mese_biome_base_noise,
	y_max = mapgen.underground_limit,
	y_min = mapgen.world_bottom,
	spawn_by = "air",
	num_spawn_by = 3,
	flags = "all_floors, force_placement",
	place_offset_y = -1,
	decoration = "blocks:marble_mese_circuits",
})

minetest.register_decoration({
	name = "mese_ceiling_marble",
	deco_type = "simple",
	place_on = {"blocks:marble"},
	noise_params = mapgen.mese_biome_base_noise,
	y_max = mapgen.underground_limit,
	y_min = mapgen.world_bottom,
	spawn_by = "air",
	num_spawn_by = 3,
	flags = "all_ceilings, force_placement",
	place_offset_y = -1,
	decoration = "blocks:marble_mese_circuits_under",
})

minetest.register_decoration({
	name = "mese_tech_crystal",
	deco_type = "simple",
	place_on = {"blocks:stone_mese_circuits", "blocks:marble_mese_circuits"},
	sidelen = 12,
	fill_ratio = 0.05,
	y_max = mapgen.underground_limit,
	y_min = mapgen.world_bottom,
	flags = "all_floors",
	height = 3,
	height_max = 6,
	decoration = "blocks:mese_tech_crystal",
})

minetest.register_decoration({
	name = "mese_vines",
	deco_type = "simple",
	place_on = {"blocks:stone_mese_circuits_under", "blocks:marble_mese_circuits_under"},
	noise_params = {
		offset = -0.25,
		scale = 1,
		spread = {x = 4, y = 4, z = 4},
		seed = 62262226,
		octaves = 1,
		flags = "eased",
	},
	y_max = mapgen.underground_limit,
	y_min = mapgen.world_bottom,
	flags = "all_ceilings",
	height = 3,
	height_max = 8,
	decoration = "flora:vines_mese",
})

minetest.register_decoration({
	name = "mese_moss",
	deco_type = "simple",
	place_on = {"blocks:stone_mese_circuits_under", "blocks:marble_mese_circuits_under"},
	noise_params = {
		offset = -0.25,
		scale = 2,
		spread = {x = 4, y = 4, z = 4},
		seed = 262226222,
		octaves = 1,
		flags = "absvalue, eased",
	},
	y_max = mapgen.underground_limit,
	y_min = mapgen.world_bottom,
	flags = "all_ceilings",
	decoration = "flora:moss_mese",
})

for i=1,5 do
	-- Small plants
	minetest.register_decoration({
		name = "mese_flower_" .. i,
		deco_type = "simple",
		place_on = {"blocks:stone_mese_circuits", "blocks:marble_mese_circuits"},
		fill_ratio = 0.1/5,
		y_max = mapgen.underground_limit,
		y_min = mapgen.world_bottom,
		param2 = 1,
		flags = "all_floors",
		decoration = "flora:flower_mese_" .. i,
	})
end

for i=1,5 do
	-- Grassamethyst
	minetest.register_decoration({
		name = "mese_grass_" .. i,
		deco_type = "simple",
		place_on = {"blocks:stone_mese_circuits", "blocks:marble_mese_circuits"},
		fill_ratio = 1/5,
		y_max = mapgen.underground_limit,
		y_min = mapgen.world_bottom,
		param2 = 1,
		flags = "all_floors",
		decoration = "flora:grass_mese_" .. i,
	})
end

-- Other Decorations

minetest.register_decoration({
	name = "sfcave_mossycobble",
	deco_type = "simple",
	place_on = {"blocks:stone"},
	fill_ratio = 10.0,
	y_max = 0,
	y_min = mapgen.underground_start,
	spawn_by = "blocks:dirt_with_grass",
	num_spawn_by = 1,
	flags = "all_floors, all_ceilings, force_placement",
	place_offset_y = -1, -- Requires force_placement
	decoration = "blocks:mossycobble",
})

minetest.register_decoration({
	name = "tree_vines",
	deco_type = "simple",
	place_on = {"flora:leaves"},
	fill_ratio = 0.2,
	y_max = 31000,
	y_min = mapgen.underground_start,
	flags = "all_ceilings",
	height = 3,
	height_max = 8,
	decoration = "flora:vines",
})

-- Rocks

mapgen.register_stalagmites = function(base_node, seed, surface, secondary_base)
	local sname = string.match(base_node, ':(.*)')
	local stalagmite_max_height = 0
	if surface then stalagmite_max_height = 512 end
	if secondary_base == nil then secondary_base = base_node end

	-- Big Stalagmites/Stalactites

	mapgen.np_stalagmites.seed = mapgen.np_stalagmites.seed  + seed

	minetest.register_decoration({
		name = "blocks:stalagmite_base_" .. sname,
		deco_type = "simple",
		param2 = 0,
		place_on = {base_node, secondary_base},
		sidelen = 8,
		noise_params = mapgen.np_stalagmites,
		y_max = stalagmite_max_height,
		y_min = mapgen.world_bottom,
		flags = "all_floors",
		decoration = "blocks:stalagmite_base_" .. sname,
	})
	minetest.register_decoration({
		name = "blocks:stalactite_base_" .. sname,
		deco_type = "simple",
		param2 = 0,
		place_on = {base_node, secondary_base},
		sidelen = 8,
		noise_params = mapgen.np_stalagmites,
		y_max = 256,
		y_min = mapgen.world_bottom,
		flags = "all_ceilings",
		decoration = "blocks:stalactite_base_" .. sname,
	})
	minetest.register_decoration({
		name = "blocks:stalagmite_middle_" .. sname,
		deco_type = "simple",
		param2 = 0,
		place_on = {"blocks:stalagmite_base_" .. sname},
		fill_ratio = 10.0,
		y_max = 256,
		y_min = mapgen.world_bottom,
		height = 1,
		height_max = 4,
		flags = "all_floors, force_placement",
		decoration = "blocks:stalagmite_middle_" .. sname,
	})
	minetest.register_decoration({
		name = "blocks:stalactite_middle_" .. sname,
		deco_type = "simple",
		param2 = 0,
		place_on = {"blocks:stalactite_base_" .. sname},
		fill_ratio = 10.0,
		y_max = 256,
		y_min = mapgen.world_bottom,
		height = 1,
		height_max = 2,
		flags = "all_ceilings, force_placement",
		decoration = "blocks:stalactite_middle_" .. sname,
	})
	minetest.register_decoration({
		name = "blocks:stalagmite_top_" .. sname,
		deco_type = "simple",
		param2 = 0,
		place_on = {"blocks:stalagmite_middle_" .. sname},
		fill_ratio = 10.0,
		y_max = 256,
		y_min = mapgen.world_bottom,
		flags = "all_floors, force_placement",
		place_offset_y = -1,
		decoration = "blocks:stalagmite_top_" .. sname,
	})
	minetest.register_decoration({
		name = "blocks:stalactite_top_" .. sname,
		deco_type = "simple",
		param2 = 0,
		place_on = {"blocks:stalactite_middle_" .. sname},
		fill_ratio = 10.0,
		y_max = 256,
		y_min = mapgen.world_bottom,
		flags = "all_ceilings, force_placement",
		place_offset_y = -1,
		decoration = "blocks:stalactite_top_" .. sname,
	})

	-- Small Stalagmites/Stalactites

	for i=1,5 do
		minetest.register_decoration({
			name = "blocks:stalagmite_" .. sname .. "_" .. i,
			deco_type = "simple",
			param2 = 0,
			param2_max = 239,
			place_on = {base_node, secondary_base},
			sidelen = 8,
			fill_ratio = 0.02,
			y_max = 0,
			y_min = mapgen.world_bottom,
			flags = "all_floors",
			decoration = "blocks:stalagmite_" .. sname .. "_" .. i,
		})
		minetest.register_decoration({
			name = "blocks:stalactite_" .. sname .. "_" .. i,
			deco_type = "simple",
			param2 = 0,
			param2_max = 239,
			place_on = {base_node, secondary_base},
			sidelen = 8,
			fill_ratio = 0.02,
			y_max = 256,
			y_min = mapgen.world_bottom,
			place_offset_y = 1,
			flags = "all_ceilings",
			decoration = "blocks:stalactite_" .. sname .. "_" .. i,
		})
	end
end

mapgen.register_stalagmites("blocks:stone", 1419)
mapgen.register_stalagmites("blocks:obsidian", 2324)
mapgen.register_stalagmites("blocks:sandstone", 4531, true)
mapgen.register_stalagmites("blocks:desert_sandstone", 3325, true)
mapgen.register_stalagmites("blocks:silver_sandstone", 6563, true)
mapgen.register_stalagmites("blocks:desert_stone", 5244)
mapgen.register_stalagmites("blocks:granite", 7333)
mapgen.register_stalagmites("blocks:marble", 8578)
mapgen.register_stalagmites("blocks:basalt", 9233)
mapgen.register_stalagmites("blocks:ice", 4253, true, "blocks:cave_ice")