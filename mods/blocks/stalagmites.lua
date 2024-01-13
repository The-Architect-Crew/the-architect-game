blocks.register_stalagmites = function(base_node, drop)
	local base_definition = minetest.registered_nodes[base_node]
	local sname = string.match(base_node, ':(.*)')
	local base_description = base_definition.description
	local groups = base_definition.groups
	local sounds = base_definition.sounds
	local box_floor = {
		type = "fixed",
		fixed = {
			{-4/16, -8/16, -4/16, 4/16, 2/16, 4/16},
		},
	}
	local box_ceiling = {
		type = "fixed",
		fixed = {
			{-4/16, -2/16, -4/16, 4/16, 8/16, 4/16},
		},
	}
	local box_big = {
		type = "fixed",
		fixed = {
			{-6/16, -8/16, -6/16, 6/16, 8/16, 6/16},
		},
	}
	drop = drop or "blocks:" .. sname .. "_chunk"
	for i=1,5 do
		minetest.register_node("blocks:stalagmite_" .. sname .. "_" .. i, {
			description = (base_description .. " Stalagmite"),
			drawtype = "plantlike",
			tiles = {"blocks_stalagmites_" .. sname .. ".png^[sheet:13x1:" .. i+4 .. ",0"},
			inventory_image = "blocks_stalagmites_" .. sname .. ".png^[sheet:13x1:" .. i+4 .. ",0",
			visual_scale = 2.0,
			sunlight_propagates = true,
			paramtype = "light",
			use_texture_alpha = "blend",
			light_source = 1,
			floodable = true,
			drop = {
				items = {
					{
						rarity = 1,
						items = {drop},
					},
					{
						rarity = 2,
						items = {drop},
					},
					{
						rarity = 3,
						items = {drop},
					},
				},
			},
			collision_box = box_floor,
			selection_box = box_floor,
			groups = groups,
			sounds = sounds,
		})
		minetest.register_node("blocks:stalactite_" .. sname .. "_" .. i, {
			description = (base_description .. " Stalactite"),
			drawtype = "mesh",
			mesh = "stalactite.obj",
			tiles = {"blocks_stalagmites_" .. sname .. ".png^[sheet:13x1:" .. i-1 .. ",0"},
			inventory_image = "blocks_stalagmites_" .. sname .. ".png^[sheet:13x1:" .. i-1 .. ",0",
			sunlight_propagates = true,
			paramtype = "light",
			use_texture_alpha = "blend",
			light_source = 1,
			floodable = true,
			drop = {
				items = {
					{
						rarity = 1,
						items = {drop},
					},
					{
						rarity = 2,
						items = {drop},
					},
					{
						rarity = 3,
						items = {drop},
					},
				},
			},
			collision_box = box_ceiling,
			selection_box = box_ceiling,
			groups = groups,
			sounds = sounds,
		})
	end
	minetest.register_node("blocks:stalagmite_base_" .. sname, {
		description = (base_description .. " Stalagmite"),
		drawtype = "plantlike",
		tiles = {"blocks_stalagmites_" .. sname .. ".png^[sheet:13x1:11,0"},
		inventory_image = "blocks_stalagmites_" .. sname .. ".png^[sheet:13x1:11,0",
		sunlight_propagates = true,
		paramtype = "light",
		use_texture_alpha = "blend",
		light_source = 1,
		visual_scale = 2,
		floodable = true,
		drop = {
			items = {
				{
					rarity = 1,
					items = {drop},
				},
				{
					rarity = 2,
					items = {drop},
				},
				{
					rarity = 3,
					items = {drop},
				},
			},
		},
		collision_box = box_big,
		selection_box = box_big,
		groups = groups,
		sounds = sounds,
		on_flood = function(pos)
			ccore.dig_dir(pos, {"blocks:stalagmite_middle_" .. sname, "blocks:stalagmite_top_" .. sname}, 1)
		end,
		after_dig_node = function(pos, node, metadata, digger)
			ccore.dig_dir(pos, {"blocks:stalagmite_middle_" .. sname, "blocks:stalagmite_top_" .. sname}, 1, digger)
		end,
		after_destruct = function(pos)
			ccore.dig_dir(pos, {"blocks:stalagmite_middle_" .. sname, "blocks:stalagmite_top_" .. sname}, 1)
		end,
	})
	minetest.register_node("blocks:stalactite_base_" .. sname, {
		description = (base_description .. " Stalactite"),
		drawtype = "plantlike",
		tiles = {"blocks_stalagmites_" .. sname .. ".png^[sheet:26x2:20,0"},
		inventory_image = "blocks_stalagmites_" .. sname .. ".png^[sheet:26x2:20,0",
		sunlight_propagates = true,
		paramtype = "light",
		use_texture_alpha = "blend",
		light_source = 1,
		floodable = true,
		drop = {
			items = {
				{
					rarity = 1,
					items = {drop},
				},
				{
					rarity = 2,
					items = {drop},
				},
				{
					rarity = 3,
					items = {drop},
				},
			},
		},
		collision_box = box_big,
		selection_box = box_big,
		groups = groups,
		sounds = sounds,
		on_flood = function(pos)
			ccore.dig_dir(pos, {"blocks:stalactite_middle_" .. sname, "blocks:stalactite_top_" .. sname}, -1)
		end,
		after_dig_node = function(pos, node, metadata, digger)
			ccore.dig_dir(pos, {"blocks:stalactite_middle_" .. sname, "blocks:stalactite_top_" .. sname}, -1, digger)
		end,
		after_destruct = function(pos)
			ccore.dig_dir(pos, {"blocks:stalactite_middle_" .. sname, "blocks:stalactite_top_" .. sname}, -1)
		end,
	})
	minetest.register_node("blocks:stalagmite_middle_" .. sname, {
		description = (base_description .. " Stalagmite"),
		drawtype = "plantlike",
		tiles = {"blocks_stalagmites_" .. sname .. ".png^[sheet:26x2:24,1"},
		inventory_image = "blocks_stalagmites_" .. sname .. ".png^[sheet:26x2:24,1",
		sunlight_propagates = true,
		paramtype = "light",
		use_texture_alpha = "blend",
		light_source = 1,
		floodable = true,
		drop = {
			items = {
				{
					rarity = 1,
					items = {drop},
				},
				{
					rarity = 2,
					items = {drop},
				},
				{
					rarity = 3,
					items = {drop},
				},
			},
		},
		collision_box = box_big,
		selection_box = box_big,
		groups = groups,
		sounds = sounds,
		on_flood = function(pos)
			ccore.dig_dir(pos, {"blocks:stalagmite_middle_" .. sname, "blocks:stalagmite_top_" .. sname}, 1)
		end,
		after_dig_node = function(pos, node, metadata, digger)
			ccore.dig_dir(pos, {"blocks:stalagmite_middle_" .. sname, "blocks:stalagmite_top_" .. sname}, 1, digger)
		end,
		after_destruct = function(pos)
			ccore.dig_dir(pos, {"blocks:stalagmite_middle_" .. sname, "blocks:stalagmite_top_" .. sname}, 1)
		end,
	})
	minetest.register_node("blocks:stalactite_middle_" .. sname, {
		description = (base_description .. " Stalactite"),
		drawtype = "plantlike",
		tiles = {"blocks_stalagmites_" .. sname .. ".png^[sheet:26x2:25,0"},
		inventory_image = "blocks_stalagmites_" .. sname .. ".png^[sheet:26x2:25,0",
		sunlight_propagates = true,
		paramtype = "light",
		use_texture_alpha = "blend",
		light_source = 1,
		floodable = true,
		drop = {
			items = {
				{
					rarity = 1,
					items = {drop},
				},
				{
					rarity = 2,
					items = {drop},
				},
				{
					rarity = 3,
					items = {drop},
				},
			},
		},
		collision_box = box_big,
		selection_box = box_big,
		groups = groups,
		sounds = sounds,
		on_flood = function(pos)
			ccore.dig_dir(pos, {"blocks:stalactite_middle_" .. sname, "blocks:stalactite_top_" .. sname}, -1)
		end,
		after_dig_node = function(pos, node, metadata, digger)
			ccore.dig_dir(pos, {"blocks:stalactite_middle_" .. sname, "blocks:stalactite_top_" .. sname}, -1, digger)
		end,
		after_destruct = function(pos)
			ccore.dig_dir(pos, {"blocks:stalactite_middle_" .. sname, "blocks:stalactite_top_" .. sname}, -1)
		end,
	})
	minetest.register_node("blocks:stalagmite_top_" .. sname, {
		description = (base_description .. " Stalagmite"),
		drawtype = "plantlike",
		tiles = {"blocks_stalagmites_" .. sname .. ".png^[sheet:26x2:24,0"},
		inventory_image = "blocks_stalagmites_" .. sname .. ".png^[sheet:26x2:24,0",
		sunlight_propagates = true,
		paramtype = "light",
		use_texture_alpha = "blend",
		light_source = 1,
		floodable = true,
		drop = {
			items = {
				{
					rarity = 1,
					items = {drop},
				},
				{
					rarity = 2,
					items = {drop},
				},
				{
					rarity = 3,
					items = {drop},
				},
			},
		},
		collision_box = box_big,
		selection_box = box_big,
		groups = groups,
		sounds = sounds,
	})
	minetest.register_node("blocks:stalactite_top_" .. sname, {
		description = (base_description .. " Stalactite"),
		drawtype = "plantlike",
		tiles = {"blocks_stalagmites_" .. sname .. ".png^[sheet:26x2:25,1"},
		inventory_image = "blocks_stalagmites_" .. sname .. ".png^[sheet:26x2:25,1",
		sunlight_propagates = true,
		paramtype = "light",
		use_texture_alpha = "blend",
		light_source = 1,
		floodable = true,
		drop = {
			items = {
				{
					rarity = 1,
					items = {drop},
				},
				{
					rarity = 2,
					items = {drop},
				},
				{
					rarity = 3,
					items = {drop},
				},
			},
		},
		collision_box = box_big,
		selection_box = box_big,
		groups = groups,
		sounds = sounds,
	})
end

blocks.register_stalagmites("blocks:stone")
blocks.register_stalagmites("blocks:obsidian", "blocks:obsidian_shard")
blocks.register_stalagmites("blocks:sandstone", "blocks:sand")
blocks.register_stalagmites("blocks:desert_sandstone", "blocks:desert_sand")
blocks.register_stalagmites("blocks:silver_sandstone", "blocks:silver_sand")
blocks.register_stalagmites("blocks:desert_stone")
blocks.register_stalagmites("blocks:granite")
blocks.register_stalagmites("blocks:marble")
blocks.register_stalagmites("blocks:basalt")
blocks.register_stalagmites("blocks:ice", "blocks:snow")