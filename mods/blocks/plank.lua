local S = default.get_translator

minetest.register_craftitem("blocks:stick", {
	description = S("Stick"),
	inventory_image = "blocks_stick.png",
	groups = {stick = 1, flammable = 2},
})

minetest.register_craftitem("blocks:bone", {
	description = S("Bone"),
	inventory_image = "blocks_bone.png",
})

minetest.register_node("blocks:wood", {
	description = S("Apple Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocks_wood.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("blocks:junglewood", {
	description = S("Jungle Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocks_junglewood.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("blocks:pine_wood", {
	description = S("Pine Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocks_pine_wood.png"},
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("blocks:acacia_wood", {
	description = S("Acacia Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocks_acacia_wood.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("blocks:aspen_wood", {
	description = S("Aspen Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocks_aspen_wood.png"},
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("blocks:bonewood", {
	description = S("Bone Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocks_bonewood.png"},
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("blocks:firewood", {
	description = S("Firewood\n\"A block of ever-burning planks\""),
	paramtype = "light",
	paramtype2 = "facedir",
	place_param2 = 0,
	light_source = 4,
	tiles = {"blocks_firewood.png"},
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("blocks:mushroom_wood", {
	description = S("Mushroom Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocks_mushroom_wood.png"},
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craftitem("blocks:firebranches", {
	description = S("Pile of Glowing Sticks\n\"An excellent fuel source\""),
	inventory_image = "blocks_firebranches.png",
	groups = {stick = 1},
})

minetest.register_craftitem("blocks:azure_mycelium", {
	description = S("Pile of Mushroom Mycelia"),
	inventory_image = "blocks_azure_mycelium.png",
})

minetest.register_craftitem("blocks:mushroom_stick", {
	description = S("Mushroom Stick\n\"A what?\""),
	inventory_image = "blocks_mushroom_stick.png",
	groups = {stick = 1},
})

--
-- == CRAFTS
--

minetest.register_craft({
	output = "blocks:stick 4",
	recipe = {
		{"group:wood"},
	}
})

minetest.register_craft({
	output = "blocks:bone 4",
	recipe = {
		{"blocks:bonewood"},
	}
})

minetest.register_craft({
	output = "blocks:wood 4",
	recipe = {
		{"flora:tree"},
	}
})

minetest.register_craft({
	output = "blocks:junglewood 4",
	recipe = {
		{"flora:jungletree"},
	}
})

minetest.register_craft({
	output = "blocks:pine_wood 4",
	recipe = {
		{"flora:pine_tree"},
	}
})

minetest.register_craft({
	output = "blocks:acacia_wood 4",
	recipe = {
		{"flora:acacia_tree"},
	}
})

minetest.register_craft({
	output = "blocks:aspen_wood 4",
	recipe = {
		{"flora:aspen_tree"},
	}
})

minetest.register_craft({
	output = "blocks:bonewood 4",
	recipe = {
		{"flora:bone_tree"},
	}
})

minetest.register_craft({
	output = "blocks:wood",
	recipe = {
		{"flora:bush_stem"},
	}
})

minetest.register_craft({
	output = "blocks:acacia_wood",
	recipe = {
		{"flora:acacia_bush_stem"},
	}
})

minetest.register_craft({
	output = "blocks:pine_wood",
	recipe = {
		{"flora:pine_bush_stem"},
	}
})

minetest.register_craft({
	output = "blocks:bonewood",
	recipe = {
		{"flora:bone_bush_stem"},
	}
})

minetest.register_craft({
	output = "blocks:firewood",
	recipe = {
		{"blocks:firebranches", "blocks:firebranches"},
		{"blocks:firebranches", "blocks:firebranches"},
	}
})

minetest.register_craft({
	output = "blocks:mushroom_wood",
	recipe = {
		{"blocks:azure_mycelium", "azure_mycelium", "blocks:azure_mycelium"},
		{"blocks:azure_mycelium", "azure_mycelium", "blocks:azure_mycelium"},
		{"blocks:azure_mycelium", "azure_mycelium", "blocks:azure_mycelium"},
	}
})
minetest.register_craft({
	output = "blocks:mushroom_stick 2",
	recipe = {
		{"", "", "blocks:azure_mycelium"},
		{"", "blocks:azure_mycelium", ""},
		{"blocks:azure_mycelium", "", ""},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "blocks:coal_lump 3",
	recipe = "blocks:mushroom_wood",
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

minetest.register_craft({
	type = "fuel",
	recipe = "blocks:branches_garnet",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "blocks:firewood",
	burntime = 150,
})

minetest.register_craft({
	type = "fuel",
	recipe = "blocks:mushroom_wood",
	burntime = 90,
})