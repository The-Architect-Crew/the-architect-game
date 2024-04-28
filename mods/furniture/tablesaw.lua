furniture.tablesaw = {}

local function tablesaw_formspec_crafting(pos, player, add)
	local meta = minetest.get_meta(pos)
	local spos = pos.x..","..pos.y..","..pos.z
	local winv_listring = ""
	local selected_category = meta:get_string("category")
    local playername = player:get_player_name()
	--local selected_category = meta:get_string("shapes_category")

	local right_inv = winv.get_inventory(player, "right")
	if right_inv == "player" then
		winv_listring =
			"listring[current_player;main]"..
			"listring[nodemeta:"..spos..";input]"..
			"listring[current_player;main]"..
			"listring[nodemeta:"..spos..";output]"..
			"listring[current_player;main]"..
			"listring[nodemeta:"..spos..";residue]"
	elseif right_inv == "crafting" then
		winv_listring =
			"listring[nodemeta:"..spos..";output]"..
			"listring[detached:winv_craft_"..playername..";input]"..
			"listring[nodemeta:"..spos..";input]"..
			"listring[detached:winv_craft_"..playername..";input]"..
			"listring[detached:winv_craft_"..playername..";output]"..
			"listring[nodemeta:"..spos..";input]"
	elseif right_inv == "craftguide" then
		winv_listring =
			"listring[detached:winv_creative_"..playername..";main]"..
			"listring[nodemeta:"..spos..";input]"..
			"listring[detached:trash;main]"..
			"listring[nodemeta:"..spos..";output]"..
			"listring[detached:trash;main]"..
			"listring[nodemeta:"..spos..";residue]"..
			"listring[detached:trash;main]"
	end

	local winv_formspec = {
		"image[0,0;7.75,10.25;winv_bg.png]",
		furniture.tablesaw.category_selection(selected_category),
		"label[0.25,0.3;Input]",
		"list[nodemeta:"..spos..";input;0.25,0.55;1,1;]",
		"label[0.25,1.8;Residue]",
		"image[0.27,2.11;0.9,0.9;gui_cube.png]",
		"list[nodemeta:"..spos..";residue;0.25,2.05;1,1;]",
		"label[0.25,3.3;Recycle]",
		"image[0.25,3.55;1,1;gui_recycle.png]",
		"list[nodemeta:"..spos..";recycle;0.25,3.55;1,1;]",
		"image[1.5,0.55;1,1;gui_arrow.png^[transformFYR90]",
		"style[tablesaw_multiplier;border=false]",
		"box[1.5,1.65;1.0,0.7;#00000040]",
		"field[1.5,1.65;1.0,0.7;tablesaw_multiplier;;x"..meta:get_int("multiplier").."]",
		"field_close_on_enter[tablesaw_multiplier;false]",
		"label[2.75,0.3;Output]",
		"list[nodemeta:"..spos..";output;2.65,0.45;4,7;]",
		winv_listring,
		"style_type[image;noclip=true]",
		"image[-1.4,8.8;1.4,1.4;gui_tab.png]",
		"image_button[-1.1,8.95;1.05,1.05;"..locks.icons(pos, "shapes_tablesaw", {"lock", "protect", "public"}).."]",
		add
	}

	return winv.init_inventory(player, table.concat(winv_formspec, ""))
end

local function tablesaw_show_formspec(pos, player, add)
	local playername = player:get_player_name()
	minetest.show_formspec(playername, "furniture:tablesaw", tablesaw_formspec_crafting(pos, player), add)
end

function furniture.tablesaw.category_selection(selected_category)
	local posx = 1.0
	local posy = 5.0
	local size = 1.0
	local padding = 0.25

	local buttons = {"style[" .. selected_category .. ";bgcolor=#AAAAAA]"}

	for _, category in ipairs(furniture.tablesaw.categories) do
		posy = posy + size + padding
		local button = "image_button[" .. posx .. "," .. posy .. ";" .. size .. "," .. size .. ";(" .. category.texture .. ")^[multiply:#AAAAAA;" .. category.craft_category .. ";]"
		local tooltip = "tooltip[" .. category.craft_category .. ";" .. category.tooltip .. "]"

		table.insert_all(buttons, {button, tooltip})
	end

	return table.concat(buttons, "")
end

furniture.tablesaw.categories = {
	{
		craft_category = "tablesaw",
		shapes_category = "shapes",
		tooltip = "Microblocks",
		texture = "shapes_crafticon_stairs.png"
	},
	{
		craft_category = "cnc",
		shapes_category = "shapes_mesh",
		tooltip = "Slopes",
		texture = "shapes_crafticon_slopes.png"
	},
}

local function tablesaw_apply_craft_result(pos, craftcat, multiplier)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local craftlist = inv:get_list("input")
	local output = workbench.craft_output(craftlist, "shapes", craftcat, 2, multiplier, true)
	if output and #output > 0 then
		local output_list = {}
		for i = 1, #output do
			output_list[i] = output[i].item[1]
		end
		inv:set_list("output", output_list)
	end
end

local function tablesaw_update(pos, listname, index, stack, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local craftlist = inv:get_list("input")
	local outlist = inv:get_list("output")
	local residuelist = inv:get_list("residue")
	local multiplier = meta:get_int("multiplier")
	local craftcat = meta:get_string("category")

	if listname == "input" then -- putting new input will always override output
		inv:set_list("output", {})
		tablesaw_apply_craft_result(pos, craftcat, multiplier)
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
					tablesaw_apply_craft_result(pos, craftcat, multiplier)
				end
				if inv:is_empty("input") then -- reset if there's no more input
					meta:set_string("crafted", "")
				end
			end
		end
	end
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
			tablesaw_apply_craft_result(pos, craftcat, multiplier)
		end
	end
	-- ensure recycle is always empty
	inv:set_list("recycle", {})
end

local function tablesaw_recycle_check(pos, stack, shapetype)
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

function tablesaw_on_construct(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	inv:set_size("input", 1)
	inv:set_size("output", 4*7)
	inv:set_size("residue", 1)
	inv:set_size("recycle", 1)
	meta:set_string("lock", "lock")
	meta:set_int("multiplier", 1)
	meta:set_string("crafted", "")
	meta:set_string("owner", "")
	meta:set_string("category", "tablesaw")
	meta:set_string("shapes_category", "shapes")
	locks.init_infotext(pos, "Shapes Tablesaw")
end

function tablesaw_after_place_node(pos, placer, itemstack, pointed_thing)
	local meta = minetest.get_meta(pos)
	local playername = placer:get_player_name()
	meta:set_string("owner", playername)
	locks.init_infotext(pos, "Shapes Tablesaw")
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "furniture:tablesaw" or not player then
		return
	end
	local playername = player:get_player_name()
	local pos = furniture.tablesaw[playername]
	local meta = minetest.get_meta(pos)
	local category = meta:get_string("category")
	if not locks.can_access(pos, player) then
		return 0
	end
	if locks.fields(pos, player, fields, "shapes_tablesaw", "Shapes Tablesaw") then
		tablesaw_show_formspec(pos, player)
	end
	if fields.key_enter_field == "tablesaw_multiplier" then
		local sub_multiplier = string.gsub(fields.tablesaw_multiplier, "x", "")
		if tonumber(sub_multiplier) and tonumber(sub_multiplier) ~= meta:get_int("multiplier") then
			local multiplier = tonumber(sub_multiplier)
			if multiplier > 100 then
				multiplier = 100
			elseif multiplier < 1 then
				multiplier = 1
			end
			meta:set_int("multiplier", multiplier)
			tablesaw_apply_craft_result(pos, category, multiplier)
			tablesaw_update(pos, "input", nil, nil, player)
		end
	end
	if not fields.quit then
		winv.node_receive_fields(player, formname, fields)
		if winv.node_refresh(player) then
			tablesaw_show_formspec(pos, player)
		end
	end
	for _,tablesaw_category in ipairs(furniture.tablesaw.categories) do
		if fields[tablesaw_category.craft_category] ~= nil then
			meta:set_string("category", tablesaw_category.craft_category)
			meta:set_string("shapes_category", tablesaw_category.shapes_category)
			tablesaw_update(pos, "input")
			tablesaw_show_formspec(pos, player)
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
	local description = base_definition.description .. " Table Saw"
	local groups = table.copy(base_definition.groups)
	groups.dig_immediate = 3
	local sounds = base_definition.sounds
	local box = {-16/16, -8/16, -10/16, 16/16, 24/16, 8/16}
	minetest.register_node("furniture:tablesaw_" .. sname, {
		drawtype = "mesh",
		mesh = "tablesaw.obj",
		selection_box = {
			type = "fixed",
			fixed = box,
		},
		collision_box = {
			type = "fixed",
			fixed = box,
		},
		tiles = {{name = "variations_" .. sname .. ".png^[sheet:3x3:1,0", backface_culling = true}, secondary_tile,
		{name = "furniture_tablesaw_static.png", backface_culling = true},
		{name = "furniture_tablesaw_void.png", backface_culling = true}, {
					name = "furniture_tablesaw_animated.png",
					animation = {
					type = "vertical_frames",
					aspect_w = 16,
					aspect_h = 16,
					length = 2.0,
				}
			}, {
				name = "furniture_tablesaw_animated2.png",
				animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
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
			if inv:is_empty("input") and inv:is_empty("residue") then
				if locks.can_access(pos, player) == true then
					return true
				end
			end
			return false
		end,
		on_construct = tablesaw_on_construct,
		after_place_node = tablesaw_after_place_node,
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			local playername = clicker:get_player_name()
			local meta = minetest.get_meta(pos)
			if not meta or meta and meta:get_string("owner") == "" then -- recreate meta if it doesnt exist
				tablesaw_on_construct(pos)
				tablesaw_after_place_node(pos, clicker, itemstack, pointed_thing)
			end

			if not locks.can_access(pos, clicker) then
				return itemstack
			end
			tablesaw_show_formspec(pos, clicker)
			furniture.tablesaw[playername] = pos
		end,
		on_metadata_inventory_put = function(pos, listname, index, stack, player)
			tablesaw_update(pos, listname, index, stack, player)
		end,
		on_metadata_inventory_take = function(pos, listname, index, stack, player)
			tablesaw_update(pos, listname, index, stack, player)
		end,
		on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
			local meta = minetest.get_meta(pos)
			local stack = meta:get_inventory():get_stack(from_list, from_index)
			tablesaw_update(pos, from_list, from_index, stack, player)
		end,
		allow_metadata_inventory_put = function(pos, listname, index, stack, player)
			local sname_shape = stack:get_name()
			if not locks.can_access(pos, player) then
				return 0
			end
			if listname == "input" then
				if shapes.registered_shape[sname_shape] then -- ensure node can be converted into shapes
					return stack:get_count()
				end
			elseif listname == "residue" then
				if string.match(sname_shape, ':shapes_(.*)_cube') then -- allowing adding cubes only
					return stack:get_count()
				end
			elseif listname == "recycle" then
				local meta = minetest.get_meta(pos)
				local shapes_category = meta:get_string("shapes_category")
				return tablesaw_recycle_check(pos, stack, shapes_category)
			end
			return 0
		end,
		allow_metadata_inventory_take = function(pos, listname, index, stack, player)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			local category = meta:get_string("category")
			local playername = player:get_player_name()
			local multiplier = meta:get_int("multiplier")
			if not locks.can_access(pos, player) then
				return 0
			end
			if listname == "input" then
				return stack:get_count()
			elseif listname == "output" then
				-- ensure enough space for residue
				local output = workbench.craft_output(inv:get_list("input"), "shapes", category, 2, multiplier, true)
				if output and output[index] and output[index].residue then
					if inv:room_for_item("residue", ItemStack(output[index].residue[1])) then
						return stack:get_count()
					else
						minetest.chat_send_player(playername, "[Shapes Tablesaw] Insufficient residue space, please clear it.")
						return 0
					end
				elseif inv:is_empty("input") then
					return stack:get_count()
				else
					minetest.chat_send_player(playername, "[Shapes Tablesaw] Invalid craft detected, please replace the crafting items.")
					return 0
				end
			elseif listname == "residue" then
				return stack:get_count()
			else
				return 0
			end
		end,
		allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			local shapes_category = meta:get_string("shapes_category")
			if not locks.can_access(pos, player) then
				return 0
			end
			-- disallow moving things in from within inventory to output
			if to_list == "output" or to_list == "residue" or to_list == "input" then
				return 0
			end
			-- only allowing output to recycle for quick recycling
			if to_list == "recycle" then
				if from_list == "output" then
					local stack = inv:get_stack(from_list, from_index)
					stack:set_count(count)
					return tablesaw_recycle_check(pos, stack, shapes_category)
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
end
