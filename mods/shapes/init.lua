shapes = {}
-- Cubic shapes
local nodebox_list = {
	--[[
	{ cost, name, description, nodebox, sunlight_propagates, backface_culling, align_style }
	1. Cost (How many microblocks make up the block, 1 block = 8 microblocks)
	2. Name (Shapename; <modname>:shapes_<nodename>_<shapename>
	3. Description (Shape Description; <nodedesc> <shapedesc>
	4. Nodebox
	5. Sunlight Propagates (Optional) (Use defined, else use itemmeta, else true)
	6. Backface Culling (Optional) (Use defined, else true)
	7. Align Style (Optional) (Use defined, else "world")
	--]]
	-- Slabs
	{ 1, "slab1", 			"Slab (1/16)", {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}, true },
	{ 1, "slab2", 			"Slab (2/16)", {-0.5, -0.5, -0.5, 0.5, -0.375, 0.5}, true },
	{ 2, "slab4", 			"Slab (4/16)", {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}, true },
	{ 3, "slab", 			"Slab", {-0.5, -0.5, -0.5, 0.5, 0, 0.5}, true },
	{ 6, "slab12", 			"Slab (12/16)", {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5}, true },
	-- Cubes
	{ 1, "cube1", 			"Cube (1/16)", {-0.5, -0.5, 0, 0, -0.4375, 0.5}, true },
	{ 1, "cube2", 			"Cube (2/16)", {-0.5, -0.5, 0, 0, -0.375, 0.5}, true },
	{ 1, "cube4", 			"Cube (4/16)", {-0.5, -0.5, 0, 0, -0.25, 0.5}, true },
	{ 1, "cube", 			"Cube", {-0.5, -0.5, 0, 0, 0, 0.5}, true },
	{ 2, "cube12", 			"Cube (12/16)", {-0.5, -0.5, 0, 0, 0.25, 0.5}, true },
	-- Steps
	{ 1, "step1", 			"Step (1/16)", {-0.5, -0.5, 0, 0.5, -0.4375, 0.5}, true },
	{ 1, "step2", 			"Step (2/16)", {-0.5, -0.5, 0, 0.5, -0.375, 0.5}, true },
	{ 1, "step4", 			"Step (4/16)", {-0.5, -0.5, 0, 0.5, -0.25, 0.5}, true },
	{ 2, "step",			"Step",	{-0.5, -0.5, 0, 0.5, 0, 0.5}, true },
	{ 3, "step12", 			"Step (12/16", {-0.5, -0.5, 0, 0.5, 0.25, 0.5}, true },
	-- Stairs
	{ 3, "halfstair", 		"Left Halfstair", {{-0.5, -0.5, -0.5, 0, 0, 0.5}, {-0.5, 0, 0, 0, 0.5, 0.5}}, true },
	{ 3, "righthalfstair",  "Right Halfstair", {{0, -0.5, -0.5, 0.5, 0, 0.5}, {0, 0, 0, 0.5, 0.5, 0.5}}, true },
	{ 5, "outerstair", 		"Outerstair", {{-0.5, -0.5, -0.5, 0.5, 0, 0.5}, {-0.5, 0, 0, 0, 0.5, 0.5}}, true },
	{ 6, "stair", 			"Stair", {{-0.5, -0.5, -0.5, 0.5, 0, 0.5}, {-0.5, 0, 0, 0.5, 0.5, 0.5}}, true },
	{ 7, "innerstair", 		"Innerstair", {{-0.5, -0.5, -0.5, 0.5, 0, 0.5}, {-0.5, 0, 0, 0.5, 0.5, 0.5}, {-0.5, 0, -0.5, 0, 0.5, 0}}, false },
	-- Split Stairs
	{ 1, "splitstair1", 	"Splitstair (1/16)", {{-0.5, -0.0625, -0.5, 0.5, 0, 0}, {-0.5, 0.4375, 0, 0.5, 0.5, 0.5}}, true },
	{ 2, "splitstair4", 	"Splitstair (4/16)", {{-0.5, -0.25, -0.5, 0.5, 0, 0}, {-0.5, 0.25, 0, 0.5, 0.5, 0.5}}, true },
	{ 4, "splitstair", 		"Splitstair", {{-0.5, -0.5, -0.5, 0.5, 0, 0}, {-0.5, 0, 0, 0.5, 0.5, 0.5}}, true },
	{ 4, "forkstair", 		"Forkstair", {{-0.5, -0.5, 0, 0, 0.5, 0.5}, {0, -0.5, 0, 0.5, 0, 0.5}, {-0.5, -0.5, -0.5, 0, 0, 0}}, true },
	-- Pole/ Pillar
	{ 2, "pole", 			"Pole", {-0.125, -0.5, -0.125, 0.125, 0.5, 0.125}, true },
	{ 2, "wallpole", 		"Wall-Pole", {-0.125, -0.5, 0.25, 0.125, 0.5, 0.5}, true },
	{ 2, "cornerpole", 		"Corner-Pole", {-0.5, -0.5, 0.25, -0.25, 0.5, 0.5}, true },
	{ 4, "pillar", 			"Pillar", {-1/4, -1/2, -1/4, 1/4, 1/2, 1/4}, true },
	{ 4, "wallpillar", 		"Wall-Pillar", {-1/4, -1/2, 0, 1/4, 1/2, 1/2}, true },
	{ 2, "halfpillar", 		"Half-Pillar", {-1/4, -1/2, 1/2, 1/4, 1/2, 1/4}, true },
	--{ 6, "pillartop", 		"Pillar Top", {{-0.25, -0.5, -0.25, 0.25, 0.5, 0.25}, {-0.5, 0.25, -0.5, 0.5, 0.5, 0.5}, {-0.375, 0, -0.375, 0.375, 0.5, 0.375}}, true },
	{ 6, "pillarcrown", 	"Pillar Crown", {{-0.25, -0.5, -0.25, 0.25, 0.5, 0.25}, {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}, {-0.375, -0.5, -0.375, 0.375, 0, 0.375}}, true },
	--{ 3, "halfpillartop", 	"Half-Pillar Top", {{-0.25, -0.5, 0.25, 0.25, 0.5, 0.5}, {-0.5, 0.25, 0, 0.5, 0.5, 0.5}, {-0.375, 0, 0.125, 0.375, 0.5, 0.5}}, true },
	{ 3, "halfpillarcrown", "Half-Pillar Crown", {{-0.25, -0.5, 0.25, 0.25, 0.5, 0.5}, {-0.5, -0.5, 0, 0.5, -0.25, 0.5}, {-0.375, -0.5, 0.125, 0.375, 0, 0.5}}, true },
	{ 5, "wallpillarcrown", "Wall-Pillar Crown", {{-0.25, -0.5, 0, 0.25, 0.5, 0.5}, {-0.5, -0.5, -0.25, 0.5, -0.25, 0.5}, {-0.375, -0.5, -0.125, 0.375, 0, 0.5}}, true },
	-- Beams
	{ 2, "beam", 			"Beam", {-0.25, -0.5, -0.5, 0.25, 0, 0.5}, true },
	{ 4, "crossbeam", 		"Crossbeam", {{-0.25, -0.5, -0.5, 0.25, 0, 0.5}, {-0.5, -0.5, -0.25, 0.5, 0, 0.25}}, true },
	{ 4, "linkdown", 		"Linkdown", {{-0.25, 0, -0.5, 0.25, 0.5, 0.5}, {-0.125, -0.5, -0.125, 0.125, 0, 0.125}, {-0.1875, -0.5, -0.1875, 0.1875, -0.375, 0.1875}, {-0.1875, -0.125, -0.1875, 0.1875, 0, 0.1875}}, true },
	{ 7, "crosslink", 		"Crosslink", {{-0.25, -0.5, -0.25, 0.25, 0.5, 0.25}, {-0.5, -0.5, -0.25, 0.5, -0, 0.25}, {-0.25, -0.5, -0.5, 0.25, -0, 0.5},{-0.4375, -0.4375, -0.4375, 0.4375, -0.0625, 0.4375}}, true },
	-- Corners
	{ 1, "corner1", 		"Corner (1/16)", {{-0.5, -0.5, -0.5, 0, -0.4375, 0.5}, {0, -0.5, 0, 0.5, -0.4375, -0.5}}, true },
	{ 1, "corner2", 		"Corner (2/16)", {{-0.5, -0.5, -0.5, 0, -0.375, 0.5}, {0, -0.5, 0, 0.5, -0.375, -0.5}}, true },
	{ 2, "corner4", 		"Corner (4/16)", {{-0.5, -0.5, -0.5, 0, -0.25, 0.5}, {0, -0.5, 0, 0.5, -0.25, -0.5}}, true },
	{ 3, "corner", 			"Corner", {{-0.5, -0.5, -0.5, 0, 0, 0.5}, {0, -0.5, 0, 0.5, 0, -0.5}}, true },
	{ 5, "corner12", 		"Corner (12/16)", {{-0.5, -0.5, -0.5, 0, 0.25, 0.5}, {0, -0.5, 0, 0.5, 0.25, -0.5}}, true },
}

-- Model-based shapes
local model_list = {
	--[[
	{ cost, name, description, model, collision_box, selection_box, sunlight_propagates, backface_culling, align_style }
	1. Cost (How many microblocks make up the block, 1 block = 8 microblocks)
	2. Name (Shapename; <modname>:shapes_<nodename>_<shapename>
	3. Description (Shape Description; <nodedesc> <shapedesc>
	4. Model (Modelfile)
	5. Collision Box
	6. Selection Box (Optional) (Use defined, else use collision box)
	7. Sunlight Propagates (Optional) (Use defined, else use itemmeta, else true)
	--]]
	{ 7, "sphere", 			"Sphere", "shapes_sphere.obj", {{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}}, nil, true },
	-- Slopes
	{ 4, "slope", 			"Slope", "shapes_slope.obj", {{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}, {-0.5, -0.25, -0.25, 0.5, 0, 0.5}, {-0.5, 0, 0, 0.5, 0.25, 0.5}, {-0.5, 0.25, 0.25, 0.5, 0.5, 0.5}}, nil, true },
	{ 2, "slope2", 			"Slope (1/2)", "shapes_slope_half.obj", {{-0.5, -0.5, -0.5, 0.5, -0.375, 0.5}, {-0.5, -0.375, -0.25, 0.5, -0.25, 0.5}, {-0.5, -0.25, 0, 0.5, -0.125, 0.5}, {-0.5, -0.125, 0.25, 0.5, 0, 0.5}}, nil, true },
	{ 4, "slope3", 			"Slope (3/4)", "shapes_slope_half_raised.obj", {{-0.5, -0.5, -0.5, 0.5, 0.125, 0.5}, {-0.5, 0.125, -0.25, 0.5, 0.25, 0.5}, {-0.5, 0.25, 0, 0.5, 0.375, 0.5}, {-0.5, 0.375, 0.25, 0.5, 0.5, 0.5}}, nil, true },
	-- Innerslopes
	{ 4, "innerslope", 		"Innerslope", "shapes_slope_inner.obj", {{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}, {-0.5, -0.5, -0.25, 0.5, 0, 0.5}, {-0.5, -0.5, -0.5, 0.25, 0, 0.5}, {-0.5, 0, -0.5, 0, 0.25, 0.5}, {-0.5, 0, 0, 0.5, 0.25, 0.5}, {-0.5, 0.25, 0.25, 0.5, 0.5, 0.5}, {-0.5, 0.25, -0.5, -0.25, 0.5, 0.5}}, nil, true },
	{ 2, "innerslope2", 	"Innerslope (1/2)", "shapes_slope_inner_half.obj", {{-0.5, -0.5, -0.5, 0.5, -0.375, 0.5}, {-0.5, -0.375, -0.25, 0.5, -0.25, 0.5}, {-0.5, -0.375, -0.5, 0.25, -0.25, 0.5}, {-0.5, -0.25, -0.5, 0, -0.125, 0.5}, {-0.5, -0.25, 0, 0.5, -0.125, 0.5}, {-0.5, -0.125, 0.25, 0.5, 0, 0.5}, {-0.5, -0.125, -0.5, -0.25, 0, 0.5}}, nil, true },
	{ 4, "innerslope3", 	"Innerslope (3/4)", "shapes_slope_inner_half_raised.obj", {{-0.5, -0.5, -0.5, 0.5, 0.125, 0.5}, {-0.5, 0.125, -0.25, 0.5, 0.25, 0.5}, {-0.5, 0.125, -0.5, 0.25, 0.25, 0.5}, {-0.5, 0.25, -0.5, 0, 0.375, 0.5}, {-0.5, 0.25, 0, 0.5, 0.375, 0.5}, {-0.5, 0.375, 0.25, 0.5, 0.5, 0.5}, {-0.5, 0.375, -0.5, -0.25, 0.5, 0.5}}, nil, true },
	-- Cut innerslopes
	{ 4, "cutinnerslope", 	"Cut Innerslope", "shapes_slope_inner_cut.obj", {{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}, {-0.5, -0.5, -0.25, 0.5, 0, 0.5}, {-0.5, -0.5, -0.5, 0.25, 0, 0.5}, {-0.5, 0, -0.5, 0, 0.25, 0.5}, {-0.5, 0, 0, 0.5, 0.25, 0.5}, {-0.5, 0.25, 0.25, 0.5, 0.5, 0.5}, {-0.5, 0.25, -0.5, -0.25, 0.5, 0.5}}, nil, true },
	{ 2, "cutinnerslope2", 	"Cut Innerslope (1/2)", "shapes_slope_inner_cut_half.obj", {{-0.5, -0.5, -0.5, 0.5, -0.375, 0.5}, {-0.5, -0.375, -0.25, 0.5, -0.25, 0.5}, {-0.5, -0.375, -0.5, 0.25, -0.25, 0.5}, {-0.5, -0.25, -0.5, 0, -0.125, 0.5}, {-0.5, -0.25, 0, 0.5, -0.125, 0.5}, {-0.5, -0.125, 0.25, 0.5, 0, 0.5}, {-0.5, -0.125, -0.5, -0.25, 0, 0.5}}, nil, true },
	{ 4, "cutinnerslope3", 	"Cut Innerslope (3/4)", "shapes_slope_inner_cut_half_raised.obj", {{-0.5, -0.5, -0.5, 0.5, 0.125, 0.5}, {-0.5, 0.125, -0.25, 0.5, 0.25, 0.5}, {-0.5, 0.125, -0.5, 0.25, 0.25, 0.5}, {-0.5, 0.25, -0.5, 0, 0.375, 0.5}, {-0.5, 0.25, 0, 0.5, 0.375, 0.5}, {-0.5, 0.375, 0.25, 0.5, 0.5, 0.5}, {-0.5, 0.375, -0.5, -0.25, 0.5, 0.5}}, nil, true },
	-- Outerslopes
	{ 4, "outerslope", 		"Outerslope", "shapes_slope_outer.obj", {{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}, {-0.5, -0.25, -0.25, 0.25, 0, 0.5}, {-0.5, 0, 0, 0, 0.25, 0.5}, {-0.5, 0.25, 0.25, -0.25, 0.5, 0.5}}, nil, true },
	{ 2, "outerslope2", 	"Outerslope (1/2)", "shapes_slope_outer_half.obj", {{-0.5, -0.5, -0.5, 0.5, -0.375, 0.5}, {-0.5, -0.375, -0.25, 0.25, -0.25, 0.5}, {-0.5, -0.25, 0, 0, -0.125, 0.5}, {-0.5, -0.125, 0.25, -0.25, 0, 0.5}}, nil, true },
	{ 4, "outerslope3", 	"Outerslope (3/4)", "shapes_slope_outer_half_raised.obj", {{-0.5, -0.5, -0.5, 0.5, 0.125, 0.5}, {-0.5, 0.125, -0.25, 0.25, 0.25, 0.5}, {-0.5, 0.25, 0, 0, 0.375, 0.5}, {-0.5, 0.375, 0.25, -0.25, 0.5, 0.5}}, nil, true },
	-- Cut outerslopes
	{ 4, "cutouterslope", 	"Cut Outerslope", "shapes_slope_outer_cut.obj", {{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}, {-0.5, -0.25, -0.25, 0.25, 0, 0.5}, {-0.5, 0, 0, 0, 0.25, 0.5}, {-0.5, 0.25, 0.25, -0.25, 0.5, 0.5}}, nil, true },
	{ 2, "cutouterslope2", 	"Cut Outerslope (1/2)", "shapes_slope_outer_cut_half.obj", {{-0.5, -0.5, -0.5, 0.5, -0.375, 0.5}, {-0.5, -0.375, -0.25, 0.25, -0.25, 0.5}, {-0.5, -0.25, 0, 0, -0.125, 0.5}, {-0.5, -0.125, 0.25, -0.25, 0, 0.5}}, nil, true },
	{ 4, "cutouterslope3", 	"Cut Outerslope (3/4)", "shapes_slope_outer_cut_half_raised.obj", {{-0.5, -0.5, -0.5, 0.5, 0.125, 0.5}, {-0.5, 0.125, -0.25, 0.25, 0.25, 0.5}, {-0.5, 0.25, 0, 0, 0.375, 0.5}, {-0.5, 0.375, 0.25, -0.25, 0.5, 0.5}}, nil, true },
	{ 4, "cutouterslope4", 	"Cut Outerslope (4/2)", "shapes_slope_cut.obj", {{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}, {-0.5, -0.25, -0.25, 0.25, 0, 0.5}, {-0.5, 0, 0, 0, 0.25, 0.5}, {-0.5, 0.25, 0.25, -0.25, 0.5, 0.5}}, nil, true },
}

shapes.rotate_node = function(itemstack, placer, pointed_thing)
	minetest.rotate_and_place(itemstack, placer, pointed_thing,
		minetest.settings:get_bool("creative_mode") or creative.is_enabled_for(placer:get_player_name()),
		{invert_wall = placer:get_player_control().sneak})
	local pos = pointed_thing.above
	minetest.check_single_for_falling(pos)
	return itemstack
end

-- return true if shape is not disabled (exception: spheres)
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

function shapes:register_shapes(name, def, disable_list)
	def = def or {}
	local disabled = def.disabled or disable_list or ""
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
		local tcraf = nodebox_list[i][1]
		local tname = nodebox_list[i][2]
		local tdesc = nodebox_list[i][3]
		local tnobo = nodebox_list[i][4]
		local tsunl = def[tname.."_sunlight_propagates"] or nodebox_list[i][5] or itemmeta.sunlight_propagates or true
		local tbfcg = def[tname.."_backface_culling"] or def.backface_culling or nodebox_list[i][6] or true
		local tagst = def[tname.."_align_style"] or def.align_style or nodebox_list[i][7] or "world"
		if is_disabled(disabled, tname) then
			-- align style and backface_culling
			local shape_images = {}
			local images = def[tname.."_tiles"] or def.global_tiles or itemmeta.tiles
			for i2, image in ipairs(images) do
				if type(image) == "string" then
					shape_images[i2] = {
						name = image,
						backface_culling = tbfcg,
						align_style = tagst,
					}
				end
			end
			-- shapes nodebox registeration
			minetest.register_node(":"..mname..":shapes_"..sname.."_"..tname, {
				description = def[tname.."_description"] or itemmeta.description.." "..tdesc,
				drawtype = "nodebox",
				groups = r_group,
				tiles = shape_images,
				paramtype = "light",
				paramtype2 = "facedir",
				sunlight_propagates = tsunl,
				use_texture_alpha = itemmeta.use_texture_alpha,
				drop = def[tname.."_drop"] or def.drop,
				light_source = def[tname.."_light_source"] or def.light_source or itemmeta.light_source,
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
		end
	end
	-- Registering model-based shapes
	for i in ipairs(model_list) do
		local tcraf = model_list[i][1]
		local tname = model_list[i][2]
		local tdesc = model_list[i][3]
		local tmodl = model_list[i][4]
		local tcoll = model_list[i][5]
		local tsele = model_list[i][6] or tcoll
		local tsunl = def[tname.."_sunlight_propagates"] or model_list[i][7] or itemmeta.sunlight_propagates or true
		if is_disabled(disabled, tname) then
			-- shapes models registeration
			minetest.register_node(":"..mname..":shapes_"..sname.."_"..tname, {
				description = def[tname.."_description"] or itemmeta.description.." "..tdesc,
				drawtype = "mesh",
				mesh = tmodl,
				groups = r_group,
				tiles = def[tname.."_tiles"] or def.global_tiles or itemmeta.tiles,
				paramtype = "light",
				paramtype2 = "facedir",
				sunlight_propagates = tsunl,
				use_texture_alpha = itemmeta.use_texture_alpha,
				drop = def[tname.."_drop"] or def.drop,
				light_source = def[tname.."_light_source"] or def.light_source or itemmeta.light_source,
				sounds = itemmeta.sounds,
				collision_box = {
					type = "fixed",
					fixed = tcoll,
				},
				selection_box = {
					type = "fixed",
					fixed = tsele,
				},
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
			light_source = def.fence_light_source or def.light_source or itemmeta.light_source,
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
		-- Fencerail
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
			light_source = def.fencerail_light_source or def.light_source or itemmeta.light_source,
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
			light_source = def.wall_light_source or def.light_source or itemmeta.light_source,
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
			light_source = def.pane_flat_light_source or def.pane_light_source or def.light_source or itemmeta.light_source,
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
			light_source = def.pane_light_source or def.light_source or itemmeta.light_source,
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
	-- Additional recipes
	if is_disabled(disabled, "halfstair") and is_disabled(disabled, "righthalfstair") then
		minetest.register_craft({
			output = mname..':shapes_'..sname..'_righthalfstair',
			recipe = {{mname..':shapes_'..sname..'_halfstair'}}
		})
	end
end