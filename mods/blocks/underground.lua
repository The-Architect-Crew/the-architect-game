--
-- Underground Decorations
--

-- support for MT game translation.
local S = default.get_translator

minetest.register_node("blocks:stone_icy", {
	description = S("Icy Stone"),
	tiles = {"blocks_stone_icy.png"},
	groups = {cracky = 3, stone = 1},
	drop = "blocks:desert_cobble",
	sounds = default.node_sound_ice_defaults(),
})

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

minetest.register_node("blocks:cobble_firemoss_ceiling", {
	description = S("Cobblestone with Firemoss (Ceiling)"),
	tiles = {"blocks_cobble.png", "blocks_cobble.png^blocks_firemoss_overlay.png", "blocks_cobble.png^blocks_firemoss_ceiling_overlay.png"},
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

minetest.register_node("blocks:stone_firemoss", {
	description = S("Stone with Firemoss"),
	tiles = {"blocks_stone.png^blocks_firemoss_overlay.png", "blocks_stone.png", "blocks_stone.png^blocks_firemoss_overlay_side.png"},
	groups = {cracky = 3, stone = 1},
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

minetest.register_node("blocks:stone_firemoss_ceiling", {
	description = S("Stone with Firemoss (Ceiling)"),
	tiles = {"blocks_stone.png", "blocks_stone.png^blocks_firemoss_overlay.png", "blocks_stone.png^blocks_firemoss_ceiling_overlay.png"},
	groups = {cracky = 3, stone = 1},
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

minetest.register_node("blocks:desert_cobble_firemoss", {
	description = S("Cobblestone with Firemoss"),
	tiles = {"blocks_desert_cobble.png^blocks_firemoss_overlay.png", "blocks_desert_cobble.png", "blocks_desert_cobble.png^blocks_firemoss_overlay_side.png"},
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

minetest.register_node("blocks:desert_cobble_firemoss_ceiling", {
	description = S("Cobblestone with Firemoss (Ceiling)"),
	tiles = {"blocks_desert_cobble.png", "blocks_desert_cobble.png^blocks_firemoss_overlay.png", "blocks_desert_cobble.png^blocks_firemoss_ceiling_overlay.png"},
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

minetest.register_node("blocks:desert_stone_firemoss", {
	description = S("Desert Stone with Firemoss"),
	tiles = {"blocks_desert_stone.png^blocks_firemoss_overlay.png", "blocks_desert_stone.png", "blocks_desert_stone.png^blocks_firemoss_overlay_side.png"},
	groups = {cracky = 3, stone = 1},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:desert_stone_chunk 2"},
			},
			{
				rarity = 2,
				items = {"blocks:firebranches"},
			},
			{
				rarity = 2,
				items = {"blocks:desert_stone_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:firebranches"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:desert_stone_firemoss_ceiling", {
	description = S("Desert Stone with Firemoss (Ceiling)"),
	tiles = {"blocks_desert_stone.png", "blocks_desert_stone.png^blocks_firemoss_overlay.png", "blocks_desert_stone.png^blocks_firemoss_ceiling_overlay.png"},
	groups = {cracky = 3, stone = 1},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:desert_stone_chunk 2"},
			},
			{
				rarity = 2,
				items = {"blocks:firebranches"},
			},
			{
				rarity = 2,
				items = {"blocks:desert_stone_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:firebranches"},
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
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
minetest.register_node("blocks:stone_mese_circuits_ceiling", {
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

minetest.register_node("blocks:sand_azure_ceiling", {
	description = S("Sand with Azure Moss (Ceiling)"),
	tiles = {"blocks_sand.png", "blocks_azure_moss_overlay.png", "blocks_sand.png^blocks_azure_moss_ceiling_overlay.png"},
	groups = {crumbly = 3, sand = 1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("blocks:desert_sand_azure", {
	description = S("Desert Sand with Azure Moss"),
	tiles = {"blocks_azure_moss_overlay.png", "blocks_desert_sand.png", "blocks_desert_sand.png^blocks_azure_moss_overlay_side.png"},
	groups = {crumbly = 3, sand = 1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("blocks:desert_sand_azure_ceiling", {
	description = S("Desert Sand with Azure Moss (Ceiling)"),
	tiles = {"blocks_desert_sand.png", "blocks_azure_moss_overlay.png", "blocks_desert_sand.png^blocks_azure_moss_ceiling_overlay.png"},
	groups = {crumbly = 3, sand = 1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("blocks:silver_sand_azure", {
	description = S("Silver Sand with Azure Moss"),
	tiles = {"blocks_azure_moss_overlay.png", "blocks_silver_sand.png", "blocks_silver_sand.png^blocks_azure_moss_overlay_side.png"},
	groups = {crumbly = 3, sand = 1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("blocks:silver_sand_azure_ceiling", {
	description = S("Silver Sand with Azure Moss (Ceiling)"),
	tiles = {"blocks_silver_sand.png", "blocks_azure_moss_overlay.png", "blocks_silver_sand.png^blocks_azure_moss_ceiling_overlay.png"},
	groups = {crumbly = 3, sand = 1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("blocks:sandstone_azure", {
	description = S("Sandstone with Azure Moss"),
	tiles = {"blocks_azure_moss_overlay.png", "blocks_sandstone.png", "blocks_sandstone.png^blocks_azure_moss_overlay_side.png"},
	groups = {crumbly = 1, cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:sandstone_azure_ceiling", {
	description = S("Sandstone with Azure Moss (Ceiling)"),
	tiles = {"blocks_sandstone.png", "blocks_azure_moss_overlay.png", "blocks_sandstone.png^blocks_azure_moss_ceiling_overlay.png"},
	groups = {crumbly = 1, cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:desert_sandstone_azure", {
	description = S("Desert Sandstone with Azure Moss"),
	tiles = {"blocks_azure_moss_overlay.png", "blocks_desert_sandstone.png", "blocks_desert_sandstone.png^blocks_azure_moss_overlay_side.png"},
	groups = {crumbly = 1, cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:desert_sandstone_azure_ceiling", {
	description = S("Desert Sandstone with Azure Moss (Ceiling)"),
	tiles = {"blocks_desert_sandstone.png", "blocks_azure_moss_overlay.png", "blocks_desert_sandstone.png^blocks_azure_moss_ceiling_overlay.png"},
	groups = {crumbly = 1, cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:silver_sandstone_azure", {
	description = S("Silver Sandstone with Azure Moss"),
	tiles = {"blocks_azure_moss_overlay.png", "blocks_silver_sandstone.png", "blocks_silver_sandstone.png^blocks_azure_moss_overlay_side.png"},
	groups = {crumbly = 1, cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:desert_sandstone_azure_ceiling", {
	description = S("Desert Sandstone with Azure Moss (Ceiling)"),
	tiles = {"blocks_desert_sandstone.png", "blocks_azure_moss_overlay.png", "blocks_desert_sandstone.png^blocks_azure_moss_ceiling_overlay.png"},
	groups = {crumbly = 1, cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blocks:ice_azure", {
	description = S("Ice with Azure Moss"),
	tiles = {"blocks_azure_moss_overlay.png", "blocks_ice.png", "blocks_ice.png^blocks_azure_moss_overlay_side.png"},
	is_ground_content = false,
	paramtype = "light",
	groups = {cracky = 3, cools_lava = 1},
	sounds = default.node_sound_ice_defaults(),
})

minetest.register_node("blocks:ice_azure_ceiling", {
	description = S("Ice with Azure Moss (Ceiling)"),
	tiles = {"blocks_ice.png", "blocks_azure_moss_overlay.png", "blocks_ice.png^blocks_azure_moss_ceiling_overlay.png"},
	is_ground_content = false,
	paramtype = "light",
	groups = {cracky = 3, cools_lava = 1, slippery = 3},
	sounds = default.node_sound_ice_defaults(),
})

minetest.register_node("blocks:cracked_ice_azure", {
	description = S("Cracked Ice with Azure Moss"),
	tiles = {"blocks_azure_moss_overlay.png", "blocks_cracked_ice.png", "blocks_cracked_ice.png^blocks_azure_moss_overlay_side.png"},
	is_ground_content = true,
	paramtype = "light",
	drop = "blocks:ice",
	groups = {cracky = 3, cools_lava = 1},
	sounds = default.node_sound_ice_defaults(),
})

minetest.register_node("blocks:cracked_ice_azure_ceiling", {
	description = S("Cracked Ice with Azure Moss (Ceiling)"),
	tiles = {"blocks_cracked_ice.png", "blocks_azure_moss_overlay.png", "blocks_cracked_ice.png^blocks_azure_moss_ceiling_overlay.png"},
	is_ground_content = true,
	paramtype = "light",
	drop = "blocks:ice",
	groups = {cracky = 3, cools_lava = 1, slippery = 3},
	sounds = default.node_sound_ice_defaults(),
})

-- Mushroom Biome

minetest.register_node("blocks:dirt_with_dark_mycelia", {
	description = S("Dirt with Dark Mycelia"),
	tiles = {"blocks_dirt.png^blocks_dark_mycelia.png"},
	groups = {crumbly = 3, soil = 1},
	drop = "blocks:dirt",
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("blocks:dirt_with_viridis_mycelia", {
	description = S("Dirt with Viridis Mycelia"),
	tiles = {"blocks_dirt.png^blocks_viridis_mycelia.png"},
	groups = {crumbly = 3, soil = 1},
	drop = "blocks:dirt",
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("blocks:dirt_with_mycelia", {
	description = S("Dirt with Mycelia"),
	tiles = {"blocks_dirt.png^blocks_mushroom_mycelia.png"},
	groups = {crumbly = 3, soil = 1},
	drop = "blocks:dirt",
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("blocks:dirt_with_dark_grass", {
	description = S("Dirt with Dark Grass"),
	tiles = {"blocks_dark_grass.png", "blocks_dirt.png^blocks_dark_mycelia.png",
		{name = "(blocks_dirt.png^blocks_dark_mycelia.png)^blocks_dark_grass_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "blocks:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

minetest.register_node("blocks:dirt_with_viridis_grass", {
	description = S("Dirt with Viridis Grass"),
	tiles = {"blocks_viridis_grass.png", "blocks_dirt.png^blocks_viridis_mycelia.png",
		{name = "(blocks_dirt.png^blocks_viridis_mycelia.png)^blocks_viridis_grass_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "blocks:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

minetest.register_node("blocks:dirt_with_mushroom_grass", {
	description = S("Dirt with Mushroom Grass"),
	tiles = {"blocks_mushroom_grass.png", "blocks_dirt.png^blocks_mushroom_mycelia.png",
		{name = "(blocks_dirt.png^blocks_mushroom_mycelia.png)^blocks_mushroom_grass_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "blocks:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

minetest.register_node("blocks:dirt_azure_mushroom", {
	description = S("Dirt with Azure Moss"),
	tiles = {"blocks_azure_moss_overlay.png", "blocks_dirt.png^blocks_mushroom_mycelia.png", "(blocks_dirt.png^blocks_mushroom_mycelia.png)^blocks_azure_moss_overlay_side.png"},
	groups = {crumbly = 3, soil = 1},
	drop = "blocks:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.4},
	}),
})

minetest.register_node("blocks:dirt_azure_mushroom_ceiling", {
	description = S("Dirt with Azure Moss (Ceiling)"),
	tiles = {"blocks_dirt.png^blocks_mushroom_mycelia.png", "blocks_azure_moss_overlay.png", "(blocks_dirt.png^blocks_mushroom_mycelia.png)^blocks_azure_moss_ceiling_overlay.png"},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "blocks:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.4},
	}),
})

minetest.register_node("blocks:dirt_firemoss_mushroom", {
	description = S("Dirt with Firemoss"),
	tiles = {"blocks_firemoss_overlay.png", "blocks_dirt.png^blocks_mushroom_mycelia.png", "(blocks_dirt.png^blocks_mushroom_mycelia.png)^blocks_firemoss_overlay_side.png"},
	groups = {crumbly = 3, soil = 1},
	drop = "blocks:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.4},
	}),
})

minetest.register_node("blocks:dirt_firemoss_mushroom_ceiling", {
	description = S("Dirt with Firemoss (Ceiling)"),
	tiles = {"blocks_dirt.png^blocks_mushroom_mycelia.png", "blocks_firemoss_overlay.png", "(blocks_dirt.png^blocks_mushroom_mycelia.png)^blocks_firemoss_ceiling_overlay.png"},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "blocks:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.4},
	}),
})