-- Mushroom Biome

minetest.register_node("flora:azure_trunk", {
	description = "Azure Mushroom Trunk",
	tiles = {"flora_azure_trunk_top.png", "flora_azure_trunk_top.png",
		"flora_azure_trunk.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {mushroom = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})
minetest.register_node("flora:azure_cap", {
	description = "Azure Mushroom Cap",
	tiles = {"flora_azure_cap.png"},
	is_ground_content = false,
	groups = {mushroom = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_node("flora:azure_gills", {
	description = "Azure Mushroom Gills",
	tiles = {"flora_azure_gills.png"},
	paramtype = "light",
	is_ground_content = false,
    light_source = 8,
	groups = {mushroom = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})

minetest.register_node("flora:fireshroom_trunk", {
	description = "Big Fireshroom Mushroom Trunk",
	tiles = {"flora_fireshroom_trunk_top.png", "flora_fireshroom_trunk_top.png",
		"flora_fireshroom_trunk.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {mushroom = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})
minetest.register_node("flora:fireshroom_cap", {
	description = "Big Fireshroom Cap",
	tiles = {"flora_fireshroom_cap.png"},
	is_ground_content = false,
	paramtype = "light",
	light_source = 8,
	groups = {mushroom = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_node("flora:fireshroom_gills", {
	description = "Big Fireshroom Gills",
	tiles = {"flora_fireshroom_gills.png"},
	is_ground_content = false,
	groups = {mushroom = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})

minetest.register_node("flora:viridis_trunk", {
	description = "Viridis Mushroom Trunk",
	tiles = {"flora_viridis_trunk_top.png", "flora_viridis_trunk_top.png",
		"flora_viridis_trunk.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
    light_source = 4,
	groups = {mushroom = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})
minetest.register_node("flora:viridis_cap", {
	description = "Viridis Mushroom Cap",
	tiles = {"flora_viridis_cap.png"},
	is_ground_content = false,
	paramtype = "light",
    light_source = 6,
	groups = {mushroom = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_node("flora:viridis_gills", {
	description = "Viridis Mushroom Gills",
	tiles = {"flora_viridis_gills.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
    light_source = 8,
	groups = {mushroom = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})
minetest.register_node("flora:viridis_cilia", {
	description = "Viridis Mushroom Cilia",
	tiles = {"flora_viridis_cilia.png"},
    drawtype = "mesh",
    mesh = "mushroom_cilia_small.obj",
	is_ground_content = false,
    light_source = 8,
	groups = {mushroom = 1, snappy = 3, oddly_breakable_by_hand = 1, flammable = 3},
    selection_box = {
        type = "fixed",
        fixed = {-8/16, 4/16, -8/16, 8/16, 8/18, 8/16}
    },
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:dark_trunk", {
	description = "Dark Mushroom Trunk",
	tiles = {"flora_dark_trunk_top.png", "flora_dark_trunk_top.png",
		"flora_dark_trunk.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {mushroom = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})
minetest.register_node("flora:dark_cap", {
	description = "Dark Mushroom Cap",
	tiles = {"flora_dark_cap.png"},
	is_ground_content = false,
	paramtype = "light",
	light_source = 2,
	groups = {mushroom = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_node("flora:dark_cap_spike", {
	description = "Dark Mushroom Cap",
	tiles = {"flora_dark_cap.png", "flora_dark_cap_spike_bottom.png", "flora_dark_cap_spike_side.png"},
	is_ground_content = false,
	drop = "flora:dark_cap",
	paramtype = "light",
	light_source = 2,
	groups = {mushroom = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_node("flora:dark_gills", {
	description = "Dark Mushroom Gills",
	tiles = {"flora_dark_gills.png"},
	is_ground_content = false,
	paramtype = "light",
	light_source = 4,
	groups = {mushroom = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_node("flora:dark_spike", {
	description = "Dark Mushroom Spike",
	drawtype = "plantlike",
	tiles = {"flora_dark_spike.png"},
	is_ground_content = false,
	sunlight_propagates = true,
	paramtype = "light",
	groups = {mushroom = 1, choppy = 3, attached_node = 1, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("flora:mushroom_grass_1", {
	description = "Mushroom Grass",
	drawtype = "plantlike",
	waving = 1,
	tiles = {"flora_mushroom_grass.png^[sheet:5x1:0,0"},
	inventory_image = "flora_mushroom_grass.png^[sheet:5x1:0,0",
	wield_image = "flora_mushroom_grass.png^[sheet:5x1:0,0",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	floodable = true,
	buildable_to = true,
	groups = {snappy = 3, flora = 1, attached_node = 1, grass = 1,
		normal_grass = 1, flammable = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -5 / 16, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random grass node
		local stack = ItemStack("flora:mushroom_grass_" .. math.random(1,5))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("flora:mushroom_grass_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 5 do
	minetest.register_node("flora:mushroom_grass_" .. i, {
		description = "Mushroom Grass",
		drawtype = "plantlike",
		waving = 1,
		tiles = {"flora_mushroom_grass.png^[sheet:5x1:" .. i-1 .. ",0"},
		inventory_image = "flora_mushroom_grass.png^[sheet:5x1:" .. i-1 .. ",0",
		wield_image = "flora_mushroom_grass.png^[sheet:5x1:" .. i-1 .. ",0",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		floodable = true,
		buildable_to = true,
		drop = "flora:mushroom_grass_1",
		groups = {snappy = 3, flora = 1, attached_node = 1,
			not_in_creative_inventory = 1, grass = 1,
			normal_grass = 1, flammable = 1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -3 / 16, 6 / 16},
		},
	})
end

minetest.register_node("flora:mushroom_grass_tall_1", {
	description = "Tall Mushroom Grass",
	drawtype = "mesh",
	mesh = "flora_grass_tall.obj",
	waving = 1,
	tiles = {"flora_mushroom_grass_tall.png^[sheet:5x1:0,0"},
	inventory_image = "flora_mushroom_grass_tall.png^[sheet:5x1:0,0",
	wield_image = "flora_mushroom_grass_tall.png^[sheet:5x1:0,0",
	paramtype = "light",
	light_source = 4,
	sunlight_propagates = true,
	walkable = false,
	floodable = true,
	buildable_to = true,
	groups = {snappy = 3, flora = 1, attached_node = 1, grass = 1,
		normal_grass = 1, flammable = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -5 / 16, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random grass node
		local stack = ItemStack("flora:mushroom_grass_tall_" .. math.random(1,5))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("flora:mushroom_grass_tall_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 5 do
	minetest.register_node("flora:mushroom_grass_tall_" .. i, {
		description = "Tall Mushroom Grass",
		drawtype = "mesh",
		mesh = "flora_grass_tall.obj",
		waving = 1,
		tiles = {"flora_mushroom_grass_tall.png^[sheet:5x1:" .. i-1 .. ",0"},
		inventory_image = "flora_mushroom_grass_tall.png^[sheet:5x1:" .. i-1 .. ",0",
		wield_image = "flora_mushroom_grass_tall.png^[sheet:5x1:" .. i-1 .. ",0",
		paramtype = "light",
		light_source = 4,
		sunlight_propagates = true,
		walkable = false,
		floodable = true,
		buildable_to = true,
		drop = "flora:mushroom_grass_tall_1",
		groups = {snappy = 3, flora = 1, attached_node = 1,
			not_in_creative_inventory = 1, grass = 1,
			normal_grass = 1, flammable = 1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -3 / 16, 6 / 16},
		},
	})
end
