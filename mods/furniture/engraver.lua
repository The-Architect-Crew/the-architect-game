furniture.engraver = {}

local function engraver_formspec_crafting(pos, player, add)
	local spos = pos.x..","..pos.y..","..pos.z
	local meta = minetest.get_meta(pos)
	local winv_listring = ""
    local playername = player:get_player_name()
	local selected_group = meta:get_string("pattern_group")
	local selected_pattern = meta:get_string("pattern_type")

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
		"list[nodemeta:"..spos..";input;0.25,0.25;1,1;0]",
		"image[6.5,0.25;1,1;dye_grey.png^[contrast:-48:-32]",
		"list[nodemeta:"..spos..";input;6.5,0.25;1,1;1]",
		furniture.engraver.tab_selection(selected_group),
		furniture.engraver.patterns_tab(selected_group, selected_pattern),
		"image[3.375,7.5;1,1;gui_arrow.png^[transformFY]",
		"style[engraver_multiplier;border=false]",
		"box[4.625,7.5;1,1;#00000040]",
		"field[4.625,7.5;1,1;engraver_multiplier;;x"..meta:get_int("multiplier").."]",
		"field_close_on_enter[engraver_multiplier;false]",
		"list[nodemeta:"..spos..";output;3.35,8.75;1,1;]",
		winv_listring,
		"style_type[image;noclip=true]",
		"image[-1.4,8.8;1.4,1.4;gui_tab.png]",
		"image_button[-1.1,8.95;1.05,1.05;"..locks.icons(pos, "pattern_engraver", {"lock", "protect", "public"}).."]",
		add
	}
	return winv.init_inventory(player, table.concat(winv_formspec, ""))
end

function furniture.engraver.tab_selection(selected_tab)
	local posx = 5.0
	local posy = 1.5
	local size = 0.5
	local padding = 0.05

	local buttons = {
		"style[" .. selected_tab .. ";bgcolor=#AAAAAA]",
		"image_button[" .. posx .. "," .. posy .. ";" .. size .. "," .. size .. ";(patterns_single_color.png^[sheet:2x3:0,0)^[multiply:#888888;single;]",
		"tooltip[single;Single Patterns]",
	}

	for _, group in ipairs(patterns.pattern_types) do
		posx = posx + size + padding
		local button = "image_button[" .. posx .. "," .. posy .. ";" .. size .. "," .. size .. ";(patterns_" .. group[1] .. "_color.png^[sheet:4x3:3,2)^[multiply:#AAAAAA;" .. group[1] .. ";]"
		local tooltip = "tooltip[" .. group[1] .. ";" .. group[2] .. " Patterns]"

		table.insert_all(buttons, {button, tooltip})
	end

	return table.concat(buttons, "")
end

function furniture.engraver.patterns_tab(group, selected_pattern)
	local buttons = {"style[" .. selected_pattern .. ";bgcolor=#AAAAAA]"}
	local posx
	local posy
	local x_offset = 1.5
	local y_offset = 3.0
	local padding = 0.25
	if group == "single" then
		for _, pattern in ipairs(patterns.patterns_single) do
			local sheet = "2x3"
			local coords = pattern.texture
			local name = group .. "_" .. pattern.name
			local pos = pattern.position
			local description = pattern.description

			posx = ((pos-1)%4) * 1.0 + ((pos-1)%4) * padding + x_offset
			posy = math.floor((pos-1)/4) + math.floor((pos-1)/4) * padding + y_offset

			table.insert_all(buttons, {"image_button[" .. posx .. "," .. posy .. ";1.0,1.0;(patterns_" .. group .. "_color.png^[sheet:" .. sheet .. ":" .. coords .. ")^[multiply:#AAAAAA;" .. name .. ";]"})
			table.insert_all(buttons, {"tooltip[" .. name .. ";" .. description .. "]"})
		end
	else
		for _, pattern in ipairs(patterns.patterns) do
			local sheet = "4x3"
			local coords = pattern.texture
			local name = group .. "_" .. pattern.name
			local pos = pattern.position
			local description = pattern.description

			posx = ((pos-1)%4) * 1.0 + ((pos-1)%4) * padding + x_offset
			posy = math.floor((pos-1)/4) + math.floor((pos-1)/4) * padding + y_offset

			table.insert_all(buttons, {"image_button[" .. posx .. "," .. posy .. ";1.0,1.0;(patterns_" .. group .. "_color.png^[sheet:" .. sheet .. ":" .. coords .. ")^[multiply:#AAAAAA;" .. name .. ";]"})
			table.insert_all(buttons, {"tooltip[" .. name .. ";" .. description .. "]"})
		end
	end
	return table.concat(buttons, "")
end

local function engraver_show_formspec(pos, player, add)
	local playername = player:get_player_name()
	minetest.show_formspec(playername, "furniture:engraver", engraver_formspec_crafting(pos, player, add))
end

local function engraver_apply_craft_result(pos, listname, index, stack, player, multiplier)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local craftlist = inv:get_list("input")

	local pattern_type = meta:get_string("pattern_type")

	local output = workbench.craft_output(craftlist, "engraving", pattern_type, 2, multiplier, nil)

	if output and output.item then
		inv:set_list("output", output.item)
	else
		inv:set_list("output", {})
	end
end

local function engraver_update(pos, listname, index, stack, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local craftlist = inv:get_list("input")
	local outlist = inv:get_list("output")
	local multiplier = meta:get_int("multiplier")
	local pattern_type = meta:get_string("pattern_type")

	if listname == "input" then
		engraver_apply_craft_result(pos, listname, index, stack, player, multiplier)
	end
	if listname == "output" then
		local output = workbench.craft_output(craftlist, "engraving", pattern_type, 2, multiplier, nil)
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
			engraver_apply_craft_result(pos, listname, index, stack, player, multiplier)
		end
	end
end

local function engraver_on_construct(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	inv:set_size("input", 2*1)
	inv:set_size("output", 1*1)
	meta:set_string("lock", "lock")
	meta:set_int("multiplier", 1)
	meta:set_string("crafted", "")
	meta:set_string("owner", "")
	meta:set_string("pattern_type", "")
	meta:set_string("pattern_group", "single")
	locks.init_infotext(pos, "Pattern Engraver")
end

local function engraver_after_place_node(pos, placer, itemstack, pointed_thing)
	local meta = minetest.get_meta(pos)
	local playername = placer:get_player_name()
	meta:set_string("owner", playername)
	locks.init_infotext(pos, "Pattern Engraver")
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "furniture:engraver" or not player then
		return
	end
	local playername = player:get_player_name()
	local pos = furniture.engraver[playername]
	local meta = minetest.get_meta(pos)
	if not locks.can_access(pos, player) then
		return 0
	end
	if locks.fields(pos, player, fields, "pattern_engraver", "Pattern Engraver") then
		engraver_show_formspec(pos, player)
	end
	if fields.key_enter_field == "engraver_multiplier" then
		local sub_multiplier = string.gsub(fields.engraver_multiplier, "x", "")
		if tonumber(sub_multiplier) then
			local multiplier = tonumber(sub_multiplier)
			if multiplier > 100 then
				multiplier = 100
			elseif multiplier < 1 then
				multiplier = 1
			end
			meta:set_int("multiplier", multiplier)
			engraver_update(pos, "input")
			engraver_show_formspec(pos, player)
		end
	end

	for _, group in ipairs(patterns.pattern_types) do
		for _, pattern in ipairs(patterns.patterns) do
			local pattern_name = group[1] .. "_" .. pattern.name
			if fields[pattern_name]~=nil then
				meta:set_string("pattern_type", pattern_name)
				engraver_update(pos, "input")
				engraver_show_formspec(pos, player)
			end
		end
	end

	for _, pattern in ipairs(patterns.patterns_single) do
		local pattern_name = "single_" .. pattern.name
			if fields[pattern_name]~=nil then
				meta:set_string("pattern_type", pattern_name)
				engraver_update(pos, "input")
				engraver_show_formspec(pos, player)
			end
	end

	if fields["single"]~=nil then
		meta:set_string("pattern_group", "single")
		engraver_update(pos, "input")
		engraver_show_formspec(pos, player)
	end

	for _, group in ipairs(patterns.pattern_types) do
		if fields[group[1]]~=nil then
			meta:set_string("pattern_group", group[1])
			engraver_update(pos, "input")
			engraver_show_formspec(pos, player)
		end
	end

	if not fields.quit then
		winv.node_receive_fields(player, formname, fields)
		if winv.node_refresh(player) then
			engraver_show_formspec(pos, player)
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
	local description = base_definition.description .. " Pattern Engraver"
	local groups = table.copy(base_definition.groups)
	groups.dig_immediate = 3
	local sounds = base_definition.sounds
	local box = {-16/16, -8/16, -16/16, 16/16, 20/16, 15/16}
	minetest.register_node("furniture:engraver_" .. sname, {
		drawtype = "mesh",
		mesh = "engraver.obj",
		selection_box = {
			type = "fixed",
			fixed = box,
		},
		collision_box = {
			type = "fixed",
			fixed = box,
		},
		tiles = {{name = "variations_" .. sname .. ".png^[sheet:3x3:1,0", backface_culling = true}, secondary_tile,
		{name = "furniture_engraver_static.png", backface_culling = true}, {
					name = "furniture_engraver_animated.png",
					animation = {
					type = "vertical_frames",
					aspect_w = 16,
					aspect_h = 16,
					length = 20.0,
				}
			}
		},
		description = description,
		use_texture_alpha = "blend",
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
		on_construct = engraver_on_construct,
		after_place_node = engraver_after_place_node,
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			local playername = clicker:get_player_name()
			local meta = minetest.get_meta(pos)
			if not meta or meta and meta:get_string("owner") == "" then
				engraver_on_construct(pos)
				engraver_after_place_node(pos, clicker, itemstack, pointed_thing)
			end

			if not locks.can_access(pos, clicker) then
				return itemstack
			end
			engraver_show_formspec(pos, clicker)
			furniture.engraver[playername] = pos
		end,
		on_metadata_inventory_put = function(pos, listname, index, stack, player)
			engraver_update(pos, listname, index, stack, player)
		end,
		on_metadata_inventory_take = function(pos, listname, index, stack, player)
			engraver_update(pos, listname, index, stack, player)
		end,
		on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
			local meta = minetest.get_meta(pos)
			local stack = meta:get_inventory():get_stack(from_list, from_index)
			engraver_update(pos, from_list, from_index, stack, player)
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
					minetest.chat_send_player(playername, "[Pattern Engraver] Please remove all output items first.")
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
					minetest.chat_send_player(playername, "[Pattern Engraver] Please remove all output items first.")
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
					minetest.chat_send_player(playername, "[Pattern Engraver] Please remove all output items first.")
					return 0
				end
			else
				return 0
			end
		end
	})
end