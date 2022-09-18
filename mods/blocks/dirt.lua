local S = default.get_translator

minetest.register_node("blocks:dirt", {
	description = S("Dirt"),
	tiles = {"blocks_dirt.png"},
	groups = {crumbly = 3, soil = 1},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("blocks:dirt_with_grass", {
	description = S("Dirt with Grass"),
	tiles = {"blocks_grass.png", "blocks_dirt.png",
		{name = "blocks_dirt.png^blocks_grass_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "blocks:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

minetest.register_node("blocks:dirt_with_grass_footsteps", {
	description = S("Dirt with Grass and Footsteps"),
	tiles = {"blocks_grass.png^blocks_footprint.png", "blocks_dirt.png",
		{name = "blocks_dirt.png^blocks_grass_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, not_in_creative_inventory = 1},
	drop = "blocks:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

minetest.register_node("blocks:dirt_with_dry_grass", {
	description = S("Dirt with Savanna Grass"),
	tiles = {"blocks_dry_grass.png",
		"blocks_dirt.png",
		{name = "blocks_dirt.png^blocks_dry_grass_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "blocks:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.4},
	}),
})

minetest.register_node("blocks:dirt_with_rainforest_litter", {
	description = S("Dirt with Rainforest Litter"),
	tiles = {
		"blocks_rainforest_litter.png",
		"blocks_dirt.png",
		{name = "blocks_dirt.png^blocks_rainforest_litter_side.png",
			tileable_vertical = false}
	},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "blocks:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.4},
	}),
})

minetest.register_node("blocks:dirt_with_coniferous_litter", {
	description = S("Dirt with Coniferous Litter"),
	tiles = {
		"blocks_coniferous_litter.png",
		"blocks_dirt.png",
		{name = "blocks_dirt.png^blocks_coniferous_litter_side.png",
			tileable_vertical = false}
	},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "blocks:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.4},
	}),
})

minetest.register_node("blocks:dry_dirt", {
	description = S("Dry Dirt"),
	tiles = {"blocks_dry_dirt.png"},
	groups = {crumbly = 3, soil = 1},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("blocks:dry_dirt_with_dry_grass", {
	description = S("Dry Dirt with Savanna Grass"),
	tiles = {"blocks_dry_grass.png", "blocks_dry_dirt.png",
		{name = "blocks_dry_dirt.png^blocks_dry_grass_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1},
	drop = "blocks:dry_dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.4},
	}),
})

minetest.register_node("blocks:chalk_with_grass", {
	description = S("Chalk with Grass"),
	tiles = {"blocks_grass.png^[colorize:#dfdcd7:40", "blocks_chalk.png",
		{name = "blocks_chalk.png^blocks_grass_side.png^[colorize:#dfdcd7:40",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "blocks:chalk_powder 4",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

minetest.register_node("blocks:dark_dirt", {
	description = "Dark Dirt",
	tiles = {"blocks_dark_dirt.png"},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

-- Crafts
minetest.register_craft({
	output = "blocks:dark_dirt 2",
	recipe = {
		{"blocks:dirt"},
		{"blocks:fine_gravel"}
	}
})