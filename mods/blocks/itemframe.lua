local tmp = {}

local function remove_item(pos, node)
	local objs = minetest.get_objects_inside_radius(pos, 0.5)
	if not objs then return end

	for _, obj in pairs(objs) do
		local ent = obj:get_luaentity()
		if obj and ent and ent.name == "blocks:f_item" then
			obj:remove()
		end
	end
end

local facedir = {
	[0] = {x = 0,  y = 0, z = 1},
	      {x = 1,  y = 0, z = 0},
	      {x = 0,  y = 0, z = -1},
	      {x = -1, y = 0, z = 0}
}

local function update_item(pos, node)
	remove_item(pos, node)
	local meta = minetest.get_meta(pos)
	local itemstring = meta:get_string("item")
	local posad = facedir[node.param2]
	if not posad or itemstring == "" then return end

	pos = vector.add(pos, vector.multiply(posad, 7.5/16))
	tmp.nodename = node.name
	tmp.texture = ItemStack(itemstring):get_name()

	local entity = minetest.add_entity(pos, "blocks:f_item")
	local yaw = (math.pi * 2) - node.param2 * (math.pi / 2)
	-- ensure entity still exists
	if entity then
		entity:set_yaw(yaw)
		-- start timer
		local timer = minetest.get_node_timer(pos)
		timer:start(15.0)
	end
end

local function drop_item(pos, node)
	local meta = minetest.get_meta(pos)
	local item = meta:get_string("item")
	if item == "" then return end

	minetest.add_item(pos, item)
	meta:set_string("item", "")
	remove_item(pos, node)

	local timer = minetest.get_node_timer(pos)
	timer:stop()
end

local function itemframe_after_place(pos, placer, itemstack)
	local meta = minetest.get_meta(pos)
	local name = placer:get_player_name()
	meta:set_string("owner", name)
	meta:set_string("infotext", "Item Frame (owned by "..name..")")
end

local function itemframe_timer(pos)
	local node = minetest.get_node(pos)
	local meta = minetest.get_meta(pos)
	local num = #minetest.get_objects_inside_radius(pos, 0.5)

	if num == 0 and meta:get_string("item") ~= "" then
		update_item(pos, node)
	end

	return true
end

local function itemframe_rightclick(pos, node, clicker, itemstack)
	local meta = minetest.get_meta(pos)
	local player_name = clicker:get_player_name()
	local owner = meta:get_string("owner")
	local admin = minetest.check_player_privs(player_name, "protection_bypass")

	if not admin and (player_name ~= owner or not itemstack) then
		return itemstack
	end

	drop_item(pos, node)
	local itemstring = itemstack:take_item():to_string()
	meta:set_string("item", itemstring)
	update_item(pos, node)
	return itemstack
end

local function itemframe_punch(pos, node, puncher)
	local meta = minetest.get_meta(pos)
	local player_name = puncher:get_player_name()
	local owner = meta:get_string("owner")
	local admin = minetest.check_player_privs(player_name, "protection_bypass")
	if admin or player_name == owner then
		drop_item(pos, node)
	end
end

local function itemframe_dig(pos, player)
	if not player then return end
	local meta = minetest.get_meta(pos)
	local player_name = player and player:get_player_name()
	local owner = meta:get_string("owner")
	local admin = minetest.check_player_privs(player_name, "protection_bypass")

	return admin or player_name == owner
end

local function register_itemframe(material, desc, def)
	minetest.register_node("blocks:itemframe_"..material, {
		description = desc.." Item Frame",
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.4375, -0.4375, 0.4375, 0.4375, 0.4375, 0.5},
			}
		},
		groups = def.groups,
		sounds = def.sounds,
		on_rotate = false,
		sunlight_propagates = true,
		inventory_image = "blocks_itemframe_"..material..".png",
		paramtype = "light",
		paramtype2 = "facedir",
		tiles = {
			"blocks_sign_border_"..material..".png",
			"blocks_sign_border_"..material..".png",
			"blocks_sign_border_"..material..".png",
			"blocks_sign_border_"..material..".png",
			"blocks_itemframe_back_"..material..".png^[transformFX",
			"blocks_itemframe_"..material..".png"
		},
		after_place_node = itemframe_after_place,
		on_timer = itemframe_timer,
		on_rightclick = itemframe_rightclick,
		on_punch = itemframe_punch,
		can_dig = itemframe_dig,
		after_destruct = remove_item
	})
	minetest.register_node("blocks:hangitemframe_"..material, {
		description = desc.." Hanging Item Frame",
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.4375, -0.4375, 0.4375, 0.4375, 0.4375, 0.5},
				{-0.4375, 0.4375, 0.4375, 0.4375, 0.5, 0.4375},
			}
		},
		groups = def.groups,
		sounds = def.sounds,
		on_rotate = false,
		sunlight_propagates = true,
		inventory_image = "blocks_itemframe_hang_"..material..".png",
		paramtype = "light",
		paramtype2 = "facedir",
		tiles = {
			"blocks_sign_border_"..material..".png",
			"blocks_sign_border_"..material..".png",
			"blocks_sign_border_"..material..".png",
			"blocks_sign_border_"..material..".png",
			"blocks_itemframe_hang_"..material..".png^[transformFX",
			"blocks_itemframe_hang_"..material..".png"
		},
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			itemframe_after_place(pos, placer, itemstack, pointed_thing)
			-- force placement only on ceiling
			local ppos = pointed_thing.under
			local direction = pos.y - ppos.y
			if direction == -1 then
				return
			end
			minetest.remove_node(pos)
		end,
		on_timer = itemframe_timer,
		on_rightclick = itemframe_rightclick,
		on_punch = itemframe_punch,
		can_dig = itemframe_dig,
		after_destruct = remove_item
	})
end

register_itemframe("wood", "Wooden", {
	sounds = default.node_sound_wood_defaults(),
	groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 3, itemframe = 1}
})

register_itemframe("steel", "Steel", {
	sounds = default.node_sound_metal_defaults(),
	groups = {cracky = 2, itemframe = 1}
})

minetest.register_entity("blocks:f_item", {
	visual = "wielditem",
	visual_size = {x = 0.33, y = 0.33},
	collisionbox = {0},
	physical = false,
	textures = {"air"},
	on_activate = function(self, staticdata)
		local pos = self.object:get_pos()
		local nname = minetest.get_node(pos).name
		if minetest.get_item_group(nname, "itemframe") == 0 then
			self.object:remove()
			return
		end

		if tmp.nodename and tmp.texture then
			self.nodename = tmp.nodename
			tmp.nodename = nil
			self.texture = tmp.texture
			tmp.texture = nil
		elseif staticdata and staticdata ~= "" then
			local data = staticdata:split(";")
			if data and data[1] and data[2] then
				self.nodename = data[1]
				self.texture = data[2]
			end
		end
		if self.texture then
			self.object:set_properties({
				textures = {self.texture}
			})
		end
	end,
	get_staticdata = function(self)
		if self.nodename and self.texture then
			return self.nodename .. ";" .. self.texture
		end

		return ""
	end
})

--
-- == CRAFTS
--
-- Wood
minetest.register_craft({
	output = "blocks:itemframe_wood 2",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "blocks:paper", "group:wood"},
		{"group:wood", "group:wood", "group:wood"}
	}
})

minetest.register_craft({
	output = "blocks:hangitemframe_wood",
	recipe = {
		{"blocks:steel_ingot", "blocks:itemframe_wood", "blocks:steel_ingot"},
	}
})

-- Steel
minetest.register_craft({
	output = "blocks:itemframe_steel 2",
	recipe = {
		{"blocks:steel_ingot", "blocks:steel_ingot", "blocks:steel_ingot"},
		{"blocks:steel_ingot", "blocks:paper", "blocks:steel_ingot"},
		{"blocks:steel_ingot", "blocks:steel_ingot", "blocks:steel_ingot"}
	}
})

minetest.register_craft({
	output = "blocks:hangitemframe_steel",
	recipe = {
		{"blocks:steel_ingot", "blocks:itemframe_steel", "blocks:steel_ingot"},
	}
})