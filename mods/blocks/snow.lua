local S = default.get_translator

minetest.register_node("blocks:snow", {
	description = S("Snow"),
	tiles = {"blocks_snow.png"},
	inventory_image = "blocks_snowball.png",
	wield_image = "blocks_snowball.png",
	paramtype = "light",
	buildable_to = true,
	floodable = true,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -6 / 16, 0.5},
		},
	},
	groups = {crumbly = 3, falling_node = 1, snowy = 1, loot = 2},
	sounds = default.node_sound_snow_defaults(),

	on_construct = function(pos)
		pos.y = pos.y - 1
		if minetest.get_node(pos).name == "blocks:dirt_with_grass" then
			minetest.set_node(pos, {name = "blocks:dirt_with_snow"})
		end
	end,
})

minetest.register_node("blocks:snowblock", {
	description = S("Snow Block"),
	tiles = {"blocks_snow.png"},
	groups = {crumbly = 3, cools_lava = 1, snowy = 1, loot = 3},
	sounds = default.node_sound_snow_defaults(),

	on_construct = function(pos)
		pos.y = pos.y - 1
		if minetest.get_node(pos).name == "blocks:dirt_with_grass" then
			minetest.set_node(pos, {name = "blocks:dirt_with_snow"})
		end
	end,
})

minetest.register_node("blocks:dirt_with_snow", {
	description = S("Dirt with Snow"),
	tiles = {"blocks_snow.png", "blocks_dirt.png",
		{name = "blocks_dirt.png^blocks_snow_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1, snowy = 1},
	drop = "blocks:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_snow_footstep", gain = 0.2},
	}),
})

-- 'is ground content = false' to avoid tunnels in sea ice or ice rivers
minetest.register_node("blocks:ice", {
	description = S("Ice"),
	tiles = {"blocks_ice.png"},
	is_ground_content = false,
	paramtype = "light",
	groups = {cracky = 3, cools_lava = 1, slippery = 3, loot = 2},
	sounds = default.node_sound_ice_defaults(),
})

-- Mapgen-placed ice with 'is ground content = true' to contain tunnels
minetest.register_node("blocks:cave_ice", {
	description = S("Cave Ice"),
	tiles = {"blocks_ice.png"},
	paramtype = "light",
	groups = {cracky = 3, cools_lava = 1, slippery = 3,
		not_in_creative_inventory = 1},
	drop = "blocks:ice",
	sounds = default.node_sound_ice_defaults(),
})

minetest.register_node("blocks:cracked_ice", {
	description = S("Cracked Ice"),
	tiles = {"blocks_cracked_ice.png"},
	is_ground_content = true,
	paramtype = "light",
	drop = "blocks:ice",
	groups = {cracky = 3, cools_lava = 1, slippery = 3, loot = 3},
	sounds = default.node_sound_ice_defaults(),
})

minetest.register_node("blocks:permafrost", {
	description = S("Permafrost"),
	tiles = {"blocks_permafrost.png"},
	groups = {cracky = 3},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("blocks:permafrost_with_stones", {
	description = S("Permafrost with Stones"),
	tiles = {"blocks_permafrost.png^blocks_stones.png",
		"blocks_permafrost.png",
		"blocks_permafrost.png^blocks_stones_side.png"},
	groups = {cracky = 3},
	sounds = default.node_sound_gravel_defaults(),
})

minetest.register_node("blocks:permafrost_with_moss", {
	description = S("Permafrost with Moss"),
	tiles = {"blocks_moss.png", "blocks_permafrost.png",
		{name = "blocks_permafrost.png^blocks_moss_side.png",
			tileable_vertical = false}},
	drop = "blocks:permafrost",
	groups = {cracky = 3},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

minetest.register_node("blocks:permafrost_with_bone_roots", {
	description = S("Permafrost with Bone Roots"),
	tiles = {"blocks_permafrost.png^flora_bone_roots.png",
		"blocks_permafrost.png",
		"blocks_permafrost.png^flora_bone_roots_side.png"},
	drop = "blocks:permafrost",
	groups = {cracky = 3},
	sounds = default.node_sound_gravel_defaults(),
})

minetest.register_node("blocks:permafrost_with_snow", {
	description = S("Permafrost with Snow"),
	tiles = {"blocks_coniferous_litter.png^blocks_patchy_snow.png", "blocks_permafrost.png",
		"(blocks_permafrost.png^blocks_coniferous_litter_side.png)^blocks_patchy_snow_side.png"},
	drop = "blocks:permafrost",
	groups = {cracky = 3},
	sounds = default.node_sound_snow_defaults({
		footstep = {name = "default_snow_footstep", gain = 0.5},
	}),
})

--
-- == CRAFTS
--

minetest.register_craft({
	output = "blocks:snowblock",
	recipe = {
		{"blocks:snow", "blocks:snow", "blocks:snow"},
		{"blocks:snow", "blocks:snow", "blocks:snow"},
		{"blocks:snow", "blocks:snow", "blocks:snow"},
	}
})

minetest.register_craft({
	output = "blocks:snow 9",
	recipe = {
		{"blocks:snowblock"},
	}
})