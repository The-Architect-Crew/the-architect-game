--
-- Underground Decorations
--

-- support for MT game translation.
local S = default.get_translator

minetest.register_node("blocks:cobble_firemoss", {
	description = S("Cobblestone with Firemoss"),
	tiles = {"blocks_cobble.png^blocks_firemoss_overlay.png", "blocks_cobble.png", "blocks_cobble.png^blocks_firemoss_overlay_side.png"},
	groups = {cracky = 3, stone = 2},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:stone_chunk 2"},
			},
			{
				rarity = 2,
				items = {"blocks:firebranches"},
			},
			{
				rarity = 2,
				items = {"blocks:stone_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:firebranches"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:desert_cobble_azure", {
	description = S("Desert Cobblestone with Azure Moss"),
	tiles = {"blocks_desert_cobble.png^blocks_azure_moss_overlay.png", "blocks_desert_cobble.png", "blocks_desert_cobble.png^blocks_azure_moss_overlay_side.png"},
	is_ground_content = false,
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:desert_stone_chunk 2"},
			},
			{
				rarity = 2,
				items = {"blocks:azure_mycelia"},
			},
			{
				rarity = 2,
				items = {"blocks:desert_stone_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:azure_mycelia"},
			},
		},
	},
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:stone_icy", {
	description = S("Icy Stone"),
	tiles = {"blocks_stone_icy.png"},
	groups = {cracky = 3, stone = 1},
	drop = "blocks:cobble",
	sounds = default.node_sound_ice_defaults(),
})

minetest.register_node("blocks:stone_mese_circuits", {
	description = S("Stone with Mese Circuits"),
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
	description = S("Stone with Mese Circuits (Ceiling)"),
	tiles = {"blocks_stone.png", "blocks_stone.png^blocks_mese_circuitry_under.png", "blocks_stone.png"},
	groups = {cracky = 3, stone = 1, not_in_creative_inventory = 1},
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

minetest.register_node("blocks:sand_azure", {
	description = S("Sand with Azure Moss"),
	tiles = {"blocks_azure_moss_overlay.png", "blocks_sand.png", "blocks_sand.png^blocks_azure_moss_overlay_side.png"},
	groups = {crumbly = 3, sand = 1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("blocks:desert_sand_azure", {
	description = S("Desert Sand with Azure Moss"),
	tiles = {"blocks_azure_moss_overlay.png", "blocks_desert_sand.png", "blocks_desert_sand.png^blocks_azure_moss_overlay_side.png"},
	groups = {crumbly = 3, sand = 1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("blocks:silver_sand_azure", {
	description = S("Silver Sand with Azure Moss"),
	tiles = {"blocks_azure_moss_overlay.png", "blocks_silver_sand.png", "blocks_silver_sand.png^blocks_azure_moss_overlay_side.png"},
	groups = {crumbly = 3, sand = 1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("blocks:dry_dirt_azure", {
	description = S("Dry Dirt with Azure Moss"),
	tiles = {"blocks_azure_moss_overlay.png", "blocks_dry_dirt.png", "blocks_dry_dirt.png^blocks_azure_moss_overlay_side.png"},
	drop = "blocks:dry_dirt",
	groups = {crumbly = 3, soil = 1},
	sounds = default.node_sound_dirt_defaults(),
 })