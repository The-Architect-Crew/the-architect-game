local function apply_craft_result(inv, player)
	local meta = player:get_meta()
	local multiplier = meta:get_int("winv_craft_multiplier")
	local craftlist = inv:get_list("input")
	local output = workbench.craft_output(craftlist, "normal", nil, 3, multiplier)
	local player_inv = player:get_inventory()
	player_inv:set_list("winv_craftinput", craftlist)

	-- update result
	if output and output.item then
		player_inv:set_list("winv_craftoutput", output.item)
		inv:set_list("output", output.item)
	else
		player_inv:set_list("winv_craftoutput", {})
		inv:set_list("output", {})
	end
end

local function apply_craft_update(inv, listname, player)
	local meta = player:get_meta()
	local multiplier = meta:get_int("winv_craft_multiplier")
	local craftlist = inv:get_list("input")
	local outlist = inv:get_list("output")
	local player_inv = player:get_inventory()
	player_inv:set_list("winv_craftoutput", outlist)

	if listname == "output" then
		local output = workbench.craft_output(craftlist, "normal", nil, 3, multiplier)
		local remainder = workbench.output_stack(outlist)
		-- ensure there's nothing remaining in the output list, otherwise prevent modifying the input list
		if output and output.dinput and meta:get_string("winv_craft_crafted") == "" then
			player_inv:set_list("winv_craftinput", output.dinput)
			inv:set_list("input", output.dinput)
			if remainder > 0 then
				meta:set_string("winv_craft_crafted", "remainder")
			end
		end
		if remainder == 0 then
			meta:set_string("winv_craft_crafted", "")
		end
		-- if theres spare input, apply crafting again
		if inv:is_empty("input") ~= true and inv:is_empty("output") then
			apply_craft_result(inv, player)
		end
	end
end

local function init_detached_craft(player)
	local name = player:get_player_name()
	local meta = player:get_meta()
	minetest.create_detached_inventory("winv_craft_"..name, {
		allow_move = function(inv, from_list, from_index, to_list, to_index, count, player2)
			if from_list == "output" or to_list == "output" then -- prevent moving items into craft output
				return 0
			end
			return count
		end,
		allow_put = function(inv, listname, index, stack, player2)
			if listname == "output" then -- prevent putting items into craft output
				return 0
			end
			return stack:get_count()
		end,
		allow_take = function(inv, listname, index, stack, player2)
			if listname == "input" then
				if meta:get_string("winv_craft_crafted") == "" then
					return stack:get_count()
				else
					local playername = player:get_player_name()
					minetest.chat_send_player(playername, "[Crafting] Please remove all output items first.")
					return 0
				end
			elseif listname == "output" then
				return stack:get_count()
			else
				return 0
			end
		end,
		on_move = function(inv, from_list, from_index, to_list, to_index, count, player2)
			apply_craft_result(inv, player2)
		end,
		on_put = function(inv, listname, index, stack, player2)
			apply_craft_result(inv, player2)
		end,
		on_take = function(inv, listname, index, stack, player2)
			if listname == "input" then
				apply_craft_result(inv, player2)
			elseif listname == "output" then
				apply_craft_update(inv, listname, player)
			end
		end,
	}, name)
	local craft_inv = minetest.get_inventory({type = "detached", name = "winv_craft_" .. name})
	craft_inv:set_size("input", 9)
	craft_inv:set_size("output", 4)
	local player_inv = player:get_inventory()
	player_inv:set_size("winv_craftinput", 9)
	player_inv:set_size("winv_craftoutput", 4)
	-- update/resume list
	craft_inv:set_list("input", player_inv:get_list("winv_craftinput"))
	craft_inv:set_list("output", player_inv:get_list("winv_craftoutput"))
end

local function multipler_reset(player)
	local meta = player:get_meta()
	local multiplier = meta:get_int("winv_craft_multiplier")
	if not multiplier or multiplier <= 0 then
		meta:set_int("winv_craft_multiplier", 1)
	end
end

minetest.register_on_joinplayer(function(player)
	multipler_reset(player)
	init_detached_craft(player)
end)

winv:register_inventory("crafting", {
	button = {
		texture = "winv_icon_craft.png",
		tooltip = "Crafting Grid",
	},
	formspec_function = function(player)
		local name = player:get_player_name()
		local meta = player:get_meta()
		multipler_reset(player)
		local multiplier = meta:get_int("winv_craft_multiplier")
		local formspec = {
			"image[0,0;7.75,7.75;winv_bg.png]",
			"list[detached:winv_craft_"..name..";input;0.25,2;3,3;]",
			"image[4,3.25;1,1;gui_arrow.png^[transformFYR90]",
			"list[detached:winv_craft_"..name..";output;5.25,2.625;2,2;]",
			"style[winv_craft_multiplier;border=false]",
			"box[4.05,2.6;0.9,0.65;#00000040]",
			"field[4.05,2.6;0.9,0.65;winv_craft_multiplier;;x"..multiplier.."]",
			"field_close_on_enter[winv_craft_multiplier;false]",
		}
		return table.concat(formspec, "")
	end,
	on_player_receive_fields = function(player, formname, fields)
		local meta = player:get_meta()
		if fields.key_enter_field == "winv_craft_multiplier" then
			local sub_multiplier = string.gsub(fields.winv_craft_multiplier, "x", "")
			if tonumber(sub_multiplier) then
				local multiplier = tonumber(sub_multiplier)
				if multiplier > 99 then
					multiplier = 99
				elseif multiplier < 1 then
					multiplier = 1
				end
				meta:set_int("winv_craft_multiplier", multiplier)
				winv.refresh(player)
				local name = player:get_player_name()
				local craft_inv = minetest.get_inventory({type = "detached", name = "winv_craft_" .. name})
				apply_craft_result(craft_inv, player)
			end
		end
	end,
})

winv:register_listring("player", "crafting", function(player)
	local name = player:get_player_name()
	local listring = {
		"listring[current_player;main]",
		"listring[detached:winv_craft_"..name..";input]",
		"listring[current_player;main]",
		"listring[detached:winv_craft_"..name..";output]",
		"listring[current_player;main]"
	}
	return table.concat(listring, "")
end)