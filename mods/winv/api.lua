local WINV_SELECTOR_AMOUNT = 3 -- gui selectors

-- reset inventory
function winv.reset_inventory(player)
	local playername = player:get_player_name()
	winv.data[playername].left = winv.default.left
	winv.data[playername].right = winv.default.right
end

local function init_inventory_data(player)
	local playername = player:get_player_name()
	local meta = player:get_meta()
	local left_inv = meta:get_string("winv:left")
	local right_inv = meta:get_string("winv:right")
	local switch_mode = meta:get_string("winv:switch")
	if left_inv == "" or right_inv == "" then
		left_inv = winv.default.left
		right_inv = winv.default.right
	end
	winv.data[playername] = {
		left = left_inv,
		right = right_inv,
		active = nil,
		switch_mode = switch_mode
	}
end

local function save_inventory_data(player)
	if player then
		local playername = player:get_player_name()
		if winv.data[playername] then
			local meta = player:get_meta()
			meta:set_string("winv:left", winv.data[playername].left)
			meta:set_string("winv:right", winv.data[playername].right)
		end
	end
end

minetest.register_on_leaveplayer(function(player)
    save_inventory_data(player)
end)

minetest.register_on_shutdown(function()
    for _, player in pairs(minetest.get_connected_players()) do
		save_inventory_data(player)
    end
end)

-- create navigation buttons
local function nav_buttons(player, incre, side, node)
	local playername = player:get_player_name()
	local left_inv = winv.data[playername].left
	local right_inv = winv.data[playername].right
	local buttonform = ""
	local invno = 0
	for invname, invdata in pairs(winv.inventories) do
		if invdata.button then
			local hide_in = nil
			if node then
				if invdata.hide_in_node == true then
					hide_in = true
				end
			end
			if not hide_in then
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
	end
	if side == "right" then -- switch button
		buttonform = buttonform.."image_button[17.15,-0.6;0.5,0.5;winv_icon_switch.png;winv_switch;;true;false;winv_icon_switch.png]"
	end
	return buttonform
end

-- create listrings rings
local function get_listring(player)
	local playername = player:get_player_name()
	local left_inv = winv.data[playername].left
	local right_inv = winv.data[playername].right
	local lrdata = winv.listrings[left_inv..","..right_inv] or winv.listrings[right_inv..","..left_inv]
	if lrdata then
		return lrdata.listring(player)
	else
		return ""
	end
end

-- construct inventory
function winv.init_inventory(player, nodeform)
	local playername = player:get_player_name()
	if not winv.data[playername] then
		init_inventory_data(player)
	end

	local inv_active = winv.data[playername].active
	local left_inv = winv.data[playername].left
	local right_inv = winv.data[playername].right

	local default_left_inv, default_right_inv = winv.default.left, winv.default.right
	local force_form
	if not inv_active then
		winv.data[playername].active = true
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
				winv.data[playername].left = default_left_inv
				left_inv = default_left_inv
			end
			winv.data[playername].right = default_right_inv
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
		"bgcolor[#00000099;true;#00000099]"..
		"style_type[*;noclip=true;font_size=13]"..
		nav_buttons(player, 0, "left")..
		"container[0,0]"..
			left_form..
		"container_end[]"..
		nav_buttons(player, 10, "right")..
		"container[10,0]"..
			right_form..
		"container_end[]"..
		get_listring(player)
	if nodeform then
		if force_form then
			player:set_inventory_formspec(form)
		end
		return
			"formspec_version[4]"..
			"size[17.75, 10.25]"..
			"bgcolor[#00000099;true;#00000099]"..
			"style_type[*;noclip=true;font_size=13]"..
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
		local playername = player:get_player_name()
		local invform = winv.init_inventory(player)
		player:set_inventory_formspec(invform)
		if show_formspec then
			minetest.show_formspec(playername, "", invform)
		end
		winv_v.nrefresh[playername] = true -- allow node inventories to detect whether there's a need for refreshes
	end
end

-- check whether there's a need to refresh and reset refresh status for node inventories
function winv.node_refresh(player)
	local playername = player:get_player_name()
	if winv_v.nrefresh[playername] then
		winv_v.nrefresh[playername] = nil
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
	local playername = player:get_player_name()
	local left_inv = winv.data[playername].left
	local right_inv = winv.data[playername].right
	local switch_mode = winv.data[playername].switch_mode
	for invname, invdata in pairs(winv.inventories) do
		-- update form name
		if fields["winv_"..invname.."_left"] then
			if invdata.button_function then -- handle function instead
				invdata.button_function(player, formname, fields)
			else
				if check_req(player, invname) then -- ensure meet requirement to show inventory
					if switch_mode == "button" then
						if right_inv ~= invname then -- do not force switch
							winv.data[playername].left = invname
						end
					else
						winv.data[playername].left = invname
						if right_inv == invname then -- force switch inventory if its the same
							winv.data[playername].right = left_inv
						end
					end
				end
				winv.refresh(player)
			end
		elseif fields["winv_"..invname.."_right"] then
			if invdata.button_function then -- handle function instead
				invdata.button_function(player, formname, fields)
			else
				if check_req(player, invname) then -- ensure meet requirement to show inventory
					if switch_mode == "button" then
						if left_inv ~= invname then -- do not force switch
							winv.data[playername].right = invname
						end
					else
						winv.data[playername].right = invname
						if left_inv == invname then  -- switch inventory if its the same
							winv.data[playername].left = right_inv
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
		winv.data[playername].left = right_inv
		winv.data[playername].right = left_inv
		winv.refresh(player)
	end

	if fields.quit then
		save_inventory_data(player)
	end
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	local playername = player:get_player_name()
	if formname == "" and winv.data[playername].active then -- ensure fields only apply for player & winv inventory is active
		winv.receive_fields(player, formname, fields)
	end
end)

-- called for nodes interacting with winv
function winv.node_receive_fields(player, formname, fields)
	local playername = player:get_player_name()
	local left_inv = winv.data[playername].left
	local right_inv = winv.data[playername].right
	for invname, invdata in pairs(winv.inventories) do
		-- node handling
		if fields["winv_"..invname.."_right_node"] then
			if check_req(player, invname) then
				winv.data[playername].right = invname
				if left_inv == invname then  -- switch inventory if its the same
					winv.data[playername].left = right_inv
				end
			end
			winv.refresh(player)
		end
		if invdata.on_player_receive_fields then
			invdata.on_player_receive_fields(player, formname, fields)
		end

		if fields.quit then
			save_inventory_data(player)
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
    func = function(playername)
		local player = minetest.get_player_by_name(playername)
		local meta = player:get_meta()
		local switch_mode = winv.data[playername].switch_mode
		if switch_mode == "" then
			meta:set_string("winv:switch", "button")
			winv.data[playername].switch_mode = "button"
			winv_chat(playername, "Disabled force switching.")
		else
			meta:set_string("winv:switch", "")
			winv.data[playername].switch_mode = ""
			winv_chat(playername, "Enabled force switching.")
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