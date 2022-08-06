-- Garnet (stone sub-biome flora)

minetest.register_node("flora:firemoss", {
	description = "Firemoss\n\"Glows in the dark\"",
	tiles = {"flora_firemoss.png"},
	inventory_image = "flora_firemoss.png",
	drawtype = "firelike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	floodable = true,
    light_source = 4,
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:firebranches"},
			},
			{
				rarity = 2,
				items = {"blocks:firebranches"},
			},
		},
	},
	groups = {snappy = 3},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-8 / 16, 4/16, -8 / 16, 8 / 16, 8 / 16, 8 / 16},
	}
})

for i=1,5 do
	minetest.register_node("flora:firegrass_" .. i, {
		description = "Firegrass\n\"Burning to the touch\"",
		tiles = {"flora_firegrass.png^[sheet:5x1:" .. i - 1 .. ",0"},
		inventory_image = "flora_firegrass.png^[sheet:5x1:" .. i - 1 .. ",0",
		drawtype = "plantlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		floodable = true,
		groups = {grass = 1, snappy = 3},
		sounds = default.node_sound_leaves_defaults(),
		drop = {
			items = {
				{
					rarity = 2,
					items = {"blocks:firebranches"},
				},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {-8 / 16, -0.5, -8 / 16, 8 / 16, -4 / 16, 8 / 16},
		}
	})

	minetest.register_node("flora:fireshroom_" .. i, {
		description = "Fireshroom\n\"Actually not poisonous\"",
		tiles = {"flora_fireshroom.png^[sheet:5x1:" .. i - 1 .. ",0"},
		inventory_image = "flora_fireshroom.png^[sheet:5x1:" .. i - 1 .. ",0",
		drawtype = "plantlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		floodable = true,
		light_source = 8,
		groups = {mushroom = 1, snappy = 3},
		sounds = default.node_sound_leaves_defaults(),
		drop = {
			items = {
				{
					rarity = 2,
					items = {"blocks:firebranches 2"},
				},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {-8 / 16, -0.5, -8 / 16, 8 / 16, -4 / 16, 8 / 16},
		}
	})
end

minetest.register_node("flora:fireplant", {
	description = "Fireplant\n\"Of unknown origins...\"",
	drawtype = "mesh",
	mesh = "flora_fireplant.obj",
	tiles = {"flora_fireplant.png", "flora_fireplant_leaf.png"},
	inventory_image = "flora_fireplant_leaf.png",
	wield_image = "flora_fireplant_leaf.png",
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
				items = {"blocks:firebranches 2"},
			},
			{
				rarity = 2,
				items = {"blocks:firebranches 2"},
			},
			{
				rarity = 3,
				items = {"blocks:firebranches 2"},
			},
		},
	},
	groups = {snappy = 3, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
	after_dig_node = function(pos, node, metadata, digger)
		local nn = node.name
		ccore.dig_dir(pos, {nn}, -1, digger)
	end
})

minetest.register_node("flora:firevines", {
	description = "Firevines",
	drawtype = "plantlike",
	tiles = {"flora_firevine.png"},
	inventory_image = "flora_firevine.png",
	wield_image = "flora_firevine.png",
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
				items = {"blocks:firebranches"},
			},
			{
				rarity = 2,
				items = {"blocks:firebranches"},
			},
		},
	},
	groups = {snappy = 3, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
	after_dig_node = function(pos, node, metadata, digger)
		local nn = node.name
		ccore.dig_dir(pos, {nn}, -1, digger)
	end
})

-- Lapis (Hot sub-biome flora)
minetest.register_node("flora:azure_moss", {
	description = "Azure Moss",
	tiles = {"flora_azure_moss.png"},
	inventory_image = "flora_azure_moss.png",
	drawtype = "firelike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	floodable = true,
    light_source = 4,
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:azure_mycelium"},
			},
			{
				rarity = 3,
				items = {"blocks:azure_mycelium"},
			},
		},
	},
	groups = {snappy = 3},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-8 / 16, 4/16, -8 / 16, 8 / 16, 8 / 16, 8 / 16},
	}
})
for i=1,5 do
	minetest.register_node("flora:azure_grass_" .. i, {
		description = "Azure Grass",
		tiles = {"flora_azure_grass.png^[sheet:5x1:" .. i - 1 .. ",0"},
		inventory_image = "flora_azure_grass.png^[sheet:5x1:" .. i - 1 .. ",0",
		drawtype = "plantlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		floodable = true,
		drop = {
			items = {
				{
					rarity = 1,
					items = {"blocks:azure_mycelium"},
				},
				{
					rarity = 2,
					items = {"blocks:azure_mycelium"},
				},
			},
		},
		groups = {grass = 1, snappy = 3},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-8 / 16, -0.5, -8 / 16, 8 / 16, -4 / 16, 8 / 16},
		}
	})
	minetest.register_node("flora:azureshroom_" .. i, {
		description = "Azureshroom\n\"Kinda hard to pronounce\"",
		tiles = {"flora_azureshroom.png^[sheet:5x1:" .. i - 1 .. ",0"},
		inventory_image = "flora_azureshroom.png^[sheet:5x1:" .. i - 1 .. ",0",
		drawtype = "plantlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		floodable = true,
		light_source = 8,
		drop = {
			items = {
				{
					rarity = 1,
					items = {"blocks:azure_mycelium 2"},
				},
				{
					rarity = 3,
					items = {"blocks:azure_mycelium 4"},
				},
			},
		},
		groups = {mushroom = 1, snappy = 3},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-8 / 16, -0.5, -8 / 16, 8 / 16, -4 / 16, 8 / 16},
		}
	})
end
minetest.register_node("flora:azure_plant", {
	description = "Azure Mushroom Colony",
	drawtype = "mesh",
	mesh = "flora_azure_plant.obj",
	tiles = {"flora_azure_plant_mushroom.png", "flora_azure_plant_1.png", "flora_azure_plant_2.png"},
	inventory_image = "flora_azure_plant_mushroom.png",
	wield_image = "flora_azure_plant_mushroom.png",
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
				items = {"blocks:azure_mycelium 2"},
			},
			{
				rarity = 2,
				items = {"blocks:azure_mycelium 4"},
			},
		},
	},
	groups = {snappy = 3, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
	after_dig_node = function(pos, node, metadata, digger)
		local nn = node.name
		ccore.dig_dir(pos, {nn}, -1, digger)
	end
})
minetest.register_node("flora:azure_vines", {
	description = "Azure Vines\n\"Shiny!\"",
	drawtype = "plantlike",
	tiles = {
		{
			name = "flora_azure_vines_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		}
	},
	inventory_image = "flora_azure_vines.png",
	wield_image = "flora_azure_vines.png",
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
				items = {"blocks:azure_mycelium"},
			},
			{
				rarity = 2,
				items = {"blocks:azure_mycelium 2"},
			},
		},
	},
	groups = {snappy = 3, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
	after_dig_node = function(pos, node, metadata, digger)
		local nn = node.name
		ccore.dig_dir(pos, {nn}, -1, digger)
	end
})
-- Mese (deep sub-biome flora)

minetest.register_node("flora:moss_mese", {
	description = "Mese Circuit Moss\n\"Science can't say if it is a plant, actually\"",
	tiles = {"flora_moss_mese.png"},
	inventory_image = "flora_moss_mese.png",
	drawtype = "firelike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	floodable = true,
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
	groups = {snappy = 3},
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
		inventory_image = "flora_grass_mese.png^[sheet:5x1:" .. i - 1 .. ",0",
		drawtype = "plantlike",
		paramtype = "light",
		paramtype2 = "meshoptions",
		place_param2 = 1,
		sunlight_propagates = true,
		walkable = false,
		floodable = true,
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
		groups = {grass = 1, snappy = 3},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-8 / 16, -0.5, -8 / 16, 8 / 16, -4 / 16, 8 / 16},
		}
	})

	minetest.register_node("flora:flower_mese_" .. i, {
		description = "Mese Circuit Flower",
		tiles = {"flora_flower_mese.png^[sheet:5x1:" .. i - 1 .. ",0"},
		inventory_image = "flora_flower_mese.png^[sheet:5x1:" .. i - 1 .. ",0",
		drawtype = "plantlike",
		paramtype = "light",
		paramtype2 = "meshoptions",
		place_param2 = 1,
		sunlight_propagates = true,
		walkable = false,
		floodable = true,
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
		groups = {snappy = 3},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-8 / 16, -0.5, -8 / 16, 8 / 16, -4 / 16, 8 / 16},
		}
	})
end

minetest.register_node("flora:vines_mese", {
	description = "Mese Circuit Vines",
	drawtype = "plantlike",
	tiles = {"flora_vines_mese.png"},
	inventory_image = "flora_vines_mese.png",
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
	groups = {snappy = 3, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
	after_dig_node = function(pos, node, metadata, digger)
		local nn = node.name
		ccore.dig_dir(pos, {nn}, -1, digger)
	end
})
