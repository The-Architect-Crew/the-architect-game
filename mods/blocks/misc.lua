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