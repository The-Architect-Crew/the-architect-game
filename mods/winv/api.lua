local WINV_SELECTOR_AMOUNT = 3

-- create navigation buttons
local function nav_buttons(player, incre, side, node)
	local meta = player:get_meta()
	local left_inv = meta:get_string("winv:left")
	local right_inv = meta:get_string("winv:right")
	local buttonform = ""
	local invno = 0
	for invname, invdata in pairs(winv.inventories) do
		if invdata.button then
			if node then
				if invdata.hide_in_node == true then
					goto continue
				end
			end
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
			::continue::
		end
	end
	if side == "right" then -- switch button
		buttonform = buttonform.."image_button[17.15,-0.6;0.5,0.5;winv_icon_switch.png;winv_switch;;true;false;winv_icon_switch.png]"
	end
	return buttonform
end

-- create listrings rings
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

-- reset inventory
function winv.reset_inventory(player)
	local meta = player:get_meta()
	local default_left_inv, default_right_inv = winv.default.left, winv.default.right
	meta:set_string("winv:left", default_left_inv)
	meta:set_string("winv:right", default_right_inv)
end

-- construct inventory
function winv.init_inventory(player, nodeform)
	local meta = player:get_meta()
	local inv_active = meta:get_string("winv:active")
	local left_inv, right_inv = meta:get_string("winv:left"), meta:get_string("winv:right")
	local default_left_inv, default_right_inv = winv.default.left, winv.default.right
	local force_form
	if inv_active == "" then
		meta:set_string("winv:active", "true")
	end
	if left_inv == "" or right_inv == "" then
		winv.reset_inventory(player)
		left_inv = default_left_inv
		right_inv = default_right_inv
	end
	local idata = winv.inventories
	-- reset inventory to remove inventories that doesnt fit requirement
	if left_inv ~= default_left_inv and right_inv ~= default_right_inv then
		if idata[left_inv].req and not idata[left_inv].req(player) and not nodeform
			or idata[right_inv].req and not idata[right_inv].req(player) then
			winv.reset_inventory(player)
			left_inv = default_left_inv
			right_inv = default_right_inv
		end
	end
	if nodeform then
		if idata[right_inv].hide_in_node then -- if inventory is not supposed to appear in node, switch to default inventory
			if left_inv == default_right_inv then
				meta:set_string("winv:left", default_left_inv)
				left_inv = default_left_inv
			end
			meta:set_string("winv:right", default_right_inv)
			right_inv = default_right_inv
			force_form = true
		end
	end
	local left_form = idata[left_inv].formspec
	local right_form = idata[right_inv].formspec
	if idata[left_inv].formspec_function then
		left_form = idata[left_inv].formspec_function(player)
	end
	if idata[right_inv].formspec_function then
		right_form = idata[right_inv].formspec_function(player)
	end

	local form =
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
	if nodeform then
		if force_form then
			player:set_inventory_formspec(form)
		end
		return
			"formspec_version[4]"..
			"size[17.75, 10.25]"..
			"style_type[*;noclip=true;font_size=13]"..
			"bgcolor[#00000000;neither]"..
			"container[0,0]"..
				nodeform..
			"container_end[]"..
			nav_buttons(player, 10, "right_node", true)..
			"container[10,0]"..
				right_form..
			"container_end[]"
	elseif not nodeform then
		return form
	end
end

winv_v = {}
winv_v.nrefresh = {}
function winv.refresh(player, show_formspec)
	if player then
		local name = player:get_player_name()
		local invform = winv.init_inventory(player)
		player:set_inventory_formspec(invform)
		if show_formspec then
			minetest.show_formspec(name, "", invform)
		end
		winv_v.nrefresh[name] = true -- allow node inventories to detect whether there's a need for refreshes
	end
end

-- check whether there's a need to refresh and reset refresh status for node inventories
function winv.node_refresh(player)
	local name = player:get_player_name()
	if winv_v.nrefresh[name] then
		winv_v.nrefresh[name] = nil
		return true
	end
	return nil
end

-- ensure valid requirements are meet
local function check_req(player, invname)
	local idata = winv.inventories[invname]
	if idata.req then -- valid requirement criteria
		if idata.req(player) then
			return true
		else
			return nil
		end
	end
	return true -- always true otherwise
end

-- player fields
function winv.receive_fields(player, formname, fields)
	local meta = player:get_meta()
	local switchmode = meta:get_string("winv:switch")
	for invname, invdata in pairs(winv.inventories) do
		-- update form name
		if fields["winv_"..invname.."_left"] then
			local left_inv = meta:get_string("winv:left")
			local right_inv = meta:get_string("winv:right")
			if invdata.button_function then -- handle function instead
				invdata.button_function(player, formname, fields)
			else
				if check_req(player, invname) then -- ensure meet requirement to show inventory
					if switchmode == "button" then
						if right_inv ~= invname then -- do not force switch
							meta:set_string("winv:left", invname)
						end
					else
						meta:set_string("winv:left", invname)
						if right_inv == invname then -- force switch inventory if its the same
							meta:set_string("winv:right", left_inv)
						end
					end
				end
				winv.refresh(player)
			end
		elseif fields["winv_"..invname.."_right"] then
			local left_inv = meta:get_string("winv:left")
			local right_inv = meta:get_string("winv:right")
			if invdata.button_function then -- handle function instead
				invdata.button_function(player, formname, fields)
			else
				if check_req(player, invname) then -- ensure meet requirement to show inventory
					if switchmode == "button" then
						if left_inv ~= invname then -- do not force switch
							meta:set_string("winv:right", invname)
						end
					else
						meta:set_string("winv:right", invname)
						if left_inv == invname then  -- switch inventory if its the same
							meta:set_string("winv:left", right_inv)
						end
					end
				end
				winv.refresh(player)
			end
		end
		if invdata.on_player_receive_fields then
			invdata.on_player_receive_fields(player, formname, fields)
		end
	end
	if fields.winv_switch then -- button to swap inventory
		local left_inv = meta:get_string("winv:left")
		local right_inv = meta:get_string("winv:right")
		meta:set_string("winv:left", right_inv)
		meta:set_string("winv:right", left_inv)
		winv.refresh(player)
	end
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	local meta = player:get_meta()
	if formname == "" and meta:get_string("winv:active") == "true" then -- ensure fields only apply for player & winv inventory is active
		winv.receive_fields(player, formname, fields)
	end
end)

-- called for nodes interacting with winv
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

-- === Chat commands to modify settings ===
-- Informative chat messages
local function winv_chat(name, message)
	if minetest.get_player_by_name(name) then
		minetest.chat_send_player(name, minetest.colorize("grey", "[winv]").." "..message)
	end
end

-- Enforce inventory switching
minetest.register_chatcommand("winv_switch", {
    description = "Enable or disable force inventory switching",
    func = function(name)
		local player = minetest.get_player_by_name(name)
		local meta = player:get_meta()
		local switchmode = meta:get_string("winv:switch")
		if switchmode == "" then
			meta:set_string("winv:switch", "button")
			winv_chat(name, "Disabled force switching.")
		else
			meta:set_string("winv:switch", "")
			winv_chat(name, "Enabled force switching.")
		end
	end,
})

-- Selector styles
minetest.register_chatcommand("winv_selector", {
	param = "<no.>",
    description = "Select your preferred selector <no.> (1-"..WINV_SELECTOR_AMOUNT..")",
    func = function(name, param)
		local player = minetest.get_player_by_name(name)
		local meta = player:get_meta()
		if tonumber(param) and tonumber(param) < WINV_SELECTOR_AMOUNT then
			meta:set_string("winv:selector", param)
			player:hud_set_hotbar_selected_image("gui_hotbar_selected_"..param..".png")
			winv_chat(name, "Set to selector "..param..".")
		else
			meta:set_string("winv:selector", "")
			player:hud_set_hotbar_selected_image("gui_hotbar_selected.png")
			winv_chat(name, "Set to default selector.")
		end
	end,
})

minetest.register_on_joinplayer(function(player)
	local meta = player:get_meta()
	-- Set formspec prepend #141318
	player:set_formspec_prepend([[
		listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF]
	]])
	-- Set hotbar textures
	player:hud_set_hotbar_image("gui_hotbar.png")
	if meta:get_string("winv:selector") ~= "" then
		player:hud_set_hotbar_selected_image("gui_hotbar_selected_"..meta:get_string("winv:selector")..".png")
	else
		player:hud_set_hotbar_selected_image("gui_hotbar_selected.png")
	end
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