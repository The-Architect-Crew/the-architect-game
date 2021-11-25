local S = default.get_translator

minetest.register_craftitem("blocks:stick", {
	description = S("Stick"),
	inventory_image = "blocks_stick.png",
	groups = { stick = 1, flammable = 2 },
})

minetest.register_node("blocks:wood", {
	description = S("Apple Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = { "blocks_wood.png" },
	is_ground_content = false,
	groups = { choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1 },
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("blocks:junglewood", {
	description = S("Jungle Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = { "blocks_junglewood.png" },
	is_ground_content = false,
	groups = { choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1 },
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("blocks:pine_wood", {
	description = S("Pine Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = { "blocks_pine_wood.png" },
	is_ground_content = false,
	groups = { choppy = 3, oddly_breakable_by_hand = 2, flammable = 3, wood = 1 },
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("blocks:acacia_wood", {
	description = S("Acacia Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = { "blocks_acacia_wood.png" },
	is_ground_content = false,
	groups = { choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1 },
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("blocks:aspen_wood", {
	description = S("Aspen Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = { "blocks_aspen_wood.png" },
	is_ground_content = false,
	groups = { choppy = 3, oddly_breakable_by_hand = 2, flammable = 3, wood = 1 },
	sounds = default.node_sound_wood_defaults(),
})

--
-- == CRAFTS
--

minetest.register_craft({
	output = "blocks:stick 4",
	recipe = {
		{ "group:wood" },
	},
})

minetest.register_craft({
	output = "blocks:wood 4",
	recipe = {
		{ "flora:tree" },
	},
})

minetest.register_craft({
	output = "blocks:junglewood 4",
	recipe = {
		{ "flora:jungletree" },
	},
})

minetest.register_craft({
	output = "blocks:pine_wood 4",
	recipe = {
		{ "flora:pine_tree" },
	},
})

minetest.register_craft({
	output = "blocks:acacia_wood 4",
	recipe = {
		{ "flora:acacia_tree" },
	},
})

minetest.register_craft({
	output = "blocks:aspen_wood 4",
	recipe = {
		{ "flora:aspen_tree" },
	},
})

minetest.register_craft({
	output = "blocks:wood",
	recipe = {
		{ "flora:bush_stem" },
	},
})

minetest.register_craft({
	output = "blocks:acacia_wood",
	recipe = {
		{ "flora:acacia_bush_stem" },
	},
})

minetest.register_craft({
	output = "blocks:pine_wood",
	recipe = {
		{ "flora:pine_bush_stem" },
	},
})

minetest.register_craft({
	type = "fuel",
	recipe = "group:stick",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "group:wood",
	burntime = 7,
})

minetest.register_craft({
	type = "fuel",
	recipe = "blocks:aspen_wood",
	burntime = 5,
})

minetest.register_craft({
	type = "fuel",
	recipe = "blocks:pine_wood",
	burntime = 6,
})

minetest.register_craft({
	type = "fuel",
	recipe = "blocks:acacia_wood",
	burntime = 8,
})

minetest.register_craft({
	type = "fuel",
	recipe = "blocks:junglewood",
	burntime = 9,
})
