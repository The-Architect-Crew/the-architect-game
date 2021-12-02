wb_furnace = {}
local function fuel_icons(pos)
	if workbench.check_active(pos, "station_furnace", "furnace") then
		return "animated_image[4.775,3.525;1,1;wadawname;workbench_furnace_fire_animated.png;8;500;1]"
	else
		return "image[4.775,3.525;1,1;workbench_furnace_fire_bg.png]"
	end
end

function wb_furnace.formspec(pos, locked)
	return workbench.tabs(pos, locked)..
		"list[context;furnace_input;3.525,2.275;1,1;]"..
		fuel_icons(pos)..
		"image[4.875,2.375;0.8,0.8;workbench_arrow.png^[transformFYR90]"..
		"list[context;furnace_output;6.025,2.275;1,1;]"..
		"field[9.15,2.9;1,1;max_offered;".."Max"..":;${max_offered}]"..
		"button[9.15,4.15;1,1;Set;".."Set".."]"..
		"listring[current_player;main]"..
		"listring[context;furnace_input]"..
		"listring[current_player;main]"..
		"listring[context;furnace_output]"
end

function wb_furnace.on_receive_fields(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	local tab = meta:get_string("tab")
	local locked = meta:get_string("lock")
	local max = tonumber(fields.max_offered)
	if max and max > 0 then
		meta:set_string("max_offered",  max)
		if tab == "furnace" then
			wb_furnace.update(pos, 0)
		end
	end
	if fields.wbtab_furnace then
		meta:set_string("tab", "furnace")
		meta:set_string("formspec", wb_furnace.formspec(pos, locked))
		wb_furnace.update(pos, 0)
	end
end

function wb_furnace.on_construct(pos)
	-- set inventory sizes
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	meta:set_string("station_furnace", "")
	inv:set_size("furnace_input", 1)
	inv:set_size("furnace_output", 1)
	-- detect if there's any stations nearby
	workbench.link_to_stations(pos, "furnace", "furnace")
end

function wb_furnace.output_count(list)
	local cooked = minetest.get_craft_result({method = "cooking", width = 1, items = list})
	if cooked and cooked.item then
		local ccount = cooked.item:get_count()
		return ccount
	end
end

function wb_furnace.update(pos, amount, listname)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local max = meta:get_int("max_offered")
	if (not max or max < 1 or max > 99) then max = 99 end
	-- if moving items out of output, update input
	local stack = inv:get_stack("furnace_input", 1)
	if listname == "furnace_output" then
		local nodename = stack:get_name() or ""
		local cooklist = inv:get_list("furnace_input")
		local cooked = minetest.get_craft_result({method = "cooking", width = 1, items = cooklist})
		local incount = stack:get_count()
		local ccount = cooked.item:get_count()
		local newamt = incount - (amount / ccount)
		inv:set_list("furnace_input", {nodename.." "..newamt})
	end
	-- if no items in input
	local stack = inv:get_stack("furnace_input", 1)
	if stack:is_empty() then
		inv:set_list("furnace_input", {""})
		inv:set_list("furnace_output", {""})
		local owner = meta:get_string("owner") or ""
		if wb_lock.is_locked(pos) then
			meta:set_string("infotext", "Workbench is empty (owned by "..owner..") \nWorkbench is locked.")
		else
			meta:set_string("infotext", "Workbench is empty (owned by "..owner..")")
		end
	-- update output based on items from input
	elseif not stack:is_empty() then
		local nodename = stack:get_name() or ""
		local cooklist = inv:get_list("furnace_input")
		local cooked = minetest.get_craft_result({method = "cooking", width = 1, items = cooklist})
		if cooked and cooked.item then
			local incount = stack:get_count()
			local stackname = stack:get_name()
			local ccount = cooked.item:get_count()
			local cname = cooked.item:get_name()
			local snameshort = stackname:match(":(.*)")
			local owner = meta:get_string("owner") or ""
			if wb_lock.is_locked(pos) then
				meta:set_string("infotext", "Workbench is cooking "..snameshort.." (owned by "..owner..") \nWorkbench is locked.")
			else
				meta:set_string("infotext", "Workbench is cooking "..snameshort.." (owned by "..owner..")")
			end
			-- ensure count matches max count set
			local newamt = ccount * incount
			if newamt > max then
				local rem = max % ccount
				local newamt2 = max - rem
				inv:set_list("furnace_input", {nodename.." "..incount})
				inv:set_list("furnace_output", {cname.." "..newamt2})
			else
				inv:set_list("furnace_output", {cname.." "..newamt})
			end
		end
	else
		inv:set_list("furnace_input", {""})
		inv:set_list("furnace_output", {""})
		local owner = meta:get_string("owner") or ""
		if wb_lock.is_locked(pos) then
			meta:set_string("infotext", "Workbench is empty (owned by "..owner..") \nWorkbench is locked.")
		else
			meta:set_string("infotext", "Workbench is empty (owned by "..owner..")")
		end
	end
end

function wb_furnace.allow_metadata_inventory_put(pos, listname, index, stack, player)
	local stackname = stack:get_name()
	local count = stack:get_count()
	if listname == "furnace_input" then
		local cooked = minetest.get_craft_result({method = "cooking", width = 1, items = {stackname}})
		if cooked and cooked.item then
			if cooked.item:get_name() ~= "" then
				return count
			end
		end
	end
	return 0
end

function wb_furnace.allow_metadata_inventory_take(pos, listname, index, stack, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local count = stack:get_count()
	local player_inv = player:get_inventory()
	local input_stack = inv:get_stack(listname,	index)
	local cooklist = inv:get_list("furnace_input")
	local ccount = wb_furnace.output_count(cooklist)
	-- Detect for an active furnace that is linked
	if listname == "furnace_output" then
		if workbench.check_active(pos, "station_furnace", "furnace", "Furnace", player) ~= true then
			return 0
		end
	end
	-- Check whether the output count is more than 1, if so adopt add_item to add the extra outputs.
	if ccount > 1 then
		if input_stack:get_count() == count then
			return count
		else
			stack:set_count(ccount)
			if not player_inv:room_for_item("main", stack) then
				return 0
			else
				stack:set_count(ccount - 1)
				player_inv:add_item("main", stack)
				return count
			end
		end
	elseif ccount == 1 then
		return count
	else
		return 0
	end
end

function wb_furnace.on_metadata_inventory_put(pos, listname, index, stack, player)
	local count = stack:get_count()
	wb_furnace.update(pos, count, listname)
end

function wb_furnace.on_metadata_inventory_take(pos, listname, index, stack, player)
	local count = stack:get_count()
	wb_furnace.update(pos, count, listname)
end