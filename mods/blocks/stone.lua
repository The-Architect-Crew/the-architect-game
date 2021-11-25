local S = default.get_translator

minetest.register_node("blocks:stone", {
	description = S("Stone"),
	tiles = { "blocks_stone.png" },
	groups = { cracky = 3, stone = 1 },
	drop = "blocks:cobble",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:cobble", {
	description = S("Cobblestone"),
	tiles = { "blocks_cobble.png" },
	is_ground_content = false,
	groups = { cracky = 3, stone = 2 },
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:stonebrick", {
	description = S("Stone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = { "blocks_stone_brick.png" },
	is_ground_content = false,
	groups = { cracky = 2, stone = 1 },
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:stone_block", {
	description = S("Stone Block"),
	tiles = { "blocks_stone_block.png" },
	is_ground_content = false,
	groups = { cracky = 2, stone = 1 },
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:mossycobble", {
	description = S("Mossy Cobblestone"),
	tiles = { "blocks_mossycobble.png" },
	is_ground_content = false,
	groups = { cracky = 3, stone = 1 },
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:desert_stone", {
	description = S("Desert Stone"),
	tiles = { "blocks_desert_stone.png" },
	groups = { cracky = 3, stone = 1 },
	drop = "blocks:desert_cobble",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:desert_cobble", {
	description = S("Desert Cobblestone"),
	tiles = { "blocks_desert_cobble.png" },
	is_ground_content = false,
	groups = { cracky = 3, stone = 2 },
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:desert_stonebrick", {
	description = S("Desert Stone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = { "blocks_desert_stone_brick.png" },
	is_ground_content = false,
	groups = { cracky = 2, stone = 1 },
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:desert_stone_block", {
	description = S("Desert Stone Block"),
	tiles = { "blocks_desert_stone_block.png" },
	is_ground_content = false,
	groups = { cracky = 2, stone = 1 },
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:sandstone", {
	description = S("Sandstone"),
	tiles = { "blocks_sandstone.png" },
	groups = { crumbly = 1, cracky = 3 },
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:sandstonebrick", {
	description = S("Sandstone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = { "blocks_sandstone_brick.png" },
	is_ground_content = false,
	groups = { cracky = 2 },
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:sandstone_block", {
	description = S("Sandstone Block"),
	tiles = { "blocks_sandstone_block.png" },
	is_ground_content = false,
	groups = { cracky = 2 },
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:desert_sandstone", {
	description = S("Desert Sandstone"),
	tiles = { "blocks_desert_sandstone.png" },
	groups = { crumbly = 1, cracky = 3 },
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:desert_sandstone_brick", {
	description = S("Desert Sandstone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = { "blocks_desert_sandstone_brick.png" },
	is_ground_content = false,
	groups = { cracky = 2 },
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:desert_sandstone_block", {
	description = S("Desert Sandstone Block"),
	tiles = { "blocks_desert_sandstone_block.png" },
	is_ground_content = false,
	groups = { cracky = 2 },
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:silver_sandstone", {
	description = S("Silver Sandstone"),
	tiles = { "blocks_silver_sandstone.png" },
	groups = { crumbly = 1, cracky = 3 },
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:silver_sandstone_brick", {
	description = S("Silver Sandstone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = { "blocks_silver_sandstone_brick.png" },
	is_ground_content = false,
	groups = { cracky = 2 },
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:silver_sandstone_block", {
	description = S("Silver Sandstone Block"),
	tiles = { "blocks_silver_sandstone_block.png" },
	is_ground_content = false,
	groups = { cracky = 2 },
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("blocks:obsidian_shard", {
	description = S("Obsidian Shard"),
	inventory_image = "blocks_obsidian_shard.png",
})

minetest.register_node("blocks:obsidian", {
	description = S("Obsidian"),
	tiles = { "blocks_obsidian.png" },
	sounds = default.node_sound_stone_defaults(),
	groups = { cracky = 1, level = 2 },
})

minetest.register_node("blocks:obsidianbrick", {
	description = S("Obsidian Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = { "blocks_obsidian_brick.png" },
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	groups = { cracky = 1, level = 2 },
})

minetest.register_node("blocks:obsidian_block", {
	description = S("Obsidian Block"),
	tiles = { "blocks_obsidian_block.png" },
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	groups = { cracky = 1, level = 2 },
})

--
-- CRAFTS
--
minetest.register_craft({
	output = "blocks:obsidian_shard 9",
	recipe = {
		{ "blocks:obsidian" },
	},
})

minetest.register_craft({
	output = "blocks:obsidian",
	recipe = {
		{ "blocks:obsidian_shard", "blocks:obsidian_shard", "blocks:obsidian_shard" },
		{ "blocks:obsidian_shard", "blocks:obsidian_shard", "blocks:obsidian_shard" },
		{ "blocks:obsidian_shard", "blocks:obsidian_shard", "blocks:obsidian_shard" },
	},
})

minetest.register_craft({
	output = "blocks:obsidianbrick 4",
	recipe = {
		{ "blocks:obsidian", "blocks:obsidian" },
		{ "blocks:obsidian", "blocks:obsidian" },
	},
})

minetest.register_craft({
	output = "blocks:obsidian_block 9",
	recipe = {
		{ "blocks:obsidian", "blocks:obsidian", "blocks:obsidian" },
		{ "blocks:obsidian", "blocks:obsidian", "blocks:obsidian" },
		{ "blocks:obsidian", "blocks:obsidian", "blocks:obsidian" },
	},
})

minetest.register_craft({
	output = "blocks:stonebrick 4",
	recipe = {
		{ "blocks:stone", "blocks:stone" },
		{ "blocks:stone", "blocks:stone" },
	},
})

minetest.register_craft({
	output = "blocks:stone_block 9",
	recipe = {
		{ "blocks:stone", "blocks:stone", "blocks:stone" },
		{ "blocks:stone", "blocks:stone", "blocks:stone" },
		{ "blocks:stone", "blocks:stone", "blocks:stone" },
	},
})

minetest.register_craft({
	output = "blocks:desert_stonebrick 4",
	recipe = {
		{ "blocks:desert_stone", "blocks:desert_stone" },
		{ "blocks:desert_stone", "blocks:desert_stone" },
	},
})

minetest.register_craft({
	output = "blocks:desert_stone_block 9",
	recipe = {
		{ "blocks:desert_stone", "blocks:desert_stone", "blocks:desert_stone" },
		{ "blocks:desert_stone", "blocks:desert_stone", "blocks:desert_stone" },
		{ "blocks:desert_stone", "blocks:desert_stone", "blocks:desert_stone" },
	},
})

minetest.register_craft({
	output = "blocks:silver_sandstone_brick 4",
	recipe = {
		{ "blocks:silver_sandstone", "blocks:silver_sandstone" },
		{ "blocks:silver_sandstone", "blocks:silver_sandstone" },
	},
})

minetest.register_craft({
	output = "blocks:silver_sandstone_block 9",
	recipe = {
		{ "blocks:silver_sandstone", "blocks:silver_sandstone", "blocks:silver_sandstone" },
		{ "blocks:silver_sandstone", "blocks:silver_sandstone", "blocks:silver_sandstone" },
		{ "blocks:silver_sandstone", "blocks:silver_sandstone", "blocks:silver_sandstone" },
	},
})

minetest.register_craft({
	output = "blocks:sandstone",
	recipe = {
		{ "blocks:sand", "blocks:sand" },
		{ "blocks:sand", "blocks:sand" },
	},
})

minetest.register_craft({
	output = "blocks:sand 4",
	recipe = {
		{ "blocks:sandstone" },
	},
})

minetest.register_craft({
	output = "blocks:sandstonebrick 4",
	recipe = {
		{ "blocks:sandstone", "blocks:sandstone" },
		{ "blocks:sandstone", "blocks:sandstone" },
	},
})

minetest.register_craft({
	output = "blocks:sandstone_block 9",
	recipe = {
		{ "blocks:sandstone", "blocks:sandstone", "blocks:sandstone" },
		{ "blocks:sandstone", "blocks:sandstone", "blocks:sandstone" },
		{ "blocks:sandstone", "blocks:sandstone", "blocks:sandstone" },
	},
})

minetest.register_craft({
	output = "blocks:desert_sandstone",
	recipe = {
		{ "blocks:desert_sand", "blocks:desert_sand" },
		{ "blocks:desert_sand", "blocks:desert_sand" },
	},
})

minetest.register_craft({
	output = "blocks:desert_sand 4",
	recipe = {
		{ "blocks:desert_sandstone" },
	},
})

minetest.register_craft({
	output = "blocks:desert_sandstone_brick 4",
	recipe = {
		{ "blocks:desert_sandstone", "blocks:desert_sandstone" },
		{ "blocks:desert_sandstone", "blocks:desert_sandstone" },
	},
})

minetest.register_craft({
	output = "blocks:desert_sandstone_block 9",
	recipe = {
		{ "blocks:desert_sandstone", "blocks:desert_sandstone", "blocks:desert_sandstone" },
		{ "blocks:desert_sandstone", "blocks:desert_sandstone", "blocks:desert_sandstone" },
		{ "blocks:desert_sandstone", "blocks:desert_sandstone", "blocks:desert_sandstone" },
	},
})

minetest.register_craft({
	output = "blocks:silver_sandstone",
	recipe = {
		{ "blocks:silver_sand", "blocks:silver_sand" },
		{ "blocks:silver_sand", "blocks:silver_sand" },
	},
})

minetest.register_craft({
	output = "blocks:silver_sand 4",
	recipe = {
		{ "blocks:silver_sandstone" },
	},
})

minetest.register_craft({
	type = "cooking",
	output = "blocks:stone",
	recipe = "blocks:cobble",
})

minetest.register_craft({
	type = "cooking",
	output = "blocks:stone",
	recipe = "blocks:mossycobble",
})

minetest.register_craft({
	type = "cooking",
	output = "blocks:desert_stone",
	recipe = "blocks:desert_cobble",
})
