local S = default.get_translator

minetest.register_node("blocks:ladder_wood", {
	description = S("Wooden Ladder"),
	drawtype = "signlike",
	tiles = {"blocks_ladder_wood.png"},
	inventory_image = "blocks_ladder_wood.png",
	wield_image = "blocks_ladder_wood.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
		--wall_top = = <default>
		--wall_bottom = = <default>
		--wall_side = = <default>
	},
	groups = {choppy = 2, oddly_breakable_by_hand = 3, flammable = 2},
	legacy_wallmounted = true,
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("blocks:ladder_steel", {
	description = S("Steel Ladder"),
	drawtype = "signlike",
	tiles = {"blocks_ladder_steel.png"},
	inventory_image = "blocks_ladder_steel.png",
	wield_image = "blocks_ladder_steel.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
		--wall_top = = <default>
		--wall_bottom = = <default>
		--wall_side = = <default>
	},
	groups = {cracky = 2},
	sounds = default.node_sound_metal_defaults(),
})
-- Chain
minetest.register_node("blocks:chain", {
	description = "Chain",
	drawtype = "signlike",
	tiles = {"blocks_chain.png"},
	inventory_image = "blocks_chain.png",
	wield_image = "blocks_chain.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	climbable = true,
	selection_box = {
		type = "wallmounted",
	},
	groups = {snappy=1,cracky=2,oddly_breakable_by_hand=2},
	legacy_wallmounted = true
})
--
-- == CRAFTS
--
minetest.register_craft({
	type = "fuel",
	recipe = "blocks:ladder_wood",
	burntime = 7,
})

minetest.register_craft({
	output = "blocks:ladder_wood 5",
	recipe = {
		{"group:stick", "", "group:stick"},
		{"group:stick", "group:stick", "group:stick"},
		{"group:stick", "", "group:stick"},
	}
})

minetest.register_craft({
	output = "blocks:ladder_steel 15",
	recipe = {
		{"blocks:steel_ingot", "", "blocks:steel_ingot"},
		{"blocks:steel_ingot", "blocks:steel_ingot", "blocks:steel_ingot"},
		{"blocks:steel_ingot", "", "blocks:steel_ingot"},
	}
})
-- Recycle
minetest.register_craft({
	output = "blocks:steel_ingot",
	recipe = {
		{"blocks:chain"}
	}
})