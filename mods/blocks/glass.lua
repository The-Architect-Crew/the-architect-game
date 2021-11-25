local S = default.get_translator

minetest.register_node("blocks:glass", {
	description = S("Glass"),
	drawtype = "glasslike_framed_optional",
	tiles = { "blocks_glass.png", "blocks_glass_detail.png" },
	use_texture_alpha = "clip", -- only needed for stairs API
	paramtype = "light",
	paramtype2 = "glasslikeliquidlevel",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = { cracky = 3, oddly_breakable_by_hand = 3 },
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("blocks:obsidian_glass", {
	description = S("Obsidian Glass"),
	drawtype = "glasslike_framed_optional",
	tiles = { "blocks_obsidian_glass.png", "blocks_obsidian_glass_detail.png" },
	use_texture_alpha = "clip", -- only needed for stairs API
	paramtype = "light",
	paramtype2 = "glasslikeliquidlevel",
	is_ground_content = false,
	sunlight_propagates = true,
	sounds = default.node_sound_glass_defaults(),
	groups = { cracky = 3 },
})

--
-- == CRAFTS
--

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
