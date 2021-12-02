wb_shapes = {}

wb_shapes.costs = {
	-- simple shapes
	{
		2,2,2,4,1,
		1,1,2,4,6,
		1,1,1,1,2,
		1,1,1,2,3,
		3,3,5,6,7,
	},
	-- complex shapes
	{
		1,2,4,4,0,
		4,4,2,2,4,
		6,5,3,4,7,
		1,1,2,3,5,
		0,0,0,0,0,
	},
	-- slopes
	{
		4,2,4,0,7,
		4,2,4,0,0,
		4,2,4,0,0,
		4,2,4,0,0,
		4,2,4,4,0,
	},
}

wb_shapes.names = {
	-- simple shapes
	{
		-- row 1
		{"pole", ""},
		{"fence", ""},
		{"fencerail", ""},
		{"wall", ""},
		{"pane_flat", ""},
		-- row 2
		{"slab1", ""},
		{"slab2", ""},
		{"slab4", ""},
		{"slab", ""},
		{"slab12", ""},
		-- row 3
		{"cube1", ""},
		{"cube2", ""},
		{"cube4", ""},
		{"cube", ""},
		{"cube12", ""},
		-- row 4
		{"step1", ""},
		{"step2", ""},
		{"step4", ""},
		{"step", ""},
		{"step12", ""},
		-- row 5
		{"halfstair", ""},
		{"righthalfstair", ""},
		{"outerstair", ""},
		{"stair", ""},
		{"innerstair", ""},
	},
	-- complex shapes
	{
		-- row 1
		{"splitstair1", ""},
		{"splitstair4", ""},
		{"splitstair", ""},
		{"forkstair", ""},
		{"", ""},
		-- row 2
		{"pillar", ""},
		{"wallpillar", ""},
		{"halfpillar", ""},
		{"beam", ""},
		{"crossbeam", ""},
		-- row 3
		{"pillarcrown", ""},
		{"wallpillarcrown", ""},
		{"halfpillarcrown", ""},
		{"linkdown", ""},
		{"crosslink", ""},
		-- row 4
		{"corner1", ""},
		{"corner2", ""},
		{"corner4", ""},
		{"corner", ""},
		{"corner12", ""},
		-- row 5
		{"", ""},
		{"", ""},
		{"", ""},
		{"", ""},
		{"", ""},
	},
	-- slopes
	{
		-- row 1
		{"slope", ""},
		{"slope2", ""},
		{"slope3", ""},
		{"", ""},
		{"sphere", ""},
		-- row 2
		{"innerslope", ""},
		{"innerslope2", ""},
		{"innerslope3", ""},
		{"", ""},
		{"", ""},
		-- row 3
		{"cutinnerslope", ""},
		{"cutinnerslope2", ""},
		{"cutinnerslope3", ""},
		{"", ""},
		{"", ""},
		-- row 4
		{"outerslope", ""},
		{"outerslope2", ""},
		{"outerslope3", ""},
		{"", ""},
		{"", ""},
		-- row 5
		{"cutouterslope", ""},
		{"cutouterslope2", ""},
		{"cutouterslope3", ""},
		{"cutotherslope4", ""},
		{"", ""},
	},
}

local function fuel_icons(pos)
	local meta = minetest.get_meta(pos)
	local tab = meta:get_int("shapes_tab")
	if tab == 1 then
		return ""
	elseif tab == 2 then
		if workbench.check_active(pos, "station_shapes_complex", "tablesaw") then
			return "animated_image[0.4,5.4;1,1;wadawname;workbench_furnace_fire_animated.png;8;500;1]"
		else
			return "image[0.4,5.4;1,1;workbench_furnace_fire_bg.png]"
		end
	elseif tab == 3 then
		if workbench.check_active(pos, "station_shapes_slope", "cnc") then
			return "animated_image[0.4,5.4;1,1;wadawname;workbench_furnace_fire_animated.png;8;500;1]"
		else
			return "image[0.4,5.4;1,1;workbench_furnace_fire_bg.png]"
		end
	end
end

function wb_shapes.formspec(pos, locked)
	return workbench.tabs(pos, locked)..
		"image[0.45,0.5;0.8,0.8;workbench_input.png]"..
		"list[context;shapes_input;0.4,0.4;1,1;]"..
		"image[1.75,0.5;0.8,0.8;workbench_arrow.png^[transformFYR90]"..
		"image[0.46,1.75;0.8,0.8;workbench_cube.png]"..
		"list[context;shapes_micro;0.4,1.65;1,1;]"..
		"image[1.75,1.75;0.8,0.8;workbench_arrow.png^[transformFYR90]"..
		"list[context;shapes_output;2.9,0.4;5,5;]"..
		"field[9.15,2.9;1,1;max_offered;".."Max"..":;${max_offered}]"..
		"button[9.15,4.15;1,1;Set;".."Set".."]"..
		"listring[current_player;main]"..
		"listring[context;shapes_input]"..
		"listring[current_player;main]"..
		"listring[context;shapes_output]"..
		"listring[current_player;main]"..
		"listring[context;shapes_micro]"..
		fuel_icons(pos)
end

function wb_shapes:reset(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	inv:set_list("shapes_input",  {})
	inv:set_list("shapes_micro",  {})
	inv:set_list("shapes_output", {})
	meta:set_int("shapes_micro", 0)
	-- update infotext
	local owner = meta:get_string("owner") or ""
	local stack = inv:get_stack("shapes_input", 1)
	if not stack:is_empty() then
		local nodename = stack:get_name() or ""
		local material = nodename:match(":(.*)")
		if wb_lock.is_locked(pos) then
			meta:set_string("infotext", "Workbench is working on "..material.." (owned by "..owner..") \nWorkbench is locked.")
		else
			meta:set_string("infotext", "Workbench is working on "..material.." (owned by "..owner..")")
		end
	else
		if wb_lock.is_locked(pos) then
			meta:set_string("infotext", "Workbench is empty (owned by "..owner..") \nWorkbench is locked")
		else
			meta:set_string("infotext", "Workbench is empty (owned by "..owner..")")
		end
	end
end

function wb_shapes:get_output(modname, material, amount, max, tab)
	if (not max or max < 1 or max > 99) then max = 99 end
	local list = {}
	local pos = #list
	if amount < 1 then
		return list
	end
	for i = 1, #wb_shapes.names[tab] do
		local t = wb_shapes.names[tab][i]
		local cost = wb_shapes.costs[tab][i]
		local balance = math.min(math.floor(amount/cost), max)
		local nodename = ""
		nodename = modname..":shapes_"..material.."_"..t[1]
		if minetest.registered_nodes[nodename] then
			pos = pos + 1
			list[pos] = nodename.." "..balance
		else
			pos = pos + 1
			list[pos] = "workbench:nil 1"
		end
	end
	return list
end

function wb_shapes:update(pos, amount, tab)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local amount = meta:get_int("shapes_micro") + amount
	local max = meta:get_int("max_offered")
	if amount < 1 then
		self:reset(pos)
		return
	end
	local stack = inv:get_stack("shapes_input", 1)
	if stack:is_empty() then
		if not inv:get_stack("shapes_micro", 1):is_empty() then
			local microstack = inv:get_stack("shapes_micro",  1)
			local nodename = microstack:get_name() or ""
			local modname = nodename:match("(.*):")
			local microname = nodename:gsub(modname..":shapes_", "", 1)
			local material = microname:gsub("_cube", "", 1)
			if amount >= 8 then -- if sufficient microblocks, convert to fullblocks
				inv:set_list("shapes_input", {modname..":"..material.." "..math.floor(amount / 8)})
				inv:set_list("shapes_micro", {nodename.." "..(amount % 8)})
			elseif amount < 8 then
				inv:set_list("shapes_micro", {nodename.." "..(amount)})
			end
			inv:set_list("shapes_output", self:get_output(modname, material, amount, max, tab))
			meta:set_int("shapes_micro", amount)
			local owner = meta:get_string("owner") or ""
			if wb_lock.is_locked(pos) then
				meta:set_string("infotext", "Workbench is working on "..material.." (owned by "..owner..") \nWorkbench is locked.")
			else
				meta:set_string("infotext", "Workbench is working on "..material.." (owned by "..owner..")")
			end
		end
	elseif not stack:is_empty() then
		local nodename = stack:get_name() or ""
		local modname = nodename:match("(.*):")
		local material = nodename:match(":(.*)")
		inv:set_list("shapes_input", {nodename.." "..math.floor(amount / 8)})
		inv:set_list("shapes_micro", {modname..":shapes_"..material.."_cube " ..(amount % 8)})
		inv:set_list("shapes_output", self:get_output(modname, material, amount, max, tab))
		meta:set_int("shapes_micro", amount)
		local owner = meta:get_string("owner") or ""
		if wb_lock.is_locked(pos) then
			meta:set_string("infotext", "Workbench is working on "..material.." (owned by "..owner..") \nWorkbench is locked.")
		else
			meta:set_string("infotext", "Workbench is working on "..material.." (owned by "..owner..")")
		end
	else
		self:reset(pos)
		return
	end
end

function wb_shapes.allow_metadata_inventory_put(pos, listname, index, stack, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local stackname = stack:get_name()
	local count = stack:get_count()
	local material = stackname:match(":(.*)")
	local modname = stackname:match("(.*):")
	if listname == "shapes_input" and minetest.registered_nodes[modname..":shapes_"..material.."_cube"] then
		local input_stack = inv:get_stack("shapes_input", 1)
		local input_name = input_stack:get_name()
		if not input_stack:is_empty() then
			if input_name ~= stackname then
				return 0
			end
		end
		-- allow adding more input only if it matchs the existing input & cubes
		local micro_stack = inv:get_stack("shapes_micro", 1)
		local micro_name = micro_stack:get_name()
		if micro_stack:is_empty() then
			return count
		else
			if micro_name == modname..":shapes_"..material.."_cube" then
				return count
			else
				return 0
			end
		end
	end
	if listname == "shapes_micro" and material == material:match(".*shapes_.*_cube") then
		local micro_stack = inv:get_stack("shapes_micro", 1)
		local micro_name = micro_stack:get_name()
		if not micro_stack:is_empty() then
			if micro_name ~= stackname then
				return 0
			end
		end
		-- allow adding more cubes only if it matches the existing cubes & input
		local input_stack = inv:get_stack("shapes_input", 1)
		local input_name = input_stack:get_name()
		if input_stack:is_empty() then
			return count
		else
			local input_material = input_name:match(":(.*)")
			local input_modname = input_name:match("(.*):")
			if stackname == input_modname..":shapes_"..input_material.."_cube" then
				return count
			else
				return 0
			end
		end
	end
	return 0
end

function wb_shapes.allow_metadata_inventory_take(pos, listname, index, stack, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local count = stack:get_count()
	local player_inv = player:get_inventory()
	local input_stack = inv:get_stack(listname,	index)
	if input_stack:get_name() == "workbench:nil" then
		return 0
	end
	if not player_inv:room_for_item("main", input_stack) then
		return 0
	else
		local tab = meta:get_int("shapes_tab")
		if listname == "shapes_output" then
			if tab == 1 then
				return count
			elseif tab == 2 then
				if workbench.check_active(pos, "station_shapes_complex", "tablesaw", "Tablesaw", player) then
					return count
				else
					return 0
				end
			elseif tab == 3 then
				if workbench.check_active(pos, "station_shapes_slope", "cnc", "CNC Table", player) then
					return count
				else
					return 0
				end
			end
		end
		return count
	end
end

function wb_shapes.on_metadata_inventory_put(pos, listname, index, stack, player)
	local meta = minetest.get_meta(pos)
	local count = stack:get_count()
	local tab = meta:get_int("shapes_tab")
	-- update inventory once something has been placed
	if listname == "shapes_input" then
		wb_shapes:update(pos, 8 * count, tab)
	elseif listname == "shapes_micro" then
		wb_shapes:update(pos, count, tab)
	end
end

function wb_shapes.on_metadata_inventory_take(pos, listname, index, stack, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local input_stack = inv:get_stack(listname, index)
	local tab = meta:get_int("shapes_tab")
	-- reset if invalid data
	if not input_stack:is_empty() and input_stack:get_name()~= stack:get_name() then
		local player_inv = player:get_inventory()
		if player_inv:room_for_item("main", input_stack) then
			player_inv:add_item("main", input_stack)
		end
		wb_shapes:reset(pos)
		return
	end
	-- update if anything is taken
	if listname == "shapes_output" then
		local cost = wb_shapes.costs[tab][index] * stack:get_count()
		wb_shapes:update(pos, -cost, tab)
	elseif listname == "shapes_micro" then
		wb_shapes:update(pos, -stack:get_count(), tab)
	elseif listname == "shapes_input" then
		wb_shapes:update(pos, 8 * -stack:get_count(), tab)
	end
end

function wb_shapes.on_construct(pos)
	local meta = minetest.get_meta(pos)
	meta:set_int("shapes_micro", 0)
	meta:set_int("shapes_tab", 1)
	meta:set_string("max_offered", 99)
	meta:set_string("lock", "locked")
	meta:set_string("station_shapes_complex", "")
	meta:set_string("station_shapes_slope", "")
	-- set inventory sizes
	local inv = meta:get_inventory()
	inv:set_size("shapes_input", 1)    -- Input slot for full blocks of material x.
	inv:set_size("shapes_micro", 1)    -- Input/storage slot for cubes
	inv:set_size("shapes_output", 25)  -- Output with shapes
	wb_shapes:reset(pos)
	-- detect if there's any stations nearby
	workbench.link_to_stations(pos, "tablesaw", "shapes_complex")
	workbench.link_to_stations(pos, "cnc", "shapes_slope")
end

function wb_shapes.on_receive_fields(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	local tab = meta:get_int("shapes_tab")
	local locked = meta:get_string("lock")
	local max = tonumber(fields.max_offered)
	if max and max > 0 then
		meta:set_string("max_offered",  max)
		wb_shapes:update(pos, 0, tab)
	end
	if fields.wbtab_shapes_basic then
		meta:set_int("shapes_tab", 1)
		meta:set_string("tab", "shapes")
		meta:set_string("formspec", wb_shapes.formspec(pos, locked))
		wb_shapes:update(pos, 0, 1)
	elseif fields.wbtab_shapes_complex then
		meta:set_int("shapes_tab", 2)
		meta:set_string("tab", "shapes")
		meta:set_string("formspec", wb_shapes.formspec(pos, locked))
		wb_shapes:update(pos, 0, 2)
	elseif fields.wbtab_shapes_slope then
		meta:set_int("shapes_tab", 3)
		meta:set_string("tab", "shapes")
		meta:set_string("formspec", wb_shapes.formspec(pos, locked))
		wb_shapes:update(pos, 0, 3)
	end
end