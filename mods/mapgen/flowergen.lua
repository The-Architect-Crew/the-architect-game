flowers = {}

-- Flower spread
-- Public function to enable override by mods

function flowers.flower_spread(pos, node)
	pos.y = pos.y - 1
	local under = minetest.get_node(pos)
	pos.y = pos.y + 1
	-- Replace flora with dry shrub in desert sand and silver sand,
	-- as this is the only way to generate them.
	-- However, preserve grasses in sand dune biomes.
	if minetest.get_item_group(under.name, "sand") == 1 and under.name ~= "blocks:sand" then
		minetest.set_node(pos, { name = "flora:dry_shrub" })
		return
	end

	if minetest.get_item_group(under.name, "soil") == 0 then
		return
	end

	local light = minetest.get_node_light(pos)
	if not light or light < 13 then
		return
	end

	local pos0 = vector.subtract(pos, 4)
	local pos1 = vector.add(pos, 4)
	-- Testing shows that a threshold of 3 results in an appropriate maximum
	-- density of approximately 7 flora per 9x9 area.
	if #minetest.find_nodes_in_area(pos0, pos1, "group:flora") > 3 then
		return
	end

	local soils = minetest.find_nodes_in_area_under_air(pos0, pos1, "group:soil")
	local num_soils = #soils
	if num_soils >= 1 then
		for si = 1, math.min(3, num_soils) do
			local soil = soils[math.random(num_soils)]
			local soil_name = minetest.get_node(soil).name
			local soil_above = { x = soil.x, y = soil.y + 1, z = soil.z }
			light = minetest.get_node_light(soil_above)
			if
				light
				and light >= 13
				-- Only spread to same surface node
				and soil_name == under.name
				-- Desert sand is in the soil group
				and soil_name ~= "blocks:desert_sand"
			then
				minetest.set_node(soil_above, { name = node.name })
			end
		end
	end
end

minetest.register_abm({
	label = "Flower spread",
	nodenames = { "group:flora" },
	interval = 13,
	chance = 300,
	action = function(...)
		flowers.flower_spread(...)
	end,
})

-- Mushroom spread and death

function flowers.mushroom_spread(pos, node)
	if minetest.get_node_light(pos, 0.5) > 3 then
		if minetest.get_node_light(pos, nil) == 15 then
			minetest.remove_node(pos)
		end
		return
	end
	local positions = minetest.find_nodes_in_area_under_air(
		{ x = pos.x - 1, y = pos.y - 2, z = pos.z - 1 },
		{ x = pos.x + 1, y = pos.y + 1, z = pos.z + 1 },
		{ "group:soil", "group:tree" }
	)
	if #positions == 0 then
		return
	end
	local pos2 = positions[math.random(#positions)]
	pos2.y = pos2.y + 1
	if minetest.get_node_light(pos2, 0.5) <= 3 then
		minetest.set_node(pos2, { name = node.name })
	end
end

minetest.register_abm({
	label = "Mushroom spread",
	nodenames = { "group:mushroom" },
	interval = 11,
	chance = 150,
	action = function(...)
		flowers.mushroom_spread(...)
	end,
})

--
-- == Flower mapgen
--

local function register_mgv6_flower(flower_name)
	minetest.register_decoration({
		name = "flora:" .. flower_name,
		deco_type = "simple",
		place_on = { "blocks:dirt_with_grass" },
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.006,
			spread = { x = 100, y = 100, z = 100 },
			seed = 436,
			octaves = 3,
			persist = 0.6,
		},
		y_max = 30,
		y_min = 1,
		decoration = "flora:" .. flower_name,
	})
end

local function register_mgv6_mushroom(mushroom_name)
	minetest.register_decoration({
		name = "flora:" .. mushroom_name,
		deco_type = "simple",
		place_on = { "blocks:dirt_with_grass" },
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.04,
			spread = { x = 100, y = 100, z = 100 },
			seed = 7133,
			octaves = 3,
			persist = 0.6,
		},
		y_max = 30,
		y_min = 1,
		decoration = "flora:" .. mushroom_name,
		spawn_by = "blocks:tree",
		num_spawn_by = 1,
	})
end

local function register_mgv6_waterlily()
	minetest.register_decoration({
		name = "flora:waterlily",
		deco_type = "simple",
		place_on = { "blocks:dirt" },
		sidelen = 16,
		noise_params = {
			offset = -0.12,
			scale = 0.3,
			spread = { x = 100, y = 100, z = 100 },
			seed = 33,
			octaves = 3,
			persist = 0.7,
		},
		y_max = 0,
		y_min = 0,
		decoration = "flora:waterlily_waving",
		param2 = 0,
		param2_max = 3,
		place_offset_y = 1,
	})
end

function flowers.register_mgv6_decorations()
	register_mgv6_flower("rose")
	register_mgv6_flower("tulip")
	register_mgv6_flower("dandelion_yellow")
	register_mgv6_flower("geranium")
	register_mgv6_flower("viola")
	register_mgv6_flower("dandelion_white")

	register_mgv6_mushroom("mushroom_brown")
	register_mgv6_mushroom("mushroom_red")

	register_mgv6_waterlily()
end

--
-- All other biome API mapgens
--

local function register_flower(seed, flower_name)
	minetest.register_decoration({
		name = "flora:" .. flower_name,
		deco_type = "simple",
		place_on = { "blocks:dirt_with_grass" },
		sidelen = 16,
		noise_params = {
			offset = -0.02,
			scale = 0.04,
			spread = { x = 200, y = 200, z = 200 },
			seed = seed,
			octaves = 3,
			persist = 0.6,
		},
		biomes = { "grassland", "deciduous_forest" },
		y_max = 31000,
		y_min = 1,
		decoration = "flora:" .. flower_name,
	})
end

local function register_mushroom(mushroom_name)
	minetest.register_decoration({
		name = "flora:" .. mushroom_name,
		deco_type = "simple",
		place_on = { "blocks:dirt_with_grass", "blocks:dirt_with_coniferous_litter" },
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.006,
			spread = { x = 250, y = 250, z = 250 },
			seed = 2,
			octaves = 3,
			persist = 0.66,
		},
		biomes = { "deciduous_forest", "coniferous_forest" },
		y_max = 31000,
		y_min = 1,
		decoration = "flora:" .. mushroom_name,
	})
end

local function register_waterlily()
	minetest.register_decoration({
		name = "flora:waterlily",
		deco_type = "simple",
		place_on = { "blocks:dirt" },
		sidelen = 16,
		noise_params = {
			offset = -0.12,
			scale = 0.3,
			spread = { x = 200, y = 200, z = 200 },
			seed = 33,
			octaves = 3,
			persist = 0.7,
		},
		biomes = { "rainforest_swamp", "savanna_shore", "deciduous_forest_shore" },
		y_max = 0,
		y_min = 0,
		decoration = "flora:waterlily_waving",
		param2 = 0,
		param2_max = 3,
		place_offset_y = 1,
	})
end

function flowers.register_decorations()
	register_flower(436, "rose")
	register_flower(19822, "tulip")
	register_flower(1220999, "dandelion_yellow")
	register_flower(800081, "chrysanthemum_green")
	register_flower(36662, "geranium")
	register_flower(1133, "viola")
	register_flower(73133, "dandelion_white")
	register_flower(42, "tulip_black")

	register_mushroom("mushroom_brown")
	register_mushroom("mushroom_red")

	register_waterlily()
end

--
-- Detect mapgen to select functions
--

local mg_name = minetest.get_mapgen_setting("mg_name")
if mg_name == "v6" then
	flowers.register_mgv6_decorations()
else
	flowers.register_decorations()
end
