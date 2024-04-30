local S = default.get_translator

minetest.register_node("blocks:stone", {
	description = S("Stone"),
	tiles = {"blocks_stone.png"},
	groups = {cracky = 3, stone = 1, loot = 1},
	drop = "blocks:cobble",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("blocks:stone_chunk", {
	description = S("Stone Chunk"),
	inventory_image = "blocks_stone_chunk.png",
	groups = {loot = 1}
})

minetest.register_node("blocks:cobble", {
	description = S("Cobblestone"),
	tiles = {"blocks_cobble.png"},
	groups = {cracky = 3, stone = 2, loot = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:mossycobble", {
	description = S("Mossy Cobblestone"),
	tiles = {"blocks_mossycobble.png"},
	is_ground_content = false,
	drop = "blocks:cobble",
	groups = {cracky = 3, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:mossy_stone", {
	description = S("Mossy Stone"),
	tiles = {"blocks_stone.png^blocks_moss_overlay.png"},
	groups = {cracky = 3, stone = 1},
	drop = "blocks:cobble",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:desert_stone", {
	description = S("Desert Stone"),
	tiles = {"blocks_desert_stone.png"},
	groups = {cracky = 3, stone = 1, loot = 2},
	drop = "blocks:desert_cobble",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("blocks:desert_stone_chunk", {
	description = S("Desert Stone Chunk"),
	inventory_image = "blocks_desert_stone_chunk.png",
	groups = {loot = 2}
})

minetest.register_node("blocks:desert_cobble", {
	description = S("Desert Cobblestone"),
	tiles = {"blocks_desert_cobble.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 2, loot = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:mossy_desert_cobble", {
	description = S("Mossy Desert Cobblestone"),
	tiles = {"blocks_desert_cobble.png^blocks_moss_dry_overlay.png"},
	groups = {cracky = 3, stone = 2},
	drop = "blocks:desert_cobble",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:mossy_desert_stone", {
	description = S("Mossy Desert Stone"),
	tiles = {"blocks_desert_stone.png^blocks_moss_dry_overlay.png"},
	groups = {cracky = 3, stone = 1},
	drop = "blocks:desert_cobble",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:sandstone", {
	description = S("Sandstone"),
	tiles = {"blocks_sandstone.png"},
	groups = {crumbly = 1, cracky = 3, loot = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:mossy_sandstone", {
	description = S("Mossy Sandstone"),
	tiles = {"blocks_sandstone.png^(blocks_moss_sand_overlay.png^[opacity:128)"},
	drop = "blocks:sandstone",
	groups = {crumbly = 1, cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:desert_sandstone", {
	description = S("Desert Sandstone"),
	tiles = {"blocks_desert_sandstone.png"},
	groups = {crumbly = 1, cracky = 3, loot = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:mossy_desert_sandstone", {
	description = S("Mossy Desert Sandstone"),
	tiles = {"blocks_desert_sandstone.png^(blocks_moss_sand_overlay.png^[opacity:192)"},
	groups = {crumbly = 1, cracky = 3},
	drop = "blocks:desert_sandstone",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:silver_sandstone", {
	description = S("Silver Sandstone"),
	tiles = {"blocks_silver_sandstone.png"},
	groups = {crumbly = 1, cracky = 3, loot = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:mossy_silver_sandstone", {
	description = S("Mossy Silver Sandstone"),
	tiles = {"blocks_silver_sandstone.png^(blocks_moss_sand_overlay.png^[opacity:128)"},
	groups = {crumbly = 1, cracky = 3},
	drop = "blocks:silver_sandstone",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("blocks:obsidian_shard", {
	description = S("Obsidian Shard"),
	inventory_image = "blocks_obsidian_shard.png",
	groups = {loot = 3}
})

minetest.register_node("blocks:obsidian", {
	description = S("Obsidian"),
	tiles = {"blocks_obsidian.png"},
	sounds = default.node_sound_stone_defaults(),
	groups = {cracky = 1, level = 2, loot = 3},
})

minetest.register_node("blocks:obsidian_cursed", {
	description = S("Cursed Obsidian"),
	tiles = {"blocks_obsidian.png^[colorizehsl:-58:66"},
	sounds = default.node_sound_stone_defaults(),
	groups = {cracky = 1, level = 2, loot = 3},
})

minetest.register_node("blocks:obsidian_sickly", {
	description = S("Sickly Obsidian"),
	tiles = {"blocks_obsidian.png^[colorizehsl:107:74"},
	sounds = default.node_sound_stone_defaults(),
	groups = {cracky = 1, level = 2, loot = 3},
})

minetest.register_node("blocks:obsidian_hot", {
	description = S("Hot Obsidian"),
	tiles = {"blocks_obsidian.png^[colorizehsl:-2:64"},
	sounds = default.node_sound_stone_defaults(),
	groups = {cracky = 1, level = 2, loot = 3},
})

minetest.register_node("blocks:obsidian_crying", {
	description = S("Crying Obsidian"),
	tiles = {"blocks_obsidian.png^[colorizehsl:-173:65"},
	sounds = default.node_sound_stone_defaults(),
	groups = {cracky = 1, level = 2, loot = 3},
})

--
-- COLORED STONE
--

blocks.stone_colors = {
	{"black", "Black", "black"},
	{"brown", "Brown", "brown"},
	{"cyan", "Cyan", "cyan"},
	{"dark_blue", "Dark Blue", "blue"},
	{"dark_green", "Dark Green", "dark_green"},
	{"dark_grey", "Dark Grey", "dark_grey"},
	{"dark_pink", "Dark Pink", "magenta"},
	{"green", "Green", "green"},
	{"grey", "Grey", "grey"},
	{"orange", "Orange", "orange"},
	{"pink", "Pink", "pink"},
	{"purple", "Purple", "violet"},
	{"red", "Red", "red"},
	{"white", "White", "white"},
	{"yellow", "Yellow", "yellow"},
}

for _, color in ipairs(blocks.stone_colors) do

	minetest.register_node("blocks:stone_" .. color[1], {
		description = S(color[2] .. " Stone"),
		tiles = {"blocks_stone_" .. color[1] .. ".png"},
		groups = {cracky = 3, stone = 1, loot = 3},
		sounds = default.node_sound_stone_defaults(),
	})
end

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

for _, color in ipairs(blocks.stone_colors) do
	minetest.register_craft({
		output = "blocks:stone_" .. color[1],
		type = "shapeless",
		recipe = {"blocks:stone", "dye:" .. color[3]},
	})
	workbench:register_craft({
		output = {{"blocks:stone_chunk 4", "dye:" .. color[3]}},
		mod = "shapeless",
		input = {{"blocks:stone_" .. color[1]}},
	})
end

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
