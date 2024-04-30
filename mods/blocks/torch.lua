-- support for MT game translation.
local S = default.get_translator

local function on_flood(pos, oldnode, newnode, torch)
	minetest.add_item(pos, ItemStack(torch .. " 1"))
	-- Play flame-extinguish sound if liquid is not an 'igniter'
	local nodedef = minetest.registered_items[newnode.name]
	if not (nodedef and nodedef.groups and
			nodedef.groups.igniter and nodedef.groups.igniter > 0) then
		minetest.sound_play(
			"default_cool_lava",
			{pos = pos, max_hear_distance = 16, gain = 0.1},
			true
		)
	end
	-- Remove the torch node
	return false
end

minetest.register_node("blocks:torch", {
	description = S("Torch"),
	drawtype = "mesh",
	mesh = "torch_floor.obj",
	inventory_image = "blocks_torch_on_floor.png",
	wield_image = "blocks_torch_on_floor.png",
	tiles = {{
		    name = "blocks_torch_on_floor_animated.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0}
	}},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	liquids_pointable = false,
	light_source = 12,
	groups = {choppy=2, dig_immediate=3, flammable=1, attached_node=1, torch=1, loot = 1},
	drop = "blocks:torch",
	selection_box = {
		type = "wallmounted",
		wall_bottom = {-1/8, -1/2, -1/8, 1/8, 2/16, 1/8},
	},
	sounds = default.node_sound_wood_defaults(),
	on_place = function(itemstack, placer, pointed_thing)
		local under = pointed_thing.under
		local node = minetest.get_node(under)
		local def = minetest.registered_nodes[node.name]
		if def and def.on_rightclick and
			not (placer and placer:is_player() and
			placer:get_player_control().sneak) then
			return def.on_rightclick(under, node, placer, itemstack,
				pointed_thing) or itemstack
		end

		local above = pointed_thing.above
		local wdir = minetest.dir_to_wallmounted(vector.subtract(under, above))
		local fakestack = itemstack
		if wdir == 0 then
			fakestack:set_name("blocks:torch_ceiling")
		elseif wdir == 1 then
			fakestack:set_name("blocks:torch")
		else
			fakestack:set_name("blocks:torch_wall")
		end

		itemstack = minetest.item_place(fakestack, placer, pointed_thing, wdir)
		itemstack:set_name("blocks:torch")

		return itemstack
	end,
	floodable = true,
	on_flood = function(pos, oldnode, newnode)
		on_flood(pos, oldnode, newnode, "blocks:torch")
	end,
	on_rotate = false
})

minetest.register_node("blocks:torch_wall", {
	drawtype = "mesh",
	mesh = "torch_wall.obj",
	tiles = {{
		    name = "blocks_torch_on_floor_animated.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0}
	}},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 12,
	groups = {choppy=2, dig_immediate=3, flammable=1, not_in_creative_inventory=1, attached_node=1, torch=1},
	drop = "blocks:torch",
	selection_box = {
		type = "wallmounted",
		wall_side = {-1/2, -1/2, -1/8, -1/8, 1/8, 1/8},
	},
	sounds = default.node_sound_wood_defaults(),
	floodable = true,
	on_flood = function(pos, oldnode, newnode)
		on_flood(pos, oldnode, newnode, "blocks:torch_wall")
	end,
	on_rotate = false
})

minetest.register_node("blocks:torch_ceiling", {
	drawtype = "mesh",
	mesh = "torch_ceiling.obj",
	tiles = {{
		    name = "blocks_torch_on_floor_animated.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0}
	}},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 12,
	groups = {choppy=2, dig_immediate=3, flammable=1, not_in_creative_inventory=1, attached_node=1, torch=1},
	drop = "blocks:torch",
	selection_box = {
		type = "wallmounted",
		wall_top = {-1/8, -1/16, -5/16, 1/8, 1/2, 1/8},
	},
	sounds = default.node_sound_wood_defaults(),
	floodable = true,
	on_flood = function(pos, oldnode, newnode)
		on_flood(pos, oldnode, newnode, "blocks:torch_ceiling")
	end,
	on_rotate = false
})

minetest.register_lbm({
	name = "blocks:3dtorch",
	nodenames = {"blocks:torch", "torches:floor", "torches:wall"},
	action = function(pos, node)
		if node.param2 == 0 then
			minetest.set_node(pos, {name = "blocks:torch_ceiling",
				param2 = node.param2})
		elseif node.param2 == 1 then
			minetest.set_node(pos, {name = "blocks:torch",
				param2 = node.param2})
		else
			minetest.set_node(pos, {name = "blocks:torch_wall",
				param2 = node.param2})
		end
	end
})

minetest.register_craft({
	output = "blocks:torch 4",
	recipe = {
		{"blocks:coal_lump"},
		{"group:stick"},
	}
})

for i=1,#blocks.fire_types do
	local name = blocks.fire_types[i][1]
	local torch_description = blocks.fire_types[i][2]
	local craft_material = blocks.fire_types[i][3]
	minetest.register_node("blocks:torch_" .. name, {
		description = S(torch_description .. " Torch"),
		drawtype = "mesh",
		mesh = "torch_floor.obj",
		inventory_image = "blocks_torch_" .. name .. ".png",
		wield_image = "blocks_torch_" .. name .. ".png",
		tiles = {{
				name = "blocks_torch_" .. name .. "_animated.png",
				animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0}
		}},
		use_texture_alpha = "clip",
		paramtype = "light",
		paramtype2 = "wallmounted",
		sunlight_propagates = true,
		walkable = false,
		liquids_pointable = false,
		light_source = 12,
		groups = {choppy=2, dig_immediate=3, flammable=1, attached_node=1, torch=1, loot = 2},
		drop = "blocks:torch_" .. name,
		selection_box = {
			type = "wallmounted",
			wall_bottom = {-1/8, -1/2, -1/8, 1/8, 2/16, 1/8},
		},
		sounds = default.node_sound_wood_defaults(),
		on_place = function(itemstack, placer, pointed_thing)
			local under = pointed_thing.under
			local node = minetest.get_node(under)
			local def = minetest.registered_nodes[node.name]
			if def and def.on_rightclick and
				not (placer and placer:is_player() and
				placer:get_player_control().sneak) then
				return def.on_rightclick(under, node, placer, itemstack,
					pointed_thing) or itemstack
			end

			local above = pointed_thing.above
			local wdir = minetest.dir_to_wallmounted(vector.subtract(under, above))
			local fakestack = itemstack
			if wdir == 0 then
				fakestack:set_name("blocks:torch_" .. name .. "_ceiling")
			elseif wdir == 1 then
				fakestack:set_name("blocks:torch_" .. name)
			else
				fakestack:set_name("blocks:torch_" .. name .. "_wall")
			end

			itemstack = minetest.item_place(fakestack, placer, pointed_thing, wdir)
			itemstack:set_name("blocks:torch_" .. name)

			return itemstack
		end,
		floodable = true,
		on_flood = function(pos, oldnode, newnode)
			on_flood(pos, oldnode, newnode, "blocks:torch_" .. name)
		end,
		on_rotate = false
	})

	minetest.register_node("blocks:torch_" .. name .. "_wall", {
		drawtype = "mesh",
		mesh = "torch_wall.obj",
		tiles = {{
				name = "blocks_torch_" .. name .. "_animated.png",
				animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0}
		}},
		use_texture_alpha = "clip",
		paramtype = "light",
		paramtype2 = "wallmounted",
		sunlight_propagates = true,
		walkable = false,
		light_source = 12,
		groups = {choppy=2, dig_immediate=3, flammable=1, not_in_creative_inventory=1, attached_node=1, torch=1},
		drop = "blocks:torch_" .. name,
		selection_box = {
			type = "wallmounted",
			wall_side = {-1/2, -1/2, -1/8, -1/8, 1/8, 1/8},
		},
		sounds = default.node_sound_wood_defaults(),
		floodable = true,
		on_flood = function(pos, oldnode, newnode)
			on_flood(pos, oldnode, newnode, "blocks:torch_" .. name .. "_wall")
		end,
		on_rotate = false
	})

	minetest.register_node("blocks:torch_" .. name .. "_ceiling", {
		drawtype = "mesh",
		mesh = "torch_ceiling.obj",
		tiles = {{
				name = "blocks_torch_" .. name .. "_animated.png",
				animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
		}},
		use_texture_alpha = "clip",
		paramtype = "light",
		paramtype2 = "wallmounted",
		sunlight_propagates = true,
		walkable = false,
		light_source = 12,
		groups = {choppy=2, dig_immediate=3, flammable=1, not_in_creative_inventory=1, attached_node=1, torch=1},
		drop = "blocks:torch_" .. name,
		selection_box = {
			type = "wallmounted",
			wall_top = {-1/8, -1/16, -5/16, 1/8, 1/2, 1/8},
		},
		sounds = default.node_sound_wood_defaults(),
		floodable = true,
		on_flood = function(pos, oldnode, newnode)
			on_flood(pos, oldnode, newnode, "blocks:torch_" .. name .. "_ceiling")
		end,
		on_rotate = false
	})

	minetest.register_lbm({
		name = "blocks:3dtorch_" .. name,
		nodenames = {"blocks:torch_" .. name},
		action = function(pos, node)
			if node.param2 == 0 then
				minetest.set_node(pos, {name = "blocks:torch_" .. name .. "_ceiling",
					param2 = node.param2})
			elseif node.param2 == 1 then
				minetest.set_node(pos, {name = "blocks:torch_" .. name,
					param2 = node.param2})
			else
				minetest.set_node(pos, {name = "blocks:torch_" .. name .. "_wall",
					param2 = node.param2})
			end
		end
	})

	minetest.register_craft({
		output = "blocks:torch_" .. name .. " 4",
		recipe = {
			{craft_material},
			{"group:stick"},
		}
	})
end