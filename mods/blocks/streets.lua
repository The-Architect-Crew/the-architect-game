local S = default.get_translator

minetest.register_node("blocks:asphalt", {
	description = S("Asphalt"),
	tiles = {"blocks_asphalt.png"},
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:concrete", {
	description = S("Concrete"),
	tiles = {"blocks_concrete.png"},
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_stone_defaults(),
})