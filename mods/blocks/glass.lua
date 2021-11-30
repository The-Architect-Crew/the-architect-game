local S = default.get_translator

minetest.register_node("blocks:glass", {
	description = S("Glass"),
	drawtype = "glasslike_framed_optional",
	tiles = {"blocks_glass.png", "blocks_glass_detail.png"},
	use_texture_alpha = "clip", -- only needed for stairs API
	paramtype = "light",
	paramtype2 = "glasslikeliquidlevel",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("blocks:obsidian_glass", {
	description = S("Obsidian Glass"),
	drawtype = "glasslike_framed_optional",
	tiles = {"blocks_obsidian_glass.png", "blocks_obsidian_glass_detail.png"},
	use_texture_alpha = "clip", -- only needed for stairs API
	paramtype = "light",
	paramtype2 = "glasslikeliquidlevel",
	is_ground_content = false,
	sunlight_propagates = true,
	sounds = default.node_sound_glass_defaults(),
	groups = {cracky = 3},
})

-- Amber Glass

minetest.register_node("blocks:amber_glass", {
	description = S("Amber Glass"),
	drawtype = "allfaces",
	tiles = {"blocks_amber_glass.png"},
	use_texture_alpha = true,
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("blocks:amber_medieval_glass", {
	description = S("Medieval Amber Glass"),
	drawtype = "allfaces",
	tiles = {"blocks_amber_glass_medieval.png"},
	use_texture_alpha = true,
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})

--
-- == CRAFTS
--

minetest.register_craft({
	output = "blocks:amber_glass 4",
	recipe = {
		{"blocks:amber_glass_tile", "blocks:amber_glass_tile"},
		{"blocks:amber_glass_tile", "blocks:amber_glass_tile"},
	}
})

minetest.register_craft({
	output = "blocks:amber_glass_medieval 4",
	recipe = {
		{"blocks:amber_glass_tile", "blocks:steel_ingot", "blocks:amber_glass_tile"},
		{"blocks:steel_ingot", "blocks:amber_glass_tile", "blocks:steel_ingot"},
		{"blocks:amber_glass_tile", "blocks:steel_ingot", "blocks:amber_glass_tile"},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "blocks:glass",
	recipe = "group:sand",
})

minetest.register_craft({
	type = "cooking",
	output = "blocks:obsidian_glass",
	recipe = "blocks:obsidian_shard",
})

minetest.register_craft({
	type = "cooking",
	output = "blocks:amber_glass_tile",
	recipe = "blocks:amber_shard",
})
