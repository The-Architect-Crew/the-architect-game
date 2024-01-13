local S = default.get_translator

-- Mapgen helper nodes

minetest.register_node("blocks:north_placeholder", {
	description = S("North Node"),
	tiles = {"blocks_placeholder_background.png^blocks_arrow.png"},
    inventory_image = "blocks_placeholder_background.png^blocks_arrow.png",
	groups = {cracky = 3, stone = 1},
	drop = "",
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("blocks:west_placeholder", {
	description = S("West Node"),
	tiles = {"blocks_placeholder_background.png^(blocks_arrow.png^[transformR90])"},
    inventory_image = "blocks_placeholder_background.png^(blocks_arrow.png^[transformR90])",
	groups = {cracky = 3, stone = 1},
	drop = "",
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("blocks:south_placeholder", {
	description = S("South Node"),
	tiles = {"blocks_placeholder_background.png^(blocks_arrow.png^[transformR180])"},
    inventory_image = "blocks_placeholder_background.png^(blocks_arrow.png^[transformR180])",
	groups = {cracky = 3, stone = 1},
	drop = "",
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("blocks:east_placeholder", {
	description = S("East Node"),
	tiles = {"blocks_placeholder_background.png^(blocks_arrow.png^[transformR270])"},
    inventory_image = "blocks_placeholder_background.png^(blocks_arrow.png^[transformR270])",
	groups = {cracky = 3, stone = 1},
	drop = "",
	sounds = default.node_sound_stone_defaults(),
})

-- Terminal nodes

minetest.register_node("blocks:north_terminal_placeholder", {
	description = S("North Node Terminal"),
	tiles = {"blocks_placeholder_background.png^blocks_arrow_terminal.png"},
    inventory_image = "blocks_placeholder_background.png^blocks_arrow_terminal.png",
	groups = {cracky = 3, stone = 1},
	drop = "",
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("blocks:west_terminal_placeholder", {
	description = S("West Node Terminal"),
	tiles = {"blocks_placeholder_background.png^(blocks_arrow_terminal.png^[transformR90])"},
    inventory_image = "blocks_placeholder_background.png^(blocks_arrow_terminal.png^[transformR90])",
	groups = {cracky = 3, stone = 1},
	drop = "",
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("blocks:south_terminal_placeholder", {
	description = S("South Node Terminal"),
	tiles = {"blocks_placeholder_background.png^(blocks_arrow_terminal.png^[transformR180])"},
    inventory_image = "blocks_placeholder_background.png^(blocks_arrow_terminal.png^[transformR180])",
	groups = {cracky = 3, stone = 1},
	drop = "",
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("blocks:east_terminal_placeholder", {
	description = S("East Node Terminal"),
	tiles = {"blocks_placeholder_background.png^(blocks_arrow_terminal.png^[transformR270])"},
    inventory_image = "blocks_placeholder_background.png^(blocks_arrow_terminal.png^[transformR270])",
	groups = {cracky = 3, stone = 1},
	drop = "",
	sounds = default.node_sound_stone_defaults(),
})