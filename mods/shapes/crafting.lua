shapes_crafting = {}
local winv_exists = minetest.global_exists("winv")
local function formspec_shapes(pos, player, def, add)
	local meta = minetest.get_meta(pos)
	local scrollval = meta:get_int("scroll")
	local spos = pos.x..","..pos.y..","..pos.z
	local output_x, output_y = def.output_x, def.output_y
	local max_scroll, fueltype, fueldesc = def.max_scroll, def.fueltype, def.fueldesc
	local ftime = meta:get_int("fueltime")
	local fireanim_form = ""
	if ftime > 0 then
		if winv_exists then
			fireanim_form =
				"animated_image[0.25,6.5;1,1;fuel_icon;gui_fire_animated.png;60;60;1]"..
				"image_button[0.25,6.5;1,1;invisible.png;fuelamt;;false;false;invisible.png]"..
				"tooltip[0.25,6.5;1,1;"..fueldesc.." left: "..ccore.get_time(ftime).." \nPress me to update!]"
		else
			fireanim_form =
				"animated_image[1.025,7.0;1,1;fuel_icon;gui_fire_animated.png;60;60;1]"..
				"image_button[1.025,7.0;1,1;invisible.png;fuelamt;;false;false;invisible.png]"..
				"tooltip[1.025,7.0;1,1;"..fueldesc.." left: "..ccore.get_time(ftime).." \nPress me to update!]"
		end
	end
	local scroll_form = ""
	if max_scroll > 0 then
		if winv_exists then
			scroll_form =
				"style[shapes_scrollbar;noclip=true]"..
				"scrollbaroptions[max="..max_scroll..";arrows=hide;thumbsize=30]"..
				"scrollbar[7.85,0.55;0.2,6.95;vertical;shapes_scrollbar;"..scrollval.."]"
		else
			scroll_form =
				"style[shapes_scrollbar;noclip=true]"..
				"scrollbaroptions[max="..max_scroll..";arrows=hide;thumbsize=30]"..
				"scrollbar[10.6,0.5;0.2,7.7;vertical;shapes_scrollbar;"..scrollval.."]"
		end
	end
	local winv_listring = ""
	if winv_exists then
		local pmeta = player:get_meta()
		local playername = player:get_player_name()
		local right_inv = pmeta:get_string("winv:right")
		if right_inv == "player" then
			winv_listring =
				"listring[current_player;main]"..
				"listring[nodemeta:"..spos..";input]"..
				"listring[current_player;main]"..
				"listring[nodemeta:"..spos..";output]"..
				"listring[current_player;main]"..
				"listring[nodemeta:"..spos..";fuel]"..
				"listring[current_player;main]"..
				"listring[nodemeta:"..spos..";residue]"..
				"listring[current_player;main]"
		elseif right_inv == "crafting" then
			winv_listring =
				"listring[nodemeta:"..spos..";output]"..
				"listring[detached:winv_craft_"..playername..";input]"..
				"listring[nodemeta:"..spos..";input]"..
				"listring[detached:winv_craft_"..playername..";input]"..
				"listring[detached:winv_craft_"..playername..";output]"..
				"listring[nodemeta:"..spos..";input]"
		elseif right_inv == "creative" then
			winv_listring =
				"listring[detached:winv_creative_"..playername..";main]"..
				"listring[nodemeta:"..spos..";input]"..
				"listring[detached:trash;main]"..
				"listring[nodemeta:"..spos..";output]"..
				"listring[detached:trash;main]"..
				"listring[nodemeta:"..spos..";fuel]"..
				"listring[detached:trash;main]"..
				"listring[nodemeta:"..spos..";residue]"..
				"listring[detached:trash;main]"
		end
	end
	local winv_formspec = {
		"image[0,0;7.75,7.75;winv_bg.png]",
		-- input
		"label[0.25,0.3;Input]",
		"list[nodemeta:"..spos..";input;0.25,0.55;1,1;]",
		-- residue
		"label[0.25,1.8;Residue]",
		"image[0.27,2.11;0.9,0.9;gui_cube.png]",
		"list[nodemeta:"..spos..";residue;0.25,2.05;1,1;]",
		"label[0.25,3.3;Recycle]",
		"image[0.25,3.55;1,1;gui_recycle.png]",
		"list[nodemeta:"..spos..";recycle;0.25,3.55;1,1;]",
		-- fuel
		"label[0.25,5;"..fueldesc.."]",
		"image[0.25,5.25;1,1;gui_fuel_"..fueltype..".png]",
		"list[nodemeta:"..spos..";fuel;0.25,5.25;1,1;]",
		"image[0.25,6.5;1,1;gui_fire_bgd.png]",
		fireanim_form,
		-- arrow
		"image[1.5,0.55;1,1;gui_arrow.png^[transformFYR90]",
		-- multiplier
		"style[shapes_station_multiplier;border=false]",
		"box[1.5,1.65;1.0,0.7;#00000040]",
		"field[1.5,1.65;1.0,0.7;shapes_station_multiplier;;x"..meta:get_int("multiplier").."]",
		"field_close_on_enter[shapes_station_multiplier;false]",
		-- output
		"label[2.75,0.3;Output]",
		scroll_form,
		"scroll_container[2.65,0.45;6.2,7.05;shapes_scrollbar;vertical]",
			"style_type[list;noclip=false]",
			"list[nodemeta:"..spos..";output;0.1,0.1;"..output_x..","..output_y..";]",
		"scroll_container_end[]",
		-- listring
		winv_listring,
		-- lock
		"style_type[image;noclip=true]",
		"image[-1.4,6.35;1.4,1.4;gui_tab.png]",
		"image_button[-1.1,6.5;1.05,1.05;"..locks.icons(pos, "shapes_station", {"lock", "protect", "public"}).."]",
		add
	}
	local formspec = {
		"formspec_version[4]",
		"size[10.5,13.55]",
		-- input
		"label[0.2,0.3;Input]",
		"box[0.2,0.5;2.65,2.65;#707070]",
		"list[nodemeta:"..spos..";input;0.4,0.7;2,3;]",
		-- residue
		"label[0.2,3.45;Residue / Recycle]",
		"box[0.2,3.65;2.65,1.4;#707070]",
		"image[0.41,3.9;0.9,0.9;gui_cube.png]",
		"list[nodemeta:"..spos..";residue;0.4,3.85;1,1;]",
		"image[1.65,3.85;1,1;gui_recycle.png]",
		"list[nodemeta:"..spos..";recycle;1.65,3.85;1,1;]",
		-- fuel
		"label[0.2,5.35;"..fueldesc.."]",
		"box[0.2,5.55;2.65,2.65;#707070]",
		"image[1.025,5.75;1,1;gui_fuel_"..fueltype..".png]",
		"list[nodemeta:"..spos..";fuel;1.025,5.75;1,1;]",
		"image[1.025,7.0;1,1;gui_fire_bgd.png]",
		fireanim_form,
		-- arrow
		"image[3,1.425;0.8,0.8;gui_arrow.png^[transformFYR90]",
		-- multiplier
		"style[shapes_station_multiplier;border=false]",
		"box[3,0.7;0.8,0.7;#707070]",
		"field[3,0.7;0.8,0.7;shapes_station_multiplier;;x"..meta:get_int("multiplier").."]",
		"field_close_on_enter[shapes_station_multiplier;false]",
		-- output
		"label[3.95,0.3;Output]",
		scroll_form,
		"box[3.95,0.5;6.4,7.7;#707070]",
		"scroll_container[4.05,0.6;6.2,7.5;shapes_scrollbar;vertical]",
			"list[nodemeta:"..spos..";output;0.1,0.1;"..output_x..","..output_y..";]",
		"scroll_container_end[]",
		-- player
		"list[current_player;main;0.4,8.4;8,4;]",
		-- listring
		"listring[nodemeta:"..spos..";output]",
		"listring[current_player;main]",
		"listring[nodemeta:"..spos..";input]",
		"listring[current_player;main]",
		"listring[nodemeta:"..spos..";fuel]",
		"listring[current_player;main]",
		"listring[nodemeta:"..spos..";residue]",
		"listring[current_player;main]",
		-- lock
		"style_type[image;noclip=true]",
		"image[-1.4,6.95;1.4,1.4;gui_tab.png]",
		"image_button[-1.1,7.1;1.05,1.05;"..locks.icons(pos, "shapes_station", {"lock", "protect", "public"}).."]",
		add
	}
	if winv_exists then
		return winv.init_inventory(player, table.concat(winv_formspec, ""))
	else
		return table.concat(formspec, "")
	end
end

local function show_formspec(pos, player, def, add) -- to do, use this, convert to rightclick
	local playername = player:get_player_name()
	minetest.show_formspec(playername, def.inactive_node, formspec_shapes(pos, player, def, add))
end

local function apply_craft_result(pos, craftcat, multiplier)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local craftlist = inv:get_list("input")
	local output = workbench.craft_output(craftlist, "shapes", craftcat, 2, multiplier, true)
	if output and #output > 0 and meta:get_int("fueltime") > 0 then -- ensure sufficient fuel and valid output
		local output_list = {}
		for i = 1, #output do
			output_list[i] = output[i].item[1]
		end
		inv:set_list("output", output_list)
	end
end

-- reset scroll value
local function scroll_reset(pos)
	local meta = minetest.get_meta(pos)
	meta:set_int("scroll", 0)
end

local function inactive_station(pos, def, player)
	local meta = minetest.get_meta(pos)
	ccore.swap_node(pos, def.inactive_node)
	meta:set_int("fueltime", 0)
	locks.init_infotext(pos, def.description, "Inactive")
	if player then
		show_formspec(pos, player, def)
	end
end

local function fuel_update(pos, def, passive, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local craftlist = inv:get_list("input")
	local fuellist = inv:get_list("fuel")
	local multiplier = meta:get_int("multiplier")
	local craftcat = def.craft_category
	local active_node = def.active_node
	local desc = def.description
	local fueltype = def.fueltype
	local fueldesc = def.fueldesc
	if meta:get_int("fueltime") > 0 then -- if fueltimer running
		local c_ftime = meta:get_int("fueltime")
		meta:set_int("fueltime", c_ftime - 1)
		locks.init_infotext(pos, desc, "Active ("..fueldesc.." Left: "..ccore.get_time(c_ftime - 1).. ")")
		minetest.get_node_timer(pos):start(1)
		if not passive and player then
			show_formspec(pos, player, def)
		end
		-- reduce timer by 1
	elseif meta:get_int("fueltime") <= 0 then -- if fueltimer empty
		local ftime, fdinput = workbench:get_fuel(fuellist, fueltype)
		if passive then -- on passive timer (without player interaction)
			inactive_station(pos, def, player)
		else -- on active timer (timer started by player interaction)
			local output = workbench.craft_output(craftlist, "shapes", craftcat, 2, multiplier, true)
			if output and #output > 0 and ftime and ftime > 0 then -- valid fuel and output > restart crafting
				locks.init_infotext(pos, desc, "Active ("..fueldesc.." Left: "..ccore.get_time(ftime).. ")")
				ccore.swap_node(pos, active_node)
				-- take fuel
				inv:set_list("fuel", fdinput)
				meta:set_int("fueltime", ftime)
				minetest.get_node_timer(pos):start(1)
				-- start crafting
				if inv:is_empty("input") ~= true and inv:is_empty("output") then
					apply_craft_result(pos, craftcat, multiplier)
					scroll_reset(pos)
				end
				if player then
					show_formspec(pos, player, def)
				end
			else -- no more valid fuel
				inactive_station(pos, def, player)
			end
		end
	end
end

local function station_update(pos, listname, index, stack, player, def)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local craftlist = inv:get_list("input")
	local outlist = inv:get_list("output")
	local residuelist = inv:get_list("residue")
	local multiplier = meta:get_int("multiplier")
	local craftcat = def.craft_category
	if listname == "fuel" then
		fuel_update(pos, def, nil, player)
	end
	if listname == "input" then -- putting new input will always override output
		inv:set_list("output", {})
		apply_craft_result(pos, craftcat, multiplier)
		fuel_update(pos, def, nil, player)
		scroll_reset(pos)
	end
	if listname == "output" then -- obtaining output applies crafting process
		local output = workbench.craft_output(craftlist, "shapes", craftcat, 2, multiplier, true)
		if output and #output > 0 then
			local coutput = output[index]
			local resitem = ItemStack(coutput.residue[1])
			local resname = resitem:get_name()
			local rescount = (resitem:get_count() * coutput.multiply) + residuelist[1]:get_count()
			if inv:is_empty("residue") or residuelist[1]:get_name() == resname or resname == "" then
				for i = 1, #output do -- remove all other outputs except the current one
					if i ~= index then
						outlist[i] = ItemStack("")
					end
				end
				inv:set_list("output", outlist)
				if meta:get_string("crafted") == "" then
					inv:set_list("input", coutput.dinput) -- update input
					if resname ~= "" then
						resitem:set_count(rescount)
						inv:set_list("residue", {resitem}) -- update residue
					end
				end
				if inv:is_empty("output") ~= true then
					meta:set_string("crafted", "remainder")
				else
					meta:set_string("crafted", "")
				end
				if inv:is_empty("input") ~= true and inv:is_empty("output") then
					apply_craft_result(pos, craftcat, multiplier)
					fuel_update(pos, def, nil, player)
				end
				if inv:is_empty("input") then -- reset if there's no more input
					meta:set_string("crafted", "")
				end
			end
		end
	end
	if listname ~= "fuel" then -- fuel timer executes this function constantly, this check here ensure its not being executed by fuel timer
		-- convert excess residue to blocks
		if inv:is_empty("residue") ~= true then
			local rstack = inv:get_stack("residue", 1)
			local rcount = rstack:get_count()
			local rname = rstack:get_name()
			if rcount >= 8 then
				local blockcount = math.floor(rcount / 8)
				local remincount = rcount % 8
				-- extract original name
				local modname = string.match(rname, '(.*):')
				local basename = string.match(rname, ':shapes_(.*)_cube')
				local basenode = modname..":"..basename
				if blockcount > 0 then
					if inv:room_for_item("input", ItemStack(basenode.." "..blockcount)) then
						--inv:set_list("residue", {})
						inv:remove_item("residue", rstack)
						inv:add_item("input", ItemStack(basenode.." "..blockcount))
						rstack:set_count(remincount)
						inv:add_item("residue", rstack)
					end
				end
			end
		end
		-- convert any excess input if there's space
		if inv:is_empty("input") ~= true then
			if inv:is_empty("output") or meta:get_string("crafted") == "" then
				apply_craft_result(pos, craftcat, multiplier)
				fuel_update(pos, def, nil, player)
			end
		end
		-- update fuel time
		-- fuel_fs_update(pos, def)
		-- ensure recycle is always empty
		inv:set_list("recycle", {})
	end
end

local function recycle_check(pos, stack, shapetype)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local sname = stack:get_name()
	if minetest.get_item_group(sname, shapetype) > 0 then -- allowing adding shapes only
		-- check if able to convert all
		local output = workbench.craft_output({stack}, "shapes", "recycle", 1)
		if output and output.item then
			local scount = stack:get_count()
			local cstack = output.item[1]
			local cname = cstack:get_name()
			local ccount = cstack:get_count() -- cube count
			local tcount = scount * ccount -- total cube count
			-- extract original name
			local modname = string.match(cname, '(.*):')
			local basename = string.match(cname, ':shapes_(.*)_cube')
			local basenode = modname..":"..basename
			-- determine block count + remainder
			local blockcount = math.floor(tcount / 8)
			local remincount = tcount % 8
			-- ensure sufficient space in both residue and input
			local blockstack = ItemStack(basenode.." "..blockcount)
			local reminstack = ItemStack(cname.." "..remincount)
			if inv:room_for_item("input", blockstack) and
				inv:room_for_item("residue", reminstack) then
				-- supply blocks accordingly
				inv:add_item("input", blockstack)
				inv:add_item("residue", reminstack)
				return stack:get_count()
			end
		end
	end
	return 0
end

local function register_shapes_station(name, def)
	local link = def.inactive_node
	shapes_crafting[link] = {}
	minetest.register_node(name, {
		description = def.description,
		drawtype = "mesh",
		mesh = def.mesh,
		selection_box = def.selection_box,
		groups = def.groups,
		tiles = def.tiles,
		light_source = def.light_source,
		drop = def.inactive_node,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		use_texture_alpha = "clip",
		sounds = default.node_sound_wood_defaults(),
		can_dig = function(pos, player)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			if inv:is_empty("input") and inv:is_empty("fuel") and inv:is_empty("residue") then -- ensure table is empty
				if locks.can_access(pos, player) == true then
					return true
				end
			end
			return false
		end,
		on_timer = function(pos, elapsed)
			local playername = shapes_crafting[link][minetest.pos_to_string(pos)] or ""
			local player = minetest.get_player_by_name(playername)
			fuel_update(pos, def, true, player)
		end,
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			--inv:set_size("input", 2*2)
			inv:set_size("input", 1)
			inv:set_size("fuel", 1)
			inv:set_size("output", def.output_x * def.output_y)
			inv:set_size("residue", 1)
			inv:set_size("recycle", 1)
			meta:set_string("lock", "lock")
			meta:set_int("multiplier", 1)
			meta:set_string("crafted", "")
			meta:set_string("owner", "")
			meta:set_int("fueltime", 0)
			meta:set_int("scroll", 0)
			locks.init_infotext(pos, def.description, "Inactive")
		end,
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			local meta = minetest.get_meta(pos)
			local playername = placer:get_player_name()
			meta:set_string("owner", playername)
			locks.init_infotext(pos, def.description, "Inactive")
		end,
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			local playername = clicker:get_player_name()
			if not locks.can_access(pos, clicker) then
				return itemstack
			end
			show_formspec(pos, clicker, def)
			shapes_crafting[link][playername] = pos
			shapes_crafting[link][minetest.pos_to_string(pos)] = playername
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
			station_update(pos, listname, index, stack, player, def)
		end,
		on_metadata_inventory_take = function(pos, listname, index, stack, player)
			station_update(pos, listname, index, stack, player, def)
		end,
		on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
			local meta = minetest.get_meta(pos)
			local stack = meta:get_inventory():get_stack(from_list, from_index)
			station_update(pos, from_list, from_index, stack, player, def)
		end,
		allow_metadata_inventory_put = function(pos, listname, index, stack, player)
			local sname = stack:get_name()
			if not locks.can_access(pos, player) then
				return 0
			end
			if listname == "input" then
				if shapes.registered_shape[sname] then -- ensure node can be converted into shapes
					return stack:get_count()
				end
			elseif listname == "fuel" then
				local ftime = workbench:get_fuel({stack}, def.fueltype)
				if ftime and ftime > 0 then
					return stack:get_count()
				end
			elseif listname == "residue" then
				if string.match(sname, ':shapes_(.*)_cube') then -- allowing adding cubes only
					return stack:get_count()
				end
			elseif listname == "recycle" then
				return recycle_check(pos, stack, def.shape_category)
			end
			return 0
		end,
		allow_metadata_inventory_take = function(pos, listname, index, stack, player)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			local playername = player:get_player_name()
			local multiplier = meta:get_int("multiplier")
			if not locks.can_access(pos, player) then
				return 0
			end
			if listname == "input" then
				return stack:get_count()
			elseif listname == "output" then
				-- ensure enough space for residue
				local output = workbench.craft_output(inv:get_list("input"), "shapes", def.craft_category, 2, multiplier, true)
				if output and output[index] and output[index].residue then
					if inv:room_for_item("residue", ItemStack(output[index].residue[1])) then
						return stack:get_count()
					else
						minetest.chat_send_player(playername, "["..def.description.."] Insufficient residue space, please clear it.")
						return 0
					end
				elseif inv:is_empty("input") then
					return stack:get_count()
				else
					minetest.chat_send_player(playername, "["..def.description.."] Invalid craft detected, please replace the crafting items.")
					return 0
				end
			elseif listname == "fuel" or listname == "residue" then
				-- update fuel
				return stack:get_count()
			else
				return 0
			end
		end,
		allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			if not locks.can_access(pos, player) then
				return 0
			end
			-- disallow moving things in from within inventory to output / fuel
			if to_list == "output" or to_list == "fuel" or to_list == "residue" or to_list == "input" then
				return 0
			end
			-- only allowing output to recycle for quick recycling
			if to_list == "recycle" then
				if from_list == "output" then
					local stack = inv:get_stack(from_list, from_index)
					stack:set_count(count)
					return recycle_check(pos, stack, def.shape_category)
				end
				return 0
			end
			-- ensure output is empty before allowing modification of input
			if from_list == "input" then
				local meta2 = minetest.get_meta(pos)
				local stack = meta2:get_inventory():get_stack(from_list, from_index)
				return stack:get_count()
			end
		end,
	})
	-- receive fields (run once with registration of inactive node)
	if not def.active then
		minetest.register_on_player_receive_fields(function(player, formname, fields)
			if formname ~= link or not player then
				return
			end
			local playername = player:get_player_name()
			local pos = shapes_crafting[link][playername]
			if not pos then
				return
			end
			local meta = minetest.get_meta(pos)
			if not locks.can_access(pos, player) then
				return 0
			end
			if locks.fields(pos, player, fields, "shapes_station", def.description) then
				station_update(pos, "fuel", nil, nil, player, def)
			end
			if fields.key_enter_field == "shapes_station_multiplier" then
				local sub_multiplier = string.gsub(fields.shapes_station_multiplier, "x", "")
				if tonumber(sub_multiplier) and tonumber(sub_multiplier) ~= meta:get_int("multiplier") then
					local multiplier = tonumber(sub_multiplier)
					if multiplier > 99 then
						multiplier = 99
					elseif multiplier < 1 then
						multiplier = 1
					end
					meta:set_int("multiplier", multiplier)
					apply_craft_result(pos, def.craft_category, multiplier)
					station_update(pos, "input", nil, nil, player, def)
				end
			end
			if fields.shapes_scrollbar then
				local scrolldis = minetest.explode_scrollbar_event(fields.shapes_scrollbar)
				meta:set_int("scroll", scrolldis.value)
			end
			if fields.quit then
				shapes_crafting[link][playername] = nil
				shapes_crafting[link][minetest.pos_to_string(pos)] = nil
			end
			if winv_exists and not fields.quit then
				winv.node_receive_fields(player, formname, fields)
				if winv.node_refresh(player) then
					show_formspec(pos, player, def)
				end
			end
		end)
	end
end

-- register mesefuel
workbench:register_fueltype("mese")

workbench:register_fuel({
	type = "mese",
	fuel = "blocks:mese",
	time = 1800,
})

workbench:register_fuel({
	type = "mese",
	fuel = "blocks:mese_crystal",
	time = 195,
})

workbench:register_fuel({
	type = "mese",
	fuel = "blocks:mese_crystal_fragment",
	time = 20,
})

register_shapes_station("shapes:tablesaw", {
	description = "Table Saw",
	mesh = "workbench_tablesaw.obj",
	craft_category = "tablesaw",
	shape_category = "shapes",
	fueltype = "normal",
	fueldesc = "Fuel",
	inactive_node = "shapes:tablesaw",
	active_node = "shapes:tablesaw_active",
	--output_x = 5,
	--output_y = 10,
	--max_scroll = 50,
	output_x = 4,
	output_y = 10,
	max_scroll = 54,
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
			{-0.125, 0.5, -0.5, 0.125, 0.75, 0.5},
		},
	},
	groups = {choppy = 2, oddly_breakable_by_hand = 2},
	tiles = {"shapes_tablesaw.png"},
})

register_shapes_station("shapes:tablesaw_active", {
	active = true,
	description = "Table Saw",
	mesh = "workbench_tablesaw.obj",
	craft_category = "tablesaw",
	shape_category = "shapes",
	fueltype = "normal",
	fueldesc = "Fuel",
	inactive_node = "shapes:tablesaw",
	active_node = "shapes:tablesaw_active",
	--output_x = 5,
	--output_y = 10,
	--max_scroll = 50,
	output_x = 4,
	output_y = 10,
	max_scroll = 54,
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
			{-0.125, 0.5, -0.5, 0.125, 0.75, 0.5},
		},
	},
	groups = {choppy = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
	tiles = {{
		name = "shapes_tablesaw_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 30,
			aspect_h = 48,
			length = 0.5,
		},
	},},
	light_source = 2,
})

register_shapes_station("shapes:cnc", {
	description = "CNC Machine",
	mesh = "workbench_cnc.obj",
	craft_category = "cnc",
	shape_category = "shapes_mesh",
	fueltype = "mese",
	fueldesc = "Fuel (Mese)",
	inactive_node = "shapes:cnc",
	active_node = "shapes:cnc_active",
	--output_x = 5,
	--output_y = 6,
	--max_scroll = 0,
	output_x = 4,
	output_y = 5,
	max_scroll = 0,
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
			{-0.4375, 0.5, -0.375, 0.4375, 1.125, 0.375},
		},
	},
	groups = {choppy = 2, oddly_breakable_by_hand = 2},
	tiles = {"shapes_cnc.png"},
})

register_shapes_station("shapes:cnc_active", {
	active = true,
	description = "CNC Machine",
	mesh = "workbench_cnc.obj",
	craft_category = "cnc",
	shape_category = "shapes_mesh",
	fueltype = "mese",
	fueldesc = "Fuel (Mese)",
	inactive_node = "shapes:cnc",
	active_node = "shapes:cnc_active",
	--output_x = 5,
	--output_y = 6,
	--max_scroll = 0,
	output_x = 4,
	output_y = 5,
	max_scroll = 0,
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
			{-0.4375, 0.5, -0.375, 0.4375, 1.125, 0.375},
		},
	},
	groups = {choppy = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
	tiles = {{
		name = "shapes_cnc_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 46,
			aspect_h = 39,
			length = 0.5,
		},
	},},
	light_source = 6,
})

minetest.register_lbm({
	name = "shapes:shapes_station",
	nodenames = {"shapes:tablesaw_active", "shapes:cnc_active"},
	action = function(pos, node)
		minetest.get_node_timer(pos):start(1)
	end
})
