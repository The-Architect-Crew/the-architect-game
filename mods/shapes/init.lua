shapes = {}
-- Cubic shapes
local nodebox_list = {
	-- description, name, nodebox, cost, sunlight_propagates
	-- Slabs
	{ "Slab (1/16)", 	"slab1", 	{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},	1, true },
	{ "Slab (2/16)", 	"slab2", 	{-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},	1, true },
	{ "Slab (4/16)", 	"slab4", 	{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}, 	2, true },
	{ "Slab", 			"slab", 	{-0.5, -0.5, -0.5, 0.5, 0, 0.5}, 		4, true },
	{ "Slab (12/16)", 	"slab12",	{-0.5, -0.5, -0.5, 0.5, 0.25, 0.5}, 	6, true },
	-- Cubes
	{ "Cube (1/16)", 	"cube1", 	{-0.5, -0.5, 0, 0, -0.4375, 0.5}, 		1, true },
	{ "Cube (2/16)", 	"cube2", 	{-0.5, -0.5, 0, 0, -0.375, 0.5}, 		1, true },
	{ "Cube (4/16)", 	"cube4", 	{-0.5, -0.5, 0, 0, -0.25, 0.5}, 		1, true },
	{ "Cube", 			"cube", 	{-0.5, -0.5, 0, 0, 0, 0.5}, 			1, true },
	{ "Cube (12/16)", 	"cube12", 	{-0.5, -0.5, 0, 0, 0.25, 0.5}, 			2, true },
	-- Steps
	{ "Step (1/16)", 	"step1", 	{-0.5, -0.5, 0, 0.5, -0.4375, 0.5}, 	1, true },
	{ "Step (2/16)", 	"step2", 	{-0.5, -0.5, 0, 0.5, -0.375, 0.5}, 		1, true },
	{ "Step (4/16)", 	"step4", 	{-0.5, -0.5, 0, 0.5, -0.25, 0.5}, 		1, true },
	{ "Step", 			"step", 	{-0.5, -0.5, 0, 0.5, 0, 0.5}, 			2, true },
	{ "Step (12/16)", 	"step12", 	{-0.5, -0.5, 0, 0.5, 0.25, 0.5}, 		3, true },
	-- Stairs
	{ "Left Halfstair", 	"halfstair", 		{{-0.5, -0.5, -0.5, 0, 0, 0.5},{-0.5, 0, 0, 0, 0.5, 0.5},}, 								3, true},
	{ "Right Halfstair", 	"righthalfstair", 	{{0, -0.5, -0.5, 0.5, 0, 0.5},	{0, 0, 0, 0.5, 0.5, 0.5},}, 								3, true},
	{ "Outerstair", 		"outerstair", 		{{-0.5, -0.5, -0.5, 0.5, 0, 0.5},{-0.5, 0, 0, 0, 0.5, 0.5},}, 								5, true},
	{ "Stair", 				"stair", 			{{-0.5, -0.5, -0.5, 0.5, 0, 0.5},{-0.5, 0, 0, 0.5, 0.5, 0.5},}, 							6, true},
	{ "Innerstair", 		"innerstair", 		{{-0.5, -0.5, -0.5, 0.5, 0, 0.5},{-0.5, 0, 0, 0.5, 0.5, 0.5},{-0.5, 0, -0.5, 0, 0.5, 0},}, 	7, false},
	-- Split Stairs
	{ "Splitstair (1/16)", 	"splitstair1", 		{{-0.5, -0.0625, -0.5, 0.5, 0, 0},	{-0.5, 0.4375, 0, 0.5, 0.5, 0.5},}, 					1, true},
	{ "Splitstair (4/16)", 	"splitstair4", 		{{-0.5, -0.25, -0.5, 0.5, 0, 0},	{-0.5, 0.25, 0, 0.5, 0.5, 0.5},}, 						2, true},
	{ "Splitstair", 		"splitstair", 		{{-0.5, -0.5, -0.5, 0.5, 0, 0},		{-0.5, 0, 0, 0.5, 0.5, 0.5},}, 							4, true},
	{ "Forkstair", 			"forkstair", 		{{-0.5, -0.5, 0, 0, 0.5, 0.5},{0, -0.5, 0, 0.5, 0, 0.5},{-0.5, -0.5, -0.5, 0, 0, 0}}, 		4, true},
	-- Pole/pillar
	{ "Pole", 			"pole", 		{-1/8, -1/2, -1/8, 1/8, 1/2, 1/8},	2, true},
	{ "Pillar", 		"pillar", 		{-1/4, -1/2, -1/4, 1/4, 1/2, 1/4}, 	4, true},
	{ "Wall-Pillar", 	"wallpillar", 	{-1/4, -1/2, 0, 1/4, 1/2, 1/2},		4, true},
	{ "Half-Pillar", 	"halfpillar", 	{-1/4, -1/2, 1/2, 1/4, 1/2, 1/4}, 	2, true},
	--{ "Pillar Top",	 		"pillartop",	 	{{-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},{-0.5, 0.25, -0.5, 0.5, 0.5, 0.5},{-0.375, 0, -0.375, 0.375, 0.5, 0.375},},		6, true},
	{ "Pillar Crown", 		"pillarcrown", 		{{-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},{-0.375, -0.5, -0.375, 0.375, 0, 0.375},}, 	6, true},
	--{ "Half-Pillar Top", 	"halfpillartop", 	{{-0.25, -0.5, 0.25, 0.25, 0.5, 0.5},{-0.5, 0.25, 0, 0.5, 0.5, 0.5},{-0.375, 0, 0.125, 0.375, 0.5, 0.5},},				3, true},
	{ "Half-Pillar Crown", "halfpillarcrown", 	{{-0.25, -0.5, 0.25, 0.25, 0.5, 0.5},{-0.5, -0.5, 0, 0.5, -0.25, 0.5},{-0.375, -0.5, 0.125, 0.375, 0, 0.5},}, 			3, true},
	{ "Wall-Pillar Crown", "wallpillarcrown", 	{{-0.25, -0.5, 0, 0.25, 0.5, 0.5},{-0.5, -0.5, -0.25, 0.5, -0.25, 0.5},{-0.375, -0.5, -0.125, 0.375, 0, 0.5},}, 		5, true},
	-- Beams
	{ "Crossbeam", 		"crossbeam", 		{{-0.25, -0.5, -0.5, 0.25, 0, 0.5}, {-0.5, -0.5, -0.25, 0.5, 0, 0.25},},		4, true},
	{ "Beam", 			"beam", 			{-0.25, -0.5, -0.5, 0.25, 0, 0.5},												2, true},
	{ "Linkdown", 		"linkdown", 		{{-0.25, 0, -0.5, 0.25, 0.5, 0.5},{-0.125, -0.5, -0.125, 0.125, 0, 0.125},{-0.1875, -0.5, -0.1875, 0.1875, -0.375, 0.1875}, {-0.1875, -0.125, -0.1875, 0.1875, 0, 0.1875},},	4, true},
	{ "Crosslink", 		"crosslink", 		{{-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},{-0.5, -0.5, -0.25, 0.5, -0, 0.25},{-0.25, -0.5, -0.5, 0.25, -0, 0.5},{-0.4375, -0.4375, -0.4375, 0.4375, -0.0625, 0.4375},},			7, true},
	-- Corners
	{ "Corner (1/16)", 	"corner1",	{{-0.5, -0.5, -0.5, 0, -0.4375, 0.5}, {0, -0.5, 0, 0.5, -0.4375, -0.5}}, 1, true},
	{ "Corner (2/16)", 	"corner2", 	{{-0.5, -0.5, -0.5, 0, -0.375, 0.5}, {0, -0.5, 0, 0.5, -0.375, -0.5}}, 1, true},
	{ "Corner (4/16)", 	"corner4", 	{{-0.5, -0.5, -0.5, 0, -0.25, 0.5}, {0, -0.5, 0, 0.5, -0.25, -0.5}}, 2, true},
	{ "Corner", 		"corner",	{{-0.5, -0.5, -0.5, 0, 0, 0.5}, {0, -0.5, 0, 0.5, 0, -0.5}}, 3, true},
	{ "Corner (12/16)", "corner12", {{-0.5, -0.5, -0.5, 0, 0.25, 0.5}, {0, -0.5, 0, 0.5, 0.25, -0.5}}, 5, true},
}

-- Model-based shapes
local model_list = {
	{ "Sphere", "sphere", "shapes_sphere.obj", 7},
	-- Slopes
	{ "Slope", "slope", "shapes_slope.obj", 4},
	{ "Slope (1/2)", "slope2", "shapes_slope_half.obj", 2},
	{ "Slope (3/4)", "slope3", "shapes_slope_half_raised.obj", 4},
	-- Innerslopes
	{ "Innerslope", "innerslope", "shapes_slope_inner.obj", 4},
	{ "Innerslope (1/2)", "innerslope2", "shapes_slope_inner_half.obj", 2},
	{ "Innerslope (3/4)", "innerslope3", "shapes_slope_inner_half_raised.obj", 4},
	-- Cut innerslopes
	{ "Cut Innerslope", "cutinnerslope", "shapes_slope_inner_cut.obj", 4},
	{ "Cut Innerslope (1/2)", "cutinnerslope2", "shapes_slope_inner_cut_half.obj", 2},
	{ "Cut Innerslope (3/4)", "cutinnerslope3", "shapes_slope_inner_cut_half_raised.obj", 4},
	-- Outerslopes
	{ "Outerslope", "outerslope", "shapes_slope_outer.obj", 4},
	{ "Outerslope (1/2)", "outerslope2", "shapes_slope_outer_half.obj", 2},
	{ "Outerslope (3/4)", "outerslope3", "shapes_slope_outer_half_raised.obj", 4},
	-- Cut outerslopes
	{ "Cut Outerslope", "cutouterslope", "shapes_slope_outer_cut.obj", 4},
	{ "Cut Outerslope (1/2)", "cutouterslope2", "shapes_slope_outer_cut_half.obj", 2},
	{ "Cut Outerslope (3/4)", "cutouterslope3", "shapes_slope_outer_cut_half_raised.obj", 4},
	{ "Cut Outerslope (4/2)", "cutotherslope4", "shapes_slope_cut.obj", 4},
}

shapes.rotate_node = function(itemstack, placer, pointed_thing)
	minetest.rotate_and_place(itemstack, placer, pointed_thing,
		minetest.settings:get_bool("creative_mode") or creative.is_enabled_for(placer:get_player_name()),
		{invert_wall = placer:get_player_control().sneak})
	local pos = pointed_thing.above
	minetest.check_single_for_falling(pos)
	return itemstack
end

local is_disabled = function(disabled, name)
	local disabled2 = ", "..disabled..", "
	local output = string.find(disabled2, ", "..name..", ")
	if name == "sphere" then
		if output ~= nil then
			return true
		elseif output == nil then
			return false
		end
	end
	if output ~= nil then
		return false
	elseif output == nil then
		return true
	end
end

--=== PANES FUCTIONALITY ===
-- Obtained from minetest-game/panes
-- [ https://github.com/minetest/minetest_game/tree/master/mods/xpanes ]
-- Credit to original authors

local function is_pane(pos)
	return minetest.get_item_group(minetest.get_node(pos).name, "pane") > 0
end

local function connects_dir(pos, name, dir)
	local aside = vector.add(pos, minetest.facedir_to_dir(dir))
	if is_pane(aside) then return true end

	local connects_to = minetest.registered_nodes[name].connects_to
	if not connects_to then return false end

	local list = minetest.find_nodes_in_area(aside, aside, connects_to)
	if #list > 0 then return true end
	return false
end

local function swap(pos, node, name, param2)
	if node.name == name and node.param2 == param2 then return end
	minetest.set_node(pos, {name = name, param2 = param2})
end

local function update_pane(pos)
	if not is_pane(pos) then return end
	local node = minetest.get_node(pos)
	local name = node.name
	if name:sub(-5) == "_flat" then
		name = name:sub(1, -6)
	end

	local any = node.param2
	local c = {}
	local count = 0
	for dir = 0, 3 do
		c[dir] = connects_dir(pos, name, dir)
		if c[dir] then
			any = dir
			count = count + 1
		end
	end

	if count == 0 then
		swap(pos, node, name .. "_flat", any)
	elseif count == 1 then
		swap(pos, node, name .. "_flat", (any + 1) % 4)
	elseif count == 2 then
		if (c[0] and c[2]) or (c[1] and c[3]) then
			swap(pos, node, name .. "_flat", (any + 1) % 4)
		else
			swap(pos, node, name, 0)
		end
	else
		swap(pos, node, name, 0)
	end
end

minetest.register_on_placenode(function(pos, node)
	if minetest.get_item_group(node, "pane") then
		update_pane(pos)
	end
	for i = 0, 3 do
		local dir = minetest.facedir_to_dir(i)
		update_pane(vector.add(pos, dir))
	end
end)

minetest.register_on_dignode(function(pos)
	for i = 0, 3 do
		local dir = minetest.facedir_to_dir(i)
		update_pane(vector.add(pos, dir))
	end
end)

function shapes:register_shapes(name, def)
	def = def or {}
	local disabled = def.disabled or ""
	local sname = string.match(name, ':(.*)')
	local mname = string.match(name, '(.*):')
	local itemmeta = minetest.registered_items[name]
	if itemmeta == nil then
		minetest.log("error", "[shapes] "..name.." does not exist!")
		return
	end
	local n_group = def.groups or itemmeta.groups
	local r_group = table.copy(n_group)
	r_group.not_in_creative_inventory = 1
	local stexture = def.texture or itemmeta.tiles[1]
	-- Registering nodebox shapes
	for i in ipairs(nodebox_list) do
		local tdesc = nodebox_list[i][1]
		local tname = nodebox_list[i][2]
		local tnobo = nodebox_list[i][3]
		local tcraf = nodebox_list[i][4]
		local tsunl = nodebox_list[i][5]
		if itemmeta.sunlight_propagates == true then
			tsunl = true
		end
		if is_disabled(disabled, tname) then
			minetest.register_node(":"..mname..":shapes_"..sname.."_"..tname, {
				description = def[tname.."_description"] or itemmeta.description.." "..tdesc,
				drawtype = "nodebox",
				groups = r_group,
				tiles = def[tname.."_tiles"] or def.global_tiles or itemmeta.tiles,
				paramtype = "light",
				paramtype2 = "facedir",
				sunlight_propagates = def[tname.."_sunlight_propagates"] or tsunl,
				use_texture_alpha = itemmeta.use_texture_alpha,
				drop = def[tname.."_drop"] or def.drop,
				light_source = def[tname.."_light_source"] or itemmeta.light_source,
				sounds = itemmeta.sounds,
				node_box = {
					type = "fixed",
					fixed = tnobo,
				},
				on_place = shapes.rotate_node,
			})
			if tcraf ~= nil then
				minetest.register_craft({
					output = mname..':shapes_'..sname..'_cube '..tcraf,
					recipe = {{mname..':shapes_'..sname..'_'..tname}}
				})
			end
			minetest.register_craft({
				output = mname..':shapes_'..sname..'_righthalfstair',
				recipe = {{mname..':shapes_'..sname..'_halfstair'}}
			})
		end
	end
	-- Registering model-based shapes
	for i in ipairs(model_list) do
		local tdesc = model_list[i][1]
		local tname = model_list[i][2]
		local tmodl = model_list[i][3]
		local tcraf = model_list[i][4]
		local tsunl = model_list[i][5]
		if is_disabled(disabled, tname) then
			minetest.register_node(":"..mname..":shapes_"..sname.."_"..tname, {
				description = def[tname.."_description"] or itemmeta.description.." "..tdesc,
				drawtype = "mesh",
				mesh = tmodl,
				groups = r_group,
				tiles = def[tname.."_tiles"] or def.global_tiles or itemmeta.tiles,
				paramtype = "light",
				paramtype2 = "facedir",
				sunlight_propagates = def[tname.."_sunlight_propagates"] or tsunl,
				use_texture_alpha = itemmeta.use_texture_alpha,
				drop = def[tname.."_drop"] or def.drop,
				light_source = def[tname.."_light_source"] or itemmeta.light_source,
				sounds = itemmeta.sounds,
				on_place = shapes.rotate_node,
			})
			if tcraf ~= nil then
				minetest.register_craft({
					output = mname..':shapes_'..sname..'_cube '..tcraf,
					recipe = {{mname..':shapes_'..sname..'_'..tname}}
				})
			end
		end
	end
	-- Registering fences
	--=== FENCES FUCTIONALITY ===
	-- Obtained from minetest-game/default/functions.lua
	-- [ https://github.com/minetest/minetest_game/tree/master/mods/default ]
	-- Credit to original authors
	if is_disabled(disabled, "fence") then
		local n_group2 = def.groups or itemmeta.groups
		local f_group = table.copy(n_group2)
		f_group.not_in_creative_inventory = 1
		f_group.fence = 1
		local fence_texture = "shapes_df_fence_overlay.png^"..stexture.."^shapes_df_fence_overlay.png^[makealpha:255,126,126"
		local fencerail_texture = "shapes_df_fencerail_overlay.png^"..stexture.."^shapes_df_fencerail_overlay.png^[makealpha:255,126,126"
		minetest.register_node(":"..mname..":shapes_"..sname.."_fence", {
			description = def.fence_description or itemmeta.description.." Fence",
			drawtype = "nodebox",
			groups = f_group,
			tiles = def.fence_tiles or {stexture},
			inventory_image = fence_texture,
			wield_image = fence_texture,
			paramtype = "light",
			sunlight_propagates = def.fence_sunlight_propagates or true,
			use_texture_alpha = itemmeta.use_texture_alpha,
			drop = def.fence_drop or def.drop,
			light_source = def.fence_light_source or itemmeta.light_source,
			sounds = itemmeta.sounds,
			node_box = {
				type = "connected",
				fixed = {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8},
				-- connect_top =
				-- connect_bottom =
				connect_front = {{-1/16,  3/16, -1/2,   1/16,  5/16, -1/8 },
								 {-1/16, -5/16, -1/2,   1/16, -3/16, -1/8 }},
				connect_left =  {{-1/2,   3/16, -1/16, -1/8,   5/16,  1/16},
								 {-1/2,  -5/16, -1/16, -1/8,  -3/16,  1/16}},
				connect_back =  {{-1/16,  3/16,  1/8,   1/16,  5/16,  1/2 },
								 {-1/16, -5/16,  1/8,   1/16, -3/16,  1/2 }},
				connect_right = {{ 1/8,   3/16, -1/16,  1/2,   5/16,  1/16},
								 { 1/8,  -5/16, -1/16,  1/2,  -3/16,  1/16}}
			},
			collision_box = {
				type = "connected",
				fixed = {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8},
				-- connect_top =
				-- connect_bottom =
				connect_front = {-1/8, -1/2, -1/2,  1/8, 1/2, -1/8},
				connect_left =  {-1/2, -1/2, -1/8, -1/8, 1/2,  1/8},
				connect_back =  {-1/8, -1/2,  1/8,  1/8, 1/2,  1/2},
				connect_right = { 1/8, -1/2, -1/8,  1/2, 1/2,  1/8}
			},
			connects_to = {"group:fence", "group:wood", "group:tree", "group:wall", "group:stone"},
		})
		minetest.register_craft({
			output = mname..':shapes_'..sname..'_cube 2',
			recipe = {{mname..':shapes_'..sname..'_fence'}}
		})
		minetest.register_node(":"..mname..":shapes_"..sname.."_fencerail", {
			description = def.fencerail_description or itemmeta.description.." Fencerail",
			drawtype = "nodebox",
			groups = f_group,
			tiles = def.fencerail_tiles or {stexture},
			inventory_image = fencerail_texture,
			wield_image = fencerail_texture,
			paramtype = "light",
			sunlight_propagates = def.fencerail_sunlight_propagates or true,
			use_texture_alpha = itemmeta.use_texture_alpha,
			drop = def.fencerail_drop or def.drop,
			light_source = def.fencerail_light_source or itemmeta.light_source,
			sounds = itemmeta.sounds,
			node_box = {
				type = "connected",
				fixed = {{-1/16,  3/16, -1/16, 1/16,  5/16, 1/16},
						{-1/16, -3/16, -1/16, 1/16, -5/16, 1/16}},
				-- connect_top =
				-- connect_bottom =
				connect_front = {{-1/16,  3/16, -1/2,   1/16,  5/16, -1/16},
								{-1/16, -5/16, -1/2,   1/16, -3/16, -1/16}},
				connect_left =  {{-1/2,   3/16, -1/16, -1/16,  5/16,  1/16},
								{-1/2,  -5/16, -1/16, -1/16, -3/16,  1/16}},
				connect_back =  {{-1/16,  3/16,  1/16,  1/16,  5/16,  1/2 },
								{-1/16, -5/16,  1/16,  1/16, -3/16,  1/2 }},
				connect_right = {{ 1/16,  3/16, -1/16,  1/2,   5/16,  1/16},
		                         { 1/16, -5/16, -1/16,  1/2,  -3/16,  1/16}}
			},
			collision_box = {
				type = "connected",
				fixed = {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8},
				-- connect_top =
				-- connect_bottom =
				connect_front = {-1/8, -1/2, -1/2,  1/8, 1/2, -1/8},
				connect_left =  {-1/2, -1/2, -1/8, -1/8, 1/2,  1/8},
				connect_back =  {-1/8, -1/2,  1/8,  1/8, 1/2,  1/2},
				connect_right = { 1/8, -1/2, -1/8,  1/2, 1/2,  1/8}
			},
			connects_to = {"group:fence", "group:wood", "group:tree", "group:wall", "group:stone"},
		})
		minetest.register_craft({
			output = mname..':shapes_'..sname..'_cube 2',
			recipe = {{mname..':shapes_'..sname..'_fencerail'}}
		})
	end
	-- Registering walls
	--=== WALLS FUCTIONALITY ===
	-- Obtained from minetest-game/walls
	-- [ https://github.com/minetest/minetest_game/tree/master/mods/walls ]
	-- Credit to original authors
	if is_disabled(disabled, "wall") then
		local n_group3 = def.groups or itemmeta.groups
		local w_group = table.copy(n_group3)
		w_group.not_in_creative_inventory = 1
		w_group.wall = 1
		local wall_texture = "shapes_df_wall_overlay.png^" .. stexture .. "^shapes_df_wall_overlay.png^[makealpha:255,126,126"
		minetest.register_node(":"..mname..":shapes_"..sname.."_wall", {
			description = def.wall_description or itemmeta.description.." Wall",
			drawtype = "nodebox",
			groups = w_group,
			tiles = def.wall_tiles or {stexture},
			inventory_image = wall_texture,
			wield_image = wall_texture,
			paramtype = "light",
			sunlight_propagates = def.wall_sunlight_propagates or true,
			use_texture_alpha = itemmeta.use_texture_alpha,
			drop = def.wall_drop or def.drop,
			light_source = def.wall_light_source or itemmeta.light_source,
			sounds = itemmeta.sounds,
			node_box = {
				type = "connected",
				fixed = {-1/4, -1/2, -1/4, 1/4, 1/2, 1/4},
				-- connect_bottom =
				connect_front = {-3/16, -1/2, -1/2,  3/16, 3/8, -1/4},
				connect_left = {-1/2, -1/2, -3/16, -1/4, 3/8,  3/16},
				connect_back = {-3/16, -1/2,  1/4,  3/16, 3/8,  1/2},
				connect_right = { 1/4, -1/2, -3/16,  1/2, 3/8,  3/16},
			},
			collision_box = {
				type = "connected",
				fixed = {-1/4, -1/2, -1/4, 1/4, 1/2, 1/4},
				-- connect_top =
				-- connect_bottom =
				connect_front = {-1/4,-1/2,-1/2,1/4,1/2,-1/4},
				connect_left = {-1/2,-1/2,-1/4,-1/4,1/2,1/4},
				connect_back = {-1/4,-1/2,1/4,1/4,1/2,1/2},
				connect_right = {1/4,-1/2,-1/4,1/2,1/2,1/4},
			},
			connects_to = { "group:wall", "group:stone", "group:fence" },
		})
		minetest.register_craft({
			output = mname..':shapes_'..sname..'_cube 4',
			recipe = {{mname..':shapes_'..sname..'_wall'}}
		})
	end
	-- Registering panes
	if is_disabled(disabled, "pane") then
		local n_group4 = def.groups or itemmeta.groups
		local p_group = table.copy(n_group4)
		p_group.not_in_creative_inventory = 1
		p_group.pane = 1
		minetest.register_node(":"..mname..":shapes_"..sname.."_pane_flat", {
			description = def.pane_description or itemmeta.description.." Pane" or "Pane",
			drawtype = "nodebox",
			groups = p_group,
			tiles = def.pane_flat_tiles or def.pane_tiles or {stexture},
			inventory_image = stexture,
			wield_image = stexture,
			paramtype = "light",
			paramtype2 = "facedir",
			sunlight_propagates = def.pane_flat_sunlight_propagates or def.pane_sunlight_propagates or true,
			use_texture_alpha = itemmeta.use_texture_alpha,
			drop = def.pane_flat_drop or def.pane_drop or def.drop,
			light_source = def.pane_flat_light_source or def.pane_light_source or itemmeta.light_source,
			sounds = itemmeta.sounds,
			node_box = {
				type = "fixed",
				fixed = {{-1/2, -1/2, -1/32, 1/2, 1/2, 1/32}},
			},
			connect_sides = { "left", "right" },
		})
		minetest.register_node(":"..mname..":shapes_"..sname.."_pane", {
			description = def.pane_description or itemmeta.description.. " Pane" or "Pane",
			drawtype = "nodebox",
			groups = p_group,
			tiles = def.pane_tiles or {stexture},
			paramtype = "light",
			sunlight_propagates = def.pane_sunlight_propagates or true,
			use_texture_alpha = itemmeta.use_texture_alpha,
			drop = mname..":shapes_"..sname.."_pane_flat",
			light_source = def.pane_light_source or itemmeta.light_source,
			sounds = itemmeta.sounds,
			node_box = {
				type = "connected",
				fixed = {{-1/32, -1/2, -1/32, 1/32, 1/2, 1/32}},
				connect_front = {{-1/32, -1/2, -1/2, 1/32, 1/2, -1/32}},
				connect_left = {{-1/2, -1/2, -1/32, -1/32, 1/2, 1/32}},
				connect_back = {{-1/32, -1/2, 1/32, 1/32, 1/2, 1/2}},
				connect_right = {{1/32, -1/2, -1/32, 1/2, 1/2, 1/32}},
			},
			connects_to = {"group:pane", "group:stone", "group:glass", "group:wood", "group:tree"},
		})
		minetest.register_craft({
			output = mname..':shapes_'..sname..'_cube',
			recipe = {{mname..':shapes_'..sname..'_pane_flat'}}
		})
	end
end