-- Garnet (stone sub-biome flora)

minetest.register_node("flora:moss_garnet", {
	description = "Red Glowing Moss",
	tiles = {"flora_moss_garnet.png"},
	drawtype = "firelike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	floodable = true,
	buildable_to = true,
    light_source = 4,
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:branches_garnet"},
			},
			{
				rarity = 2,
				items = {"blocks:branches_garnet"},
			},
		},
	},
	groups = {snappy = 3, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-8 / 16, 4/16, -8 / 16, 8 / 16, 8 / 16, 8 / 16},
	}
})

for i=1,5 do
	minetest.register_node("flora:grass_garnet_" .. i, {
		description = "Red Glowing Grass",
		tiles = {"flora_grass_garnet.png^[sheet:5x1:" .. i - 1 .. ",0"},
		drawtype = "plantlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		floodable = true,
		buildable_to = true,
		groups = {grass = 1, snappy = 3, attached_node = 1},
		sounds = default.node_sound_leaves_defaults(),
		drop = {
			items = {
				{
					rarity = 2,
					items = {"blocks:branches_garnet"},
				},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {-8 / 16, -0.5, -8 / 16, 8 / 16, -4 / 16, 8 / 16},
		}
	})

	minetest.register_node("flora:mushroom_garnet_" .. i, {
		description = "Red Glowing Mushroom",
		tiles = {"flora_mushroom_garnet.png^[sheet:5x1:" .. i - 1 .. ",0"},
		drawtype = "plantlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		floodable = true,
		buildable_to = true,
		light_source = 8,
		groups = {mushroom = 1, snappy = 3, attached_node = 1},
		sounds = default.node_sound_leaves_defaults(),
		drop = {
			items = {
				{
					rarity = 2,
					items = {"blocks:branches_garnet 2"},
				},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {-8 / 16, -0.5, -8 / 16, 8 / 16, -4 / 16, 8 / 16},
		}
	})
end

minetest.register_node("flora:plant_garnet", {
	description = "Red Glowing Plant",
	drawtype = "mesh",
	mesh = "flora_plant_garnet.obj",
	tiles = {"flora_plant_garnet.png", "flora_plant_garnet_leaf.png"},
	inventory_image = "flora_plant_garnet_leaf.png",
	wield_image = "flora_plant_garnet_leaf.png",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 8,
	floodable = true,
	sunlight_propagates = true,
	walkable = false,
	use_texture_alpha = "clip",
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:branches_garnet 2"},
			},
			{
				rarity = 2,
				items = {"blocks:branches_garnet 2"},
			},
			{
				rarity = 3,
				items = {"blocks:branches_garnet 2"},
			},
		},
	},
	groups = {snappy = 3, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),

	after_dig_node = function(pos, node, metadata, digger)
		default.dig_up(pos, node, digger)
	end,
})

minetest.register_node("flora:vines_garnet", {
	description = "Vines",
	drawtype = "plantlike",
	tiles = {"flora_vines_garnet.png"},
	inventory_image = "flora_vines_garnet.png",
	wield_image = "flora_vines_garnet.png",
	paramtype = "light",
	light_source = 8,
	floodable = true,
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:branches_garnet"},
			},
			{
				rarity = 2,
				items = {"blocks:branches_garnet"},
			},
		},
	},
	groups = {snappy = 3, flammable = 2, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})

-- Lapis (Hot sub-biome flora)
minetest.register_node("flora:moss_lapis", {
	description = "Blue Glowing Moss",
	tiles = {"flora_moss_lapis.png"},
	drawtype = "firelike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	floodable = true,
	buildable_to = true,
    light_source = 4,
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:mycelium_lapis"},
			},
			{
				rarity = 3,
				items = {"blocks:mycelium_lapis"},
			},
		},
	},
	groups = {snappy = 3, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-8 / 16, 4/16, -8 / 16, 8 / 16, 8 / 16, 8 / 16},
	}
})
for i=1,5 do
	minetest.register_node("flora:grass_lapis_" .. i, {
		description = "Blue Glowing Grass",
		tiles = {"flora_grass_lapis.png^[sheet:5x1:" .. i - 1 .. ",0"},
		drawtype = "plantlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		floodable = true,
		buildable_to = true,
		drop = {
			items = {
				{
					rarity = 1,
					items = {"blocks:mycelium_lapis"},
				},
				{
					rarity = 2,
					items = {"blocks:mycelium_lapis"},
				},
			},
		},
		groups = {grass = 1, snappy = 3, attached_node = 1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-8 / 16, -0.5, -8 / 16, 8 / 16, -4 / 16, 8 / 16},
		}
	})
	minetest.register_node("flora:mushroom_lapis_" .. i, {
		description = "Blue Glowing Mushroom",
		tiles = {"flora_mushroom_lapis.png^[sheet:5x1:" .. i - 1 .. ",0"},
		drawtype = "plantlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		floodable = true,
		light_source = 8,
		drop = {
			items = {
				{
					rarity = 1,
					items = {"blocks:mycelium_lapis 2"},
				},
				{
					rarity = 3,
					items = {"blocks:mycelium_lapis 4"},
				},
			},
		},
		groups = {mushroom = 1, snappy = 3, attached_node = 1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-8 / 16, -0.5, -8 / 16, 8 / 16, -4 / 16, 8 / 16},
		}
	})
end
minetest.register_node("flora:plant_lapis", {
	description = "Blue Glowing Plant",
	drawtype = "mesh",
	mesh = "flora_plant_lapis.obj",
	tiles = {"flora_plant_lapis_mushroom.png", "flora_plant_lapis_1.png", "flora_plant_lapis_2.png"},
	inventory_image = "flora_plant_lapis_mushroom.png",
	wield_image = "flora_plant_lapis_mushroom.png",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 8,
	floodable = true,
	sunlight_propagates = true,
	walkable = false,
	use_texture_alpha = "clip",
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:mycelium_lapis 2"},
			},
			{
				rarity = 2,
				items = {"blocks:mycelium_lapis 4"},
			},
		},
	},
	groups = {snappy = 3, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),

	after_dig_node = function(pos, node, metadata, digger)
		default.dig_up(pos, node, digger)
	end,
})
minetest.register_node("flora:vines_lapis", {
	description = "Vines",
	drawtype = "plantlike",
	tiles = {
		{
			name = "flora_vines_lapis_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		}
	},
	inventory_image = "flora_vines_lapis.png",
	wield_image = "flora_vines_lapis.png",
	paramtype = "light",
	light_source = 8,
	sunlight_propagates = true,
	floodable = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:mycelium_lapis"},
			},
			{
				rarity = 2,
				items = {"blocks:mycelium_lapis 2"},
			},
		},
	},
	groups = {snappy = 3, flammable = 2, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})
-- Mese (deep sub-biome flora)

minetest.register_node("flora:moss_mese", {
	description = "Mese Circuit Moss",
	tiles = {"flora_moss_mese.png"},
	drawtype = "firelike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	floodable = true,
	buildable_to = true,
    light_source = 4,
	visual_scale = 2.0,
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
		},
	},
	groups = {snappy = 3, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-8 / 16, 4/16, -8 / 16, 8 / 16, 8 / 16, 8 / 16},
	}
})
for i=1,5 do
	minetest.register_node("flora:grass_mese_" .. i, {
		description = "Mese Circuit Grass",
		tiles = {"flora_grass_mese.png^[sheet:5x1:" .. i - 1 .. ",0"},
		drawtype = "plantlike",
		paramtype = "light",
		paramtype2 = "meshoptions",
		place_param2 = 1,
		sunlight_propagates = true,
		walkable = false,
		floodable = true,
		buildable_to = true,
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
			},
		},
		groups = {grass = 1, snappy = 3, attached_node = 1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-8 / 16, -0.5, -8 / 16, 8 / 16, -4 / 16, 8 / 16},
		}
	})

	minetest.register_node("flora:flower_mese_" .. i, {
		description = "Mese Circuit Flower",
		tiles = {"flora_flower_mese.png^[sheet:5x1:" .. i - 1 .. ",0"},
		drawtype = "plantlike",
		paramtype = "light",
		paramtype2 = "meshoptions",
		place_param2 = 1,
		sunlight_propagates = true,
		walkable = false,
		floodable = true,
		buildable_to = true,
		visual_scale = 2.0,
		light_source = 8,
		drop = {
			items = {
				{
					rarity = 1,
					items = {"blocks:mese_fiber 2"},
				},
				{
					rarity = 2,
					items = {"blocks:mese_crystal_fragment"},
				},
				{
					rarity = 2,
					items = {"blocks:mese_fiber"},
				},
				{
					rarity = 3,
					items = {"blocks:mese_crystal_fragment"},
				},
			},
		},
		groups = {snappy = 3, attached_node = 1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-8 / 16, -0.5, -8 / 16, 8 / 16, -4 / 16, 8 / 16},
		}
	})
end
--[[
minetest.register_node("flora:plant_garnet", {
	description = "Red Glowing Plant",
	drawtype = "mesh",
	mesh = "flora_plant_garnet.obj",
	tiles = {"flora_plant_garnet.png", "flora_plant_garnet_leaf.png"},
	inventory_image = "flora_plant_garnet_leaf.png",
	wield_image = "flora_plant_garnet_leaf.png",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 8,
	floodable = true,
	sunlight_propagates = true,
	walkable = false,
	use_texture_alpha = "clip",
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	groups = {snappy = 3, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),

	after_dig_node = function(pos, node, metadata, digger)
		default.dig_up(pos, node, digger)
	end,
})]]--
minetest.register_node("flora:vines_mese", {
	description = "Mese Circuit Vines",
	drawtype = "plantlike",
	tiles = {"flora_vines_mese.png"},
	paramtype = "light",
	light_source = 2,
	floodable = true,
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
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
		},
	},
	groups = {snappy = 3, flammable = 2, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})
