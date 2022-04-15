local function formspec_crafting(pos, add)
	local spos = pos.x..","..pos.y..","..pos.z
	local formspec = {
		"formspec_version[4]",
		"size[10.5,12.25]",
		-- input
		"label[0.2,0.3;Crafting Grid]",
		"box[0.2,0.5;6.4,6.4;#707070]",
		"list[nodemeta:"..spos..";input;0.4,0.7;5,5;]",
		-- arrow
		"image[6.75,3.3;0.8,0.8;gui_arrow.png^[transformFYR90]",
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
		add
	}
	return table.concat(formspec, "")
end

local function apply_craft_result(pos, listname, index, stack, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local craftlist = inv:get_list("input")
	local output = workbench.craft_output(craftlist, "normal", nil, 5)
	if output then
		inv:set_list("output", output)
	else
		inv:set_list("output", {})
	end
end

local function craftbench_update(pos, listname, index, stack, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local craftlist = inv:get_list("input")
	local outlist = inv:get_list("output")
	-- update output list when item placed in input
	if listname == "input" then
		apply_craft_result(pos, listname, index, stack, player)
	end
	-- remove items when taking from output
	if listname == "output" then
		local _, _, d_input = workbench.craft_output(craftlist, "normal", nil, 5)
		local remainder = workbench.output_count(outlist)
		-- ensure there's nothing remaining in the output list, otherwise prevent modifying the input list
		if remainder == 0 then
			meta:set_string("crafted", "")
		elseif remainder > 0 then
			meta:set_string("crafted", "remainder")
		end
		if d_input and meta:get_string("crafted") == "" then
			inv:set_list("input", d_input)
		end
		if inv:is_empty("input") ~= true and inv:is_empty("output") then
			apply_craft_result(pos, listname, index, stack, player)
		end
	end
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
			return true
		end
		return false
	end,
	on_timer = function(pos, elapsed)
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size("input", 5*5)
		inv:set_size("fuel", 1)
		inv:set_size("output", 2*2)
		meta:set_string("formspec", formspec_crafting(pos))
		meta:set_string("crafted", "")
		meta:set_string("owner", "")
		meta:set_string("infotext", "Craftbench")
	end,
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		local meta = minetest.get_meta(pos)
		local playername = placer:get_player_name()
		meta:set_string("owner", playername)
		meta:set_string("infotext", "Craftbench \n(Owned by "..playername..")")
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
	end,
})