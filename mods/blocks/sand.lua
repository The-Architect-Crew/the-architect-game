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