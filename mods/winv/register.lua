-- store registrations
function winv:register_inventory(inv_name, def)
	if winv.inventories[inv_name] then
		return minetest.log("error", "[winv] Error registering inventory, '"..inv_name.."' already exists!")
	end
	-- compress button data
	local bdef = def.button
	local bdata = {
		texture = bdef.texture, -- main icon
		pressed_texture = bdef.pressed_texture or bdef.texture, -- icon when pressed
		label = bdef.label or "", -- word label, defaults to nothing
		tooltip = bdef.tooltip or inv_name, -- tooltip label, defaults to inv name
	}
	local formspec = nil
	if def.formspec then
		formspec = table.concat(def.formspec)
	end
	-- store data
	winv.inventories[inv_name] = {
		lists = def.lists,
		req = def.requirement,
		button = bdata,
		button_function = def.button_function or nil, -- player, formname, fields
		formspec = formspec or nil,
		formspec_function = def.formspec_function or nil, -- player, formname, fields
		hide_in_node = def.hide_in_node or nil,
		on_player_receive_fields = def.on_player_receive_fields,
        on_exit = def.on_exit or nil,
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

