workbench.furnace = {}
local winv_exists = minetest.global_exists("winv")
local function formspec_cooking(pos, player, add)
	local meta = minetest.get_meta(pos)
	local spos = pos.x..","..pos.y..","..pos.z
	local winv_listring = ""
	if winv_exists then
		local pmeta = player:get_meta()
		local playername = player:get_player_name()
		local right_inv = pmeta:get_string("winv:right")
		if right_inv == "player" then
			winv_listring =
				"listring[nodemeta:"..spos..";output]"..
				"listring[current_player;main]"..
				"listring[nodemeta:"..spos..";input]"..
				"listring[current_player;main]"..
				"listring[nodemeta:"..spos..";fuel]"..
				"listring[current_player;main]"
		elseif right_inv == "crafting" then
			winv_listring =
				"listring[nodemeta:"..spos..";input]"..
				"listring[detached:winv_craft_"..playername..";input]"..
				"listring[nodemeta:"..spos..";input]"..
				"listring[nodemeta:"..spos..";output]"..
				"listring[detached:winv_craft_"..playername..";input]"..
				"listring[detached:winv_craft_"..playername..";output]"
		elseif right_inv == "creative" then
			winv_listring =
				"listring[detached:winv_creative_"..playername..";main]"..
				"listring[nodemeta:"..spos..";input]"..
				"listring[detached:trash;main]"..
				"listring[nodemeta:"..spos..";fuel]"..
				"listring[detached:trash;main]"..
				"listring[nodemeta:"..spos..";output]"..
				"listring[detached:trash;main]"
		end
	end
	local fireanim_form = ""
	local ftime = meta:get_int("fueltime")
	if ftime > 0 then
		if winv_exists then
			fireanim_form =
				"animated_image[6.5,5.6;1,1;fuel_icon;gui_fire_animated.png;60;60;1]"..
				"image_button[6.5,5.6;1,1;invisible.png;fuelamt;;false;false;invisible.png]"..
				"tooltip[6.5,5.6;1,1;Fuel Left: "..ccore.get_time(ftime).." \n(Press to update)]"
		else
			fireanim_form =
				"animated_image[8.675,2.575;1,1;fuel_icon;gui_fire_animated.png;60;60;1]"..
				"image_button[8.675,2.575;1,1;invisible.png;fuelamt;;false;false;invisible.png]"..
				"tooltip[8.675,2.575;1,1;Fuel Left: "..ccore.get_time(ftime).." \n(Press to update)]"
		end
	end
	local winv_formspec = {
		"image[0,0;7.75,7.75;winv_bg.png]",
		-- input
		"list[nodemeta:"..spos..";input;0.25,2.125;3,3;]",
		-- arrow
		"image[4,3.375;1,1;gui_arrow.png^[transformFYR90]",
		-- multiplier
		"style[workbench_multiplier;border=false]",
		"box[4,2.125;1,1;#00000040]",
		"field[4,2.125;1,1;workbench_multiplier;;x"..meta:get_int("multiplier").."]",
		"field_close_on_enter[workbench_multiplier;false]",
		-- output
		"list[nodemeta:"..spos..";output;5.25,2.75;2,2;]",
		-- fuel
		"label[5.25,5.35;Fuel]",
		"list[nodemeta:"..spos..";fuel;5.25,5.6;1,1;]",
		"image[6.5,5.6;1,1;gui_fire_bgd.png]",
		fireanim_form,
		-- listring
		winv_listring,
		-- lock
		"style_type[image;noclip=true]",
		"image[-1.4,6.35;1.4,1.4;gui_tab.png]",
		"image_button[-1.1,6.5;1.05,1.05;"..locks.icons(pos, "workbench_furnace", {"lock", "protect", "public"}).."]",
		add
	}
	local formspec = {
		"formspec_version[4]",
		"size[10.5,9.75]",
		-- input
		"label[0.2,0.3;Input]",
		"box[0.2,0.5;3.9,3.9;#707070]",
		"list[nodemeta:"..spos..";input;0.4,0.7;3,3;]",
		-- arrow
		"image[4.25,2.05;0.8,0.8;gui_arrow.png^[transformFYR90]",
		-- multiplier
		"style[workbench_multiplier;border=false]",
		"box[4.25,1.325;0.8,0.7;#707070]",
		"field[4.25,1.325;0.8,0.7;workbench_multiplier;;x"..meta:get_int("multiplier").."]",
		"field_close_on_enter[workbench_multiplier;false]",
		-- output
		"label[5.2,0.925;Output]",
		"box[5.2,1.125;2.65,2.65;#707070]",
		"list[nodemeta:"..spos..";output;5.4,1.325;2,2;]",
		-- fuel
		"label[8.05,0.925;Fuel]",
		"box[8.05,1.125;2.25,2.65;#707070]",
		"list[nodemeta:"..spos..";fuel;8.675,1.325;1,1;]",
		"image[8.675,2.575;1,1;gui_fire_bgd.png]",
		fireanim_form,
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
	if winv_exists then
		return winv.init_inventory(player, table.concat(winv_formspec, ""))
	else
		return table.concat(formspec, "")
	end
end

local function show_formspec(pos, player, add)
	local playername = player:get_player_name()
	minetest.show_formspec(playername, "workbench:furnace", formspec_cooking(pos, player, add))
end

local function apply_craft_result(pos, multiplier)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local craftlist = inv:get_list("input")
	local output = workbench.craft_output(craftlist, "cooking", nil, 3, multiplier)
	if output and output.item and meta:get_int("fueltime") > 0 then -- sufficient fuel and valid output
		inv:set_list("output", output.item)
	end
end

local function inactive_furnace(pos, player)
	local meta = minetest.get_meta(pos)
	ccore.swap_node(pos, "workbench:furnace")
	meta:set_int("fueltime", 0)
	locks.init_infotext(pos, "Furnace", "Inactive")
	if player then
		show_formspec(pos, player)
	end
end

local function fuel_update(pos, passive, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local craftlist = inv:get_list("input")
	local fuellist = inv:get_list("fuel")
	local multiplier = meta:get_int("multiplier")
	if meta:get_int("fueltime") > 0 then -- if fueltimer running
		local c_ftime = meta:get_int("fueltime")
		meta:set_int("fueltime", c_ftime - 1)
		locks.init_infotext(pos, "Furnace", "Active (Fuel Left: "..ccore.get_time(c_ftime - 1).. ")")
		minetest.get_node_timer(pos):start(1)
		if not passive and player then
			show_formspec(pos, player)
		end
		-- reduce timer by 1
	elseif meta:get_int("fueltime") <= 0 then -- if fueltimer empty
		local ftime, fdinput = workbench:get_fuel(fuellist)
		if passive then -- on passive timer (without player interaction)
			inactive_furnace(pos, player)
		else -- on active timer (timer started by player interaction)
			local output = workbench.craft_output(craftlist, "cooking", nil, 3, multiplier)
			if ftime and ftime > 0 and output and output.item then -- valid fuel and output > restart cooking
				locks.init_infotext(pos, "Furnace", "Active (Fuel Left: "..ccore.get_time(ftime).. ")")
				ccore.swap_node(pos, "workbench:furnace_active")
				inv:set_list("fuel", fdinput) -- take fuel
				meta:set_int("fueltime", ftime)
				minetest.get_node_timer(pos):start(1)
				-- start crafting
				if inv:is_empty("input") ~= true and inv:is_empty("output") then
					apply_craft_result(pos, multiplier)
				end
				if player then
					show_formspec(pos, player)
				end
			else -- no more valid fuel / output > end cooking
				inactive_furnace(pos, player)
			end
		end
	end
end

local function furnace_update(pos, listname, index, stack, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local craftlist = inv:get_list("input")
	local outlist = inv:get_list("output")
	local multiplier = meta:get_int("multiplier")
	if listname == "fuel" then
		fuel_update(pos, nil, player)
	end
	-- apply craft when output is empty
	if listname == "input" then
		inv:set_list("output", {})
		apply_craft_result(pos, multiplier)
		fuel_update(pos, nil, player)
	end
	-- remove items when taking from output
	if listname == "output" then
		local output = workbench.craft_output(craftlist, "cooking", nil, 3, multiplier)
		local remainder = workbench.output_stack(outlist)
		-- ensure there's nothing remaining in the output list, otherwise prevent modifying the input list
		if output and output.dinput and meta:get_string("crafted") == "" then
			inv:set_list("input", output.dinput)
			if remainder > 0 then
				meta:set_string("crafted", "remainder")
			end
		end
		if remainder == 0 then
			meta:set_string("crafted", "")
		end
		-- if theres spare input, apply crafting again
		if inv:is_empty("input") ~= true and inv:is_empty("output") then
			apply_craft_result(pos, multiplier)
			fuel_update(pos, nil, player)
		end
	end
end

local function furnace_on_construct(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	inv:set_size("input", 3*3)
	inv:set_size("fuel", 1)
	inv:set_size("output", 2*2)
	meta:set_string("lock", "lock")
	meta:set_int("multiplier", 1)
	meta:set_string("crafted", "")
	meta:set_string("owner", "")
	meta:set_int("fueltime", 0)
	locks.init_infotext(pos, "Furnace", "Inactive")
end

local function furnace_after_place_node(pos, placer, itemstack, pointed_thing)
	local meta = minetest.get_meta(pos)
	local playername = placer:get_player_name()
	meta:set_string("owner", playername)
	locks.init_infotext(pos, "Furnace", "Inactive")
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
			local playername = workbench.furnace[minetest.pos_to_string(pos)] or ""
			local player = minetest.get_player_by_name(playername)
			fuel_update(pos, true, player)
		end,
		on_construct = furnace_on_construct,
		after_place_node = furnace_after_place_node,
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			local playername = clicker:get_player_name()
			local meta = minetest.get_meta(pos)
			if not meta or meta and meta:get_string("owner") == "" then -- recreate meta if it doesnt exist
				furnace_on_construct(pos)
				furnace_after_place_node(pos, clicker, itemstack, pointed_thing)
			end

			if not locks.can_access(pos, clicker) then
				return itemstack
			end
			show_formspec(pos, clicker)
			workbench.furnace[playername] = pos
			workbench.furnace[minetest.pos_to_string(pos)] = playername
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
			if to_list == "output" then
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
	})
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "workbench:furnace" or not player then
		return
	end
	local playername = player:get_player_name()
	local pos = workbench.furnace[playername]
	if not pos then
		return
	end
	local meta = minetest.get_meta(pos)
	if not locks.can_access(pos, player) then
		return
	end
	if locks.fields(pos, player, fields, "workbench_furnace", "Furance") then
		fuel_update(pos, nil, player)
	end
	if fields.fuelamt then
		fuel_update(pos, nil, player)
	end
	if fields.key_enter_field == "workbench_multiplier" then
		local sub_multiplier = string.gsub(fields.workbench_multiplier, "x", "")
		if tonumber(sub_multiplier) then
			local multiplier = tonumber(sub_multiplier)
			if meta:get_int("multiplier") ~= multiplier then -- ensure there's changes in multiplier for update
				if multiplier > 99 then
					multiplier = 99
				elseif multiplier < 1 then
					multiplier = 1
				end
				meta:set_int("multiplier", multiplier)
				furnace_update(pos, "input", nil, nil, player)
			end
		end
	end
	if fields.quit then
		workbench.furnace[playername] = nil
		workbench.furnace[minetest.pos_to_string(pos)] = nil
	end
	if winv_exists and not fields.quit then
		winv.node_receive_fields(player, formname, fields)
		if winv.node_refresh(player) then
			show_formspec(pos, player)
		end
	end
end)

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