local S = default.get_translator

minetest.register_node("blocks:asphalt", {
	description = S("Asphalt"),
	tiles = {"blocks_asphalt.png"},
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:asphalt_dashed_line", {
	description = S("Asphalt with Dashed Line"),
	tiles = {"blocks_asphalt.png^(blocks_street_dashed_line.png^[opacity:128)", "blocks_asphalt.png", "blocks_asphalt.png"},
	paramtype2 = "facedir",
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:asphalt_line", {
	description = S("Asphalt with Line"),
	tiles = {"blocks_asphalt.png^(blocks_street_line.png^[opacity:128)", "blocks_asphalt.png", "blocks_asphalt.png"},
	paramtype2 = "facedir",
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:asphalt_arrow", {
	description = S("Asphalt with Forward Arrow"),
	tiles = {"blocks_asphalt.png^(blocks_street_arrow.png^[opacity:128)", "blocks_asphalt.png", "blocks_asphalt.png"},
	paramtype2 = "facedir",
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:asphalt_arrow_left", {
	description = S("Asphalt with Left Arrow"),
	tiles = {"blocks_asphalt.png^(blocks_street_arrow_side.png^[opacity:128)", "blocks_asphalt.png", "blocks_asphalt.png"},
	paramtype2 = "facedir",
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:asphalt_arrow_right", {
	description = S("Asphalt with Right Arrow"),
	tiles = {"blocks_asphalt.png^((blocks_street_arrow_side.png^[opacity:128)^[transformFX)", "blocks_asphalt.png", "blocks_asphalt.png"},
	paramtype2 = "facedir",
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:asphalt_arrow_forward_left", {
	description = S("Asphalt with Forward and Left Arrows"),
	tiles = {"blocks_asphalt.png^((blocks_street_arrow.png^blocks_street_arrow_side.png)^[opacity:128)", "blocks_asphalt.png", "blocks_asphalt.png"},
	paramtype2 = "facedir",
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:asphalt_arrow_forward_right", {
	description = S("Asphalt with Forward and Right Arrows"),
	tiles = {"blocks_asphalt.png^((blocks_street_arrow.png^(blocks_street_arrow_side.png^[transformFX))^[opacity:128)", "blocks_asphalt.png", "blocks_asphalt.png"},
	paramtype2 = "facedir",
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:asphalt_arrow_all", {
	description = S("Asphalt with All Arrows"),
	tiles = {"blocks_asphalt.png^((blocks_street_arrow.png^blocks_street_arrow_side.png^(blocks_street_arrow_side.png^[transformFX))^[opacity:128)", "blocks_asphalt.png", "blocks_asphalt.png"},
	paramtype2 = "facedir",
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:asphalt_line_side", {
	description = S("Asphalt with Side Line"),
	tiles = {"blocks_asphalt.png^(blocks_street_side_line.png^[opacity:128)", "blocks_asphalt.png", "blocks_asphalt.png"},
	paramtype2 = "facedir",
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:asphalt_line_two_side", {
	description = S("Asphalt with Two Side Lines"),
	tiles = {"blocks_asphalt.png^((blocks_street_side_line.png^(blocks_street_side_line.png^[transformFX))^[opacity:128)", "blocks_asphalt.png", "blocks_asphalt.png"},
	paramtype2 = "facedir",
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:asphalt_line_three_side", {
	description = S("Asphalt with Three Side Lines"),
	tiles = {"blocks_asphalt.png^((blocks_street_side_line.png^(blocks_street_side_line.png^[transformFX)^(blocks_street_side_line.png^[transformR90))^[opacity:128)", "blocks_asphalt.png", "blocks_asphalt.png"},
	paramtype2 = "facedir",
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:asphalt_line_corner", {
	description = S("Asphalt with Line Corner"),
	tiles = {"blocks_asphalt.png^(blocks_street_corner_line.png^[opacity:128)", "blocks_asphalt.png", "blocks_asphalt.png"},
	paramtype2 = "facedir",
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:concrete", {
	description = S("Concrete"),
	tiles = {"blocks_concrete.png"},
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_stone_defaults(),
})

-- Recipes

minetest.register_craft({
	output = "blocks:concrete",
	recipe = {
		{"blocks:stone"},
	}
})

minetest.register_craft({
	output = "blocks:asphalt_dashed_line 7",
	recipe = {
		{"blocks:asphalt", "dye:white", "blocks:asphalt"},
		{"blocks:asphalt", "blocks:asphalt", "blocks:asphalt"},
		{"blocks:asphalt", "dye:white", "blocks:asphalt"},
	}
})

minetest.register_craft({
	output = "blocks:asphalt_line 6",
	recipe = {
		{"blocks:asphalt", "dye:white", "blocks:asphalt"},
		{"blocks:asphalt", "dye:white", "blocks:asphalt"},
		{"blocks:asphalt", "dye:white", "blocks:asphalt"},
	}
})

minetest.register_craft({
	output = "blocks:asphalt_arrow 5",
	recipe = {
		{"blocks:asphalt", "dye:white", "blocks:asphalt"},
		{"dye:white", "dye:white", "dye:white"},
		{"blocks:asphalt", "blocks:asphalt", "blocks:asphalt"},
	}
})

minetest.register_craft({
	output = "blocks:asphalt_arrow_left 5",
	recipe = {
		{"blocks:asphalt", "dye:white", "blocks:asphalt"},
		{"dye:white", "dye:white", "blocks:asphalt"},
		{"blocks:asphalt", "dye:white", "blocks:asphalt"},
	}
})

minetest.register_craft({
	output = "blocks:asphalt_arrow_right 5",
	recipe = {
		{"blocks:asphalt", "dye:white", "blocks:asphalt"},
		{"blocks:asphalt", "dye:white", "dye:white"},
		{"blocks:asphalt", "dye:white", "blocks:asphalt"},
	}
})

minetest.register_craft({
	output = "blocks:asphalt_arrow_forward_left 2",
	recipe = {
		{"blocks:asphalt_arrow"},
		{"blocks:asphalt_arrow_left"},
	}
})

minetest.register_craft({
	output = "blocks:asphalt_arrow_forward_right 2",
	recipe = {
		{"blocks:asphalt_arrow"},
		{"blocks:asphalt_arrow_right"},
	}
})

minetest.register_craft({
	output = "blocks:asphalt_arrow_all 3",
	recipe = {
		{"blocks:asphalt_arrow"},
		{"blocks:asphalt_arrow_right"},
		{"blocks:asphalt_arrow_left"},
	}
})

minetest.register_craft({
	output = "blocks:asphalt_line_side 6",
	recipe = {
		{"dye:white", "blocks:asphalt", "blocks:asphalt"},
		{"dye:white", "blocks:asphalt", "blocks:asphalt"},
		{"dye:white", "blocks:asphalt", "blocks:asphalt"},
	}
})

minetest.register_craft({
	output = "blocks:asphalt_line_two_side 3",
	recipe = {
		{"dye:white", "blocks:asphalt", "dye:white"},
		{"dye:white", "blocks:asphalt", "dye:white"},
		{"dye:white", "blocks:asphalt", "dye:white"},
	}
})

minetest.register_craft({
	output = "blocks:asphalt_line_three_side 2",
	recipe = {
		{"dye:white", "dye:white", "dye:white"},
		{"dye:white", "blocks:asphalt", "dye:white"},
		{"dye:white", "blocks:asphalt", "dye:white"},
	}
})

minetest.register_craft({
	output = "blocks:asphalt_line_corner 4",
	recipe = {
		{"dye:white", "dye:white", "dye:white"},
		{"dye:white", "blocks:asphalt", "blocks:asphalt"},
		{"dye:white", "blocks:asphalt", "blocks:asphalt"},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "blocks:asphalt",
	recipe = "blocks:gravel",
})