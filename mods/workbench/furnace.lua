local function formspec_cooking(pos, add)
	local spos = pos.x..","..pos.y..","..pos.z
	local formspec = {
		"formspec_version[4]",
		"size[10.5,9.75]",
		-- input
		"label[0.2,0.3;Input]",
		"box[0.2,0.5;3.9,3.9;#707070]",
		"list[nodemeta:"..spos..";input;0.4,0.7;3,3;]",
		-- arrow
		"image[4.25,2.05;0.8,0.8;gui_arrow.png^[transformFYR90]",
		-- output
		"label[5.2,0.925;Output]",
		"box[5.2,1.125;2.65,2.65;#707070]",
		"list[nodemeta:"..spos..";output;5.4,1.325;2,2;]",
		-- fuel
		"label[8.05,0.925;Fuel]",
		"box[8.05,1.125;2.25,2.65;#707070]",
		"list[nodemeta:"..spos..";fuel;8.675,1.325;1,1;]",
		"image[8.675,2.575;1,1;gui_fire_bgd.png]",
		-- player
		"list[current_player;main;0.4,4.6;8,4;]",
		-- listring
		"listring[nodemeta:"..spos..";output]",
		"listring[current_player;main]",
		"listring[nodemeta:"..spos..";input]",
		"listring[current_player;main]",
		"listring[nodemeta:"..spos..";fuel]",
		"listring[current_player;main]",
		-- lock
		"style_type[image;noclip=true]",
		"image[-1.4,3;1.4,1.4;gui_tab.png]",
		"image_button[-1.1,3.15;1.05,1.05;"..locks.icons(pos, "workbench_furnace", {"lock", "protect", "public"}).."]",
		add
	}
	return table.concat(formspec, "")
end

local function apply_craft_result(pos, listname, index, stack, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local craftlist = inv:get_list("input")
	local output = workbench.craft_output(craftlist, "cooking", nil, 3)
	if output then
		-- ensure sufficient fuel
		if meta:get_int("fueltime") > 0 then
			inv:set_list("output", output)
		end
	else
		inv:set_list("output", {})
	end
end

local function furnace_update(pos, listname, index, stack, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local craftlist = inv:get_list("input")
	local outlist = inv:get_list("output")
	local fuellist = inv:get_list("fuel")
	if listname == "fuel" then
		if meta:get_int("fueltime") > 0 then -- if fueltimer running
			local c_ftime = meta:get_int("fueltime")
			meta:set_int("fueltime", c_ftime - 1)
			meta:set_string("formspec", formspec_cooking(pos,
				"animated_image[8.675,2.575;1,1;fuel_icon;gui_fire_animated.png;8;500;1]"..
				"tooltip[8.675,2.575;1,1;Fuel Left: "..ccore.get_time(c_ftime - 1).."]"
			))
			locks.init_infotext(pos, "Furnace", "Active (Fuel Left: "..ccore.get_time(c_ftime - 1).. ")")
			minetest.get_node_timer(pos):start(1)
			-- reduce timer by 1
		elseif meta:get_int("fueltime") <= 0 then -- if fueltimer empty
			local ftime, fdinput = workbench:get_fuel(fuellist)
			if ftime and ftime > 0 then -- ensure valid fuel
				-- take fuel
				meta:set_string("formspec", formspec_cooking(pos,
					"animated_image[8.675,2.575;1,1;fuel_icon;gui_fire_animated.png;8;500;1]"..
					"tooltip[8.675,2.575;1,1;Fuel Left: "..ccore.get_time(ftime).."]"
				))
				locks.init_infotext(pos, "Furnace", "Active (Fuel Left: "..ccore.get_time(ftime).. ")")
				ccore.swap_node(pos, "workbench:furnace_active")
				inv:set_list("fuel", fdinput)
				meta:set_int("fueltime", ftime)
				minetest.get_node_timer(pos):start(1)
			else -- no more valid fuel
				meta:set_string("formspec", formspec_cooking(pos))
				ccore.swap_node(pos, "workbench:furnace")
				meta:set_int("fueltime", 0)
				locks.init_infotext(pos, "Furnace", "Inactive")
			end
		end
	end
	-- apply craft when output is empty
	if listname == "input" or inv:is_empty("input") ~= true and inv:is_empty("output") then
		apply_craft_result(pos, listname, index, stack, player)
	end
	-- remove items when taking from output
	if listname == "output" then
		local _, _, d_input = workbench.craft_output(craftlist, "cooking", nil, 3)
		local remainder = workbench.output_count(outlist)
		-- ensure there's nothing remaining in the output list, otherwise prevent modifying the input list
		if remainder == 0 then
			inv:set_list("output", {})
			meta:set_string("crafted", "")
		elseif remainder > 0 then
			meta:set_string("crafted", "remainder")
		end
		if d_input and meta:get_string("crafted") == "" then
			inv:set_list("input", d_input)
		end
		-- if theres spare input, apply crafting again
		if inv:is_empty("input") ~= true and inv:is_empty("output") then
			apply_craft_result(pos, listname, index, stack, player)
		end
	end
end

local function register_furnace(name, def)
	minetest.register_node(name, {
		description = def.description,
		drawtype = "mesh",
		mesh = "workbench_furnace.obj",
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-0.375, 0.5, -0.375, 0.375, 1.5, 0.375},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-0.375, 0.5, -0.375, 0.375, 1.5, 0.375},
			},
		},
		groups = def.groups,
		tiles = def.tiles,
		light_source = def.light_source,
		drop = def.drop,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		use_texture_alpha = "clip",
		sounds = default.node_sound_stone_defaults(),
		can_dig = function(pos, player)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			if inv:is_empty("input") and inv:is_empty("fuel") and inv:is_empty("output") then -- ensure table is empty
				if locks.can_access(pos, player) == true then
					return true
				end
			end
			return false
		end,
		on_timer = function(pos, elapsed)
			furnace_update(pos, "fuel")
		end,
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			inv:set_size("input", 3*3)
			inv:set_size("fuel", 1)
			inv:set_size("output", 2*2)
			meta:set_string("lock", "lock")
			meta:set_string("formspec", formspec_cooking(pos))
			meta:set_string("crafted", "")
			meta:set_string("owner", "")
			meta:set_int("fueltime", 0)
			locks.init_infotext(pos, "Furnace", "Inactive")
		end,
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			local meta = minetest.get_meta(pos)
			local playername = placer:get_player_name()
			meta:set_string("owner", playername)
			locks.init_infotext(pos, "Furnace", "Inactive")
		end,
		on_place = function(itemstack, placer, pointed_thing)
			local pos = pointed_thing.above
			local top_pos = {x=pos.x, y=pos.y+1, z=pos.z}
			local topnode = minetest.get_node(top_pos).name
			if minetest.registered_nodes[topnode].buildable_to then -- ensure top space is buildable
				minetest.dig_node(top_pos) -- remove top space
				minetest.item_place(itemstack, placer, pointed_thing)
			end
			return itemstack
		end,
		on_metadata_inventory_put = function(pos, listname, index, stack, player)
			furnace_update(pos, listname, index, stack, player)
		end,
		on_metadata_inventory_take = function(pos, listname, index, stack, player)
			furnace_update(pos, listname, index, stack, player)
		end,
		on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
			local meta = minetest.get_meta(pos)
			local stack = meta:get_inventory():get_stack(from_list, from_index)
			furnace_update(pos, from_list, from_index, stack, player)
		end,
		allow_metadata_inventory_put = function(pos, listname, index, stack, player)
			local meta = minetest.get_meta(pos)
			if not locks.can_access(pos, player) then
				return 0
			end
			if listname == "input" then
				if meta:get_string("crafted") == "" then
					return stack:get_count()
				else
					local playername = player:get_player_name()
					minetest.chat_send_player(playername, "[workbench] Please remove all output items first.")
					return 0
				end
			elseif listname == "fuel" then
				local ftime = workbench:get_fuel({stack})
				if ftime and ftime > 0 then
					return stack:get_count()
				end
			end
			return 0
		end,
		allow_metadata_inventory_take = function(pos, listname, index, stack, player)
			local meta = minetest.get_meta(pos)
			if not locks.can_access(pos, player) then
				return 0
			end
			if listname == "input" then
				if meta:get_string("crafted") == "" then
					return stack:get_count()
				else
					local playername = player:get_player_name()
					minetest.chat_send_player(playername, "[workbench] Please remove all output items first.")
					return 0
				end
			elseif listname == "output" or listname == "fuel" then
				-- update fuel
				return stack:get_count()
			else
				return 0
			end
		end,
		allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
			if not locks.can_access(pos, player) then
				return 0
			end
			-- disallow moving things in from within inventory to output / fuel
			if to_list == "output" or to_list == "fuel" then
				return 0
			end
			-- ensure output is empty before allowing modification of input
			if from_list == "input" then
				local meta = minetest.get_meta(pos)
				local stack = meta:get_inventory():get_stack(from_list, from_index)
				if meta:get_string("crafted") == "" then
					return stack:get_count()
				else
					local playername = player:get_player_name()
					minetest.chat_send_player(playername, "[workbench] Please remove all output items first.")
					return 0
				end
			else
				return 0
			end
		end,
		on_receive_fields = function(pos, formname, fields, sender)
			if locks.fields(pos, sender, fields, "workbench_furnace", "Furance") then
				furnace_update(pos, "fuel")
			end
		end,
	})
end

register_furnace("workbench:furnace", {
	description = "Furnace",
	groups = {crumbly = 2},
	tiles = {"workbench_furnace.png"},
})

register_furnace("workbench:furnace_active", {
	description = "Furnace (Active)",
	groups = {crumbly = 2, not_in_creative_inventory = 1},
	tiles = {{
		name = "workbench_furnace_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 70,
			aspect_h = 58,
			length = 1,
		},
	},},
	light_source = 8,
	drop = "workbench:furnace",
})

minetest.register_lbm({
	name = "workbench:furnace_active",
	nodenames = {"workbench:furnace_active"},
	action = function(pos, node)
		minetest.get_node_timer(pos):start(1)
	end
})