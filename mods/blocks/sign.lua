local function lock_icon(locked, owner)
	if locked == "lock" then
		return "image_button[0.3,0.975;1.05,1.05;gui_lock.png;sign_protect;;;false;gui_lock.png]"..
			"tooltip[sign_protect;Press to protect-lock sign \nCurrently locked \nOwned by "..owner.."]"
	elseif locked == "protect" then
		return "image_button[0.3,0.975;1.05,1.05;gui_protect.png;sign_unlock;;;false;gui_protect.png]"..
			"tooltip[sign_unlock;Press to unlock sign \nCurrently protect-locked \nOwned by "..owner.."]"
	elseif locked == "unlock" then
		return "image_button[0.3,0.975;1.05,1.05;gui_unlock.png;sign_lock;;;false;gui_unlock.png]"..
			"tooltip[sign_lock;Press to lock sign \nCurrently unlocked \nOwned by "..owner.."]"
	else
		return ""
	end
end

local function sign_formspec(pos)
	local meta = minetest.get_meta(pos)
	local locked = meta:get_string("lock")
	local owner = meta:get_string("owner")
	local text = meta:get_string("text")
	return "formspec_version[4]"..
		"size[10.5,3]"..
		lock_icon(locked, owner)..
		"textarea[1.55,0.4;7.4,2.2;sign_text;;"..text.."]"..
		"image_button_exit[9.25,0.975;1.05,1.05;gui_enter.png;sign_save;;;false]"
end

local function sign_on_construct(pos)
	local meta = minetest.get_meta(pos)
	meta:set_string("lock", "lock")
	meta:set_string("text", "Insert text here")
	meta:set_string("formspec", sign_formspec(pos))
end

local function sign_after_place_node(pos, placer, itemstack, pointed_thing)
	if placer then
		local meta = minetest.get_meta(pos)
		local owner = placer and placer:get_player_name() or ""
		meta:set_string("owner", owner)
		meta:set_string("formspec", sign_formspec(pos))
	end
end

local function sign_on_receive_fields(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	local playername = sender:get_player_name()
	local owner = meta:get_string("owner")
	local locked = meta:get_string("lock")
	if minetest.is_protected(pos, playername) then
		minetest.record_protection_violation(pos, playername)
		return
	end
	if owner == playername or owner == "" then
		if fields.sign_protect then
			meta:set_string("lock", "protect")
			meta:set_string("formspec", sign_formspec(pos))
		elseif fields.sign_unlock then
			meta:set_string("lock", "unlock")
			meta:set_string("formspec", sign_formspec(pos))
		elseif fields.sign_lock then
			meta:set_string("lock", "lock")
			meta:set_string("formspec", sign_formspec(pos))
		end
	end
	local text = fields.sign_text
	if not text then
		return
	end
	-- if lock only allow owner to edit
	if locked == "lock" and owner ~= playername and owner ~= "" then
		minetest.chat_send_player(playername, "[sign] Sign is locked and owned by "..owner)
		return
	end
	-- if lock or protect, allow protected to edit
	if locked == "protect" and minetest.is_protected(pos, playername) then
		minetest.record_protection_violation(pos, playername)
		return
	end
	if string.len(text) > 512 then
		minetest.chat_send_player(playername, "[sign] Text too long")
		return
	end
	minetest.log("action", playername.." wrote \""..text:gsub("\n", " / ").."\" to the sign at "..minetest.pos_to_string(pos))
	meta:set_string("text", text)
	meta:set_string("formspec", sign_formspec(pos))
	if #text > 0 then
		meta:set_string("infotext", '"'..text..'"')
	else
		meta:set_string("infotext", "")
	end
end

local function sign_can_dig(pos, player)
	local meta = minetest.get_meta(pos)
	local playername = player:get_player_name()
	local owner = meta:get_string("owner")
	local locked = meta:get_string("lock")
	if locked == "lock" and owner ~= playername and owner ~= "" then
		minetest.chat_send_player(playername, "[sign] Sign is locked and owned by "..owner)
		return false
	else
		if minetest.is_protected(pos, playername) then
			minetest.record_protection_violation(pos, playername)
			return false
		end
	end
	return true
end

local arrowsign_rotation = {
	[0] = 16,
	[16] = 20,
	[20] = 12,
	[12] = 0,
	--
	[1] = 5,
	[5] = 23,
	[23] = 9,
	[9] = 1,
	--
	[2] = 14,
	[14] = 22,
	[22] = 18,
	[18] = 2,
	--
	[3] = 11,
	[11] = 21,
	[21] = 7,
	[7] = 3,
	--
	[4] = 19,
	[19] = 10,
	[10] = 13,
	[13] = 4,
	--
	[8] = 17,
	[17] = 6,
	[6] = 15,
	[15] = 8,
}

local function arrowsign_on_rotate(pos, node, player, mode, new_param2)
	node.param2 = arrowsign_rotation[node.param2] or 0
	minetest.swap_node(pos, node)
	return true
end

local function hangsign_on_rotate(pos, node, player, mode, new_param2)
	node.param2 = node.param2 + 1
	if node.param2 > 3 then
		node.param2 = 0
	end
	minetest.swap_node(pos, node)
	return true
end

local function register_sign(material, desc, def)
	local agroup = table.copy(def.groups)
	agroup.attached_node = 1
	minetest.register_node("blocks:sign_"..material, {
		description = desc.." Sign",
		drawtype = "nodebox",
		tiles = {"blocks_sign_"..material..".png^blocks_sign_border_"..material..".png"},
		inventory_image = "blocks_sign_"..material..".png",
		paramtype = "light",
		paramtype2 = "wallmounted",
		sunlight_propagates = true,
		is_ground_content = false,
		walkable = false,
		use_texture_alpha = "opaque",
		node_box = {
			type = "wallmounted",
			wall_top    = {-0.4375, 0.4375, -0.3125, 0.4375, 0.5, 0.3125},
			wall_bottom = {-0.4375, -0.5, -0.3125, 0.4375, -0.4375, 0.3125},
			wall_side   = {-0.5, -0.3125, -0.4375, -0.4375, 0.3125, 0.4375},
		},
		groups = agroup,
		legacy_wallmounted = true,
		sounds = def.sounds,
		on_construct = sign_on_construct,
		after_place_node = sign_after_place_node,
		on_receive_fields = sign_on_receive_fields,
		can_dig = sign_can_dig,
	})

	minetest.register_node("blocks:arrowsign_"..material, {
		description = desc.." Arrow-Sign",
		drawtype = "nodebox",
		tiles = {
			"blocks_sign_border_"..material..".png",
			"blocks_sign_border_"..material..".png",
			"blocks_sign_border_"..material..".png",
			"blocks_sign_border_"..material..".png",
			"blocks_sign_arrow_"..material..".png^[transformFX",
			"blocks_sign_arrow_"..material..".png"
		},
		inventory_image = "blocks_sign_arrow_"..material..".png",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = false,
		walkable = false,
		use_texture_alpha = "opaque",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.25, -0.3125, 0.4375, 0.5, 0.3125, 0.5},
				{-0.3125, -0.25, 0.4375, -0.25, 0.25, 0.5},
				{-0.375, -0.1875, 0.4375, -0.3125, 0.1875, 0.5},
				{-0.4375, -0.125, 0.4375, -0.375, 0.125, 0.5},
				{-0.5, -0.0625, 0.4375, -0.4375, 0.0625, 0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.3125, 0.4375, 0.5, 0.3125, 0.5}
			},
		},
		groups = def.groups,
		legacy_wallmounted = true,
		sounds = def.sounds,
		on_construct = sign_on_construct,
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			sign_after_place_node(pos, placer, itemstack, pointed_thing)
			local ppos = pointed_thing.under
			local direction = pos.y - ppos.y
			local node = minetest.get_node(pos)
			if direction == -1 then -- ceiling
				node.param2 = 8
				minetest.swap_node(pos, node)
			elseif direction == 1 then -- floor
				node.param2 = 4
				minetest.swap_node(pos, node)
			end
		end,
		on_receive_fields = sign_on_receive_fields,
		can_dig = sign_can_dig,
		on_rotate = arrowsign_on_rotate,
	})

	minetest.register_node("blocks:hangsign_"..material, {
		description = desc.." Hanging Sign",
		drawtype = "nodebox",
		tiles = {
			"blocks_sign_border_"..material..".png",
			"blocks_sign_border_"..material..".png",
			"blocks_sign_border_"..material..".png",
			"blocks_sign_border_"..material..".png",
			"blocks_sign_hang_"..material..".png^[transformFX",
			"blocks_sign_hang_"..material..".png"
		},
		inventory_image = "blocks_sign_hang_"..material..".png",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = false,
		walkable = false,
		use_texture_alpha = "clip",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.4375, -0.3125, 0.4375, 0.4375, 0.3125, 0.5},
				{-0.4375, 0.3125, 0.4375, 0.4375, 0.5, 0.4375},
			},
		},
		groups = def.groups,
		legacy_wallmounted = true,
		sounds = def.sounds,
		on_construct = sign_on_construct,
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			sign_after_place_node(pos, placer, itemstack, pointed_thing)
			-- force placement only on ceiling
			local ppos = pointed_thing.under
			local direction = pos.y - ppos.y
			if direction == -1 then
				return
			end
			minetest.remove_node(pos)
		end,
		on_receive_fields = sign_on_receive_fields,
		can_dig = sign_can_dig,
		on_rotate = hangsign_on_rotate,
	})

	minetest.register_node("blocks:hangarrowsign_"..material, {
		description = desc.." Hanging Arrow-Sign",
		drawtype = "nodebox",
		tiles = {
			"blocks_sign_border_"..material..".png",
			"blocks_sign_border_"..material..".png",
			"blocks_sign_border_"..material..".png",
			"blocks_sign_border_"..material..".png",
			"blocks_sign_hangarrow_"..material..".png^[transformFX",
			"blocks_sign_hangarrow_"..material..".png"
		},
		inventory_image = "blocks_sign_hangarrow_"..material..".png",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = false,
		walkable = false,
		use_texture_alpha = "clip",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.25, -0.3125, 0.4375, 0.5, 0.3125, 0.5},
				{-0.3125, -0.25, 0.4375, -0.25, 0.25, 0.5},
				{-0.375, -0.1875, 0.4375, -0.3125, 0.1875, 0.5},
				{-0.4375, -0.125, 0.4375, -0.375, 0.125, 0.5},
				{-0.5, -0.0625, 0.4375, -0.4375, 0.0625, 0.5},
				{-0.4375, 0.3125, 0.4375, 0.4375, 0.5, 0.4375},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.3125, 0.4375, 0.5, 0.3125, 0.5}
			},
		},
		groups = def.groups,
		legacy_wallmounted = true,
		sounds = def.sounds,
		on_construct = sign_on_construct,
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			sign_after_place_node(pos, placer, itemstack, pointed_thing)
			-- force placement only on ceiling
			local ppos = pointed_thing.under
			local direction = pos.y - ppos.y
			if direction == -1 then
				return
			end
			minetest.remove_node(pos)
		end,
		on_receive_fields = sign_on_receive_fields,
		can_dig = sign_can_dig,
		on_rotate = hangsign_on_rotate,
	})
	minetest.register_node("blocks:hangarrowsign_right_"..material, {
		description = desc.." Hanging Arrow-Sign (Right)",
		drawtype = "nodebox",
		tiles = {
			"blocks_sign_border_"..material..".png",
			"blocks_sign_border_"..material..".png",
			"blocks_sign_border_"..material..".png",
			"blocks_sign_border_"..material..".png",
			"blocks_sign_hangarrow_"..material..".png",
			"blocks_sign_hangarrow_"..material..".png^[transformFX"
		},
		inventory_image = "blocks_sign_hangarrow_"..material..".png^[transformFX",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = false,
		walkable = false,
		use_texture_alpha = "clip",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.3125, 0.4375, 0.25, 0.3125, 0.5},
				{0.25, -0.25, 0.4375, 0.3125, 0.25, 0.5},
				{0.3125, -0.1875, 0.4375, 0.375, 0.1875, 0.5},
				{0.375, -0.125, 0.4375, 0.4375, 0.125, 0.5},
				{0.4375, -0.0625, 0.4375, 0.5, 0.0625, 0.5},
				{-0.5, 0.3125, 0.4375, 0.25, 0.5, 0.4375},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.3125, 0.4375, 0.5, 0.3125, 0.5}
			},
		},
		groups = def.groups,
		legacy_wallmounted = true,
		sounds = def.sounds,
		on_construct = sign_on_construct,
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			sign_after_place_node(pos, placer, itemstack, pointed_thing)
			-- force placement only on ceiling
			local ppos = pointed_thing.under
			local direction = pos.y - ppos.y
			if direction == -1 then
				return
			end
			minetest.remove_node(pos)
		end,
		on_receive_fields = sign_on_receive_fields,
		can_dig = sign_can_dig,
		on_rotate = hangsign_on_rotate,
	})
end

register_sign("wood", "Wooden", {
	sounds = default.node_sound_wood_defaults(),
	groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 3}
})

register_sign("steel", "Steel", {
	sounds = default.node_sound_metal_defaults(),
	groups = {cracky = 2}
})

minetest.register_node("blocks:sign_support", {
	description = "Sign Support",
	tiles = {
		"blocks_sign_support.png",
		"blocks_sign_support.png",
		"blocks_sign_support.png",
		"blocks_sign_support_b.png",
		"blocks_sign_support.png",
		"blocks_sign_support_b.png"
	},
	inventory_image = "blocks_sign_support_b.png",
	wield_image = "blocks_sign_support_b.png",
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=3, oddly_breakable_by_hand=2, flammable=3},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 0.5, -0.375, 0.5},
			{-0.5, -0.5, 0.4375, 0.5, -0.0625, 0.4375},
		},
	},
})

minetest.register_node("blocks:sign_support_2", {
	description = "Sign Support (Right)",
	tiles = {
		"blocks_sign_support.png",
		"blocks_sign_support.png",
		"blocks_sign_support.png^[transformFX",
		"blocks_sign_support_b.png^[transformFX",
		"blocks_sign_support.png^[transformFX",
		"blocks_sign_support_b.png^[transformFX"
	},
	inventory_image = "blocks_sign_support_b.png^[transformFX",
	wield_image = "blocks_sign_support_b.png^[transformFX",
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=3, oddly_breakable_by_hand=2, flammable=3},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 0.5, -0.375, 0.5},
			{-0.5, -0.5, 0.4375, 0.5, -0.0625, 0.4375},
		},
	},
})

--
-- == CRAFTS
--
-- Wood
minetest.register_craft({
	output = "blocks:sign_wood 3",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "blocks:arrowsign_wood 3",
	recipe = {
		{"", "group:wood", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
		{"", "group:wood", "group:wood"},
	}
})

minetest.register_craft({
	output = "blocks:hangsign_wood",
	recipe = {
		{"blocks:steel_ingot", "blocks:sign_wood", "blocks:steel_ingot"},
	}
})

minetest.register_craft({
	output = "blocks:hangarrowsign_wood",
	recipe = {
		{"blocks:steel_ingot", "blocks:arrowsign_wood", "blocks:steel_ingot"},
	}
})


minetest.register_craft({
	output = "blocks:hangarrowsign_right_wood",
	recipe = {
		{"blocks:hangarrowsign_wood"},
	}
})

minetest.register_craft({
	output = "blocks:hangarrowsign_wood",
	recipe = {
		{"blocks:hangarrowsign_right_wood"},
	}
})

-- Steel
minetest.register_craft({
	output = "blocks:sign_steel 3",
	recipe = {
		{"blocks:steel_ingot", "blocks:steel_ingot", "blocks:steel_ingot"},
		{"blocks:steel_ingot", "blocks:steel_ingot", "blocks:steel_ingot"},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "blocks:arrowsign_steel 3",
	recipe = {
		{"", "blocks:steel_ingot", "blocks:steel_ingot"},
		{"blocks:steel_ingot", "blocks:steel_ingot", "blocks:steel_ingot"},
		{"", "blocks:steel_ingot", "blocks:steel_ingot"},
	}
})

minetest.register_craft({
	output = "blocks:hangsign_steel",
	recipe = {
		{"blocks:steel_ingot", "blocks:sign_steel", "blocks:steel_ingot"},
	}
})

minetest.register_craft({
	output = "blocks:hangarrowsign_steel",
	recipe = {
		{"blocks:steel_ingot", "blocks:arrowsign_steel", "blocks:steel_ingot"},
	}
})


minetest.register_craft({
	output = "blocks:hangarrowsign_right_steel",
	recipe = {
		{"blocks:hangarrowsign_steel"},
	}
})

minetest.register_craft({
	output = "blocks:hangarrowsign_steel",
	recipe = {
		{"blocks:hangarrowsign_right_steel"},
	}
})

-- Sign Support
minetest.register_craft({
	output = "blocks:sign_support",
	recipe = {
		{"", "group:stick", "group:stick"},
		{"group:stick", "group:stick", "group:stick"},
	}
})

minetest.register_craft({
	output = "blocks:sign_support",
	recipe = {
		{"blocks:sign_support_2"},
	}
})

minetest.register_craft({
	output = "blocks:sign_support_2",
	recipe = {
		{"blocks:sign_support"},
	}
})