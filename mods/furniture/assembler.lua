furniture.assembler = {}

local function assembler_formspec_crafting(pos, player, add)
	local spos = pos.x..","..pos.y..","..pos.z
	local meta = minetest.get_meta(pos)
	local winv_listring = ""
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
	local winv_formspec = {
		"image[0,0;7.75,10.25;winv_bg.png]",
		"list[nodemeta:"..spos..";input;0.875,0.25;5,5;]",
		"image[3.375,6.5;1,1;gui_arrow.png^[transformFY]",
		"style[furniture_multiplier;border=false]",
		"box[4.625,6.5;1,1;#00000040]",
		"field[4.625,6.5;1,1;furniture_multiplier;;x"..meta:get_int("multiplier").."]",
		"field_close_on_enter[furniture_multiplier;false]",
		"list[nodemeta:"..spos..";output;3.35,7.75;1,1;]",
		winv_listring,
		"style_type[image;noclip=true]",
		"image[-1.4,8.8;1.4,1.4;gui_tab.png]",
		"image_button[-1.1,8.95;1.05,1.05;"..locks.icons(pos, "furniture_assembler", {"lock", "protect", "public"}).."]",
		add
	}
	return winv.init_inventory(player, table.concat(winv_formspec, ""))
end

local function assembler_show_formspec(pos, player, add)
	local playername = player:get_player_name()
	minetest.show_formspec(playername, "furniture:assembler", assembler_formspec_crafting(pos, player, add))
end

local function assembler_apply_craft_result(pos, listname, index, stack, player, multiplier)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local craftlist = inv:get_list("input")
	local output = workbench.craft_output(craftlist, "furniture", nil, 5, multiplier, nil)

	if output and output.item then
		inv:set_list("output", output.item)
	else
		inv:set_list("output", {})
	end
end

local function assembler_update(pos, listname, index, stack, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local craftlist = inv:get_list("input")
	local outlist = inv:get_list("output")
	local multiplier = meta:get_int("multiplier")

	if listname == "input" then
		assembler_apply_craft_result(pos, listname, index, stack, player, multiplier)
	end

	if listname == "output" then
		local output = workbench.craft_output(craftlist, "furniture", nil, 5, multiplier, nil)
		local remainder = workbench.output_stack(outlist)

		if output and output.dinput and meta:get_string("crafted") == "" then
			inv:set_list("input", output.dinput)
			if remainder > 0 then
				meta:set_string("crafted", "remainder")
			end
		end
		if remainder == 0 then
			meta:set_string("crafted", "")
		end

		if inv:is_empty("input") ~= true and inv:is_empty("output") then
			assembler_apply_craft_result(pos, listname, index, stack, player, multiplier)
		end
	end
end

local function assembler_on_construct(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	inv:set_size("input", 5*5)
	inv:set_size("output", 1*1)
	meta:set_string("lock", "lock")
	meta:set_int("multiplier", 1)
	meta:set_string("crafted", "")
	meta:set_string("owner", "")
	locks.init_infotext(pos, "Furniture Assembler")
end

local function assembler_after_place_node(pos, placer, itemstack, pointed_thing)
	local meta = minetest.get_meta(pos)
	local playername = placer:get_player_name()
	meta:set_string("owner", playername)
	locks.init_infotext(pos, "Furniture Assembler")
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "furniture:assembler" or not player then
		return
	end
	local playername = player:get_player_name()
	local pos = furniture.assembler[playername]
	local meta = minetest.get_meta(pos)
	if not locks.can_access(pos, player) then
		return 0
	end
	if locks.fields(pos, player, fields, "furniture_assembler", "Furniture Assembler") then
		assembler_show_formspec(pos, player)
	end
	if fields.key_enter_field == "furniture_multiplier" then
		local sub_multiplier = string.gsub(fields.furniture_multiplier, "x", "")
		if tonumber(sub_multiplier) then
			local multiplier = tonumber(sub_multiplier)
			if multiplier > 99 then
				multiplier = 99
			elseif multiplier < 1 then
				multiplier = 1
			end
			meta:set_int("multiplier", multiplier)
			assembler_update(pos, "input")
			assembler_show_formspec(pos, player)
		end
	end
	if not fields.quit then
		winv.node_receive_fields(player, formname, fields)
		if winv.node_refresh(player) then
			assembler_show_formspec(pos, player)
		end
	end
end)

-- Registration
for i=1,#furniture.craftstation_materials do
	local material = furniture.craftstation_materials[i]
	local secondary_tile = {name = "variations_steelblock.png^[sheet:3x3:1,0", backface_culling = true}
	if (type(furniture.craftstation_materials[i]) == "table") then
		material = furniture.craftstation_materials[i][1]
		local secondary_material = furniture.craftstation_materials[i][2]
		local secondary_sname = string.match(secondary_material, ':(.*)')
		secondary_tile = {name = "variations_" .. secondary_sname .. ".png^[sheet:3x3:1,0", backface_culling = true}
	end
	local base_definition = minetest.registered_nodes[material]
	local sname = string.match(material, ':(.*)')
	local description = base_definition.description .. " Furniture Assembler"
	local groups = table.copy(base_definition.groups)
	groups.dig_immediate = 3
	local sounds = base_definition.sounds
	local box = {-16/16, -8/16, -8/16, 16/16, 23/16, 8/16}
	minetest.register_node("furniture:assembler_" .. sname, {
		drawtype = "mesh",
		mesh = "assembler.obj",
		selection_box = {
			type = "fixed",
			fixed = box,
		},
		collision_box = {
			type = "fixed",
			fixed = box,
		},
		tiles = {{name = "variations_" .. sname .. ".png^[sheet:3x3:1,0", backface_culling = true}, secondary_tile,
				{
					name = "furniture_assembler_animated.png",
					animation = {
					type = "vertical_frames",
					aspect_w = 16,
					aspect_h = 16,
					length = 2.0,
				},
				},
		{name = "furniture_assembler_static.png", backface_culling = true},
		{name = "furniture_assembler_void.png", backface_culling = true}},
		description = description,
		paramtype = "light",
		paramtype2 = "facedir",
		groups = groups,
		sounds = sounds,
		can_dig = function(pos, player)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			if inv:is_empty("input") and inv:is_empty("output") then
				if locks.can_access(pos, player) == true then
					return true
				end
			end
			return false
		end,
		on_construct = assembler_on_construct,
		after_place_node = assembler_after_place_node,
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			local playername = clicker:get_player_name()
			local meta = minetest.get_meta(pos)
			if not meta or meta and meta:get_string("owner") == "" then
				assembler_on_construct(pos)
				assembler_after_place_node(pos, clicker, itemstack, pointed_thing)
			end

			if not locks.can_access(pos, clicker) then
				return itemstack
			end
			assembler_show_formspec(pos, clicker)
			furniture.assembler[playername] = pos
		end,
		on_metadata_inventory_put = function(pos, listname, index, stack, player)
			assembler_update(pos, listname, index, stack, player)
		end,
		on_metadata_inventory_take = function(pos, listname, index, stack, player)
			assembler_update(pos, listname, index, stack, player)
		end,
		on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
			local meta = minetest.get_meta(pos)
			local stack = meta:get_inventory():get_stack(from_list, from_index)
			assembler_update(pos, from_list, from_index, stack, player)
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
					minetest.chat_send_player(playername, "[Furniture Assembler] Please remove all output items first.")
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
					minetest.chat_send_player(playername, "[Furniture Assembler] Please remove all output items first.")
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

			if to_list == "output" then
				return 0
			end

			if from_list == "input" then
				local meta = minetest.get_meta(pos)
				local stack = meta:get_inventory():get_stack(from_list, from_index)
				if meta:get_string("crafted") == "" then
					return stack:get_count()
				else
					local playername = player:get_player_name()
					minetest.chat_send_player(playername, "[Furniture Assembler] Please remove all output items first.")
					return 0
				end
			else
				return 0
			end
		end
	})
end