local path = minetest.get_modpath("workbench")
dofile(path.."/tabs/lock.lua")
dofile(path.."/tabs/tabs.lua")
-- Shapes
dofile(path.."/tabs/shapes.lua")
-- Furnace
dofile(path.."/tabs/furnace.lua")

minetest.register_craftitem("workbench:nil", {
	description = "Not Available",
	inventory_image = "workbench_nil.png",
})

function workbench.detect(pos, nodename)
	local pos1 = vector.subtract(pos, 5)
	local pos2 = vector.add(pos, 5)
	local position = minetest.find_nodes_in_area(pos1, pos2, nodename)
	if #position > 0 then
		return #position, position
	end
end

function workbench.check_active(pos, stsave, stname, stdesc, player)
	local meta = minetest.get_meta(pos)
	local stdata = meta:get_string(stsave)
	if stdata ~= "" then
		local stpos = minetest.deserialize(stdata)
		if minetest.get_node(stpos).name == "workbench:"..stname.."_active" then
			return true
		else
			if player then
				workbench.send(player, stdesc.." is out of fuel.")
			end
		end
	elseif stdata == "" then
		if player then
			workbench.send(player, "No "..stdesc.." detected nearby of workbench (5 block radius).")
		end
	end
end

function workbench.link_to_stations(pos, nodename, savename)
	local meta = minetest.get_meta(pos)
	local pos1 = vector.subtract(pos, 5)
	local pos2 = vector.add(pos, 5)
	local position = minetest.find_nodes_in_area(pos1, pos2, {"workbench:"..nodename, "workbench:"..nodename.."_active"})
	if #position > 0 then
		for i = 1, #position do
			local stmeta = minetest.get_meta(position[i])
			if stmeta:get_string("link") == "" then
				stmeta:set_string("link", minetest.serialize(pos))
				meta:set_string("station_"..savename, minetest.serialize(position[i]))
				-- start work stations node timer to enable infotext update
				minetest.get_node_timer(position[i]):start(0.0)
				return true
			end
		end
	end
end

function workbench.unlink_to_stations(pos, nodename, savename)
	local meta = minetest.get_meta(pos)
	local stdata = meta:get_string("station_"..savename)
	if stdata ~= "" then
		local stpos = minetest.deserialize(stdata)
		if minetest.get_node(stpos).name == "workbench:"..nodename or minetest.get_node(stpos).name == "workbench:"..nodename.."_active" then
			local stmeta = minetest.get_meta(stpos)
			if stmeta:get_string("link") ~= "" then
				meta:set_string("station_"..savename, "")
				stmeta:set_string("link", "")
				workbench.update(pos)
				-- start work stations node timer to enable infotext update
				minetest.get_node_timer(stpos):start(0.0)
			end
		end
	end
end

function workbench.send(player, text)
	local name = player:get_player_name()
	minetest.chat_send_player(name, "[workbench] "..text)
end

local function allow_move(pos, from_list, from_index, to_list, to_index, count, player)
	local meta = minetest.get_meta(pos)
	-- Lock checks
	if wb_lock.check(pos, player) then
		return 0
	end
	return 0
end

local function allow_put(pos, listname, index, stack, player)
	local meta = minetest.get_meta(pos)
	local tab = meta:get_string("tab")
	-- Lock checks
	if wb_lock.check(pos, player) then
		return 0
	end
	-- =================
	-- allow_put updates
	-- =================
	if tab == "shapes" then
		return wb_shapes.allow_metadata_inventory_put(pos, listname, index, stack, player)
	elseif tab == "furnace" then
		return wb_furnace.allow_metadata_inventory_put(pos, listname, index, stack, player)
	end
	-- =================
	return 0
end

local function allow_take(pos, listname, index, stack, player)
	local meta = minetest.get_meta(pos)
	local count = stack:get_count()
	local tab = meta:get_string("tab")
	-- Lock checks
	if wb_lock.check(pos, player) then
		return 0
	end
	-- ==================
	-- allow_take updates
	-- ==================
	if tab == "shapes" then
		return wb_shapes.allow_metadata_inventory_take(pos, listname, index, stack, player)
	elseif tab == "furnace" then
		return wb_furnace.allow_metadata_inventory_take(pos, listname, index, stack, player)
	end
	-- ==================
	return count
end

local function on_put(pos, listname, index, stack, player)
	local meta = minetest.get_meta(pos)
	local tab = meta:get_string("tab")
	-- ==============
	-- on_put updates
	-- ==============
	if tab == "shapes" then
		wb_shapes.on_metadata_inventory_put(pos, listname, index, stack, player)
	elseif tab == "furnace" then
		wb_furnace.on_metadata_inventory_put(pos, listname, index, stack, player)
	end
	-- ==============
end

local function on_take(pos, listname, index, stack, player)
	local meta = minetest.get_meta(pos)
	local tab = meta:get_string("tab")
	-- ===============
	-- on_take updates
	-- ===============
	if tab == "shapes" then
		wb_shapes.on_metadata_inventory_take(pos, listname, index, stack, player)
	elseif tab == "furnace" then
		wb_furnace.on_metadata_inventory_take(pos, listname, index, stack, player)
	end
	-- ===============
end

local function on_construct(pos)
	local meta = minetest.get_meta(pos)
	meta:set_string("tab", "shapes")
	-- ====================
	-- on_construct updates
	-- ====================
	wb_furnace.on_construct(pos)
	wb_shapes.on_construct(pos)
	-- ====================
end

function workbench.update(pos, locked)
	local meta = minetest.get_meta(pos)
	local tab = meta:get_string("tab")
	local lock = locked or meta:get_string("lock")
	if tab == "shapes" then
		meta:set_string("formspec", wb_shapes.formspec(pos, lock))
	elseif tab == "furnace" then
		meta:set_string("formspec", wb_furnace.formspec(pos, lock))
	end
end

local function on_receive_fields(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	-- Lock checks
	if wb_lock.check(pos, sender) then
		return
	end
	-- ==============
	-- fields updates
	-- ==============
	wb_shapes.on_receive_fields(pos, formname, fields, sender)
	wb_furnace.on_receive_fields(pos, formname, fields, sender)
	-- ==============
	if wb_lock.noaccess(pos, sender) ~= true then
		-- Lock workbench
		if fields.workbench_lock then
			meta:set_string("lock", "locked")
			workbench.update(pos, "locked")
			local infotext = meta:get_string("infotext")
			meta:set_string("infotext", infotext.." \nWorkbench is locked.")
		end
		-- Unlock workbench
		if fields.workbench_unlock then
			meta:set_string("lock", "unlocked")
			workbench.update(pos, "unlocked")
			local infotext = meta:get_string("infotext"):gsub(" \nWorkbench is locked", "", 1)
			meta:set_string("infotext", infotext)
		end
	end
end

local function can_dig(pos, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	-- Only owner can dig
	if player:get_player_name() ~= meta:get_string("owner") then
		return false
	end
	-- ===============
	-- can_dig updates
	-- ===============
	-- shapes
	if not inv:is_empty("shapes_input") or not inv:is_empty("shapes_micro") then
		return false
	-- furnace
	elseif not inv:is_empty("furnace_input") then
		return false
	end
	-- ===============
	return true
end

local function after_place_node(pos, placer)
	local meta = minetest.get_meta(pos)
	local owner = placer and placer:get_player_name() or ""
	meta:set_string("owner",  owner)
	-- ===================
	-- after_place updates
	-- ===================
	wb_shapes.after_place_node(pos, placer)
	-- ===================
end

local function on_destruct(pos)
	-- ===================
	-- on_destruct updates
	-- ===================
	workbench.unlink_to_stations(pos, "tablesaw", "shapes_complex")
	workbench.unlink_to_stations(pos, "cnc", "shapes_slope")
	workbench.unlink_to_stations(pos, "furnace", "furnace")
	-- ===================
end

minetest.register_node("workbench:workbench",  {
	description = "Workbench",
	drawtype = "mesh",
	mesh = "workbench.obj",
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 }
	},
	tiles = {"workbench_workbench.png"},
	paramtype = "light",
	sunlight_propagates = true,
	use_texture_alpha = "opaque",
	paramtype2 = "facedir",
	groups = {choppy = 2,oddly_breakable_by_hand = 2},
	sounds = default.node_sound_wood_defaults(),
	on_construct = on_construct,
	after_place_node = after_place_node,
	on_destruct = on_destruct,
	can_dig = can_dig,
	on_receive_fields = on_receive_fields,
	allow_metadata_inventory_move = allow_move,
	allow_metadata_inventory_put = allow_put,
	allow_metadata_inventory_take = allow_take,
	on_metadata_inventory_put = on_put,
	on_metadata_inventory_take = on_take,
})