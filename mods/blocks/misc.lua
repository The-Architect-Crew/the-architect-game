local S = default.get_translator

minetest.register_node("blocks:cloud", {
	description = S("Cloud"),
	tiles = {"blocks_cloud.png"},
	is_ground_content = false,
	sounds = default.node_sound_defaults(),
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("blocks:core_plating", {
	description = S("Planet Core Plating"),
	tiles = {"blocks_core_plating.png"},
	is_ground_content = false,
	sounds = default.node_sound_metal_defaults(),
	groups = {not_in_creative_inventory = 1},
})

minetest.register_craftitem("blocks:imagination", {
	description = ccore.comment("Imagination", "Contained fourth wall-breaking reality glitch\nUsed to craft the still unavailable materials"),
	inventory_image = "blocks_imagination.png",
})

-- Crafting

minetest.register_craft({
	output = "blocks:marble",
	type = "shapeless",
	recipe = {"blocks:imagination", "blocks:clay"},
	replacements = {
		{"blocks:imagination", "blocks:imagination"}
	},
})

minetest.register_craft({
	output = "blocks:granite",
	type = "shapeless",
	recipe = {"blocks:imagination", "blocks:stone_dark_grey"},
	replacements = {
		{"blocks:imagination", "blocks:imagination"}
	},
})

minetest.register_craft({
	output = "blocks:malachite",
	type = "shapeless",
	recipe = {"blocks:imagination", "blocks:dirt_with_viridis_mycelia"},
	replacements = {
		{"blocks:imagination", "blocks:imagination"}
	},
})

minetest.register_craft({
	output = "blocks:lapis_lazuli",
	type = "shapeless",
	recipe = {"blocks:imagination", "blocks:dirt_with_mycelia"},
	replacements = {
		{"blocks:imagination", "blocks:imagination"}
	},
})

minetest.register_craft({
	output = "blocks:obsidian",
	type = "shapeless",
	recipe = {"blocks:imagination", "blocks:stone_black"},
	replacements = {
		{"blocks:imagination", "blocks:imagination"}
	},
})

minetest.register_craft({
	output = "blocks:obsidian_crying",
	type = "shapeless",
	recipe = {"blocks:imagination", "blocks:stone_dark_blue"},
	replacements = {
		{"blocks:imagination", "blocks:imagination"}
	},
})

minetest.register_craft({
	output = "blocks:obsidian_cursed",
	type = "shapeless",
	recipe = {"blocks:imagination", "blocks:stone_purple"},
	replacements = {
		{"blocks:imagination", "blocks:imagination"}
	},
})

minetest.register_craft({
	output = "blocks:obsidian_hot",
	type = "shapeless",
	recipe = {"blocks:imagination", "blocks:stone_red"},
	replacements = {
		{"blocks:imagination", "blocks:imagination"}
	},
})

minetest.register_craft({
	output = "blocks:obsidian_sickly",
	type = "shapeless",
	recipe = {"blocks:imagination", "blocks:stone_dark_green"},
	replacements = {
		{"blocks:imagination", "blocks:imagination"}
	},
})

minetest.register_craft({
	output = "blocks:porphyry",
	type = "shapeless",
	recipe = {"blocks:imagination", "flora:dark_gills"},
	replacements = {
		{"blocks:imagination", "blocks:imagination"}
	},
})

minetest.register_craft({
	output = "blocks:serpentine",
	type = "shapeless",
	recipe = {"blocks:imagination", "blocks:wool_green"},
	replacements = {
		{"blocks:imagination", "blocks:imagination"}
	},
})

minetest.register_craft({
	output = "blocks:turquoise",
	type = "shapeless",
	recipe = {"blocks:imagination", "blocks:wool_cyan"},
	replacements = {
		{"blocks:imagination", "blocks:imagination"}
	},
})

minetest.register_craft({
	output = "blocks:wool_white",
	recipe = {
		{"group:leaves", "group:leaves", "group:leaves"},
		{"group:leaves", "blocks:imagination", "group:leaves"},
		{"group:leaves", "group:leaves", "group:leaves"},
	},
	replacements = {
		{"blocks:imagination", "blocks:imagination"}
	},
})

minetest.register_craft({
	output = "blocks:diamond",
	recipe = {
		{"", "blocks:mese_crystal", ""},
		{"blocks:mese_crystal", "blocks:imagination", "blocks:mese_crystal"},
		{"", "blocks:mese_crystal", ""}
	},
	replacements = {
		{"blocks:imagination", "blocks:imagination"}
	},
})