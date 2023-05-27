mapgen.register_tapered_vein = function(ore_definition)
    minetest.register_ore({
        ore_type = "vein",
        ore = ore_definition.ore,
        wherein = ore_definition.wherein,
        y_min = ore_definition.y_max - ore_definition.taper_distance,
        y_max = ore_definition.y_max,
        noise_threshold = 0.85,
        noise_params = ore_definition.noise_params,
        random_factor = 0,
    })
    minetest.register_ore({
        ore_type = "vein",
        ore = ore_definition.ore,
        wherein = ore_definition.wherein,
        y_min = ore_definition.y_min + ore_definition.taper_distance,
        y_max = ore_definition.y_max - ore_definition.taper_distance,
        noise_threshold = 0.75,
        noise_params = ore_definition.noise_params,
        random_factor = 0,
    })
    minetest.register_ore({
        ore_type = "vein",
        ore = ore_definition.ore,
        wherein = ore_definition.wherein,
        y_min = ore_definition.y_min,
        y_max = ore_definition.y_min + ore_definition.taper_distance,
        noise_threshold = 0.85,
        noise_params = ore_definition.noise_params,
        random_factor = 0,
    })
end

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


mapgen.register_stalagmites = function(base_node, limits, rarity, seed, id)
	local sname = string.match(base_node, ':(.*)')
	local base = {}
	if id == nil then
		id = ""
	else
		id = "_" .. id
	end
	if type(base_node) == table then
		for i=1,#base_node do
			base[i] = base_node[i]
		end
	else
		base[1] = base_node
	end

	-- Big Stalagmites/Stalactites

	mapgen.np_stalagmites.seed = mapgen.np_stalagmites.seed  + seed
	mapgen.np_stalagmites.offset = mapgen.np_stalagmites.offset  + ((rarity - 1) / 2)

	minetest.register_decoration({
		name = "stalagmite_base_" .. sname .. id,
		deco_type = "simple",
		param2 = 0,
		place_on = base,
		sidelen = 8,
		noise_params = mapgen.np_stalagmites,
		y_max = limits.max,
		y_min = limits.min,
		flags = "all_floors",
		decoration = "blocks:stalagmite_base_" .. sname,
	})
	minetest.register_decoration({
		name = "stalactite_base_" .. sname .. id,
		deco_type = "simple",
		param2 = 0,
		place_on = base,
		sidelen = 8,
		noise_params = mapgen.np_stalagmites,
		y_max = limits.max,
		y_min = limits.min,
		flags = "all_ceilings",
		decoration = "blocks:stalactite_base_" .. sname,
	})
	minetest.register_decoration({
		name = "stalagmite_middle_" .. sname .. id,
		deco_type = "simple",
		param2 = 0,
		place_on = {"blocks:stalagmite_base_" .. sname},
		fill_ratio = 10.0,
		y_max = limits.max,
		y_min = limits.min,
		height = 1,
		height_max = 4,
		flags = "all_floors, force_placement",
		decoration = "blocks:stalagmite_middle_" .. sname,
	})
	minetest.register_decoration({
		name = "stalactite_middle_" .. sname .. id,
		deco_type = "simple",
		param2 = 0,
		place_on = {"blocks:stalactite_base_" .. sname},
		fill_ratio = 10.0,
		y_max = limits.max,
		y_min = limits.min,
		height = 1,
		height_max = 2,
		flags = "all_ceilings, force_placement",
		decoration = "blocks:stalactite_middle_" .. sname,
	})
	minetest.register_decoration({
		name = "stalagmite_top_" .. sname .. id,
		deco_type = "simple",
		param2 = 0,
		place_on = {"blocks:stalagmite_middle_" .. sname},
		fill_ratio = 10.0,
		y_max = limits.max,
		y_min = limits.min,
		flags = "all_floors, force_placement",
		place_offset_y = -1,
		decoration = "blocks:stalagmite_top_" .. sname,
	})
	minetest.register_decoration({
		name = "stalactite_top_" .. sname .. id,
		deco_type = "simple",
		param2 = 0,
		place_on = {"blocks:stalactite_middle_" .. sname},
		fill_ratio = 10.0,
		y_max = limits.max,
		y_min = limits.min,
		flags = "all_ceilings, force_placement",
		place_offset_y = -1,
		decoration = "blocks:stalactite_top_" .. sname,
	})

	-- Small Stalagmites/Stalactites

	for i=1,5 do
		minetest.register_decoration({
			name = "stalagmite_" .. sname .. "_" .. i .. id,
			deco_type = "simple",
			param2 = 0,
			param2_max = 239,
			place_on = base,
			sidelen = 8,
			fill_ratio = 0.02 * rarity,
			y_max = limits.max,
			y_min = limits.min,
			flags = "all_floors",
			decoration = "blocks:stalagmite_" .. sname .. "_" .. i,
		})
		minetest.register_decoration({
			name = "stalactite_" .. sname .. "_" .. i .. id,
			deco_type = "simple",
			param2 = 0,
			param2_max = 239,
			place_on = base,
			sidelen = 8,
			fill_ratio = 0.02 * rarity,
			y_max = limits.max,
			y_min = limits.min,
			place_offset_y = 1,
			flags = "all_ceilings",
			decoration = "blocks:stalactite_" .. sname .. "_" .. i,
		})
	end
end