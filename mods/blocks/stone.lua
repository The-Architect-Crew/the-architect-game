local S = default.get_translator

minetest.register_node("blocks:stone", {
	description = S("Stone"),
	tiles = {"blocks_stone.png"},
	groups = {cracky = 3, stone = 1},
	drop = "blocks:cobble",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("blocks:stone_chunk", {
	description = S("Stone Chunk"),
	inventory_image = "blocks_stone_chunk.png",
})

minetest.register_node("blocks:cobble", {
	description = S("Cobblestone"),
	tiles = {"blocks_cobble.png"},
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:stonebrick", {
	description = S("Stone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocks_stone_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:stone_block", {
	description = S("Stone Block"),
	tiles = {"blocks_stone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:mossycobble", {
	description = S("Mossy Cobblestone"),
	tiles = {"blocks_mossycobble.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:mossy_stone", {
	description = S("Stone"),
	tiles = {"blocks_stone.png^blocks_moss_overlay.png"},
	groups = {cracky = 3, stone = 1},
	drop = "blocks:cobble",
	sounds = default.node_sound_stone_defaults(),
})


minetest.register_node("blocks:desert_stone", {
	description = S("Desert Stone"),
	tiles = {"blocks_desert_stone.png"},
	groups = {cracky = 3, stone = 1},
	drop = "blocks:desert_cobble",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("blocks:desert_stone_chunk", {
	description = S("Desert Stone Chunk"),
	inventory_image = "blocks_desert_stone_chunk.png",
})

minetest.register_node("blocks:desert_cobble", {
	description = S("Desert Cobblestone"),
	tiles = {"blocks_desert_cobble.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:desert_stonebrick", {
	description = S("Desert Stone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocks_desert_stone_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:desert_stone_block", {
	description = S("Desert Stone Block"),
	tiles = {"blocks_desert_stone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:mossy_desert_cobble", {
	description = S("Desert Cobblestone"),
	tiles = {"blocks_desert_cobble.png^blocks_moss_dry_overlay.png"},
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:mossy_desert_stone", {
	description = S("Desert Stone"),
	tiles = {"blocks_desert_stone.png^blocks_moss_dry_overlay.png"},
	groups = {cracky = 3, stone = 1},
	drop = "blocks:desert_cobble",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:sandstone", {
	description = S("Sandstone"),
	tiles = {"blocks_sandstone.png"},
	groups = {crumbly = 1, cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:sandstonebrick", {
	description = S("Sandstone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocks_sandstone_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:sandstone_block", {
	description = S("Sandstone Block"),
	tiles = {"blocks_sandstone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:mossy_sandstone", {
	description = S("Sandstone"),
	tiles = {"blocks_sandstone.png^(blocks_moss_sand_overlay.png^[opacity:128)"},
	groups = {crumbly = 1, cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:desert_sandstone", {
	description = S("Desert Sandstone"),
	tiles = {"blocks_desert_sandstone.png"},
	groups = {crumbly = 1, cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:desert_sandstone_brick", {
	description = S("Desert Sandstone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocks_desert_sandstone_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:desert_sandstone_block", {
	description = S("Desert Sandstone Block"),
	tiles = {"blocks_desert_sandstone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:mossy_desert_sandstone", {
	description = S("Desert Sandstone"),
	tiles = {"blocks_desert_sandstone.png^(blocks_moss_sand_overlay.png^[opacity:192)"},
	groups = {crumbly = 1, cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:silver_sandstone", {
	description = S("Silver Sandstone"),
	tiles = {"blocks_silver_sandstone.png"},
	groups = {crumbly = 1, cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:silver_sandstone_brick", {
	description = S("Silver Sandstone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocks_silver_sandstone_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:silver_sandstone_block", {
	description = S("Silver Sandstone Block"),
	tiles = {"blocks_silver_sandstone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:mossy_silver_sandstone", {
	description = S("Silver Sandstone"),
	tiles = {"blocks_silver_sandstone.png^(blocks_moss_sand_overlay.png^[opacity:128)"},
	groups = {crumbly = 1, cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("blocks:obsidian_shard", {
	description = S("Obsidian Shard"),
	inventory_image = "blocks_obsidian_shard.png",
})

minetest.register_node("blocks:obsidian", {
	description = S("Obsidian"),
	tiles = {"blocks_obsidian.png"},
	sounds = default.node_sound_stone_defaults(),
	groups = {cracky = 1, level = 2},
})

minetest.register_node("blocks:obsidianbrick", {
	description = S("Obsidian Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocks_obsidian_brick.png"},
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	groups = {cracky = 1, level = 2},
})

minetest.register_node("blocks:obsidian_block", {
	description = S("Obsidian Block"),
	tiles = {"blocks_obsidian_block.png"},
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	groups = {cracky = 1, level = 2},
})

--
-- COLORED STONE
--

blocks.stone_colors = {
	{"black", "Black"},
	{"brown", "Brown"},
	{"cyan", "Cyan"},
	{"dark_blue", "Dark Blue"},
	{"dark_green", "Dark Green"},
	{"dark_grey", "Dark Grey"},
	{"dark_pink", "Dark Pink"},
	{"green", "Green"},
	{"grey", "Grey"},
	{"orange", "Orange"},
	{"pink", "Pink"},
	{"purple", "Purple"},
	{"red", "Red"},
	{"white", "White"},
	{"yellow", "Yellow"},
}

for _, color in ipairs(blocks.stone_colors) do

	minetest.register_node("blocks:stone_" .. color[1], {
		description = S(color[2] .. " Stone"),
		tiles = {"blocks_stone_" .. color[1] .. ".png"},
		groups = {cracky = 3, stone = 1},
		sounds = default.node_sound_stone_defaults(),
	})
end

--
-- Underground Decorations
--

minetest.register_node("blocks:cobble_garnet", {
	description = S("Cobblestone"),
	tiles = {"blocks_cobble.png^blocks_moss_garnet_overlay.png", "blocks_cobble.png", "blocks_cobble.png^blocks_moss_garnet_overlay_side.png"},
	groups = {cracky = 3, stone = 2},
	drop = "blocks:cobble",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:desert_cobble_lapis", {
	description = S("Desert Cobblestone"),
	tiles = {"blocks_desert_cobble.png^blocks_moss_lapis_overlay.png", "blocks_desert_cobble.png", "blocks_desert_cobble.png^blocks_moss_lapis_overlay_side.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:stone_icy", {
	description = S("Stone"),
	tiles = {"blocks_stone_icy.png"},
	groups = {cracky = 3, stone = 1},
	drop = "blocks:cobble",
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("blocks:stone_mese_circuits", {
	description = S("Stone"),
	tiles = {"blocks_stone.png^blocks_mese_circuitry_overlay.png", "blocks_stone.png^blocks_mese_circuitry_under.png", "blocks_stone.png^blocks_mese_circuitry_side.png"},
	groups = {cracky = 3, stone = 1},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:mese_fiber"},
			},
			{
				rarity = 2,
				items = {"blocks:mese_fiber 2"},
			},
			{
				rarity = 1,
				items = {"blocks:stone_chunk 2"},
			},
			{
				rarity = 2,
				items = {"blocks:stone_chunk"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("blocks:stone_mese_circuits_under", {
	description = S("Stone"),
	tiles = {"blocks_stone.png", "blocks_stone.png^blocks_mese_circuitry_under.png", "blocks_stone.png"},
	groups = {cracky = 3, stone = 1},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:mese_fiber"},
			},
			{
				rarity = 2,
				items = {"blocks:mese_fiber"},
			},
			{
				rarity = 1,
				items = {"blocks:stone_chunk 2"},
			},
			{
				rarity = 2,
				items = {"blocks:stone_chunk 2"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

--
-- CRAFTS
--
minetest.register_craft({
	output = "blocks:cobble",
	recipe = {
		{"blocks:stone_chunk", "blocks:stone_chunk"},
		{"blocks:stone_chunk", "blocks:stone_chunk"},
	}
})

minetest.register_craft({
	output = "blocks:desert_cobble",
	recipe = {
		{"blocks:desert_stone_chunk", "blocks:desert_stone_chunk"},
		{"blocks:desert_stone_chunk", "blocks:desert_stone_chunk"},
	}
})

minetest.register_craft({
	output = "blocks:obsidian_shard 9",
	recipe = {
		{"blocks:obsidian"}
	}
})

minetest.register_craft({
	output = "blocks:obsidian",
	recipe = {
		{"blocks:obsidian_shard", "blocks:obsidian_shard", "blocks:obsidian_shard"},
		{"blocks:obsidian_shard", "blocks:obsidian_shard", "blocks:obsidian_shard"},
		{"blocks:obsidian_shard", "blocks:obsidian_shard", "blocks:obsidian_shard"},
	}
})

minetest.register_craft({
	output = "blocks:sandstone",
	recipe = {
		{"blocks:sand", "blocks:sand"},
		{"blocks:sand", "blocks:sand"},
	}
})

minetest.register_craft({
	output = "blocks:sand 4",
	recipe = {
		{"blocks:sandstone"},
	}
})

minetest.register_craft({
	output = "blocks:desert_sandstone",
	recipe = {
		{"blocks:desert_sand", "blocks:desert_sand"},
		{"blocks:desert_sand", "blocks:desert_sand"},
	}
})

minetest.register_craft({
	output = "blocks:desert_sand 4",
	recipe = {
		{"blocks:desert_sandstone"},
	}
})

minetest.register_craft({
	output = "blocks:silver_sandstone",
	recipe = {
		{"blocks:silver_sand", "blocks:silver_sand"},
		{"blocks:silver_sand", "blocks:silver_sand"},
	}
})

minetest.register_craft({
	output = "blocks:silver_sand 4",
	recipe = {
		{"blocks:silver_sandstone"},
	}
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
