local S = default.get_translator

minetest.register_node("blocks:sand", {
	description = S("Sand"),
	tiles = {"blocks_sand.png"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("blocks:desert_sand", {
	description = S("Desert Sand"),
	tiles = {"blocks_desert_sand.png"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("blocks:silver_sand", {
	description = S("Silver Sand"),
	tiles = {"blocks_silver_sand.png"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_craftitem("blocks:flint", {
	description = S("Flint"),
	inventory_image = "blocks_flint.png"
})

minetest.register_node("blocks:gravel", {
	description = S("Gravel"),
	tiles = {"blocks_gravel.png"},
	groups = {crumbly = 2, falling_node = 1},
	sounds = default.node_sound_gravel_defaults(),
	drop = {
		max_items = 1,
		items = {
			{items = {"blocks:flint"}, rarity = 16},
			{items = {"blocks:gravel"}}
		}
	}
})

-- Underground Decorations

minetest.register_node("blocks:sand_azure", {
	description = S("Sand with Azure Moss"),
	tiles = {"blocks_azure_moss_overlay.png", "blocks_sand.png", "blocks_sand.png^blocks_azure_moss_overlay_side.png"},
	groups = {crumbly = 3, sand = 1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("blocks:desert_sand_azure", {
	description = S("Desert Sand with Azure Moss"),
	tiles = {"blocks_azure_moss_overlay.png", "blocks_desert_sand.png", "blocks_desert_sand.png^blocks_azure_moss_overlay_side.png"},
	groups = {crumbly = 3, sand = 1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("blocks:silver_sand_azure", {
	description = S("Silver Sand with Azure Moss"),
	tiles = {"blocks_azure_moss_overlay.png", "blocks_silver_sand.png", "blocks_silver_sand.png^blocks_azure_moss_overlay_side.png"},
	groups = {crumbly = 3, sand = 1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("blocks:fine_gravel", {
	description = S("Fine Gravel"),
	tiles = {"blocks_fine_gravel.png"},
	groups = {crumbly = 2, falling_node = 1},
	sounds = default.node_sound_gravel_defaults(),
})

-- Crafts
minetest.register_craft({
	output = "blocks:fine_gravel",
	recipe = {
		{"blocks:gravel"}
	}
})