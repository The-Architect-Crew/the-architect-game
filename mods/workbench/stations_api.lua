local function swap_node(pos, name)
	local node = minetest.get_node(pos)
	if node.name == name then
		return
	end
	node.name = name
	minetest.swap_node(pos, node)
end

local function active_formspec(fuel_percent, fueltype)
	return "size[8,8.5]"..
		"image[3.49,2;1,1;workbench_fuel_"..fueltype..".png]"..
		"list[context;fuel;3.49,2;1,1;]"..
		"image[3.49,1;1,1;workbench_furnace_fire_bg.png^[lowpart:"..
		(fuel_percent)..":workbench_furnace_fire.png]"..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		default.get_hotbar_bg(0, 4.25)
end

local function inactive_formspec(fueltype)
	return "size[8,8.5]"..
		"image[3.49,2;1,1;workbench_fuel_"..fueltype..".png]"..
		"list[context;fuel;3.49,2;1,1;]"..
		"image[3.49,1;1,1;workbench_furnace_fire_bg.png]"..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		default.get_hotbar_bg(0, 4.25)
end

workbench.fuel_list = {}
function workbench:register_fuel(def)
	local name = def.name
	table.insert(workbench.fuel_list, {
		fueltype = def.fueltype,
		name = name,
		time = tonumber(def.time),
	})
end

local function get_fueltype(inv, fueltype, stackname)
	if fueltype == "fuel" then
		local fueldata,_ = minetest.get_craft_result({method = "fuel", width = 1, items = inv:get_list("fuel")})
		return fueldata
	else
		local name = stackname or inv:get_stack("fuel", 1):get_name()
		for i in ipairs(workbench.fuel_list) do
			if workbench.fuel_list[i].fueltype == fueltype and workbench.fuel_list[i].name == name then
				local fueldata = workbench.fuel_list[i]
				return fueldata
			end
		end
	end
end

local function linktext(pos)
	local meta = minetest.get_meta(pos)
	local link = meta:get_string("link")
	if link ~= "" then
		local lpos = minetest.deserialize(link)
		local ltext = lpos.x..", "..lpos.y..", "..lpos.z
		return "Linked to workbench ("..ltext..")"
	elseif link == "" then
		return "Not linked to any workbench."
	end
end

local function burner_timer(pos, name, desc, fueltype, fueldesc)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local fuellist = inv:get_list("fuel")
	
	if not fuellist then return end
	
	if meta:get_string("elasped") == "" then
		meta:set_float("elasped", 0.0)
	elseif meta:get_string("fueltime") == "" then
		meta:set_float("fueltime", 0.0)
	end
	
	local fuel = get_fueltype(inv, fueltype)
	local fuelinfo = fueldesc or ""
	-- if no fuel detected, revert to inactive state
	if meta:get_float("fueltime") == 0 then
		if not fuel or fuel.time <= 0 or inv:is_empty("fuel") then
			meta:set_string("infotext", linktext(pos).." \n"..desc.." out of fuel \n"..fuelinfo)
			swap_node(pos,"workbench:"..name)
			meta:set_string("formspec", inactive_formspec(fueltype))
			-- update workbench fuel icon
			if meta:get_string("link") ~= "" then
				local wbpos = minetest.deserialize(meta:get_string("link"))
				if minetest.get_node(wbpos).name == "workbench:workbench" then
					workbench.update(wbpos)
				end
			end
			return
		end
	end
	
	-- if fuel detected and not running, change to active active
	local meta = minetest.get_meta(pos)
	local elasped = meta:get_float("elasped")
	local fueltime = meta:get_float("fueltime")
	if fueltime == 0 then
		meta:set_float("elasped", 0)
		meta:set_float("fueltime", fuel.time)
		
		local percent = math.floor(100 - (meta:get_float("elasped") / meta:get_float("fueltime") * 100))
		meta:set_string("infotext", linktext(pos).." \n"..desc.." active: "..percent.."% fuel left \n"..fuelinfo)
		swap_node(pos,"workbench:"..name.."_active")
		meta:set_string("formspec", active_formspec(percent, fueltype))
		-- consume fuel
		local stack = inv:get_stack("fuel", 1)
		local stackcount = stack:get_count()
		if stackcount > 0 then
			stack:take_item()
			inv:set_stack("fuel", 1, stack)
		end
		-- update workbench fuel icon
		if meta:get_string("link") ~= "" then
			local wbpos = minetest.deserialize(meta:get_string("link"))
			if minetest.get_node(wbpos).name == "workbench:workbench" then
				workbench.update(wbpos)
			end
		end
		-- restart timer
		minetest.get_node_timer(pos):start(1.0)
	end
	
	-- if fuel not fully expended, continue running timer
	local meta = minetest.get_meta(pos)
	local elasped2 = meta:get_float("elasped")
	local fueltime2 = meta:get_float("fueltime")
	if elasped2 < fueltime2 then
		meta:set_float("elasped", meta:get_float("elasped") + 1)
		local percent = math.floor(100 - (meta:get_float("elasped") / meta:get_float("fueltime") * 100))
		meta:set_string("infotext", linktext(pos).." \n"..desc.." active: "..percent.."% fuel left \n"..fuelinfo)
		meta:set_string("formspec", active_formspec(percent, fueltype))
		-- restart timer
		minetest.get_node_timer(pos):start(1.0)
	end
	
	-- if fuel fully expended, reset to 0
	local elasped3 = meta:get_float("elasped") or 0
	local fueltime3 = meta:get_float("fueltime") or 0
	if elasped3 >= fueltime3 and fueltime3 ~= 0 then
		meta:set_float("elasped", 0.0)
		meta:set_float("fueltime", 0.0)
	end
end

local function allow_put(pos, listname, stack, player, fueltype)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	if listname == "fuel" then
		if fueltype == "fuel" then
			if minetest.get_craft_result({method="fuel", width=1, items={stack}}).time ~= 0 then
				return stack:get_count()
			else
				return 0
			end
		else
			local stackname = stack:get_name()
			if get_fueltype(inv, fueltype, stackname) then
				return stack:get_count()
			else
				return 0
			end
		end
	end
end


local function allow_take(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	return stack:get_count()
end

local function link_to_wb(pos, savename)
	local meta = minetest.get_meta(pos)
	local wbcount, wbpos = workbench.detect(pos, "workbench:workbench")
	
	if wbcount and wbcount >= 1 then
		for i = 1, wbcount do
			local wb_meta = minetest.get_meta(wbpos[i])
			if wb_meta:get_string("station_"..savename) == "" then
				wb_meta:set_string("station_"..savename, minetest.serialize(pos))
				meta:set_string("link", minetest.serialize(wbpos[i]))
				workbench.update(wbpos[i])
				return
			end
		end
	end
end

local function unlink_to_wb(pos, savename)
	local meta = minetest.get_meta(pos)
	if meta:get_string("link") ~= "" then
		local wbpos = minetest.deserialize(meta:get_string("link"))
		if minetest.get_node(wbpos).name == "workbench:workbench" then
			local wb_meta = minetest.get_meta(wbpos)
			wb_meta:set_string("station_"..savename, "")
			meta:set_string("link", "")
			workbench.update(wbpos)
		end
	end
end

function workbench:register_workstation(name, def)
	def = def or {}
	local fueltype = def.fueltype
	local fueldesc = def.fueldesc
	local desc = def.description
	local sname = def.savename
	
	minetest.register_node("workbench:"..name, {
		description = desc,
		drawtype = "mesh",
		mesh = def.mesh,
		groups = def.groups,
		tiles = def.tiles,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		use_texture_alpha = "clip",
		sounds = def.sounds,
		can_dig = function(pos, player)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return inv:is_empty("fuel")
		end,
		on_timer = function(pos, elapsed)
			burner_timer(pos, name, desc, fueltype, fueldesc)
		end,
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			meta:set_string("link", "")
			inv:set_size('fuel', 1)
			link_to_wb(pos, sname)
			burner_timer(pos, name, desc, fueltype, fueldesc)
		end,
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			local pos = pointed_thing.above
			local wbcount = workbench.detect(pos, "workbench:workbench")
			if placer then
				if not wbcount or wbcount == 0 then
					workbench.send(placer, "Please place the "..desc.." nearby (5 node radius) to a workbench")
					minetest.remove_node(pos)
					return true
				end
			end
		end,
		on_destruct = function(pos)
			unlink_to_wb(pos, sname)
		end,
		on_metadata_inventory_move = function(pos)
			minetest.get_node_timer(pos):start(1.0)
		end,
		on_metadata_inventory_put = function(pos)
			minetest.get_node_timer(pos):start(1.0)
		end,
		on_metadata_inventory_take = function(pos)
			minetest.get_node_timer(pos):start(1.0)
		end,
		allow_metadata_inventory_put = function(pos, listname, index, stack, player)
			return allow_put(pos, listname, stack, player, fueltype)
		end,
		allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
			return 0
		end,
		allow_metadata_inventory_take = allow_take,
	})
	
	local r_group = table.copy(def.groups)
	r_group.not_in_creative_inventory = 1
	minetest.register_node("workbench:"..name.."_active", {
		description = desc,
		drawtype = "mesh",
		mesh = def.mesh,
		groups = r_group,
		tiles = def.animated_tiles,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		use_texture_alpha = "clip",
		drop = "workbench:"..name,
		sounds = def.sounds,
		can_dig = function(pos, player)
			local meta = minetest.get_meta(pos);
			local inv = meta:get_inventory()
			return inv:is_empty("fuel")
		end,
		on_timer = function(pos, elapsed)
			burner_timer(pos, name, desc, fueltype, fueldesc)
		end,
		on_place =  function(itemstack, placer, pointed_thing)
			if placer then return end
		end,
		on_destruct = function(pos)
			unlink_to_wb(pos, sname)
		end,
		on_metadata_inventory_move = function(pos)
			minetest.get_node_timer(pos):start(1.0)
		end,
		on_metadata_inventory_put = function(pos)
			minetest.get_node_timer(pos):start(1.0)
		end,
		on_metadata_inventory_take = function(pos)
			minetest.get_node_timer(pos):start(1.0)
		end,
		allow_metadata_inventory_put = function(pos, listname, index, stack, player)
			return allow_put(pos, listname, stack, player, fueltype)
		end,
		allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
			return 0
		end,
		allow_metadata_inventory_take = allow_take,
	})
end