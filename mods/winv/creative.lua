local S = minetest.get_translator("creative")

minetest.register_privilege("creative", {
	description = S("Allow player to use creative inventory"),
	give_to_singleplayer = false,
	give_to_admin = false,
	on_grant = function(name, granter_name)
		local player = minetest.get_player_by_name(name)
		winv.refresh(player)
	end,
	on_revoke = function(name, revoker_name)
		local player = minetest.get_player_by_name(name)
		winv.refresh(player)
	end,
})

-- Override the engine's creative mode function
local old_is_creative_enabled = minetest.is_creative_enabled

function minetest.is_creative_enabled(name)
	if name == "" then
		return old_is_creative_enabled(name)
	end
	return minetest.check_player_privs(name, {creative = true}) or
		old_is_creative_enabled(name)
end

-- For backwards compatibility:
creative = {}
function creative.is_enabled_for(name)
	return minetest.is_creative_enabled(name)
end

if minetest.is_creative_enabled("") then
	-- Dig time is modified according to difference (leveldiff) between tool
	-- 'maxlevel' and node 'level'. Digtime is divided by the larger of
	-- leveldiff and 1.
	-- To speed up digging in creative, hand 'maxlevel' and 'digtime' have been
	-- increased such that nodes of differing levels have an insignificant
	-- effect on digtime.
	local digtime = 42
	local caps = {times = {digtime, digtime, digtime}, uses = 0, maxlevel = 256}

	-- Override the hand tool
	minetest.override_item("", {
		range = 10,
		tool_capabilities = {
			full_punch_interval = 0.5,
			max_drop_level = 3,
			groupcaps = {
				crumbly = caps,
				cracky  = caps,
				snappy  = caps,
				choppy  = caps,
				oddly_breakable_by_hand = caps,
				-- dig_immediate group doesn't use value 1. Value 3 is instant dig
				dig_immediate =
					{times = {[2] = digtime, [3] = 0}, uses = 0, maxlevel = 256},
			},
			damage_groups = {fleshy = 10},
		}
	})
end

-- Unlimited node placement
minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack)
	if placer and placer:is_player() then
		return minetest.is_creative_enabled(placer:get_player_name())
	end
end)

-- Don't pick up if the item is already in the inventory
local old_handle_node_drops = minetest.handle_node_drops
function minetest.handle_node_drops(pos, drops, digger)
	if not digger or not digger:is_player() or
		not minetest.is_creative_enabled(digger:get_player_name()) then
		return old_handle_node_drops(pos, drops, digger)
	end
	local inv = digger:get_inventory()
	if inv then
		for _, item in ipairs(drops) do
			if not inv:contains_item("main", item, true) then
				inv:add_item("main", item)
			end
		end
	end
end

-- Create the trash field
local trash = minetest.create_detached_inventory("trash", {
	-- Allow the stack to be placed and remove it in on_put()
	-- This allows the creative inventory to restore the stack
	allow_put = function(inv, listname, index, stack, player)
		return stack:get_count()
	end,
	on_put = function(inv, listname)
		inv:set_list(listname, {})
	end,
})
trash:set_size("main", 1)

-- ==================
-- Creative Inventory
-- ==================
local player_inventory = {}
local inventory_cache = {}

local function init_creative_cache(items)
	inventory_cache[items] = {}
	local i_cache = inventory_cache[items]

	for name, def in pairs(items) do
		if def.groups.not_in_creative_inventory ~= 1 and
				def.description and def.description ~= "" then
			i_cache[name] = def
		end
	end
	table.sort(i_cache)
	return i_cache
end

local function init_creative_inv(player)
	local name = player:get_player_name()
	player_inventory[name] = {
		size = 0,
		filter = "",
		start_i = 0,
		old_filter = nil, -- use only for caching in update_creative_inventory
		old_content = nil,
		content = minetest.registered_items,
		show_mod_filter = nil,
		old_mod_filter = {},
		mod_filter = {},
		mod_filter_scroll = 0,
	}
	minetest.create_detached_inventory("winv_creative_"..name, {
		allow_move = function(inv, from_list, from_index, to_list, to_index, count, player2)
			local name = player2 and player2:get_player_name() or ""
			if not minetest.is_creative_enabled(name) or to_list == "main" then
				return 0
			end
			return count
		end,
		allow_put = function(inv, listname, index, stack, player2)
			return 0
		end,
		allow_take = function(inv, listname, index, stack, player2)
			local name = player2 and player2:get_player_name() or ""
			if not minetest.is_creative_enabled(name) then
				return 0
			end
			return -1
		end,
		on_move = function(inv, from_list, from_index, to_list, to_index, count, player2)
		end,
		on_take = function(inv, listname, index, stack, player2)
			if stack and stack:get_count() > 0 then
				minetest.log("action", name .. " takes " .. stack:get_name().. " from creative inventory")
			end
		end,
	}, name)
	return player_inventory[name]
end

local function get_modfilter_status(modname, name)
	local inv = player_inventory[name]
	if not inv.mod_filter or not next(inv.mod_filter) then
		return "true"
	end
	for i, modfname in pairs(inv.mod_filter) do
		if modfname == modname then
			return "false"
		end
	end
	return "true"
end

local function mod_match(s, mod_filter)
	if not mod_filter or not next(mod_filter) then
		return true
	end
	for i, modname in pairs(mod_filter) do
		if s:lower():find(modname..":", 1, true) then
			return nil
		end
	end
	return true
end

local NO_MATCH = 999
local function match(s, filter)
	if filter == "" then
		return 0
	end
	if s:lower():find(filter, 1, true) then
		return #s - #filter
	end
	return NO_MATCH
end

local function description(def, lang_code)
	local s = def.description
	if lang_code then
		s = minetest.get_translated_string(lang_code, s)
	end
	return s:gsub("\n.*", "") -- First line only
end

local function update_creative_inv(player_name)
	local inv = player_inventory[player_name] or
				init_creative_inv(minetest.get_player_by_name(player_name))
	local player_inv = minetest.get_inventory({type = "detached", name = "winv_creative_" .. player_name})
	
	if inv.filter == inv.old_filter and inv.content == inv.old_content and inv.modfilter == inv.old_mod_filter then
		return
	end
	inv.old_filter = inv.filter
	inv.old_content = inv.content
	inv.old_mod_filter = inv.mod_filter

	local items = inventory_cache[inv.content] or init_creative_cache(inv.content)

	local lang
	local player_info = minetest.get_player_information(player_name)
	if player_info and player_info.lang_code ~= "" then
		lang = player_info.lang_code
	end
	
	local creative_list = {}
	local order = {}
	for name, def in pairs(items) do
		local mf = mod_match(name, inv.mod_filter)
		if mf then
			local m = match(description(def), inv.filter)
			if m > 0 then
				m = math.min(m, match(description(def, lang), inv.filter))
			end
			if m > 0 then
				m = math.min(m, match(name, inv.filter))
			end

			if m < NO_MATCH then
				creative_list[#creative_list+1] = name
				-- Sort by match value first so closer matches appear earlier
				order[name] = string.format("%02d", m) .. name
			end
		end
	end

	table.sort(creative_list, function(a, b) return order[a] < order[b] end)

	player_inv:set_size("main", #creative_list)
	player_inv:set_list("main", creative_list)
	inv.size = #creative_list
end

-- Sort registered items
local registered_nodes = {}
local registered_tools = {}
local registered_craftitems = {}

minetest.register_on_mods_loaded(function()
	for name, def in pairs(minetest.registered_items) do
		local group = def.groups or {}

		local nogroup = not (group.node or group.tool or group.craftitem)
		if group.node or (nogroup and minetest.registered_nodes[name]) then
			registered_nodes[name] = def
		elseif group.tool or (nogroup and minetest.registered_tools[name]) then
			registered_tools[name] = def
		elseif group.craftitem or (nogroup and minetest.registered_craftitems[name]) then
			registered_craftitems[name] = def
		end
	end
end)

local function modfilter_list(name)
	local modlist = ""
	local modnames = minetest.get_modnames()
	for i, modname in ipairs(modnames) do
		modlist = modlist.."checkbox[0.1,"..((i - 1) * 0.4 + 0.25)..";winv_creative_modfilter_mod_"..modname..";"..modname..";"..get_modfilter_status(modname, name).."]"
	end
	return modlist
end

winv:register_inventory("creative", {
	requirement = function(player)
		local name = player:get_player_name()
		if minetest.is_creative_enabled(name) then
			return true
		end
	end,
	button = {
		texture = "winv_icon_creative.png",
		tooltip = "Creative Inventory",
	},
	formspec_function = function(player)
		local name = player:get_player_name()
		update_creative_inv(name)
		local inv = player_inventory[name]
		local pagenum = math.floor(inv.start_i / (4*8) + 1)
		local pagemax = math.ceil(inv.size / (4*8))
		local modfilter_form = ""
		if inv.show_mod_filter then
			local modf_length = #minetest.get_modnames()
			local modf_scroll = ""
			local modf_bg = 0
			if modf_length > 12 then
				modf_scroll =
					"scrollbaroptions[max="..((modf_length - 12) * 4.3)..";thumbsize=15]"..
					"scrollbar[3.625,4.4;0.3,4.2;vertical;winv_creative_modfilter_scroll;"..(inv.mod_filter_scroll).."]"
				modf_bg = modf_length - 12
			end
			modfilter_form =
				"box[0,3.85;4,4.9;#49494AE6]"..
				"image_button[0,3.85;4,4.9;gui_invis.png;winv_creative_modfilter_bg;;true;false;]"..
				"button[-0.6,4.75;0.5,0.5;winv_creative_modfilter_reset;R]"..
				"image_button[-0.6,5.35;0.5,0.5;gui_cross.png;winv_creative_modfilter_clear;]"..
				modf_scroll..
				"image_button[3.5,3.85;0.5,0.5;gui_cross_light.png;winv_creative_modfilter_remove;;true;false;]"..
				"scroll_container[0,3.85;3.6,4.9;winv_creative_modfilter_scroll;vertical;0.1]"..
					"style_type[checkbox;noclip=false]"..
					"image_button[0,0;3.6,"..(4.9 + modf_bg * 0.4)..";gui_invis.png;winv_creative_modfilter_bg;;false;false;]"..
					modfilter_list(name)..
				"scroll_container_end[]"
		end
		local formspec = {
			--"image[0,0;7.75,7.75;winv_bg.png]",
			"style_type[image,label;noclip=true]",
			"image[0,0;7.75,9;winv_bg.png]",
			"label[0.25,9.3;Page " .. minetest.colorize("#FFFF00", tostring(pagenum)) .. " / " .. tostring(pagemax) .. "]",
			"list[detached:winv_creative_"..name..";main;0.25,0.25;6,6;"..tostring(inv.start_i).."]",
			-- search icons
			"field[0.25,7.75;4,1;winv_creative_filter;;"..inv.filter.."]",
			"field_close_on_enter[winv_creative_filter;false]" ..
			"image_button[4.5,7.75;0.5,0.5;gui_pointer.png;winv_creative_search;]",
			"image_button[4.5,8.25;0.5,0.5;gui_cross.png;winv_creative_clear;]",
			-- trash
			"image[5.325,7.85;0.8,0.8;gui_trash.png]",
			"list[detached:trash;main;5.25,7.75;1,1;]",
			-- arrows
			"image_button[6.5,7.83;0.5,0.8;icon_miniarrow.png^[transformFX;winv_creative_prev;;;false;]",
			"image_button[7,7.85;0.5,0.8;icon_miniarrow.png;winv_creative_next;;;false;]",
			-- icons
			"image_button[-0.9,0.25;0.8,0.8;icon_all.png;winv_creative_all;;true;false;]",
			"tooltip[winv_creative_all;Show all]",
			"image_button[-0.9,1.15;0.8,0.8;icon_block.png;winv_creative_block;;true;false;]",
			"tooltip[winv_creative_block;Show blocks only]",
			"image_button[-0.9,2.05;0.8,0.8;icon_tool.png;winv_creative_tool;;true;false;]",
			"tooltip[winv_creative_tool;Show tools only]",
			"image_button[-0.9,2.95;0.8,0.8;icon_craftitem.png;winv_creative_craftitem;;true;false;]",
			"tooltip[winv_creative_craftitem;Show craft items only]",
			"image_button[-0.9,3.85;0.8,0.8;icon_filter.png;winv_creative_modfilter;;true;false;]",
			"tooltip[winv_creative_modfilter;Filter by mods]",
			modfilter_form
		}
		return table.concat(formspec, "")
	end,
	on_player_receive_fields = function(player, formname, fields)
		local player_name = player:get_player_name()
		local inv = player_inventory[player_name]
		if not inv then
			return
		end
		
		if fields.winv_creative_all then
			inv.content = minetest.registered_items
			winv.refresh(player)
		elseif fields.winv_creative_block then
			inv.content = registered_nodes
			winv.refresh(player)
		elseif fields.winv_creative_tool then
			inv.content = registered_tools
			winv.refresh(player)
		elseif fields.winv_creative_craftitem then
			inv.content = registered_craftitems
			winv.refresh(player)
		elseif fields.winv_creative_modfilter then
			if inv.show_mod_filter then
				inv.show_mod_filter = nil
			else
				inv.show_mod_filter = true
			end
			winv.refresh(player)
		elseif fields.winv_creative_modfilter_remove then
			inv.show_mod_filter = nil
			winv.refresh(player)
		end
		
		local modnames = minetest.get_modnames()
		if inv.show_mod_filter then
			for i, modname in ipairs(modnames) do
				local mfield = fields["winv_creative_modfilter_mod_"..modname]
				if mfield then
					if mfield == "false" then
						inv.mod_filter[#inv.mod_filter+1] = modname
					elseif mfield == "true" then
						for i, modfname in pairs(inv.mod_filter) do
							if modfname == modname then
								inv.mod_filter[i] = nil
							end
						end
					end
					winv.refresh(player)
				end
			end
		end
		if fields.winv_creative_modfilter_reset then
			inv.mod_filter = {}
			winv.refresh(player)
		elseif fields.winv_creative_modfilter_clear then
			inv.mod_filter = {}
			for i, modname in ipairs(modnames) do
				inv.mod_filter[#inv.mod_filter+1] = modname
			end
			winv.refresh(player)
		end

		if fields.winv_creative_clear then
			inv.start_i = 0
			inv.filter = ""
			winv.refresh(player)
		elseif fields.winv_creative_search or
				fields.key_enter_field == "winv_creative_filter" then
			inv.start_i = 0
			inv.filter = fields.winv_creative_filter:lower()
			winv.refresh(player)
		elseif not fields.quit then
			local start_i = inv.start_i or 0
			if fields.winv_creative_prev then
				start_i = start_i - 6*6
				if start_i < 0 then
					start_i = inv.size - (inv.size % (6*6))
					if inv.size == start_i then
						start_i = math.max(0, inv.size - (6*6))
					end
				end
				winv.refresh(player)
			elseif fields.winv_creative_next then
				start_i = start_i + 6*6
				if start_i >= inv.size then
					start_i = 0
				end
				winv.refresh(player)
			end
			inv.start_i = start_i
		end
		
		if fields.winv_creative_modfilter_scroll then
			local scrolldis = minetest.explode_scrollbar_event(fields.winv_creative_modfilter_scroll)
			inv.mod_filter_scroll = scrolldis.value
		end
	end,
})

winv:register_listring("player", "creative", function(player)
	local name = player:get_player_name()
	local listring = {
		"listring[detached:winv_creative_"..name..";main]",
		"listring[current_player;main]",
		"listring[detached:trash;main]",
	}
	return table.concat(listring, "")
end)

winv:register_listring("crafting", "creative", function(player)
	local name = player:get_player_name()
	local listring = {
		"listring[detached:winv_creative_"..name..";main]",
		"listring[detached:winv_craft_"..name..";input]",
		"listring[detached:trash;main]",
		"listring[detached:winv_craft_"..name..";output]",
		"listring[detached:trash;main]",
	}
	return table.concat(listring, "")
end)