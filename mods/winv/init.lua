winv = {}
winv.default = {}
winv.default.left = "crafting"
winv.default.right = "player"
winv.inventories = {}
winv.listrings = {}
winv.mod_storage = minetest.get_mod_storage()

-- store registrations
function winv:register_inventory(name, def)
	if winv.inventories[name] then
		return minetest.log("error", "[winv] Error registering inventory, '"..name.."' already exists!")
	end
	-- compress button data
	local bdef = def.button
	local bdata = {
		texture = bdef.texture,
		pressed_texture = bdef.texture,
		label = bdef.label or "",
		tooltip = bdef.tooltip or name,
	}
	local formspec = nil
	if def.formspec then
		formspec = table.concat(def.formspec)
	end
	-- store data
	winv.inventories[name] = {
		lists = def.lists,
		req = def.requirement,
		button = bdata,
		formspec = formspec or nil,
		formspec_function = def.formspec_function,
		on_player_receive_fields = def.on_player_receive_fields
	}
end

function winv:register_listring(inv1, inv2, listring)
	if not winv.inventories[inv1] or not winv.inventories[inv2] then
		return minetest.log("error", "[winv] Error registering listring for '"..inv1.."' and '"..inv2.."'. Inventory does not exist!")
	end
	winv.listrings[inv1..","..inv2] = {
		listring = listring
	}
end

-- player inventory
winv:register_inventory("player", {
	lists = {
		{"main", 6 * 6},
	},
	button = {
		texture = "winv_icon_player.png",
		tooltip = "Player Inventory",
	},
	formspec =  {
		"image[0,0;7.75,7.75;winv_bg.png]",
		"list[current_player;main;0.25,0.25;6,6;]",
	},
})

-- create nav buttons
local function nav_buttons(player, incre, side)
	local meta = player:get_meta()
	local left_inv = meta:get_string("winv:left")
	local right_inv = meta:get_string("winv:right")
	local buttonform = ""
	local invno = 0
	for invname, invdata in pairs(winv.inventories) do
		if invdata.button then
			if invdata.req and invdata.req(player) or not invdata.req then
				local bdef = invdata.button
				local icon_darken = ""
				if side == "left" and left_inv == invname or
					side == "right" and right_inv == invname or
					side == "right_node" and right_inv == invname then
					icon_darken = "^[colorize:#565656" -- darken icon for visible inventories
				end
				buttonform = buttonform.."image_button["..0.1 + (invno * 0.6) + incre..",-0.6;0.5,0.5;"..bdef.texture..""..icon_darken..";winv_"..invname.."_"..side..";"..bdef.label..";true;false;"..bdef.pressed_texture..""..icon_darken.."]"..
					"tooltip[winv_"..invname.."_"..side..";"..bdef.tooltip.."]"
				invno = invno + 1
			end
		end
	end
	return buttonform
end

local function create_listring(player)
	local meta = player:get_meta()
	local left_inv = meta:get_string("winv:left")
	local right_inv = meta:get_string("winv:right")
	local lrdata = winv.listrings[left_inv..","..right_inv] or winv.listrings[right_inv..","..left_inv]
	if lrdata then
		return lrdata.listring(player)
	else
		return ""
	end
end

-- construct inventory
function winv.init_inventory(player, nodeform)
	local meta = player:get_meta()
	local left_inv, right_inv = meta:get_string("winv:left"), meta:get_string("winv:right")
	local default_left_inv, default_right_inv = winv.default.left, winv.default.right
	if left_inv == "" or right_inv == "" then
		meta:set_string("winv:left", default_left_inv)
		meta:set_string("winv:right", default_right_inv)
		left_inv = default_left_inv
		right_inv = default_right_inv
	end
	local idata = winv.inventories
	-- reset inventory to remove inventories that doesnt fit requirement
	if left_inv ~= default_left_inv and right_inv ~= default_right_inv then
		if idata[left_inv].req and not idata[left_inv].req(player) and not nodeform
			or idata[right_inv].req and not idata[right_inv].req(player) then
			meta:set_string("winv:left", default_left_inv)
			meta:set_string("winv:right", default_right_inv)
			left_inv = default_left_inv
			right_inv = default_right_inv
		end
	end
	local left_form = idata[left_inv].formspec
	local right_form = idata[right_inv].formspec
	if idata[meta:get_string("winv:left")].formspec_function then
		left_form = idata[left_inv].formspec_function(player)
	end
	if idata[meta:get_string("winv:right")].formspec_function then
		right_form = idata[right_inv].formspec_function(player)
	end
	if nodeform then
		return
			"formspec_version[4]"..
			"size[17.75, 10.25]"..
			"style_type[*;noclip=true;font_size=13]"..
			"bgcolor[#00000000;neither]"..
			"container[0,0]"..
				nodeform..
			"container_end[]"..
			nav_buttons(player, 10, "right_node")..
			"container[10,0]"..
				right_form..
			"container_end[]"
	elseif not nodeform then
		return
			"formspec_version[4]"..
			"size[17.75, 9]"..
			"style_type[*;noclip=true;font_size=13]"..
			"bgcolor[#00000000;neither]"..
			nav_buttons(player, 0, "left")..
			"container[0,0]"..
				left_form..
			"container_end[]"..
			nav_buttons(player, 10, "right")..
			"container[10,0]"..
				right_form..
			"container_end[]"..
			create_listring(player)
	end
end

function winv.refresh(player)
	if player then
		local invform = winv.init_inventory(player)
		player:set_inventory_formspec(invform)
	end
end

local function check_req(player, invname)
	local idata = winv.inventories[invname]
	if idata.req then
		if idata.req(player) then
			return true
		else
			return nil
		end
	end
	return true
end

function winv.receive_fields(player, formname, fields)
	local meta = player:get_meta()
	for invname, invdata in pairs(winv.inventories) do
		-- normal handling
		if fields["winv_"..invname.."_left"] then
			local left_inv = meta:get_string("winv:left")
			local right_inv = meta:get_string("winv:right")
			if check_req(player, invname) then
				meta:set_string("winv:left", invname)
				if right_inv == invname then -- switch inventory if its the same
					meta:set_string("winv:right", left_inv)
				end
			end
			winv.refresh(player)
		elseif fields["winv_"..invname.."_right"] then
			local left_inv = meta:get_string("winv:left")
			local right_inv = meta:get_string("winv:right")
			if check_req(player, invname) then
				meta:set_string("winv:right", invname)
				if left_inv == invname then  -- switch inventory if its the same
					meta:set_string("winv:left", right_inv)
				end
			end
			winv.refresh(player)
		end
		if invdata.on_player_receive_fields then
			invdata.on_player_receive_fields(player, formname, fields)
		end
	end
end

-- used for nodes interacting with winv
function winv.node_receive_fields(player, formname, fields)
	local meta = player:get_meta()
	for invname, invdata in pairs(winv.inventories) do
		-- node handling
		if fields["winv_"..invname.."_right_node"] then
			local left_inv = meta:get_string("winv:left")
			local right_inv = meta:get_string("winv:right")
			if check_req(player, invname) then
				meta:set_string("winv:right", invname)
				if left_inv == invname then  -- switch inventory if its the same
					meta:set_string("winv:left", right_inv)
				end
			end
			winv.refresh(player)
		end
		if invdata.on_player_receive_fields then
			invdata.on_player_receive_fields(player, formname, fields)
		end
	end
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "" then -- ensure fields only apply for play
		winv.receive_fields(player, formname, fields)
	end
end)

minetest.register_on_joinplayer(function(player)
	-- Set formspec prepend #141318
	player:set_formspec_prepend([[
		listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF]
	]])
	-- Set hotbar textures
	player:hud_set_hotbar_image("gui_hotbar.png")
	player:hud_set_hotbar_selected_image("gui_hotbar_selected.png")
	-- Set hotbar size
	player:hud_set_hotbar_itemcount(12)
	-- initialize inventory sizes
	local inv = player:get_inventory()
	for invname, invdata in pairs(winv.inventories) do
		if invdata.lists then
			for i, ldata in pairs(invdata.lists) do
				local lname = ldata[1]
				local pname = player:get_player_name()
				if string.find(lname, "<playername>") then
					lname = string.gsub(lname, "<playername>", pname)
				end
				inv:set_size(lname, ldata[2])
			end
		end
	end
	-- construct inventory
	local invform = winv.init_inventory(player)
	player:set_inventory_formspec(invform)
end)

local path = minetest.get_modpath("winv")
dofile(path.."/crafting.lua")
dofile(path.."/creative.lua")
dofile(path.."/home.lua")
--dofile(path.."/remote.lua")