local S = default.get_translator


-- Coal
minetest.register_craftitem("blocks:coal_lump", {
	description = S("Coal Lump"),
	inventory_image = "blocks_coal_lump.png",
	groups = {coal = 1, flammable = 1}
})

minetest.register_node("blocks:stone_with_coal", {
	description = S("Coal Ore"),
	tiles = {"blocks_stone.png^blocks_mineral_coal.png"},
	groups = {cracky = 3},
	drop = "blocks:coal_lump",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:coal", {
	description = S("Coal"),
	tiles = {"blocks_coal.png"},
	is_ground_content = false,
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

-- Iron
minetest.register_craftitem("blocks:iron_lump", {
	description = S("Iron Lump"),
	inventory_image = "blocks_iron_lump.png"
})

minetest.register_node("blocks:stone_with_iron", {
	description = S("Iron Ore"),
	tiles = {"blocks_stone.png^blocks_mineral_iron.png"},
	groups = {cracky = 2},
	drop = "blocks:iron_lump",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("blocks:steel_ingot", {
	description = S("Steel Ingot"),
	inventory_image = "blocks_steel_ingot.png"
})

minetest.register_node("blocks:steel", {
	description = S("Steel"),
	tiles = {"blocks_steel.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})

-- Copper
minetest.register_craftitem("blocks:copper_ingot", {
	description = S("Copper Ingot"),
	inventory_image = "blocks_copper_ingot.png"
})

minetest.register_craftitem("blocks:copper_lump", {
	description = S("Copper Lump"),
	inventory_image = "blocks_copper_lump.png"
})

minetest.register_node("blocks:stone_with_copper", {
	description = S("Copper Ore"),
	tiles = {"blocks_stone.png^blocks_mineral_copper.png"},
	groups = {cracky = 2},
	drop = "blocks:copper_lump",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:copper", {
	description = S("Copper"),
	tiles = {"blocks_copper.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})

-- Tin
minetest.register_craftitem("blocks:tin_ingot", {
	description = S("Tin Ingot"),
	inventory_image = "blocks_tin_ingot.png"
})

minetest.register_craftitem("blocks:tin_lump", {
	description = S("Tin Lump"),
	inventory_image = "blocks_tin_lump.png"
})

minetest.register_node("blocks:stone_with_tin", {
	description = S("Tin Ore"),
	tiles = {"blocks_stone.png^blocks_mineral_tin.png"},
	groups = {cracky = 2},
	drop = "blocks:tin_lump",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:tin", {
	description = S("Tin"),
	tiles = {"blocks_tin.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})

-- Bronze
minetest.register_craftitem("blocks:bronze_ingot", {
	description = S("Bronze Ingot"),
	inventory_image = "blocks_bronze_ingot.png"
})

minetest.register_node("blocks:bronze", {
	description = S("Bronze"),
	tiles = {"blocks_bronze.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})

-- Mese
minetest.register_craftitem("blocks:mese_crystal", {
	description = S("Mese Crystal"),
	inventory_image = "blocks_mese_crystal.png",
})

minetest.register_craftitem("blocks:mese_crystal_fragment", {
	description = S("Mese Crystal Fragment"),
	inventory_image = "blocks_mese_crystal_fragment.png",
})

minetest.register_node("blocks:stone_with_mese", {
	description = S("Mese Ore"),
	tiles = {"blocks_stone.png^blocks_mineral_mese.png"},
	groups = {cracky = 1},
	drop = "blocks:mese_crystal",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:mese", {
	description = S("Mese Block"),
	tiles = {"blocks_mese_block.png"},
	paramtype = "light",
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_stone_defaults(),
	light_source = 3,
})

-- Gold
minetest.register_craftitem("blocks:gold_ingot", {
	description = S("Gold Ingot"),
	inventory_image = "blocks_gold_ingot.png"
})

minetest.register_craftitem("blocks:gold_lump", {
	description = S("Gold Lump"),
	inventory_image = "blocks_gold_lump.png"
})

minetest.register_node("blocks:stone_with_gold", {
	description = S("Gold Ore"),
	tiles = {"blocks_stone.png^blocks_mineral_gold.png"},
	groups = {cracky = 2},
	drop = "blocks:gold_lump",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:gold", {
	description = S("Goldk"),
	tiles = {"blocks_gold.png"},
	is_ground_content = false,
	groups = {cracky = 1},
	sounds = default.node_sound_metal_defaults(),
})

-- Diamond
minetest.register_craftitem("blocks:diamond", {
	description = S("Diamond"),
	inventory_image = "blocks_diamond.png",
})

minetest.register_node("blocks:stone_with_diamond", {
	description = S("Diamond Ore"),
	tiles = {"blocks_stone.png^blocks_mineral_diamond.png"},
	groups = {cracky = 1},
	drop = "blocks:diamond",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:diamondblock", {
	description = S("Diamond Block"),
	tiles = {"blocks_diamond_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 3},
	sounds = default.node_sound_stone_defaults(),
})

--
-- == CRAFTS
--

minetest.register_craft({
	output = "blocks:bronze_ingot 9",
	recipe = {
		{"blocks:copper_ingot", "blocks:copper_ingot", "blocks:copper_ingot"},
		{"blocks:copper_ingot", "blocks:tin_ingot", "blocks:copper_ingot"},
		{"blocks:copper_ingot", "blocks:copper_ingot", "blocks:copper_ingot"},
	}
})

minetest.register_craft({
	output = "blocks:coal_lump 9",
	recipe = {
		{"blocks:coalblock"},
	}
})

minetest.register_craft({
	output = "blocks:copper_ingot 9",
	recipe = {
		{"blocks:copperblock"},
	}
})

minetest.register_craft({
	output = "blocks:diamond 9",
	recipe = {
		{"blocks:diamondblock"},
	}
})

minetest.register_craft({
	output = "blocks:gold_ingot 9",
	recipe = {
		{"blocks:goldblock"},
	}
})

minetest.register_craft({
	output = "blocks:coalblock",
	recipe = {
		{"blocks:coal_lump", "blocks:coal_lump", "blocks:coal_lump"},
		{"blocks:coal_lump", "blocks:coal_lump", "blocks:coal_lump"},
		{"blocks:coal_lump", "blocks:coal_lump", "blocks:coal_lump"},
	}
})

minetest.register_craft({
	output = "blocks:steel",
	recipe = {
		{"blocks:steel_ingot", "blocks:steel_ingot", "blocks:steel_ingot"},
		{"blocks:steel_ingot", "blocks:steel_ingot", "blocks:steel_ingot"},
		{"blocks:steel_ingot", "blocks:steel_ingot", "blocks:steel_ingot"},
	}
})

minetest.register_craft({
	output = "blocks:copper",
	recipe = {
		{"blocks:copper_ingot", "blocks:copper_ingot", "blocks:copper_ingot"},
		{"blocks:copper_ingot", "blocks:copper_ingot", "blocks:copper_ingot"},
		{"blocks:copper_ingot", "blocks:copper_ingot", "blocks:copper_ingot"},
	}
})

minetest.register_craft({
	output = "blocks:tin",
	recipe = {
		{"blocks:tin_ingot", "blocks:tin_ingot", "blocks:tin_ingot"},
		{"blocks:tin_ingot", "blocks:tin_ingot", "blocks:tin_ingot"},
		{"blocks:tin_ingot", "blocks:tin_ingot", "blocks:tin_ingot"},
	}
})

minetest.register_craft({
	output = "blocks:bronze",
	recipe = {
		{"blocks:bronze_ingot", "blocks:bronze_ingot", "blocks:bronze_ingot"},
		{"blocks:bronze_ingot", "blocks:bronze_ingot", "blocks:bronze_ingot"},
		{"blocks:bronze_ingot", "blocks:bronze_ingot", "blocks:bronze_ingot"},
	}
})

minetest.register_craft({
	output = "blocks:bronze_ingot 9",
	recipe = {
		{"blocks:bronze"},
	}
})

minetest.register_craft({
	output = "blocks:gold",
	recipe = {
		{"blocks:gold_ingot", "blocks:gold_ingot", "blocks:gold_ingot"},
		{"blocks:gold_ingot", "blocks:gold_ingot", "blocks:gold_ingot"},
		{"blocks:gold_ingot", "blocks:gold_ingot", "blocks:gold_ingot"},
	}
})

minetest.register_craft({
	output = "blocks:diamondblock",
	recipe = {
		{"blocks:diamond", "blocks:diamond", "blocks:diamond"},
		{"blocks:diamond", "blocks:diamond", "blocks:diamond"},
		{"blocks:diamond", "blocks:diamond", "blocks:diamond"},
	}
})

minetest.register_craft({
	output = "blocks:mese_crystal",
	recipe = {
		{"blocks:mese_crystal_fragment", "blocks:mese_crystal_fragment", "blocks:mese_crystal_fragment"},
		{"blocks:mese_crystal_fragment", "blocks:mese_crystal_fragment", "blocks:mese_crystal_fragment"},
		{"blocks:mese_crystal_fragment", "blocks:mese_crystal_fragment", "blocks:mese_crystal_fragment"},
	}
})

minetest.register_craft({
	output = "blocks:mese_crystal 9",
	recipe = {
		{"blocks:mese"},
	}
})

minetest.register_craft({
	output = "blocks:mese",
	recipe = {
		{"blocks:mese_crystal", "blocks:mese_crystal", "blocks:mese_crystal"},
		{"blocks:mese_crystal", "blocks:mese_crystal", "blocks:mese_crystal"},
		{"blocks:mese_crystal", "blocks:mese_crystal", "blocks:mese_crystal"},
	}
})

minetest.register_craft({
	output = "blocks:mese_crystal_fragment 9",
	recipe = {
		{"blocks:mese_crystal"},
	}
})

minetest.register_craft({
	output = "blocks:steel_ingot 9",
	recipe = {
		{"blocks:steel"},
	}
})

minetest.register_craft({
	output = "blocks:tin_ingot 9",
	recipe = {
		{"blocks:tin"},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "blocks:copper_ingot",
	recipe = "blocks:copper_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "blocks:gold_ingot",
	recipe = "blocks:gold_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "blocks:steel_ingot",
	recipe = "blocks:iron_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "blocks:tin_ingot",
	recipe = "blocks:tin_lump",
})

minetest.register_craft({
	type = "fuel",
	recipe = "blocks:coal_lump",
	burntime = 40,
})

minetest.register_craft({
	type = "fuel",
	recipe = "blocks:coalblock",
	burntime = 370,
})
