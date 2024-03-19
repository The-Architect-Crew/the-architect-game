workbench.furnace = {}

local function formspec_cooking(pos, player, add)
	local meta = minetest.get_meta(pos)
	local spos = pos.x..","..pos.y..","..pos.z
	local winv_listring = ""
	local playername = player:get_player_name()
	local right_inv = winv.get_inventory(player, "right")
	if right_inv == "player" then
		winv_listring =
			"listring[nodemeta:"..spos..";output]"..
			"listring[current_player;main]"..
			"listring[nodemeta:"..spos..";input]"..
			"listring[current_player;main]"
	elseif right_inv == "crafting" then
		winv_listring =
			"listring[nodemeta:"..spos..";input]"..
			"listring[detached:winv_craft_"..playername..";input]"..
			"listring[nodemeta:"..spos..";input]"..
			"listring[nodemeta:"..spos..";output]"..
			"listring[detached:winv_craft_"..playername..";input]"..
			"listring[detached:winv_craft_"..playername..";output]"
	elseif right_inv == "craftguide" then
		winv_listring =
			"listring[detached:winv_creative_"..playername..";main]"..
			"listring[nodemeta:"..spos..";input]"..
			"listring[detached:trash;main]"..
			"listring[nodemeta:"..spos..";output]"..
			"listring[detached:trash;main]"
	end

	local winv_formspec = {
		"image[0,0;7.75,7.75;winv_bg.png]",
		-- input
		"list[nodemeta:"..spos..";input;0.25,3.25;1,1;]",
		-- arrow
		"image[3.25,3.25;1,1;gui_arrow.png^[transformFYR90]",
		-- multiplier
		"style[workbench_multiplier;border=false]",
		"box[3.25,2.125;1,1;#00000040]",
		"field[3.25,2.125;1,1;workbench_multiplier;;x"..meta:get_int("multiplier").."]",
		"field_close_on_enter[workbench_multiplier;false]",
		-- output
		"list[nodemeta:"..spos..";output;6.5,3.25;1,1;]",
		"animated_image[3.25,4.25;1,1;fuel_icon;gui_fire_animated.png;60;60;1]",
		-- listring
		winv_listring,
		-- lock
		"style_type[image;noclip=true]",
		"image[-1.4,6.35;1.4,1.4;gui_tab.png]",
		"image_button[-1.1,6.5;1.05,1.05;"..locks.icons(pos, "workbench_furnace", {"lock", "protect", "public"}).."]",
		add
	}
	return winv.init_inventory(player, table.concat(winv_formspec, ""))
end

local function show_formspec(pos, player, add)
	local playername = player:get_player_name()
	minetest.show_formspec(playername, "workbench:furnace", formspec_cooking(pos, player, add))
end

local function apply_craft_result(pos, multiplier)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local craftlist = inv:get_list("input")
	local output = workbench.craft_output(craftlist, "cooking", nil, 1, multiplier)
	if output and output.item then -- valid output
		inv:set_list("output", output.item)
	end
end

local function furnace_update(pos, listname, index, stack, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local craftlist = inv:get_list("input")
	local outlist = inv:get_list("output")
	local multiplier = meta:get_int("multiplier")

	-- apply craft when output is empty
	if listname == "input" then
		inv:set_list("output", {})
		apply_craft_result(pos, multiplier)
	end
	-- remove items when taking from output
	if listname == "output" then
		local output = workbench.craft_output(craftlist, "cooking", nil, 1, multiplier)
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
		end
	end
end

local function furnace_on_construct(pos, material_description)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	inv:set_size("input", 1*1)
	inv:set_size("output", 1*1)
	meta:set_string("lock", "lock")
	meta:set_int("multiplier", 1)
	meta:set_string("crafted", "")
	meta:set_string("owner", "")
	meta:set_string("material", material_description)
	locks.init_infotext(pos, material_description .. " Furnace")
end

local function furnace_after_place_node(pos, material_description, placer, itemstack, pointed_thing)
	local meta = minetest.get_meta(pos)
	local playername = placer:get_player_name()
	meta:set_string("owner", playername)
	meta:set_string("material", material_description)
	locks.init_infotext(pos, material_description .. " Furnace")
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
	if locks.fields(pos, player, fields, "workbench_furnace", 	meta:get_string("material") .. " Furnace") then
		show_formspec(pos, player)
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
	if not fields.quit then
		winv.node_receive_fields(player, formname, fields)
		if winv.node_refresh(player) then
			show_formspec(pos, player)
		end
	end
end)

-- Registration

function workbench.register_furnace(modname, material)
	local base_definition = minetest.registered_nodes[material]
	local sname = string.match(material, ':(.*)')
	local description = base_definition.description .. " Furnace"
	local sounds = base_definition.sounds
	minetest.register_node(modname .. ":furnace_" .. sname, {
		description = description,
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
		groups = {dig_immediate = 3},
		tiles = {"variations_" .. sname .. ".png^[sheet:3x3:1,0", "(variations_" .. sname .. ".png^[sheet:3x3:1,0)^[contrast:0:-64",
			{
				name = "blocks_fire_animated.png",
				animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0}
			}, "workbench_furnace.png",
		},
		light_source = 8,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		use_texture_alpha = "clip",
		sounds = sounds,
		can_dig = function(pos, player)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			if inv:is_empty("input") and inv:is_empty("output") then -- ensure table is empty
				if locks.can_access(pos, player) == true then
					return true
				end
			end
			return false
		end,
		on_construct = function(pos)
			furnace_on_construct(pos, ccore.strip_newlines(base_definition.description))
		end,
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			furnace_after_place_node(pos, ccore.strip_newlines(base_definition.description), placer, itemstack, pointed_thing)
		end,
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
			elseif listname == "output" then
				return stack:get_count()
			else
				return 0
			end
		end,
		allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
			if not locks.can_access(pos, player) then
				return 0
			end
			-- disallow moving things in from within inventory to output
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