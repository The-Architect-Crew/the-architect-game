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

-- Medieval Glass

minetest.register_node("blocks:medieval_glass", {
	description = S("Medieval Glass"),
	drawtype = "glasslike_framed_optional",
	tiles = {"blocks_medieval_glass.png", "blocks_medieval_glass_detail.png"},
	use_texture_alpha = "clip", -- only needed for stairs API
	paramtype = "light",
	paramtype2 = "glasslikeliquidlevel",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})

-- Amber Glass

minetest.register_node("blocks:amber_glass", {
	description = S("Amber Glass"),
	drawtype = "glasslike_framed_optional",
	tiles = {"blocks_amber_glass.png", "blocks_amber_glass_detail.png"},
	use_texture_alpha = "blend",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("blocks:amber_medieval_glass", {
	description = S("Medieval Amber Glass"),
	drawtype = "glasslike_framed_optional",
	tiles = {"blocks_amber_glass_medieval.png", "blocks_amber_glass_medieval_detail.png"},
	use_texture_alpha = "blend",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})


minetest.register_node("blocks:malachite_glass", {
	description = S("Malachite Glass"),
	drawtype = "glasslike",
	tiles = {"blocks_malachite_glass.png"},
	use_texture_alpha = "blend", 
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
	output = "blocks:medieval_glass 5",
	recipe = {
		{"blocks:glass", "blocks:steel_ingot", "blocks:glass"},
		{"blocks:steel_ingot", "blocks:glass", "blocks:steel_ingot"},
		{"blocks:glass", "blocks:steel_ingot", "blocks:glass"},
	}
})

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
