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
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:coal_lump"},
			},
			{
				rarity = 2,
				items = {"blocks:stone_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:stone_chunk 2"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:stone_with_coalblock", {
	description = S("Coal Deposit"),
	tiles = {"blocks_mineral_coal_block.png"},
	groups = {cracky = 2},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:coal_lump 2"},
			},
			{

				rarity = 2,
				items = {"blocks:coal_lump 3"},

			},
			{

				rarity = 3,
				items = {"blocks:coal_lump 4"},

			},
			{

				rarity = 5,
				items = {"blocks:coalblock"},

			},
			{

				rarity = 7,
				items = {"blocks:amber_lump 2"},

			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:coalblock", {
	description = S("Coal Block"),
	tiles = {"blocks_coal_block.png"},
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
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:iron_lump"},
			},
			{
				rarity = 2,
				items = {"blocks:stone_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:stone_chunk 2"},
			},
			{
				rarity = 5,
				items = {"blocks:iron_lump"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:desert_stone_with_iron", {
	description = S("Iron Ore (Desert Stone)"),
	tiles = {"blocks_desert_stone.png^blocks_mineral_iron.png"},
	groups = {cracky = 3},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:iron_lump"},
			},
			{
				rarity = 2,
				items = {"blocks:desert_stone_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:desert_stone_chunk 2"},
			},
			{
				rarity = 5,
				items = {"blocks:iron_lump"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:sandstone_with_iron", {
	description = S("Iron Ore (Sandstone)"),
	tiles = {"blocks_sandstone.png^blocks_mineral_iron.png"},
	groups = {crumbly = 1, cracky = 3},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:iron_lump"},
			},
			{
				rarity = 2,
				items = {"blocks:sand"},
			},
			{
				rarity = 3,
				items = {"blocks:sand 2"},
			},
			{
				rarity = 5,
				items = {"blocks:iron_lump"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:desert_sandstone_with_iron", {
	description = S("Iron Ore (Desert Sandstone)"),
	tiles = {"blocks_desert_sandstone.png^blocks_mineral_iron.png"},
	groups = {crumbly = 1, cracky = 3},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:iron_lump"},
			},
			{
				rarity = 2,
				items = {"blocks:desert_sand"},
			},
			{
				rarity = 3,
				items = {"blocks:desert_sand 2"},
			},
			{
				rarity = 5,
				items = {"blocks:iron_lump"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:silver_sandstone_with_iron", {
	description = S("Iron Ore (Silver Sandstone)"),
	tiles = {"blocks_silver_sandstone.png^blocks_mineral_iron.png"},
	groups = {crumbly = 1, cracky = 3},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:iron_lump"},
			},
			{
				rarity = 2,
				items = {"blocks:silver_sand"},
			},
			{
				rarity = 3,
				items = {"blocks:silver_sand 2"},
			},
			{
				rarity = 5,
				items = {"blocks:iron_lump"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("blocks:steel_ingot", {
	description = S("Steel Ingot"),
	inventory_image = "blocks_steel_ingot.png"
})

minetest.register_node("blocks:steelblock", {
	description = S("Steel Block"),
	tiles = {"blocks_steel_block.png"},
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
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:copper_lump"},
			},
			{
				rarity = 2,
				items = {"blocks:stone_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:stone_chunk 2"},
			},
			{
				rarity = 5,
				items = {"blocks:copper_lump"},
			},
			{
				rarity = 7,
				items = {"blocks:malachite_chunk"},
			},
			{
				rarity = 7,
				items = {"blocks:silver_lump"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:malachite_with_copper", {
	description = S("Copper Ore (Malachite)"),
	tiles = {"blocks_malachite.png^blocks_mineral_copper.png"},
	groups = {cracky = 2},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:copper_lump 2"},
			},
			{
				rarity = 2,
				items = {"blocks:stone_chunk 4"},
			},
			{
				rarity = 1,
				items = {"blocks:malachite_chunk 2"},
			},
			{
				rarity = 2,
				items = {"blocks:malachite_chunk"},
			},
			{
				rarity = 4,
				items = {"blocks:silver_lump"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:copperblock", {
	description = S("Copper Block"),
	tiles = {"blocks_copper_block.png"},
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
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:tin_lump"},
			},
			{
				rarity = 2,
				items = {"blocks:stone_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:stone_chunk 2"},
			},
			{
				rarity = 5,
				items = {"blocks:tin_lump"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:granite_with_tin", {
	description = S("Tin Ore (Granite)"),
	tiles = {"blocks_granite.png^blocks_mineral_tin.png"},
	groups = {cracky = 2},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:tin_lump"},
			},
			{
				rarity = 2,
				items = {"blocks:granite_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:granite_chunk 2"},
			},
			{
				rarity = 5,
				items = {"blocks:tin_lump"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:tinblock", {
	description = S("Tin Block"),
	tiles = {"blocks_tin_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})

-- Bronze
minetest.register_craftitem("blocks:bronze_ingot", {
	description = S("Bronze Ingot"),
	inventory_image = "blocks_bronze_ingot.png"
})

minetest.register_node("blocks:bronzeblock", {
	description = S("Bronze Block"),
	tiles = {"blocks_bronze_block.png"},
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

minetest.register_craftitem("blocks:mese_fiber", {
	description = S("Mese Fibers"),
	inventory_image = "blocks_mese_fiber.png",
})

minetest.register_craftitem("blocks:mese_fragment_skeleton", {
	description = S("Mese Fragment Skeleton"),
	inventory_image = "blocks_mese_fragment_skeleton.png",
})

minetest.register_node("blocks:stone_with_mese", {
	description = S("Mese Ore"),
	tiles = {"blocks_stone.png^blocks_mineral_mese.png"},
	groups = {cracky = 1},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:mese_crystal"},
			},
			{
				rarity = 2,
				items = {"blocks:marble_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:marble_chunk"},
			},
			{
				rarity = 7,
				items = {"blocks:mese_crystal"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:marble_with_mese", {
	description = S("Mese Ore (Marble)"),
	tiles = {"blocks_marble.png^blocks_mineral_mese.png"},
	groups = {cracky = 1},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:mese_crystal"},
			},
			{
				rarity = 2,
				items = {"blocks:marble_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:marble_chunk"},
			},
			{
				rarity = 5,
				items = {"blocks:mese_crystal"},
			},
		},
	},
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
minetest.register_node("blocks:mese_tech_crystal", {
	description = S("Mese Tech Crystal"),
	tiles = {"blocks_mese_tech_crystal.png"},
	drawtype = "glasslike",
	use_texture_alpha = "blend",
	paramtype = "light",
	groups = {cracky = 3, level = 2},
	sounds = default.node_sound_glass_defaults(),
	light_source = 6,
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
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:gold_lump"},
			},
			{
				rarity = 2,
				items = {"blocks:stone_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:stone_chunk 2"},
			},
			{
				rarity = 5,
				items = {"blocks:gold_lump"},
			},
			{
				rarity = 7,
				items = {"blocks:silver_lump"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:sandstone_with_gold", {
	description = S("Gold Ore (Sandstone)"),
	tiles = {"blocks_sandstone.png^blocks_mineral_gold.png"},
	groups = {crumbly = 1, cracky = 3},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:gold_lump"},
			},
			{
				rarity = 2,
				items = {"blocks:sand"},
			},
			{
				rarity = 3,
				items = {"blocks:sand 2"},
			},
			{
				rarity = 5,
				items = {"blocks:gold_lump"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:desert_sandstone_with_gold", {
	description = S("Gold Ore (Desert Sandstone)"),
	tiles = {"blocks_desert_sandstone.png^blocks_mineral_gold.png"},
	groups = {crumbly = 1, cracky = 3},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:gold_lump"},
			},
			{
				rarity = 2,
				items = {"blocks:desert_sand"},
			},
			{
				rarity = 3,
				items = {"blocks:desert_sand 2"},
			},
			{
				rarity = 5,
				items = {"blocks:gold_lump"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:silver_sandstone_with_gold", {
	description = S("Gold Ore (Silver Sandstone)"),
	tiles = {"blocks_silver_sandstone.png^blocks_mineral_gold.png"},
	groups = {crumbly = 1, cracky = 3},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:gold_lump"},
			},
			{
				rarity = 2,
				items = {"blocks:silver_sand"},
			},
			{
				rarity = 3,
				items = {"blocks:silver_sand 2"},
			},
			{
				rarity = 5,
				items = {"blocks:gold_lump"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:granite_with_gold", {
	description = S("Gold Ore (Granite)"),
	tiles = {"blocks_granite.png^blocks_mineral_gold.png"},
	groups = {cracky = 2},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:gold_lump"},
			},
			{
				rarity = 2,
				items = {"blocks:granite_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:granite_chunk"},
			},
			{
				rarity = 5,
				items = {"blocks:gold_lump"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:goldblock", {
	description = S("Gold Block"),
	tiles = {"blocks_gold_block.png"},
	is_ground_content = false,
	groups = {cracky = 1},
	sounds = default.node_sound_metal_defaults(),
})

-- Electrum
minetest.register_node("blocks:stone_with_electrum", {
	description = S("Electrum Ore"),
	tiles = {"blocks_stone.png^blocks_mineral_electrum.png"},
	groups = {cracky = 2},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:gold_lump"},
			},
			{
				rarity = 1,
				items = {"blocks:silver_lump"},
			},
			{
				rarity = 2,
				items = {"blocks:copper_lump 2"},
			},
			{
				rarity = 2,
				items = {"blocks:stone_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:stone_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:gold_lump"},
			},
			{
				rarity = 3,
				items = {"blocks:silver_lump"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:granite_with_electrum", {
	description = S("Electrum Ore (Granite)"),
	tiles = {"blocks_granite.png^blocks_mineral_electrum.png"},
	groups = {cracky = 2},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:gold_lump"},
			},
			{
				rarity = 1,
				items = {"blocks:silver_lump"},
			},
			{
				rarity = 2,
				items = {"blocks:copper_lump 2"},
			},
			{
				rarity = 2,
				items = {"blocks:granite_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:granite_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:gold_lump"},
			},
			{
				rarity = 3,
				items = {"blocks:silver_lump"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
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
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:diamond"},
			},
			{
				rarity = 2,
				items = {"blocks:stone_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:stone_chunk"},
			},
			{
				rarity = 5,
				items = {"blocks:diamond"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:granite_with_diamond", {
	description = S("Diamond Ore (Granite)"),
	tiles = {"blocks_granite.png^blocks_mineral_diamond.png"},
	groups = {cracky = 1},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:diamond"},
			},
			{
				rarity = 2,
				items = {"blocks:granite_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:granite_chunk"},
			},
			{
				rarity = 5,
				items = {"blocks:diamond"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:obsidian_with_diamond", {
	description = S("Diamond Ore (Obsidian)"),
	tiles = {"blocks_obsidian.png^blocks_mineral_diamond.png"},
	groups = {cracky = 1},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:diamond"},
			},
			{
				rarity = 2,
				items = {"blocks:obsidian_shard 3"},
			},
			{
				rarity = 3,
				items = {"blocks:obsidian_shard 3"},
			},
			{
				rarity = 5,
				items = {"blocks:diamond"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:basalt_with_diamond", {
	description = S("Diamond Ore (Basalt)"),
	tiles = {"blocks_basalt.png^blocks_mineral_diamond.png"},
	groups = {cracky = 1},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:diamond"},
			},
			{
				rarity = 2,
				items = {"blocks:basalt_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:basalt_chunk"},
			},
			{
				rarity = 5,
				items = {"blocks:diamond"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:diamondblock", {
	description = S("Diamond Block"),
	tiles = {"blocks_diamond_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 3},
	sounds = default.node_sound_stone_defaults(),
})

-- Amber
minetest.register_craftitem("blocks:amber_shard", {
	description = S("Amber Shard"),
	inventory_image = "blocks_amber_shard.png",
})

minetest.register_craftitem("blocks:amber_lump", {
	description = S("Amber Lump"),
	inventory_image = "blocks_amber_lump.png",
})

minetest.register_craftitem("blocks:amber_glass_tile", {
	description = S("Amber Glass Tile"),
	inventory_image = "blocks_amber_glass_tile.png",
})

minetest.register_node("blocks:stone_with_amber", {
	description = S("Stone with Amber Ore"),
	tiles = {"blocks_stone.png^blocks_mineral_amber.png"},
	is_ground_content = true,
	groups = {cracky = 3},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:amber_lump"},
			},
			{

				rarity = 2,
				items = {"blocks:amber_lump"},

			},
			{

				rarity = 2,
				items = {"blocks:stone_chunk"},

			},
			{

				rarity = 3,
				items = {"blocks:stone_chunk 2"},

			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:sandstone_with_amber", {
	description = S("Amber Ore (Sandstone)"),
	tiles = {"blocks_sandstone.png^blocks_mineral_amber.png"},
	is_ground_content = true,
	groups = {crumbly = 1, cracky = 3},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:amber_lump"},
			},
			{

				rarity = 2,
				items = {"blocks:amber_lump"},

			},
			{

				rarity = 2,
				items = {"blocks:sand"},

			},
			{

				rarity = 3,
				items = {"blocks:sand 2"},

			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:desert_sandstone_with_amber", {
	description = S("Amber Ore (Desert Sandstone)"),
	tiles = {"blocks_desert_sandstone.png^blocks_mineral_amber.png"},
	is_ground_content = true,
	groups = {crumbly = 1, cracky = 3},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:amber_lump"},
			},
			{

				rarity = 2,
				items = {"blocks:amber_lump"},

			},
			{

				rarity = 2,
				items = {"blocks:desert_sand"},

			},
			{

				rarity = 3,
				items = {"blocks:desert_sand 2"},

			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:silver_sandstone_with_amber", {
	description = S("Amber Ore (Silver Sandstone)"),
	tiles = {"blocks_silver_sandstone.png^blocks_mineral_amber.png"},
	is_ground_content = true,
	groups = {crumbly = 1, cracky = 3},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:amber_lump"},
			},
			{

				rarity = 2,
				items = {"blocks:amber_lump"},

			},
			{

				rarity = 2,
				items = {"blocks:silver_sand"},

			},
			{

				rarity = 3,
				items = {"blocks:silver_sand 2"},

			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:coal_with_amber", {
	description = S("Amber Ore (Coal Deposit)"),
	tiles = {"blocks_stone.png^(blocks_mineral_coal_block.png^blocks_mineral_amber.png)"},
	groups = {cracky = 3},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:coal_lump 4"},
			},
			{

				rarity = 1,
				items = {"blocks:amber_lump 2"},

			},
			{

				rarity = 2,
				items = {"blocks:amber_lump"},

			},
			{

				rarity = 4,
				items = {"blocks:amber_lump"},

			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:mud_with_amber", {
	description = S("Amber Ore (Mud)"),
	tiles = {"blocks_mud.png^blocks_mineral_amber.png", "blocks_mud_side.png^blocks_mineral_amber.png"},
	is_ground_content = true,
	groups = {crumbly = 3},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:amber_lump"},
			},
			{

				rarity = 2,
				items = {"blocks:amber_lump"},

			},
			{

				rarity = 2,
				items = {"blocks:mud_lump"},

			},
			{

				rarity = 3,
				items = {"blocks:mud_lump 2"},

			},
		},
	},
	sounds = default.node_sound_dirt_defaults({
		footstep = "",
	}),
})

minetest.register_node("blocks:dirt_with_amber", {
	description = S("Amber Ore (Dirt)"),
	tiles = {"blocks_dirt.png^blocks_mineral_amber.png"},
	is_ground_content = true,
	groups = {crumbly = 3, soil = 1},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:amber_lump"},
			},
			{

				rarity = 2,
				items = {"blocks:amber_lump"},

			},
			{

				rarity = 2,
				items = {"blocks:dirt"},

			},
		},
	},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("blocks:dry_dirt_with_amber", {
	description = S("Amber Ore (Dry Dirt)"),
	tiles = {"blocks_dry_dirt.png^blocks_mineral_amber.png"},
	is_ground_content = true,
	groups = {crumbly = 3, soil = 1},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:amber_lump"},
			},
			{

				rarity = 2,
				items = {"blocks:amber_lump"},

			},
			{

				rarity = 2,
				items = {"blocks:dry_dirt"},

			},
		},
	},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("blocks:sand_with_amber", {
	description = S("Amber Ore (Sand)"),
	tiles = {"blocks_sand.png^blocks_mineral_amber.png"},
	is_ground_content = true,
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:amber_lump"},
			},
			{

				rarity = 2,
				items = {"blocks:amber_lump"},

			},
			{

				rarity = 2,
				items = {"blocks:sand"},

			},
		},
	},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("blocks:amber", {
	description = S("Amber"),
	tiles = {"blocks_amber.png"},
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})


-- Silver
minetest.register_craftitem("blocks:silver_ingot", {
	description = S("Silver Ingot"),
	inventory_image = "blocks_silver_ingot.png"
})

minetest.register_craftitem("blocks:silver_lump", {
	description = S("Silver Lump"),
	inventory_image = "blocks_silver_lump.png"
})

minetest.register_node("blocks:stone_with_silver", {
	description = S("Silver Ore"),
	tiles = {"blocks_stone.png^blocks_mineral_silver.png"},
	groups = {cracky = 2},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:silver_lump"},
			},
			{

				rarity = 2,
				items = {"blocks:stone_chunk"},

			},
			{

				rarity = 3,
				items = {"blocks:stone_chunk"},

			},
			{

				rarity = 5,
				items = {"blocks:silver_lump"},

			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:granite_with_silver", {
	description = S("Silver Ore (Granite)"),
	tiles = {"blocks_granite.png^blocks_mineral_silver.png"},
	groups = {cracky = 2},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:silver_lump"},
			},
			{

				rarity = 2,
				items = {"blocks:granite_chunk"},

			},
			{

				rarity = 3,
				items = {"blocks:granite_chunk"},

			},
			{

				rarity = 5,
				items = {"blocks:silver_lump"},

			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:silverblock", {
	description = S("Silver Block"),
	tiles = {"blocks_silver_block.png"},
	is_ground_content = false,
	groups = {cracky = 1},
	sounds = default.node_sound_metal_defaults(),
})

-- Mithril
minetest.register_craftitem("blocks:mithril_ingot", {
	description = S("Mithril Ingot"),
	inventory_image = "blocks_mithril_ingot.png"
})

minetest.register_craftitem("blocks:mithril_lump", {
	description = S("Mithril Lump"),
	inventory_image = "blocks_mithril_lump.png"
})

minetest.register_node("blocks:stone_with_mithril", {
	description = S("Mithril Ore"),
	tiles = {"blocks_stone.png^blocks_mineral_mithril.png"},
	groups = {cracky = 1},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:mithril_lump"},
			},
			{
				rarity = 2,
				items = {"blocks:stone_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:stone_chunk"},
			},
			{
				rarity = 7,
				items = {"blocks:mithril_lump"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:mithrilblock", {
	description = S("Mithril Block"),
	tiles = {"blocks_mithril_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 3},
	sounds = default.node_sound_metal_defaults(),
})

-- Amethyst
minetest.register_node("blocks:granite_with_amethyst", {
	description = S("Amethyst Ore (Granite)"),
	tiles = {"blocks_granite.png^blocks_mineral_amethyst.png"},
	groups = {cracky = 2},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:amethyst_crystal 2"},
			},
			{
				rarity = 2,
				items = {"blocks:granite_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:granite_chunk"},
			},
			{
				rarity = 5,
				items = {"blocks:amethyst_crystal 3"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:marble_with_amethyst", {
	description = S("Amethyst Ore (Marble)"),
	tiles = {"blocks_marble.png^blocks_mineral_amethyst.png"},
	groups = {cracky = 2},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:amethyst_crystal 3"},
			},
			{
				rarity = 2,
				items = {"blocks:marble_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:marble_chunk"},
			},
			{
				rarity = 5,
				items = {"blocks:amethyst_crystal 4"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:slate_with_amethyst", {
	description = S("Amethyst Ore (Slate)"),
	tiles = {"blocks_slate.png^blocks_mineral_amethyst.png"},
	groups = {cracky = 2},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:amethyst_crystal 2"},
			},
			{
				rarity = 2,
				items = {"blocks:slate_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:slate_chunk"},
			},
			{
				rarity = 5,
				items = {"blocks:amethyst_crystal 3"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:sandstone_with_amethyst", {
	description = S("Amethyst Ore (Sandstone)"),
	tiles = {"blocks_sandstone.png^blocks_mineral_amethyst.png"},
	groups = {crumbly = 1, cracky = 3},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:amethyst_crystal 2"},
			},
			{
				rarity = 2,
				items = {"blocks:sand"},
			},
			{
				rarity = 3,
				items = {"blocks:sand 2"},
			},
			{
				rarity = 5,
				items = {"blocks:amethyst_crystal 2"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:desert_sandstone_with_amethyst", {
	description = S("Amethyst Ore (Desert Sandstone)"),
	tiles = {"blocks_desert_sandstone.png^blocks_mineral_amethyst.png"},
	groups = {crumbly = 1, cracky = 3},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:amethyst_crystal 2"},
			},
			{
				rarity = 2,
				items = {"blocks:desert_sand"},
			},
			{
				rarity = 3,
				items = {"blocks:desert_sand 2"},
			},
			{
				rarity = 5,
				items = {"blocks:amethyst_crystal 2"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:silver_sandstone_with_amethyst", {
	description = S("Amethyst Ore (Silver Sandstone)"),
	tiles = {"blocks_silver_sandstone.png^blocks_mineral_amethyst.png"},
	groups = {crumbly = 1, cracky = 3},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:amethyst_crystal 2"},
			},
			{
				rarity = 2,
				items = {"blocks:silver_sand"},
			},
			{
				rarity = 3,
				items = {"blocks:silver_sand 2"},
			},
			{
				rarity = 5,
				items = {"blocks:amethyst_crystal 2"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("blocks:amethyst_crystal", {
	description = S("Amethyst Crystal"),
	inventory_image = "blocks_amethyst_crystal.png",
})

minetest.register_node("blocks:amethyst", {
	description = S("Amethyst"),
	drawtype = "glasslike",
	tiles = {"blocks_amethyst.png"},
	paramtype = "light",
	use_texture_alpha = "blend",
	is_ground_content = true,
	sunlight_propagates = true,
	groups = {cracky = 2},
	sounds = default.node_sound_glass_defaults(),
})

-- Garnet
minetest.register_node("blocks:granite_with_garnet", {
	description = S("Garnet Ore (Granite)"),
	tiles = {"blocks_granite.png^blocks_mineral_garnet.png"},
	groups = {cracky = 2},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:garnet_crystal 2"},
			},
			{
				rarity = 2,
				items = {"blocks:granite_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:granite_chunk"},
			},
			{
				rarity = 5,
				items = {"blocks:garnet_crystal 3"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:marble_with_garnet", {
	description = S("Garnet Ore (Marble)"),
	tiles = {"blocks_marble.png^blocks_mineral_garnet.png"},
	groups = {cracky = 2},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:garnet_crystal 3"},
			},
			{
				rarity = 2,
				items = {"blocks:marble_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:marble_chunk"},
			},
			{
				rarity = 5,
				items = {"blocks:garnet_crystal 4"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:slate_with_garnet", {
	description = S("Garnet Ore (Slate)"),
	tiles = {"blocks_slate.png^blocks_mineral_garnet.png"},
	groups = {cracky = 2},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:garnet_crystal 2"},
			},
			{
				rarity = 2,
				items = {"blocks:slate_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:slate_chunk"},
			},
			{
				rarity = 5,
				items = {"blocks:garnet_crystal 3"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:basalt_with_garnet", {
	description = S("Garnet Ore (Basalt)"),
	tiles = {"blocks_basalt.png^blocks_mineral_garnet.png"},
	groups = {cracky = 2},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:garnet_crystal 2"},
			},
			{
				rarity = 2,
				items = {"blocks:basalt_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:basalt_chunk"},
			},
			{
				rarity = 5,
				items = {"blocks:garnet_crystal 3"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:obsidian_with_garnet", {
	description = S("Garnet Ore (Obsidian)"),
	tiles = {"blocks_obsidian.png^blocks_mineral_garnet.png"},
	groups = {cracky = 1},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:garnet_crystal 2"},
			},
			{
				rarity = 2,
				items = {"blocks:obsidian_shard 3"},
			},
			{
				rarity = 3,
				items = {"blocks:obsidian_shard 3"},
			},
			{
				rarity = 5,
				items = {"blocks:garnet_crystal 3"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("blocks:garnet_crystal", {
	description = S("Garnet Crystal"),
	inventory_image = "blocks_garnet_crystal.png",
})

minetest.register_node("blocks:garnet", {
	description = S("Garnet"),
	drawtype = "glasslike",
	tiles = {"blocks_garnet.png"},
	paramtype = "light",
	use_texture_alpha = "blend",
	is_ground_content = true,
	sunlight_propagates = true,
	groups = {cracky = 2},
	sounds = default.node_sound_glass_defaults(),
})

-- Turquoise
minetest.register_node("blocks:turquoise", {
	description = S("Turquoise"),
	tiles = {"blocks_turquoise.png"},
	is_ground_content = true,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

-- Lapis Lazuli
minetest.register_node("blocks:lapis_lazuli", {
	description = S("Lapis Lazuli"),
	tiles = {"blocks_lapis_lazuli.png"},
	is_ground_content = true,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("blocks:lapis_chunk", {
	description = S("Lapis Lazuli Chunk"),
	inventory_image = "blocks_lapis_chunk.png",
})

minetest.register_node("blocks:marble_with_lapis", {
	description = S("Lapis Lazuli Ore (Marble)"),
	tiles = {"blocks_marble.png^blocks_mineral_lapis.png"},
	groups = {cracky = 2},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:lapis_chunk 2"},
			},
			{
				rarity = 2,
				items = {"blocks:marble_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:marble_chunk"},
			},
			{
				rarity = 4,
				items = {"blocks:garnet_crystal"},
			},
			{
				rarity = 5,
				items = {"blocks:lapis_chunk 2"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

-- Malachite
minetest.register_node("blocks:malachite", {
	description = S("Malachite"),
	tiles = {"blocks_malachite.png"},
	is_ground_content = true,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("blocks:malachite_chunk", {
	description = S("Malachite Chunk"),
	inventory_image = "blocks_malachite_chunk.png",
})

-- Basalt
minetest.register_node("blocks:basalt", {
	description = S("Basalt"),
	tiles = {"blocks_basalt.png"},
	is_ground_content = true,
	groups = {cracky = 3},
	drop = "blocks:basalt_cobble",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("blocks:basalt_chunk", {
	description = S("Basalt Chunk"),
	inventory_image = "blocks_basalt_chunk.png",
})

minetest.register_node("blocks:basalt_cobble", {
	description = S("Basalt Cobble"),
	tiles = {"blocks_basalt_cobble.png"},
	is_ground_content = true,
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

-- Chalk
minetest.register_node("blocks:chalk", {
	description = S("Chalk"),
	tiles = {"blocks_chalk.png"},
	is_ground_content = true,
	groups = {crumbly=2,cracky = 2},
	drop = "blocks:chalk_powder 4",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("blocks:chalk_powder", {
	description = S("Chalk Powder"),
	inventory_image = "blocks_chalk_powder.png",
})

-- Granite
minetest.register_node("blocks:granite", {
	description = S("Granite"),
	tiles = {"blocks_granite.png"},
	is_ground_content = true,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("blocks:granite_chunk", {
	description = S("Granite Chunk"),
	inventory_image = "blocks_granite_chunk.png",
})

-- Marble
minetest.register_node("blocks:marble", {
	description = S("Marble"),
	tiles = {"blocks_marble.png"},
	is_ground_content = true,
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("blocks:marble_chunk", {
	description = S("Marble Chunk"),
	inventory_image = "blocks_marble_chunk.png",
})

-- Mese biome
minetest.register_node("blocks:marble_mese_circuits", {
	description = S("Marble with Mese Circuits"),
	tiles = {"blocks_marble.png^blocks_mese_circuitry_overlay.png", "blocks_marble.png^blocks_mese_circuitry_under.png", "blocks_marble.png^blocks_mese_circuitry_side.png"},
	is_ground_content = true,
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:mese_fiber 2"},
			},
			{
				rarity = 2,
				items = {"blocks:mese_fiber"},
			},
			{
				rarity = 1,
				items = {"blocks:marble_chunk 2"},
			},
			{
				rarity = 2,
				items = {"blocks:marble_chunk"},
			},
		},
	},
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("blocks:marble_mese_circuits_under", {
	description = S("Marble with Mese Circuits (Ceiling)"),
	tiles = {"blocks_marble.png", "blocks_marble.png^blocks_mese_circuitry_under.png", "blocks_marble.png"},
	is_ground_content = true,
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
				items = {"blocks:marble_chunk 2"},
			},
			{
				rarity = 2,
				items = {"blocks:marble_chunk 2"},
			},
		},
	},
	groups = {cracky = 3, not_in_creative_inventory = 1},
	sounds = default.node_sound_stone_defaults(),
})
-- Mud
minetest.register_node("blocks:mud", {
	description = S("Mud"),
	tiles = {"blocks_mud.png", "blocks_mud_side.png"},
	is_ground_content = true,
	groups = {crumbly = 3},
	drop = "blocks:mud_lump 4",
	sounds = default.node_sound_dirt_defaults({
		footstep = "",
	}),
})

minetest.register_craftitem("blocks:mud_lump", {
	description = S("Mud Lump"),
	inventory_image = "blocks_mud_lump.png",
})

-- Porphyry
minetest.register_node("blocks:porphyry", {
	description = S("Porphyry"),
	tiles = {"blocks_porphyry.png"},
	is_ground_content = true,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

-- Serpentine
minetest.register_node("blocks:serpentine", {
	description = S("Serpentine"),
	tiles = {"blocks_serpentine.png"},
	is_ground_content = true,
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

-- Slate
minetest.register_node("blocks:slate", {
	description = S("Slate"),
	tiles = {"blocks_slate.png"},
	is_ground_content = true,
	groups = {cracky = 2},
	drop = "blocks:slate_cobble",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("blocks:slate_chunk", {
	description = S("Slate Chunk"),
	inventory_image = "blocks_slate_chunk.png",
})

minetest.register_node("blocks:slate_cobble", {
	description = S("Slate Cobble"),
	tiles = {"blocks_slate_cobble.png"},
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

-- Moonstone

minetest.register_node("blocks:stone_with_moonstone", {
	description = S("Stone with Moonstone"),
	tiles = {"blocks_stone.png^blocks_mineral_moonstone.png"},
	paramtype = "light",
	light_source = default.LIGHT_MAX,
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:moonstone_crystal"},
			},
			{
				rarity = 2,
				items = {"blocks:moonstone_crystal"},
			},
			{
				rarity = 2,
				items = {"blocks:stone_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:stone_chunk 2"},
			},
		},
	},
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("blocks:moonstone_crystal", {
	description = S("Moonstone Crystal"),
	inventory_image = "blocks_moonstone_crystal.png",
})

minetest.register_craftitem("blocks:moonstone_powder", {
	description = S("Moonstone Powder"),
	inventory_image = "blocks_moonstone_powder.png",
})

minetest.register_node("blocks:moonstone", {
	description = S("Moonstone"),
	tiles = {"blocks_moonstone.png"},
	paramtype = "light",
	drawtype = "glasslike",
	use_texture_alpha = "blend",
	light_source = default.LIGHT_MAX,
	groups = {cracky = 3},
	sounds = default.node_sound_glass_defaults(),
})

-- Fossils

blocks.fossil_drop_table = {
	{
		rarity = 1,
		items = {"blocks:bone"},
	},
	{
		rarity = 2,
		items = {"blocks:bone"},
	},
	{
		rarity = 3,
		items = {"blocks:coal_lump"},
	},
	{
		rarity = 3,
		items = {"blocks:iron_lump"},
	},
	{
		rarity = 3,
		items = {"blocks:copper_lump"},
	},
	{
		rarity = 3,
		items = {"blocks:amber_lump"},
	},
	{
		rarity = 3,
		items = {"blocks:tin_lump"},
	},
	{
		rarity = 4,
		items = {"blocks:gold_lump"},
	},
	{
		rarity = 4,
		items = {"blocks:silver_lump"},
	},
	{
		rarity = 5,
		items = {"blocks:coal_lump"},
	},
	{
		rarity = 5,
		items = {"blocks:iron_lump"},
	},
	{
		rarity = 5,
		items = {"blocks:copper_lump"},
	},
	{
		rarity = 5,
		items = {"blocks:amber_lump"},
	},
	{
		rarity = 5,
		items = {"blocks:tin_lump"},
	},
}

minetest.register_node("blocks:dry_dirt_with_fossils", {
	description = S("Dry Dirt with Fossils"),
	tiles = {"blocks_dry_dirt.png^blocks_fossil_overlay.png"},
	drop = {
		items = blocks.fossil_drop_table
	},
	groups = {crumbly = 3, soil = 1},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("blocks:permafrost_with_fossils", {
	description = S("Permafrost with Fossils"),
	tiles = {"blocks_permafrost.png^blocks_fossil_overlay.png"},
	drop = {
		items = blocks.fossil_drop_table
	},
	groups = {cracky = 3},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("blocks:desert_stone_with_fossils", {
	description = S("Desert Stone with Fossils"),
	tiles = {"blocks_desert_stone.png^blocks_fossil_overlay.png"},
	groups = {cracky = 3, stone = 1},
	drop = {
		items = blocks.fossil_drop_table
	},
	sounds = default.node_sound_stone_defaults(),
})

-- Geodes

blocks.geode_drop_table = {
	{
		rarity = 2,
		items = {"blocks:glass_fragments 2"},
	},
	{
		rarity = 3,
		items = {"blocks:amethyst_crystal"},
	},
	{
		rarity = 3,
		items = {"blocks:garnet_crystal"},
	},
	{
		rarity = 4,
		items = {"blocks:mese_crystal"},
	},
	{
		rarity = 4,
		items = {"blocks:diamond"},
	},
	{
		rarity = 4,
		items = {"blocks:glass_fragments 2"},
	},
	{
		rarity = 5,
		items = {"blocks:amethyst_crystal"},
	},
	{
		rarity = 5,
		items = {"blocks:garnet_crystal"},
	},
	{
		rarity = 6,
		items = {"blocks:mese_crystal"},
	},
	{
		rarity = 6,
		items = {"blocks:diamond"},
	},
}

minetest.register_node("blocks:ice_with_geode", {
	description = S("Geode in Ice"),
	tiles = {"blocks_ice.png^blocks_geode_overlay.png"},
	paramtype = "light",
	drop = {
		items = blocks.geode_drop_table
	},
	groups = {cracky = 3, cools_lava = 1, slippery = 3},
	sounds = default.node_sound_ice_defaults(),
})

minetest.register_node("blocks:obsidian_with_geode", {
	description = S("Geode in Obsidian"),
	tiles = {"blocks_obsidian.png^blocks_geode_overlay.png"},
	drop = {
		items = blocks.geode_drop_table
	},
	sounds = default.node_sound_stone_defaults(),
	groups = {cracky = 1, level = 2},
})

-- Mineral salt formerly known as ORS (old red sandstone)
minetest.register_node("blocks:mineral_salt", {
	description = S("Mineral Salt"),
	tiles = {"blocks_mineral_salt.png"},
	is_ground_content = true,
	drop = "blocks:mineral_salt_cobble",
	groups = {crumbly=2,cracky=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("blocks:mineral_salt_chunk", {
	description = S("Mineral Salt Chunk"),
	inventory_image = "blocks_mineral_salt_chunk.png",
})

minetest.register_node("blocks:mineral_salt_cobble", {
	description = S("Mineral Salt Cobble"),
	tiles = {"blocks_mineral_salt_cobble.png"},
	groups = {crumbly=2,cracky=2},
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
	output = "blocks:steelblock",
	recipe = {
		{"blocks:steel_ingot", "blocks:steel_ingot", "blocks:steel_ingot"},
		{"blocks:steel_ingot", "blocks:steel_ingot", "blocks:steel_ingot"},
		{"blocks:steel_ingot", "blocks:steel_ingot", "blocks:steel_ingot"},
	}
})

minetest.register_craft({
	output = "blocks:copperblock",
	recipe = {
		{"blocks:copper_ingot", "blocks:copper_ingot", "blocks:copper_ingot"},
		{"blocks:copper_ingot", "blocks:copper_ingot", "blocks:copper_ingot"},
		{"blocks:copper_ingot", "blocks:copper_ingot", "blocks:copper_ingot"},
	}
})

minetest.register_craft({
	output = "blocks:tinblock",
	recipe = {
		{"blocks:tin_ingot", "blocks:tin_ingot", "blocks:tin_ingot"},
		{"blocks:tin_ingot", "blocks:tin_ingot", "blocks:tin_ingot"},
		{"blocks:tin_ingot", "blocks:tin_ingot", "blocks:tin_ingot"},
	}
})

minetest.register_craft({
	output = "blocks:bronzeblock",
	recipe = {
		{"blocks:bronze_ingot", "blocks:bronze_ingot", "blocks:bronze_ingot"},
		{"blocks:bronze_ingot", "blocks:bronze_ingot", "blocks:bronze_ingot"},
		{"blocks:bronze_ingot", "blocks:bronze_ingot", "blocks:bronze_ingot"},
	}
})

minetest.register_craft({
	output = "blocks:bronze_ingot 9",
	recipe = {
		{"blocks:bronzeblock"},
	}
})

minetest.register_craft({
	output = "blocks:goldblock",
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
	output = "blocks:mese_crystal 9",
	recipe = {
		{"blocks:mese"},
	}
})

minetest.register_craft({
	output = "blocks:mese_crystal",
	recipe = {
		{"blocks:mese_crystal_fragment", "blocks:mese_fiber", "blocks:mese_crystal_fragment"},
		{"blocks:mese_fiber", "", "blocks:mese_fiber"},
		{"blocks:mese_crystal_fragment", "blocks:mese_fiber", "blocks:mese_crystal_fragment"},
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
	output = "blocks:mese_tech_crystal",
	recipe = {
		{"blocks:mese_fiber", "blocks:mese_fiber", "blocks:mese_fiber"},
		{"blocks:mese_fiber", "blocks:mese_fiber", "blocks:mese_fiber"},
		{"blocks:mese_fiber", "blocks:mese_fiber", "blocks:mese_fiber"},
	}
})

minetest.register_craft({
	output = "blocks:mese_fiber 9",
	recipe = {
		{"blocks:mese_tech_crystal"},
	}
})

minetest.register_craft({
	output = "blocks:mese_fragment_skeleton",
	recipe = {
		{"", "blocks:mese_fiber"},
		{"blocks:mese_fiber", ""},
	}
})

minetest.register_craft({
	output = "blocks:mese_crystal_fragment 4",
	recipe = {
		{"blocks:mese_crystal"},
	}
})

minetest.register_craft({
	output = "blocks:steel_ingot 9",
	recipe = {
		{"blocks:steelblock"},
	}
})

minetest.register_craft({
	output = "blocks:tin_ingot 9",
	recipe = {
		{"blocks:tinblock"},
	}
})

minetest.register_craft({
	output = "blocks:amber",
	recipe = {
		{"blocks:amber_shard", "blocks:amber_shard", "blocks:amber_shard"},
		{"blocks:amber_shard", "blocks:amber_shard", "blocks:amber_shard"},
		{"blocks:amber_shard", "blocks:amber_shard", "blocks:amber_shard"},
	}
})
minetest.register_craft({
	output= "blocks:amber_shard 9",
	recipe = {
		{"blocks:amber"},
	}
})
minetest.register_craft({
	output = "blocks:amethyst",
	recipe = {
		{"blocks:amethyst_crystal", "blocks:amethyst_crystal", "blocks:amethyst_crystal"},
		{"blocks:amethyst_crystal", "blocks:amethyst_crystal", "blocks:amethyst_crystal"},
		{"blocks:amethyst_crystal", "blocks:amethyst_crystal", "blocks:amethyst_crystal"},
	}
})
minetest.register_craft({
	output = "blocks:garnet",
	recipe = {
		{"blocks:garnet_crystal", "blocks:garnet_crystal", "blocks:garnet_crystal"},
		{"blocks:garnet_crystal", "blocks:garnet_crystal", "blocks:garnet_crystal"},
		{"blocks:garnet_crystal", "blocks:garnet_crystal", "blocks:garnet_crystal"},
	}
})

minetest.register_craft({
	output = "blocks:amethyst_crystal 9",
	recipe = {
		{"blocks:amethyst"},
	}
})

minetest.register_craft({
	output = "blocks:garnet_crystal 9",
	recipe = {
		{"blocks:garnet"},
	}
})

minetest.register_craft({
	output = "blocks:malachite",
	recipe = {
		{"blocks:malachite_chunk", "blocks:malachite_chunk"},
		{"blocks:malachite_chunk", "blocks:malachite_chunk"},
	}
})

minetest.register_craft({
	output = "blocks:granite",
	recipe = {
		{"blocks:granite_chunk", "blocks:granite_chunk"},
		{"blocks:granite_chunk", "blocks:granite_chunk"},
	}
})

minetest.register_craft({
	output = "blocks:basalt_cobble",
	recipe = {
		{"blocks:basalt_chunk", "blocks:basalt_chunk"},
		{"blocks:basalt_chunk", "blocks:basalt_chunk"},
	}
})

minetest.register_craft({
	output = "blocks:mud",
	recipe = {
		{"blocks:mud_lump", "blocks:mud_lump"},
		{"blocks:mud_lump", "blocks:mud_lump"},
	}
})

minetest.register_craft({
	output = "blocks:marble",
	recipe = {
		{"blocks:marble_chunk", "blocks:marble_chunk"},
		{"blocks:marble_chunk", "blocks:marble_chunk"},
	}
})

minetest.register_craft({
	output = "blocks:slate_cobble",
	recipe = {
		{"blocks:slate_chunk", "blocks:slate_chunk"},
		{"blocks:slate_chunk", "blocks:slate_chunk"},
	}
})

minetest.register_craft({
	output = "blocks:lapis_lazuli",
	recipe = {
		{"blocks:lapis_chunk", "blocks:lapis_chunk"},
		{"blocks:lapis_chunk", "blocks:lapis_chunk"},
	}
})

minetest.register_craft({
	output = "blocks:chalk",
	recipe = {
		{"blocks:chalk_powder", "blocks:chalk_powder"},
		{"blocks:chalk_powder", "blocks:chalk_powder"},
	}
})

minetest.register_craft({
	output = "blocks:chalk_powder 4",
	recipe = {
		{"blocks:chalk"},
	}
})

minetest.register_craft({
	output = "blocks:moonstone",
	recipe = {
		{"blocks:moonstone_crystal", "blocks:moonstone_crystal", "blocks:moonstone_crystal"},
		{"blocks:moonstone_crystal", "blocks:moonstone_crystal", "blocks:moonstone_crystal"},
		{"blocks:moonstone_crystal", "blocks:moonstone_crystal", "blocks:moonstone_crystal"},
	}
})

minetest.register_craft({
	output = "blocks:moonstone_crystal",
	recipe = {
		{"blocks:moonstone_powder", "blocks:moonstone_powder"},
		{"blocks:moonstone_powder", "blocks:moonstone_powder"},
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
	type = "cooking",
	output = "blocks:mese_crystal_fragment",
	recipe = "blocks:mese_fragment_skeleton",
})

minetest.register_craft({
	type = "cooking",
	output = "blocks:amber_shard",
	recipe = "blocks:amber_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "blocks:slate",
	recipe = "blocks:slate_cobble",
})

minetest.register_craft({
	type = "cooking",
	output = "blocks:basalt",
	recipe = "blocks:basalt_cobble",
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
