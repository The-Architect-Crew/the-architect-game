-- Garnet (stone sub-biome flora)

minetest.register_node("flora:moss_garnet", {
	description = "Red Glowing Moss",
	tiles = {"flora_moss_garnet.png"},
	drawtype = "firelike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
    light_source = 4,
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
		buildable_to = true,
		groups = {grass = 1, snappy = 3, attached_node = 1},
		sounds = default.node_sound_leaves_defaults(),
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
		buildable_to = true,
		light_source = 8,
		groups = {mushroom = 1, snappy = 3, attached_node = 1},
		sounds = default.node_sound_leaves_defaults(),
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
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
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
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	groups = {snappy = 3, flammable = 2, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})

-- Amethyst (sand[stone] (and ice) sub-biome flora)
minetest.register_node("flora:mushroom_amethyst", {
	description = "Violet Glowing Mushroom",
	tiles = {"flora_mushroom_amethyst.png"},
	drawtype = "plantlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
    light_source = 8,
	groups = {mushroom = 1, snappy = 3, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-8 / 16, -0.5, -8 / 16, 8 / 16, -4 / 16, 8 / 16},
	}
})
minetest.register_node("flora:moss_amethyst", {
	description = "Violet Glowing Moss",
	tiles = {"flora_moss_amethyst.png"},
	drawtype = "firelike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
    light_source = 4,
	groups = {snappy = 3, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-8 / 16, 4/16, -8 / 16, 8 / 16, 8 / 16, 8 / 16},
	}
})
for i=1,5 do
	minetest.register_node("flora:grass_amethyst_" .. i, {
		description = "Violet Glowing Grass",
		tiles = {"flora_grass_amethyst.png^[sheet:5x1:" .. i - 1 .. ",0"},
		drawtype = "plantlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {grass = 1, snappy = 3, attached_node = 1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-8 / 16, -0.5, -8 / 16, 8 / 16, -4 / 16, 8 / 16},
		}
	})
end--[[
minetest.register_node("flora:plant_amethyst", {
	description = "Red Glowing Plant",
	drawtype = "mesh",
	mesh = "flora_plant_garnet.obj",
	tiles = {"flora_plant_amethyst.png", "flora_plant_amethyst_leaf.png"},
	inventory_image = "flora_plant_amethyst_leaf.png",
	wield_image = "flora_plant_amethyst_leaf.png",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 8,
	sunlight_propagates = true,
	walkable = false,
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
minetest.register_node("flora:vines_amethyst", {
	description = "Vines",
	drawtype = "plantlike",
	tiles = {
		{
			name = "flora_vines_amethyst_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		}
	},
	inventory_image = "flora_vines_amethyst.png",
	wield_image = "flora_vines_amethyst.png",
	paramtype = "light",
	light_source = 8,
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	groups = {snappy = 3, flammable = 2, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})
-- Mese (deep sub-biome flora)