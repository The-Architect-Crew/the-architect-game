local S = default.get_translator

minetest.register_node("flora:cactus", {
	description = S("Cactus"),
	tiles = {"flora_cactus_top.png", "flora_cactus_top.png",
		"flora_cactus_side.png"},
	paramtype2 = "facedir",
	groups = {choppy = 3},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	after_dig_node = function(pos, node, metadata, digger)
		default.dig_up(pos, node, digger)
	end,
})

minetest.register_node("flora:large_cactus_seedling", {
	description = S("Large Cactus Seedling"),
	drawtype = "plantlike",
	tiles = {"flora_large_cactus_seedling.png"},
	inventory_image = "flora_large_cactus_seedling.png",
	wield_image = "flora_large_cactus_seedling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {
			-5 / 16, -0.5, -5 / 16,
			5 / 16, 0.5, 5 / 16
		}
	},
	groups = {choppy = 3, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_wood_defaults(),

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = flora.sapling_on_place(itemstack, placer, pointed_thing,
			"flora:large_cactus_seedling",
			{x = -2, y = -1, z = -2},
			{x = 2, y = 5, z = 2},
			4)

		return itemstack
	end,

	on_construct = function(pos)
		-- Normal cactus farming adds 1 cactus node by ABM,
		-- interval 12s, chance 83.
		-- Consider starting with 5 cactus nodes. We make sure that growing a
		-- large cactus is not a faster way to produce new cactus nodes.
		-- Confirmed by experiment, when farming 5 cacti, on average 1 new
		-- cactus node is added on average every
		-- 83 / 5 = 16.6 intervals = 16.6 * 12 = 199.2s.
		-- Large cactus contains on average 14 cactus nodes.
		-- 14 * 199.2 = 2788.8s.
		-- Set random range to average to 2789s.
		minetest.get_node_timer(pos):start(math.random(1859, 3719))
	end,

	on_timer = function(pos)
		local node_under = minetest.get_node_or_nil(
			{x = pos.x, y = pos.y - 1, z = pos.z})
		if not node_under then
			-- Node under not yet loaded, try later
			minetest.get_node_timer(pos):start(300)
			return
		end

		if minetest.get_item_group(node_under.name, "sand") == 0 then
			-- Seedling dies
			minetest.remove_node(pos)
			return
		end

		local light_level = minetest.get_node_light(pos)
		if not light_level or light_level < 13 then
			-- Too dark for growth, try later in case it's night
			minetest.get_node_timer(pos):start(300)
			return
		end

		minetest.log("action", "A large cactus seedling grows into a large" ..
			"cactus at ".. minetest.pos_to_string(pos))
		flora.grow_large_cactus(pos)
	end,
})

minetest.register_node("flora:papyrus", {
	description = S("Papyrus"),
	drawtype = "plantlike",
	tiles = {"flora_papyrus.png"},
	inventory_image = "flora_papyrus.png",
	wield_image = "flora_papyrus.png",
	paramtype = "light",
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

--
-- Papyrus and cactus growing
--

-- Wrapping the functions in ABM action is necessary to make overriding them possible

function flora.grow_cactus(pos, node)
	if node.param2 >= 4 then
		return
	end
	pos.y = pos.y - 1
	if minetest.get_item_group(minetest.get_node(pos).name, "sand") == 0 then
		return
	end
	pos.y = pos.y + 1
	local height = 0
	while node.name == "flora:cactus" and height < 4 do
		height = height + 1
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	if height == 4 or node.name ~= "air" then
		return
	end
	if minetest.get_node_light(pos) < 13 then
		return
	end
	minetest.set_node(pos, {name = "flora:cactus"})
	return true
end

function flora.grow_papyrus(pos, node)
	pos.y = pos.y - 1
	local name = minetest.get_node(pos).name
	if name ~= "blocks:dirt" and
			name ~= "blocks:dirt_with_grass" and
			name ~= "blocks:dirt_with_dry_grass" and
			name ~= "blocks:dirt_with_rainforest_litter" and
			name ~= "blocks:dry_dirt" and
			name ~= "blocks:dry_dirt_with_dry_grass" then
		return
	end
	if not minetest.find_node_near(pos, 3, {"group:water"}) then
		return
	end
	pos.y = pos.y + 1
	local height = 0
	while node.name == "flora:papyrus" and height < 4 do
		height = height + 1
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	if height == 4 or node.name ~= "air" then
		return
	end
	if minetest.get_node_light(pos) < 13 then
		return
	end
	minetest.set_node(pos, {name = "flora:papyrus"})
	return true
end

minetest.register_abm({
	label = "Grow cactus",
	nodenames = {"flora:cactus"},
	neighbors = {"group:sand"},
	interval = 12,
	chance = 83,
	action = function(...)
		flora.grow_cactus(...)
	end
})

minetest.register_abm({
	label = "Grow papyrus",
	nodenames = {"flora:papyrus"},
	-- Grows on the dirt and surface dirt nodes of the biomes papyrus appears in,
	-- including the old savanna nodes.
	-- 'default:dirt_with_grass' is here only because it was allowed before.
	neighbors = {
		"blocks:dirt",
		"blocks:dirt_with_grass",
		"blocks:dirt_with_dry_grass",
		"blocks:dirt_with_rainforest_litter",
		"blocks:dry_dirt",
		"blocks:dry_dirt_with_dry_grass",
	},
	interval = 14,
	chance = 71,
	action = function(...)
		flora.grow_papyrus(...)
	end
})


minetest.register_node("flora:dry_shrub", {
	description = S("Dry Shrub"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"flora_dry_shrub.png"},
	inventory_image = "flora_dry_shrub.png",
	wield_image = "flora_dry_shrub.png",
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 4,
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 4 / 16, 6 / 16},
	},
})
for i=1,5 do
	minetest.register_node("flora:junglegrass_" .. i, {
		description = S("Jungle Grass"),
		drawtype = "plantlike",
		waving = 1,
		visual_scale = 1.69,
		tiles = {"flora_junglegrass.png^[sheet:5x1:" .. i-1 .. ",0"},
		inventory_image = "flora_junglegrass.png^[sheet:5x1:" .. i-1 .. ",0",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flora = 1, attached_node = 1, grass = 1, junglegrass = 1, flammable = 1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
		},
	})
end


minetest.register_node("flora:grass_1", {
	description = S("Grass"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"flora_grass_1.png"},
	-- Use texture of a taller grass stage in inventory
	inventory_image = "flora_grass_3.png",
	wield_image = "flora_grass_3.png",
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
		local stack = ItemStack("flora:grass_" .. math.random(1,5))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("flora:grass_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 5 do
	minetest.register_node("flora:grass_" .. i, {
		description = S("Grass"),
		drawtype = "plantlike",
		waving = 1,
		tiles = {"flora_grass_" .. i .. ".png"},
		inventory_image = "flora_grass_" .. i .. ".png",
		wield_image = "flora_grass_" .. i .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		floodable = true,
		buildable_to = true,
		drop = "flora:grass_1",
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


minetest.register_node("flora:dry_grass_1", {
	description = S("Savanna Grass"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"flora_dry_grass.png^[sheet:5x1:0,0"},
	inventory_image = "flora_dry_grass.png^[sheet:5x1:0,0",
	visual_scale = 2,
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, flora = 1,
		attached_node = 1, grass = 1, dry_grass = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -3 / 16, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random dry grass node
		local stack = ItemStack("flora:dry_grass_" .. math.random(1, 5))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("flora:dry_grass_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 5 do
	minetest.register_node("flora:dry_grass_" .. i, {
		description = S("Savanna Grass"),
		drawtype = "plantlike",
		waving = 1,
		tiles = {"flora_dry_grass.png^[sheet:5x1:" .. i-1 .. ",0"},
		inventory_image = "flora_dry_grass.png^[sheet:5x1:" .. i-1 .. ",0",
		visual_scale = 2,
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 3, flora = 1, attached_node = 1,
			not_in_creative_inventory = 1, grass = 1, dry_grass = 1},
		drop = "flora:dry_grass_1",
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -1 / 16, 6 / 16},
		},
	})
end


minetest.register_node("flora:fern_1", {
	description = S("Fern"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"flora_fern_1.png"},
	inventory_image = "flora_fern_1.png",
	wield_image = "flora_fern_1.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, flora = 1, grass = 1,
		fern = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random fern node
		local stack = ItemStack("flora:fern_" .. math.random(1, 3))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("flora:fern_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 3 do
	minetest.register_node("flora:fern_" .. i, {
		description = S("Fern"),
		drawtype = "plantlike",
		waving = 1,
		visual_scale = 2,
		tiles = {"flora_fern_" .. i .. ".png"},
		inventory_image = "flora_fern_" .. i .. ".png",
		wield_image = "flora_fern_" .. i .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 3, flora = 1, attached_node = 1,
			grass = 1, fern = 1, not_in_creative_inventory = 1},
		drop = "flora:fern_1",
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
		},
	})
end


minetest.register_node("flora:marram_grass_1", {
	description = S("Marram Grass"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"flora_marram_grass_1.png"},
	inventory_image = "flora_marram_grass_1.png",
	wield_image = "flora_marram_grass_1.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, flora = 1, grass = 1, marram_grass = 1,
		attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random marram grass node
		local stack = ItemStack("flora:marram_grass_" .. math.random(1, 3))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("flora:marram_grass_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 3 do
	minetest.register_node("flora:marram_grass_" .. i, {
		description = S("Marram Grass"),
		drawtype = "plantlike",
		waving = 1,
		tiles = {"flora_marram_grass_" .. i .. ".png"},
		inventory_image = "flora_marram_grass_" .. i .. ".png",
		wield_image = "flora_marram_grass_" .. i .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 3, flora = 1, attached_node = 1,
			grass = 1, marram_grass = 1, not_in_creative_inventory = 1},
		drop = "flora:marram_grass_1",
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
		},
	})
end

minetest.register_node("flora:tundra_grass_red", {
	description = S("Red Tundra Grass"),
	drawtype = "plantlike",
	waving = 1,
	paramtype2 = "meshoptions",
	place_param2 = 4,
	tiles = {"flora_tundra_grass_red.png"},
	inventory_image = "flora_tundra_grass_red.png",
	wield_image = "flora_tundra_grass_red.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-8 / 16, -0.5, -8 / 16, 8 / 16, -6 / 16, 8 / 16},
	},
})
minetest.register_node("flora:tundra_grass_yellow", {
	description = S("Yellow Tundra Grass"),
	drawtype = "plantlike",
	waving = 1,
	paramtype2 = "meshoptions",
	place_param2 = 4,
	tiles = {"flora_tundra_grass_yellow.png"},
	inventory_image = "flora_tundra_grass_yellow.png",
	wield_image = "flora_tundra_grass_yellow.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-8 / 16, -0.5, -8 / 16, 8 / 16, -6 / 16, 8 / 16},
	},
})

--
-- == CRAFTS
--

minetest.register_craft({
	output = "flora:large_cactus_seedling",
	recipe = {
		{"", "flora:cactus", ""},
		{"flora:cactus", "flora:cactus", "flora:cactus"},
		{"", "flora:cactus", ""},
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "flora:cactus",
	burntime = 15,
})

minetest.register_craft({
	type = "fuel",
	recipe = "flora:large_cactus_seedling",
	burntime = 5,
})

minetest.register_craft({
	type = "fuel",
	recipe = "flora:papyrus",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "flora:grass_1",
	burntime = 2,
})

minetest.register_craft({
	type = "fuel",
	recipe = "flora:dry_grass_1",
	burntime = 2,
})

minetest.register_craft({
	type = "fuel",
	recipe = "flora:fern_1",
	burntime = 2,
})

minetest.register_craft({
	type = "fuel",
	recipe = "flora:marram_grass_1",
	burntime = 2,
})

minetest.register_craft({
	type = "fuel",
	recipe = "flora:dry_shrub",
	burntime = 2,
})
