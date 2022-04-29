decorations = {}

decorations.register_stalagmites = function(base_node, drop)
	local base_definition = minetest.registered_nodes[base_node]
	local sname = string.match(base_node, ':(.*)')
	local base_description = base_definition.description
	local groups = {} -- Simply assigning the value of base node's group to here will then make any edits also mirror on the original node (bug?)
	groups.cracky = base_definition.groups.cracky
	groups.crumbly = base_definition.groups.crumbly
	groups.stone = base_definition.groups.stone
	groups.level = base_definition.groups.level
	groups.attached_node = 1
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
			{-4/16, -2/16 + 16/16, -4/16, 4/16, 8/16 + 16/16, 4/16},
		},
	}
	if (drop == nil) then
		drop = "blocks:" .. sname .. "_chunk"
	end
	for i=1,5 do
		minetest.register_node("decorations:stalagmite_" .. sname .. "_" .. i, {
			description = (base_description .. " Stalagmite"),
			drawtype = "plantlike",
			tiles = {"decorations_stalagmites_" .. sname .. ".png^[sheet:5x1:" .. i-1 .. ",0"},
			visual_scale = 2.0,
			paramtype2 = "degrotate",
			place_param2 = 0,
			sunlight_propagates = true,
			paramtype = "light",
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
		minetest.register_node("decorations:stalactite_" .. sname .. "_" .. i, {
			description = (base_description .. " Stalactite"),
			drawtype = "plantlike",
			tiles = {"(decorations_stalagmites_" .. sname .. ".png^[sheet:5x1:" .. i-1 .. ",0)^[transformFY"},
			visual_scale = 2.0,
			paramtype2 = "degrotate",
			place_param2 = 0,
			sunlight_propagates = true,
			paramtype = "light",
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
end

decorations.register_stalagmites("blocks:stone")
decorations.register_stalagmites("blocks:obsidian", "blocks:obsidian_shard")
decorations.register_stalagmites("blocks:sandstone", "blocks:sand")
decorations.register_stalagmites("blocks:desert_sandstone", "blocks:desert_sand")
decorations.register_stalagmites("blocks:silver_sandstone", "blocks:silver_sand")
decorations.register_stalagmites("blocks:desert_stone")
decorations.register_stalagmites("blocks:granite")
decorations.register_stalagmites("blocks:marble")
decorations.register_stalagmites("blocks:basalt")