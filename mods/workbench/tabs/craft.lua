wb_craft = {}

function wb_craft.formspec(pos, locked)
	local meta = minetest.get_meta(pos)
	local craft_result = meta:get_string("craft_result")
	return workbench.tabs(pos, locked)..
		"list[context;craft_grid;2.9,1.025;4,4;]"..
		"style[wbtab_craft_result;border=false;bgimg=gui_bg.png;bgimg_hovered=gui_bg_hover.png]"..
		"item_image_button[9.15,2.9;1,1;"..craft_result..";wbtab_craft_result;]"..
		"image[8,3;0.8,0.8;gui_arrow.png^[transformFYR90]"..
		"listring[current_player;main]"..
		"listring[context;craft_grid]"
end

function wb_craft.get_craft_result(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local gridlist = inv:get_list("craft_grid")
	return minetest.get_craft_result({method = "normal", width = 4, items = gridlist})
end

function wb_craft.update(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local locked = meta:get_string("lock")
	local crafted = wb_craft.get_craft_result(pos)
	local cstack = crafted.item
	local cname = cstack:get_name()
	local ccount = cstack:get_count()
	meta:set_string("craft_result", cname.." "..ccount)
	meta:set_string("formspec", wb_craft.formspec(pos, locked))
	local owner = meta:get_string("owner") or ""
	if ccount == 0 then
		if inv:is_empty("craft_grid") then
			if wb_lock.is_locked(pos) then
				meta:set_string("infotext", "Workbench is empty (owned by "..owner..") \nWorkbench is locked")
			else
				meta:set_string("infotext", "Workbench is empty (owned by "..owner..")")
			end
		else
			if wb_lock.is_locked(pos) then
				meta:set_string("infotext", "Workbench is crafting nothing (owned by "..owner..") \nWorkbench is locked")
			else
				meta:set_string("infotext", "Workbench is crafting nothing (owned by "..owner..")")
			end
		end
	elseif ccount > 1 then
		if wb_lock.is_locked(pos) then
			meta:set_string("infotext", "Workbench is crafting "..cname.." (owned by "..owner..") \nWorkbench is locked")
		else
			meta:set_string("infotext", "Workbench is crafting "..cname.." (owned by "..owner..")")
		end
	end
end

function wb_craft.on_receive_fields(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	local locked = meta:get_string("lock")
	if fields.wbtab_craft then
		meta:set_string("tab", "craft")
		meta:set_string("formspec", wb_craft.formspec(pos, locked))
	elseif fields.wbtab_craft_result then
		if meta:get_string("craft_result") ~= "" then
			local player_inv = sender:get_inventory()
			local inv = meta:get_inventory()
			local crafted, craftgrid = wb_craft.get_craft_result(pos)
			local cstack = crafted.item
			-- ensure player inventory can handle items, if so give player items
			if player_inv:room_for_item("main", cstack) then
				-- update craft grid
				inv:set_list("craft_grid", craftgrid.items)
				-- give items + update
				player_inv:add_item("main", cstack)
				wb_craft.update(pos)
			end
		end
	end
end

function wb_craft.on_construct(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	meta:set_string("craft_result", "")
	inv:set_size("craft_grid", 16)
	local locked = meta:get_string("lock")
	meta:set_string("formspec", wb_craft.formspec(pos, locked))
end

function wb_craft.allow_metadata_inventory_put(pos, listname, index, stack, player)
	if listname == "craft_grid" then
		local count = stack:get_count()
		return count
	else
		return 0
	end
end

function wb_craft.allow_metadata_inventory_take(pos, listname, index, stack, player)
	local count = stack:get_count()
	return count
end

function wb_craft.on_metadata_inventory_put(pos, listname, index, stack, player)
	wb_craft.update(pos)
end

function wb_craft.on_metadata_inventory_take(pos, listname, index, stack, player)
	wb_craft.update(pos)
end

function wb_craft.on_metadata_inventory_move(pos, from_list, from_index, to_list, to_index, count, player)
	wb_craft.update(pos)
end