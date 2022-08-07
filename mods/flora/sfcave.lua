minetest.register_node("flora:vines_horizontal", {
	description = "Horizontal Vines",
	tiles = {"flora_vines_horizontal.png"},
	inventory_image = "flora_vines_horizontal.png",
	drawtype = "firelike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	floodable = true,
	visual_scale = 1.64,
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:stick"},
			},
			{
				rarity = 1,
				items = {"flora:leaves"},
			},
			{
				rarity = 2,
				items = {"flora:leaves 2"},
			},
			{
				rarity = 3,
				items = {"blocks:stick 2"},
			},
			{
				rarity = 7,
				items = {"blocks:moonstone_powder"},
			},
		},
	},
	groups = {snappy = 1, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-8 / 16, 4/16, -8 / 16, 8 / 16, 8 / 16, 8 / 16},
	}
})
minetest.register_node("flora:vines", {
	description = "Vines",
	tiles = {"flora_vines.png"},
	inventory_image = "flora_vines.png",
	drawtype = "plantlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	floodable = true,
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:stick"},
			},
			{
				rarity = 1,
				items = {"flora:leaves"},
			},
			{
				rarity = 2,
				items = {"flora:leaves 2"},
			},
			{
				rarity = 3,
				items = {"blocks:stick 2"},
			},
			{
				rarity = 7,
				items = {"blocks:moonstone_powder"},
			},
		},
	},
	groups = {snappy = 1, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	after_dig_node = function(pos, node, metadata, digger)
		local nn = node.name
		ccore.dig_dir(pos, {nn}, -1, digger)
	end
})
for i=1,5 do
	minetest.register_node("flora:moonflower_" .. i, {
		description = "Moonflower",
		tiles = {"flora_moonflower.png^[sheet:5x1:" .. i-1 .. ",0"},
		inventory_image = "flora_moonflower.png^[sheet:5x1:" .. i-1 .. ",0",
		drawtype = "plantlike",
		paramtype = "light",
		light_source = default.LIGHT_MAX,
		sunlight_propagates = true,
		walkable = false,
		floodable = true,
		drop = {
			items = {
				{
					rarity = 1,
					items = {"blocks:moonstone_powder"},
				},
				{
					rarity = 1,
					items = {"blocks:moonstone_powder 2"},
				},
			},
		},
		groups = {snappy = 1, oddly_breakable_by_hand = 1},
		sounds = default.node_sound_leaves_defaults(),
	})
end
minetest.register_node("flora:vines_with_moonstone", {
	description = "Vines with Moonstone",
	tiles = {"flora_vines_with_moonstone.png"},
	inventory_image = "flora_vines_with_moonstone.png",
	drawtype = "plantlike",
	paramtype = "light",
	light_source = default.LIGHT_MAX,
	sunlight_propagates = true,
	walkable = false,
	floodable = true,
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:stick"},
			},
			{
				rarity = 1,
				items = {"blocks:moonstone_powder"},
			},
			{
				rarity = 2,
				items = {"flora:leaves"},
			},
			{
				rarity = 2,
				items = {"blocks:moonstone_powder"},
			},
			{
				rarity = 3,
				items = {"blocks:moonstone_powder 2"},
			},
			{
				rarity = 3,
				items = {"blocks:stick 2"},
			},
			{
				rarity = 7,
				items = {"blocks:moonstone_powder 4"},
			},
		},
	},
	groups = {snappy = 1, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	after_dig_node = function(pos, node, metadata, digger)
		local nn = node.name
		ccore.dig_dir(pos, {nn}, -1, digger)
	end
})

-- Desert variant

minetest.register_node("flora:vines_dry_horizontal", {
	description = "Horizontal Dry Vines",
	tiles = {"flora_vines_dry_horizontal.png"},
	inventory_image = "flora_vines_dry_horizontal.png",
	drawtype = "firelike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	floodable = true,
	visual_scale = 1.64,
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:stick"},
			},
			{
				rarity = 1,
				items = {"flora:dry_leaves"},
			},
			{
				rarity = 2,
				items = {"flora:dry_leaves 2"},
			},
			{
				rarity = 3,
				items = {"blocks:stick 2"},
			},
			{
				rarity = 7,
				items = {"blocks:moonstone_powder"},
			},
		},
	},
	groups = {snappy = 1, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-8 / 16, 4/16, -8 / 16, 8 / 16, 8 / 16, 8 / 16},
	}
})
minetest.register_node("flora:vines_dry", {
	description = "Dry Vines",
	tiles = {"flora_vines_dry.png"},
	inventory_image = "flora_vines_dry.png",
	drawtype = "plantlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	floodable = true,
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:stick"},
			},
			{
				rarity = 1,
				items = {"flora:dry_leaves"},
			},
			{
				rarity = 2,
				items = {"flora:dry_leaves 2"},
			},
			{
				rarity = 3,
				items = {"blocks:stick 2"},
			},
			{
				rarity = 7,
				items = {"blocks:moonstone_powder"},
			},
		},
	},
	groups = {snappy = 1, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	after_dig_node = function(pos, node, metadata, digger)
		local nn = node.name
		ccore.dig_dir(pos, {nn}, -1, digger)
	end
})
for i=1,5 do
	minetest.register_node("flora:moonflower_dry_" .. i, {
		description = "Moonflower with Dry Grass",
		tiles = {"flora_moonflower_dry.png^[sheet:5x1:" .. i-1 .. ",0"},
		inventory_image = "flora_moonflower_dry.png^[sheet:5x1:" .. i-1 .. ",0",
		drawtype = "plantlike",
		paramtype = "light",
		light_source = default.LIGHT_MAX,
		sunlight_propagates = true,
		walkable = false,
		floodable = true,
		drop = {
			items = {
				{
					rarity = 1,
					items = {"blocks:moonstone_powder"},
				},
				{
					rarity = 1,
					items = {"blocks:moonstone_powder 2"},
				},
			},
		},
		groups = {snappy = 1, oddly_breakable_by_hand = 1},
		sounds = default.node_sound_leaves_defaults(),
	})
end
minetest.register_node("flora:vines_dry_with_moonstone", {
	description = "Dry Vines with Moonstone",
	tiles = {"flora_vines_dry_with_moonstone.png"},
	inventory_image = "flora_vines_dry_with_moonstone.png",
	drawtype = "plantlike",
	paramtype = "light",
	light_source = default.LIGHT_MAX,
	sunlight_propagates = true,
	walkable = false,
	floodable = true,
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:stick"},
			},
			{
				rarity = 1,
				items = {"blocks:moonstone_powder"},
			},
			{
				rarity = 2,
				items = {"flora:dry_leaves"},
			},
			{
				rarity = 2,
				items = {"blocks:moonstone_powder"},
			},
			{
				rarity = 3,
				items = {"blocks:moonstone_powder 2"},
			},
			{
				rarity = 3,
				items = {"blocks:stick 2"},
			},
			{
				rarity = 7,
				items = {"blocks:moonstone_powder 4"},
			},
		},
	},
	groups = {snappy = 1, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	after_dig_node = function(pos, node, metadata, digger)
		local nn = node.name
		ccore.dig_dir(pos, {nn}, -1, digger)
	end
})

-- Frosty variant

for i=1,5 do
	minetest.register_node("flora:grass_frosty_" .. i, {
		description = "Frosty Grass",
		tiles = {"flora_grass_frosty.png^[sheet:5x1:" .. i-1 .. ",0"},
		inventory_image = "flora_grass_frosty.png^[sheet:5x1:" .. i-1 .. ",0",
		drawtype = "plantlike",
		paramtype = "light",
		waving = 1,
		sunlight_propagates = true,
		walkable = false,
		floodable = true,
		drop = {
			items = {
				{
					rarity = 2,
					items = {"blocks:snow 2"},
				},
				{
					rarity = 2,
					items = {"blocks:stick"},
				},
				{
					rarity = 3,
					items = {"flora:dry_leaves"},
				},
			},
		},
		groups = {snappy = 1, oddly_breakable_by_hand = 1},
		sounds = default.node_sound_leaves_defaults(),
	})
end

minetest.register_node("flora:vines_frosty_horizontal", {
	description = "Frosty Horizontal Vines",
	tiles = {"flora_vines_frosty_horizontal.png"},
	inventory_image = "flora_vines_frosty_horizontal.png",
	drawtype = "firelike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	floodable = true,
	visual_scale = 1.64,
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:stick"},
			},
			{
				rarity = 1,
				items = {"flora:dry_leaves"},
			},
			{
				rarity = 2,
				items = {"flora:dry_leaves 2"},
			},
			{
				rarity = 3,
				items = {"blocks:stick 2"},
			},
			{
				rarity = 7,
				items = {"blocks:moonstone_powder"},
			},
		},
	},
	groups = {snappy = 1, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-8 / 16, 4/16, -8 / 16, 8 / 16, 8 / 16, 8 / 16},
	}
})
minetest.register_node("flora:vines_frosty", {
	description = "Frosty Vines",
	tiles = {"flora_vines_frosty.png"},
	inventory_image = "flora_vines_frosty.png",
	drawtype = "plantlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	floodable = true,
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:stick"},
			},
			{
				rarity = 1,
				items = {"flora:dry_leaves"},
			},
			{
				rarity = 2,
				items = {"flora:dry_leaves 2"},
			},
			{
				rarity = 3,
				items = {"blocks:stick 2"},
			},
			{
				rarity = 7,
				items = {"blocks:moonstone_powder"},
			},
		},
	},
	groups = {snappy = 1, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	after_dig_node = function(pos, node, metadata, digger)
		local nn = node.name
		ccore.dig_dir(pos, {nn}, -1, digger)
	end
})
for i=1,5 do
	minetest.register_node("flora:moonflower_frosty_" .. i, {
		description = "Moonflower with Frosty Grass",
		tiles = {"flora_moonflower_frosty.png^[sheet:5x1:" .. i-1 .. ",0"},
		inventory_image = "flora_moonflower_frosty.png^[sheet:5x1:" .. i-1 .. ",0",
		drawtype = "plantlike",
		paramtype = "light",
		light_source = default.LIGHT_MAX,
		sunlight_propagates = true,
		walkable = false,
		floodable = true,
		drop = {
			items = {
				{
					rarity = 1,
					items = {"blocks:moonstone_powder"},
				},
				{
					rarity = 1,
					items = {"blocks:moonstone_powder 2"},
				},
			},
		},
		groups = {snappy = 1, oddly_breakable_by_hand = 1},
		sounds = default.node_sound_leaves_defaults(),
	})
end
minetest.register_node("flora:vines_frosty_with_moonstone", {
	description = "Frosty Vines with Moonstone",
	tiles = {"flora_vines_dry_with_moonstone.png"},
	inventory_image = "flora_vines_dry_with_moonstone.png",
	drawtype = "plantlike",
	paramtype = "light",
	light_source = default.LIGHT_MAX,
	sunlight_propagates = true,
	walkable = false,
	floodable = true,
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:stick"},
			},
			{
				rarity = 1,
				items = {"blocks:moonstone_powder"},
			},
			{
				rarity = 2,
				items = {"flora:dry_leaves"},
			},
			{
				rarity = 2,
				items = {"blocks:moonstone_powder"},
			},
			{
				rarity = 3,
				items = {"blocks:moonstone_powder 2"},
			},
			{
				rarity = 3,
				items = {"blocks:stick 2"},
			},
			{
				rarity = 7,
				items = {"blocks:moonstone_powder 4"},
			},
		},
	},
	groups = {snappy = 1, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	after_dig_node = function(pos, node, metadata, digger)
		local nn = node.name
		ccore.dig_dir(pos, {nn}, -1, digger)
	end
})