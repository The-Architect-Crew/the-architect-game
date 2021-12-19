crates = {}
crates.pos = {}

local path = minetest.get_modpath("crates")
dofile(path.."/labels.lua")

-- Inventory sorting ( Taken from https://github.com/minetest-mods/technic/blob/master/technic_chests/register.lua )
local function sort_inventory(inv, sorttype, sort)
	local inlist = inv:get_list("main")
	local typecnt = {}
	local typekeys = {}
	for _, st in ipairs(inlist) do
		if not st:is_empty() then
			local n = st:get_name()
			local w = st:get_wear()
			local m = st:get_metadata()
			local k = string.format("%s %05d %s", n, w, m)
			if not typecnt[k] then
				typecnt[k] = {st}
				table.insert(typekeys, k)
			else
				table.insert(typecnt[k], st)
			end
		end
	end
	if sort then
		table.sort(typekeys)
	end
	inv:set_list("main", {})
	for _, k in ipairs(typekeys) do
		for _, item in ipairs(typecnt[k]) do
			inv:add_item("main", item)
		end
	end
end

-- label display
local function label_display(label)
	if label == "" then
		return ""
	else
		return "Label: "..label
	end
end

local function filled_desc(label, desc, lock)
	if label ~= "" then
		return locks.desc(lock, 2).." "..desc.." (Filled) \nLabel: "..label.." \nPunch to view storage \nPlace down to access storage"
	end
	return locks.desc(lock, 2).." "..desc.." (Filled) \nPunch to view storage \nPlace down to access storage"
end

-- storage API
function crates:register_storage(name, def)
	local desc = def.description
	local scolumns = tonumber(def.columns) or 1
	local colw = scolumns * 1.25
	local locko = def.lock_order
	-- storage formspec
	local function storage_formspec(pos)
		local spos = pos.x..","..pos.y..","..pos.z
		local meta = minetest.get_meta(pos)
		local label = meta:get_string("label")
		local shared = meta:get_string("shared")
		local lock = meta:get_string("lock")
		-- sorting formspec
		if def.sorting and scolumns > 1 then
			crates.sorting_formspec =
				"button[10.65,1.8;0.5,0.5;storage_sort;S]"..
				"tooltip[storage_sort;Sort everything]"..
				"button[10.65,2.4;0.5,0.5;storage_compress;C]"..
				"tooltip[storage_compress;Compress everything (Fill all the gaps)]"..
				"button[10.65,3.0;0.5,0.5;storage_row_up;Ʌ]"..
				"tooltip[storage_row_up;Move everything one row up]"..
				"button[10.65,3.6;0.5,0.5;storage_row_down;V]"..
				"tooltip[storage_row_down;Move everything one row down]"
		elseif def.sorting and scolumns == 1 then
			crates.sorting_formspec =
				"button[10.65,1.8;0.5,0.5;storage_sort;S]"..
				"tooltip[storage_sort;Sort everything]"
		else
			crates.sorting_formspec = ""
		end
		-- color label formspec
		if def.colorlabel then
			crates.label_formspec2 = crates.label_formspec()
		else
			crates.label_formspec2 = ""
		end
		-- portability formspec
		if def.portable then
			local portability = meta:get_string("portable")
			crates.porta_formspec =
				"image[-1.4,"..(5.6 + colw)..";1.4,1.4;gui_tab.png]"..
				"image_button[-1.1,"..(5.8 + colw)..";1,1;gui_"..portability..".png;storage_"..portability..";;true;false;gui_"..portability..".png^[colorize:black:80]"..
				"tooltip[storage_portable;Current mode: Portable \n(Able to pick up storage with filled inventory) \nPress to disable portability.]"..
				"tooltip[storage_unportable;Current mode: Not portable \n(Unable to pick up storage with filled inventory) \nPress to enable portability.]"
		else
			crates.porta_formspec = ""
		end
		return "formspec_version[4]"..
			"size[10.55,"..(8.35 + colw).."]"..
			-- bg
			"style_type[image;noclip=true]"..
			"image[-1.4,"..(6.9 + colw)..";1.4,1.4;gui_tab.png]"..
			--"image[10.54,"..(6.9 + colw)..";1.4,1.4;gui_tab.png^[transformFX]"..
			--"image[10.54,0.3;1.4,1.4;gui_tab.png^[transformFX]"..
			"box[0.2,1.6;10.15,"..(0.15 + colw)..";#707070]"..
			-- label
			"field[0.375,0.6;9.2,0.8;storage_label;"..desc.." Label;"..label.."]"..
			"field_close_on_enter[storage_label;false]"..
			"image_button[9.5,0.47;1,1;gui_enter.png;storage_label_save;;true;false;gui_enter.png^[colorize:black:80]"..
			crates.label_formspec2..
			-- storage
			"list[nodemeta:"..spos..";main;0.4,1.8;8,"..scolumns..";]"..
			-- player
			"list[current_player;main;0.4,"..(1.95 + colw)..";8,4;]"..
			-- locks
			"image_button[-1.1,"..(7.05 + colw)..";1.05,1.05;"..locks.icons("storage", lock, locko)..
			"field[0.375,"..(7.2 + colw)..";9.2,0.8;storage_shared;Shared with (separate names with spaces):;"..shared.."]"..
			"field_close_on_enter[storage_shared;false]"..
			"tooltip[storage_shared;Player names here will have access regardless of locked status \nOnly the owner can change settings \nFormat: 'name1 name2 name3...']"..
			"image_button[9.5,"..(7.07 + colw)..";1,1;gui_enter.png;storage_shared_save;;true;false;gui_enter.png^[colorize:black:80]"..
			-- sorting
			"style_type[button;noclip=true;bgimg=gui_bg_curved.png;bgimg_hovered=gui_bg_hover_curved.png;border=false]"..
			crates.sorting_formspec..
			crates.porta_formspec..
			-- listring
			"listring[nodemeta:"..spos..";main]"..
			"listring[current_player;main]"
	end
	-- show formspec
	local function show_formspec(playername, pos)
		minetest.show_formspec(playername, name, storage_formspec(pos))
	end
	-- storage block
	minetest.register_node(":"..name, {
		description = desc,
		drawtype = def.drawtype,
		mesh = def.mesh,
		visual_scale = def.visual_scale,
		node_box = def.node_box,
		selection_box = def.selection_box,
		collision_box = def.collision_box,
		tiles = def.tiles,
		overlay_tiles = def.overlay_tiles,
		special_tiles = def.special_tiles,
		inventory_image = def.inventory_image,
		inventory_overlay = def.inventory_overlay,
		wield_image = def.wield_image,
		wield_overlay = def.wield_overlay,
		wield_scale = def.wield_scale,
		paramtype = def.paramtype,
		paramtype2 = def.paramtype2,
		sunlight_propagates = def.sunlight_propagates,
		use_texture_alpha = def.use_texture_alpha,
		range = def.range,
		walkable = def.walkable,
		pointable = def.pointable,
		diggable = def.diggable,
		climbable = def.climbable,
		move_resistance = def.move_resistance,
		buildable_to = def.buildable_to,
		floodable = def.floodable,
		leveled = def.leveled,
		leveled_max = def.leveled_max,
		light_source = def.light_source,
		waving = def.waving,
		groups = def.groups,
		drop = def.drop,
		sounds = def.sounds,
		mod_origin = def.mod_origin,
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			inv:set_size("main", 8 * scolumns)
			meta:set_string("owner", "")
			meta:set_string("colorlabel", "")
			meta:set_string("label", "")
			meta:set_string("shared", "")
			meta:set_string("lock", locko[1])
			if def.portable then
				meta:set_string("portable", "portable")
			end
			meta:set_string("infotext", locks.desc(locko[1], 2).." "..desc.." \nUnowned")
		end,
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			local meta = minetest.get_meta(pos)
			local playername = placer:get_player_name()
			meta:set_string("owner", playername)
			meta:set_string("infotext", locks.desc(locko[1], 2).." "..desc.." (Owned by "..playername..")")
		end,
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			local playername = clicker:get_player_name()
			if locks.can_access(pos, clicker) then
				show_formspec(playername, pos)
				crates.pos[playername] = pos
			end
		end,
		allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
			local ints = locks.can_access(pos, player)
			if ints then
				if ints == "mail" then
					return 0
				else
					return count
				end
			end
			return 0
		end,
		allow_metadata_inventory_put = function(pos, listname, index, stack, player)
			if locks.can_access(pos, player) then
				-- disallow filled storages (prevent excessive data)
				if minetest.get_item_group(stack:get_name(), "filled_crates") > 0 then
					return 0
				end
				return stack:get_count()
			end
			return 0
		end,
		allow_metadata_inventory_take = function(pos, listname, index, stack, player)
			local ints = locks.can_access(pos, player)
			if ints then
				if ints == "mail" then
					return 0
				else
					return stack:get_count()
				end
			end
			return 0
		end,
		on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
			minetest.log("action", player:get_player_name() ..
				" moves stuff in "..name.." at " .. minetest.pos_to_string(pos))
		end,
		on_metadata_inventory_put = function(pos, listname, index, stack, player)
			minetest.log("action", player:get_player_name() ..
				" moves " .. stack:get_name() ..
				" to "..name.." at " .. minetest.pos_to_string(pos))
		end,
		on_metadata_inventory_take = function(pos, listname, index, stack, player)
			minetest.log("action", player:get_player_name() ..
				" takes " .. stack:get_name() ..
				" from "..name.." at " .. minetest.pos_to_string(pos))
		end,
		can_dig = function(pos, player)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			if locks.can_access(pos, player) == true then
				if def.portable and meta:get_string("portable") == "portable" then
					return true
				elseif inv:is_empty("main") then
					return true
				end
			end
		end,
		on_dig = function(pos, node, digger)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			if def.portable and meta:get_string("portable") == "portable" and not inv:is_empty("main") then
				local items = {}
				for i = 1, (scolumns * 8) do
					local stack = inv:get_stack("main", i)
					items[i] = stack:to_string()
				end
				local storageitem = ItemStack(name.."_filled")
				local simeta = storageitem:get_meta()
				simeta:set_string("label", meta:get_string("label"))
				simeta:set_string("shared", meta:get_string("shared"))
				simeta:set_string("lock", meta:get_string("lock"))
				simeta:set_string("portable", meta:get_string("portable"))
				simeta:set_string("invdata", minetest.serialize(items))
				simeta:set_string("description", filled_desc(meta:get_string("label"), desc, meta:get_string("lock")))
				minetest.remove_node(pos)
				-- ensure sufficient space in player inventory, else drop as item
				local pinv = digger:get_inventory()
				if pinv:room_for_item("main", {name=name.."_filled"}) then
					pinv:add_item("main", storageitem)
				else
					minetest.add_item(pos, storageitem)
				end
				return false
			end
			minetest.node_dig(pos, node, digger)
			return true
		end,
		on_destruct = function(pos)
			crates.label_remove(pos)
		end,
		on_blast = function() end,
	})
	if def.portable then
		minetest.register_node(":"..name.."_filled", {
			description = desc.." (Filled) \nPunch to view storage \nPlace down to access storage",
			drawtype = def.drawtype,
			mesh = def.mesh,
			visual_scale = def.visual_scale,
			node_box = def.node_box,
			selection_box = def.selection_box,
			collision_box = def.collision_box,
			tiles = def.filled_tiles or def.tiles,
			overlay_tiles = def.overlay_tiles,
			special_tiles = def.special_tiles,
			inventory_image = def.inventory_image,
			inventory_overlay = def.inventory_overlay,
			wield_image = def.wield_image,
			wield_overlay = def.wield_overlay,
			wield_scale = def.wield_scale,
			paramtype = def.paramtype,
			paramtype2 = def.paramtype2,
			sunlight_propagates = def.sunlight_propagates,
			use_texture_alpha = def.use_texture_alpha,
			range = def.range,
			walkable = def.walkable,
			pointable = def.pointable,
			diggable = def.diggable,
			climbable = def.climbable,
			move_resistance = def.move_resistance,
			buildable_to = def.buildable_to,
			floodable = def.floodable,
			leveled = def.leveled,
			leveled_max = def.leveled_max,
			light_source = def.light_source,
			waving = def.waving,
			groups = {not_in_creative_inventory = 1, filled_crates = 1},
			drop = "",
			stack_max = 1,
			on_use = function(itemstack, user, pointed_thing)
				local playername = user:get_player_name()
				local tinv = minetest.get_inventory({type="detached", name="crates:temp_"..playername})
				local imeta = itemstack:get_meta()
				local iinvdata = minetest.deserialize(imeta:get_string("invdata"))
				tinv:set_size("main", 8 * scolumns)
				tinv:set_list("main", iinvdata)
				local temp_formspec = "formspec_version[4]"..
					"size[10.55,"..(3.75 + colw).."]"..
					"label[0.375,0.435;Viewing storage (Place down to access and modify storage)]"..
					"field[0.375,1.0;9.82,0.8;storage_label;"..locks.desc(imeta:get_string("lock"), 2).." "..desc.." Label;"..imeta:get_string("label").."]"..
					"field[0.375,"..(2.6 + colw)..";9.82,0.8;storage_shared;Shared with (separate names with spaces):;"..imeta:get_string("shared").."]"..
					"list[detached:crates:temp_"..playername..";main;0.4,2.2;8,"..scolumns..";]"
				minetest.show_formspec(playername, name.."_filled", temp_formspec)
			end,
			on_place = function(itemstack, placer, pointed_thing)
				local addnode, addpos = minetest.item_place_node(ItemStack(name), placer, pointed_thing)
				if addnode and addpos then
					local nmeta = minetest.get_meta(addpos)
					local inv = nmeta:get_inventory()
					local imeta = itemstack:get_meta()
					local playername = placer:get_player_name()
					nmeta:set_string("label", imeta:get_string("label"))
					nmeta:set_string("shared", imeta:get_string("shared"))
					nmeta:set_string("lock", imeta:get_string("lock"))
					nmeta:set_string("portable", imeta:get_string("portable"))
					nmeta:set_string("infotext", locks.desc(imeta:get_string("lock"), 2).." "..desc.." (Owned by "..playername..") \n"..label_display(nmeta:get_string("label")))
					local iinvdata = minetest.deserialize(imeta:get_string("invdata"))
					inv:set_list("main", iinvdata)
					if not minetest.is_creative_enabled(playername) then
						itemstack:take_item(1)
					end
				end
				return itemstack
			end,
		})
	end
	-- receive fields
	minetest.register_on_player_receive_fields(function(player, formname, fields)
		local playername = player:get_player_name()
		local pos = crates.pos[playername]
		if def.portable and formname == name.."_filled" then
			if fields.quit then
				local tinv = minetest.get_inventory({type="detached", name="crates:temp_"..playername})
				tinv:set_size("main", 0)
				tinv:set_list("main", {})
			end
		end
		if formname ~= name or not player then
			return
		end
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")
		local lock = meta:get_string("lock")
		local label = meta:get_string("label")
		-- owner-only settings
		if playername == owner then
			-- locks
			if fields.storage_lock then
				meta:set_string("lock", "lock")
				show_formspec(playername, pos)
				meta:set_string("infotext", locks.desc("lock" , 2).." "..desc.." (Owned by "..owner..") \n"..label_display(label))
			elseif fields.storage_protect then
				meta:set_string("lock", "protect")
				show_formspec(playername, pos)
				meta:set_string("infotext", locks.desc("protect" , 2).." "..desc.." (Owned by "..owner..") \n"..label_display(label))
			elseif fields.storage_mail then
				meta:set_string("lock", "mail")
				show_formspec(playername, pos)
				meta:set_string("infotext", locks.desc("mail" , 2).." "..desc.." (Owned by "..owner..") \n"..label_display(label))
			elseif fields.storage_unlock then
				meta:set_string("lock", "unlock")
				show_formspec(playername, pos)
				meta:set_string("infotext", locks.desc("unlock" , 2).." "..desc.." (Owned by "..owner..") \n"..label_display(label))
			end
			-- labeling
			if fields.storage_label_save or fields.key_enter_field == "storage_label" then
				local newlabel = fields.storage_label
				meta:set_string("label", newlabel)
				meta:set_string("infotext", locks.desc(lock , 2).." "..desc.." (Owned by "..owner..") \n"..label_display(newlabel))
				show_formspec(playername, pos)
			end
			-- sharing
			if fields.storage_shared_save or fields.key_enter_field == "storage_shared" then
				local newshared = fields.storage_shared
				meta:set_string("shared", newshared)
				show_formspec(playername, pos)
			end
			-- portability
			if def.portable then
				if fields.storage_portable then
					meta:set_string("portable", "unportable")
					show_formspec(playername, pos)
				elseif fields.storage_unportable then
					meta:set_string("portable", "portable")
					show_formspec(playername, pos)
				end
			end
		end
		-- sorting
		-- allow shared and owner access always
		-- if protected + "protect/unlock": allow protection owner(s)
		-- if unprotected + "protect/unlock": allow everyone
		local ints = locks.can_access(pos, player)
		if ints and ints ~= "mail" and ints ~= "public" then
			local inv = meta:get_inventory()
			local tslots = scolumns * 8
			local uslots = tslots - 8
			if fields.storage_row_up then
				local inlist = inv:get_list("main")
				local newlist = {}
				for i = 1, 8 do
					newlist[uslots+i] = inlist[i]
				end
				for i = 8, tslots do
					if (i - 8) == 0 then
						newlist[1] = inlist[i]
					else
						newlist[i-8] = inlist[i]
					end
				end
				inv:set_list("main", newlist)
			elseif fields.storage_row_down then
				local inlist = inv:get_list("main")
				local newlist = {}
				for i = uslots, tslots do
					if (uslots - i) == 0 then
						newlist[1] = inlist[i]
					else
						newlist[i-uslots] = inlist[i]
					end
				end
				for i = 1, uslots do
					newlist[i+8] = inlist[i]
				end
				inv:set_list("main", newlist)
			elseif fields.storage_sort then
				sort_inventory(inv, "all", true)
			elseif fields.storage_compress then
				sort_inventory(inv, "all")
			end
			-- colour labels
			if def.colorlabel then
				crates.label_receive_fields(player, formname, fields, pos, def.colorlabel)
			end
		end
		-- quit field, reset pos
		if fields.quit then
			crates.pos[playername] = nil
		end
	end)
end

-- Create temp inventory for filled storage viewing
minetest.register_on_joinplayer(function(player, last_login)
    local playername = player:get_player_name()
    local temp_crates = minetest.create_detached_inventory("crates:temp_"..playername, {
		allow_move = function()
			return 0
		end,
		allow_put = function()
			return 0
		end,
		allow_take = function()
			return 0
		end,
	}, playername)
	temp_crates:set_size("main", 0)
	temp_crates:set_list("main", {})
end)

crates:register_storage("crates:crate", {
	description = "Crate",
	columns = 4,
	sorting = true,
	portable = true,
	colorlabel = 2,
	lock_order = {"lock", "protect", "unlock", "mail"},
	drawtype = "mesh",
	mesh = "crates_crate.obj",
	groups = {oddly_breakable_by_hand = 1},
	tiles = {"crates_crate.png"},
	filled_tiles = {"crates_crate_filled.png"},
	sunlight_propagates = true,
	use_texture_alpha = "opaque",
	paramtype = "light",
	paramtype2 = "facedir",
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = "crates:crate",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "blocks:chest_locked", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
	}
})