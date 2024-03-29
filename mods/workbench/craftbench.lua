workbench.craftbench = {}
local winv_exists = minetest.global_exists("winv")
local function formspec_crafting(pos, player, add)
	local spos = pos.x..","..pos.y..","..pos.z
	local meta = minetest.get_meta(pos)
	local winv_listring = ""
	if winv_exists then
		local playername = player:get_player_name()
		local right_inv = winv.get_inventory(player, "right")
		if right_inv == "player" then
			winv_listring =
				"listring[current_player;main]"..
				"listring[nodemeta:"..spos..";input]"..
				"listring[current_player;main]"..
				"listring[nodemeta:"..spos..";output]"
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
	end
	local winv_formspec = {
		"image[0,0;7.75,10.25;winv_bg.png]",
		-- input
		"list[nodemeta:"..spos..";input;0.875,0.25;5,5;]",
		-- arrow
		"image[3.375,6.5;1,1;gui_arrow.png^[transformFY]",
		-- multiplier
		"style[workbench_multiplier;border=false]",
		"box[4.625,6.5;1,1;#00000040]",
		"field[4.625,6.5;1,1;workbench_multiplier;;x"..meta:get_int("multiplier").."]",
		"field_close_on_enter[workbench_multiplier;false]",
		-- output
		"list[nodemeta:"..spos..";output;2.75,7.75;2,2;]",
		winv_listring,
		-- lock
		"style_type[image;noclip=true]",
		"image[-1.4,8.8;1.4,1.4;gui_tab.png]",
		"image_button[-1.1,8.95;1.05,1.05;"..locks.icons(pos, "workbench_craftbench", {"lock", "protect", "public"}).."]",
		add
	}
	local formspec = {
		"formspec_version[4]",
		"size[10.5,12.25]",
		-- input
		"label[0.2,0.3;Crafting Grid]",
		"box[0.2,0.5;6.4,6.4;#707070]",
		"list[nodemeta:"..spos..";input;0.4,0.7;5,5;]",
		-- arrow
		"image[6.75,3.3;0.8,0.8;gui_arrow.png^[transformFYR90]",
		-- multiplier
		"style[workbench_multiplier;border=false]",
		"box[6.75,2.575;0.8,0.7;#707070]",
		"field[6.75,2.575;0.8,0.7;workbench_multiplier;;x"..meta:get_int("multiplier").."]",
		"field_close_on_enter[workbench_multiplier;false]",
		-- output
		"label[7.7,2.175;Output]",
		"box[7.7,2.375;2.65,2.65;#707070]",
		"list[nodemeta:"..spos..";output;7.9,2.575;2,2;]",
		-- player
		"list[current_player;main;0.4,7.1;8,4;]",
		-- listring
		"listring[nodemeta:"..spos..";output]",
		"listring[current_player;main]",
		"listring[nodemeta:"..spos..";input]",
		"listring[current_player;main]",
		-- lock
		"style_type[image;noclip=true]",
		"image[-1.4,5.5;1.4,1.4;gui_tab.png]",
		"image_button[-1.1,5.65;1.05,1.05;"..locks.icons(pos, "workbench_craftbench", {"lock", "protect", "public"}).."]",
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
	minetest.show_formspec(playername, "workbench:craftbench", formspec_crafting(pos, player, add))
end

local function apply_craft_result(pos, listname, index, stack, player, multiplier)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local craftlist = inv:get_list("input")
	local output = workbench.craft_output(craftlist, "normal", nil, 5, multiplier)
	if output and output.item then
		inv:set_list("output", output.item)
	else
		inv:set_list("output", {})
	end
end

local function craftbench_update(pos, listname, index, stack, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local craftlist = inv:get_list("input")
	local outlist = inv:get_list("output")
	local multiplier = meta:get_int("multiplier")
	-- update output list when item placed in input
	if listname == "input" then
		apply_craft_result(pos, listname, index, stack, player, multiplier)
	end
	-- remove items when taking from output
	if listname == "output" then
		local output = workbench.craft_output(craftlist, "normal", nil, 5, multiplier)
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
			apply_craft_result(pos, listname, index, stack, player, multiplier)
		end
	end
end

local function craftbench_on_construct(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	inv:set_size("input", 5*5)
	inv:set_size("fuel", 1)
	inv:set_size("output", 2*2)
	meta:set_string("lock", "lock")
	meta:set_int("multiplier", 1)
	meta:set_string("crafted", "")
	meta:set_string("owner", "")
	locks.init_infotext(pos, "Craftbench")
end

local function craftbench_after_place_node(pos, placer, itemstack, pointed_thing)
	local meta = minetest.get_meta(pos)
	local playername = placer:get_player_name()
	meta:set_string("owner", playername)
	locks.init_infotext(pos, "Craftbench")
end

minetest.register_node("workbench:craftbench", {
	description = "Craftbench",
	drawtype = "mesh",
	mesh = "workbench_craftbench.obj",
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
			{-0.4375, 0.5, 0.25, 0.4375, 1.5, 0.4375},
		},
	},
	groups = {choppy = 2,oddly_breakable_by_hand = 2},
	tiles = {"workbench_craftbench.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	use_texture_alpha = "opaque",
	sounds = default.node_sound_wood_defaults(),
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
	end,
	on_construct = craftbench_on_construct,
	after_place_node = craftbench_after_place_node,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		local playername = clicker:get_player_name()
		local meta = minetest.get_meta(pos)
		if not meta or meta and meta:get_string("owner") == "" then -- recreate meta if it doesnt exist
			craftbench_on_construct(pos)
			craftbench_after_place_node(pos, clicker, itemstack, pointed_thing)
		end

		if not locks.can_access(pos, clicker) then
			return itemstack
		end
		show_formspec(pos, clicker)
		workbench.craftbench[playername] = pos
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
		craftbench_update(pos, listname, index, stack, player)
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		craftbench_update(pos, listname, index, stack, player)
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		local stack = meta:get_inventory():get_stack(from_list, from_index)
		craftbench_update(pos, from_list, from_index, stack, player)
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
				minetest.chat_send_player(playername, "[Craftbench] Please remove all output items first.")
				return 0
			end
		else
			return 0
		end
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
				minetest.chat_send_player(playername, "[Craftbench] Please remove all output items first.")
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
				minetest.chat_send_player(playername, "[Craftbench] Please remove all output items first.")
				return 0
			end
		else
			return 0
		end
	end
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "workbench:craftbench" or not player then
		return
	end
	local playername = player:get_player_name()
	local pos = workbench.craftbench[playername]
	local meta = minetest.get_meta(pos)
	if not locks.can_access(pos, player) then
		return
	end
	if locks.fields(pos, player, fields, "workbench_craftbench", "Craftbench") then
		show_formspec(pos, player)
	end
	if fields.key_enter_field == "workbench_multiplier" then
		local sub_multiplier = string.gsub(fields.workbench_multiplier, "x", "")
		if tonumber(sub_multiplier) then
			local multiplier = tonumber(sub_multiplier)
			if multiplier > 99 then
				multiplier = 99
			elseif multiplier < 1 then
				multiplier = 1
			end
			meta:set_int("multiplier", multiplier)
			craftbench_update(pos, "input")
			show_formspec(pos, player)
		end
	end
	if winv_exists and not fields.quit then
		winv.node_receive_fields(player, formname, fields)
		if winv.node_refresh(player) then
			show_formspec(pos, player)
		end
	end
end)