local S = default.get_translator

minetest.register_node("flora:sand_with_kelp", {
	description = S("Kelp"),
	drawtype = "plantlike_rooted",
	waving = 1,
	tiles = {"blocks_sand.png"},
	special_tiles = {{name = "flora_kelp.png", tileable_vertical = true}},
	inventory_image = "flora_kelp.png",
	wield_image = "flora_kelp.png",
	paramtype = "light",
	paramtype2 = "leveled",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-2/16, 0.5, -2/16, 2/16, 3.5, 2/16},
		},
	},
	node_dig_prediction = "blocks:sand",
	node_placement_prediction = "",
	sounds = default.node_sound_sand_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		-- Call on_rightclick if the pointed node defines it
		if pointed_thing.type == "node" and placer and
				not placer:get_player_control().sneak then
			local node_ptu = minetest.get_node(pointed_thing.under)
			local def_ptu = minetest.registered_nodes[node_ptu.name]
			if def_ptu and def_ptu.on_rightclick then
				return def_ptu.on_rightclick(pointed_thing.under, node_ptu, placer,
					itemstack, pointed_thing)
			end
		end

		local pos = pointed_thing.under
		if minetest.get_node(pos).name ~= "blocks:sand" then
			return itemstack
		end

		local height = math.random(4, 6)
		local pos_top = {x = pos.x, y = pos.y + height, z = pos.z}
		local node_top = minetest.get_node(pos_top)
		local def_top = minetest.registered_nodes[node_top.name]
		local player_name = placer:get_player_name()

		if def_top and def_top.liquidtype == "source" and
				minetest.get_item_group(node_top.name, "water") > 0 then
			if not minetest.is_protected(pos, player_name) and
					not minetest.is_protected(pos_top, player_name) then
				minetest.set_node(pos, {name = "flora:sand_with_kelp",
					param2 = height * 16})
				if not minetest.is_creative_enabled(player_name) then
					itemstack:take_item()
				end
			else
				minetest.chat_send_player(player_name, "Node is protected")
				minetest.record_protection_violation(pos, player_name)
			end
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "blocks:sand"})
	end
})

local function coral_on_place(itemstack, placer, pointed_thing)
	if pointed_thing.type ~= "node" or not placer then
		return itemstack
	end

	local player_name = placer:get_player_name()
	local pos_under = pointed_thing.under
	local pos_above = pointed_thing.above
	local node_under = minetest.get_node(pos_under)
	local def_under = minetest.registered_nodes[node_under.name]

	if def_under and def_under.on_rightclick and not placer:get_player_control().sneak then
		return def_under.on_rightclick(pos_under, node_under,
				placer, itemstack, pointed_thing) or itemstack
	end

	if node_under.name ~= "flora:coral_skeleton" or
			minetest.get_node(pos_above).name ~= "blocks:water_source" then
		return itemstack
	end

	if minetest.is_protected(pos_under, player_name) or
			minetest.is_protected(pos_above, player_name) then
		minetest.log("action", player_name
			.. " tried to place " .. itemstack:get_name()
			.. " at protected position "
			.. minetest.pos_to_string(pos_under))
		minetest.record_protection_violation(pos_under, player_name)
		return itemstack
	end

	node_under.name = itemstack:get_name()
	minetest.set_node(pos_under, node_under)
	if not minetest.is_creative_enabled(player_name) then
		itemstack:take_item()
	end

	return itemstack
end

minetest.register_node("flora:coral_green", {
	description = S("Green Coral"),
	drawtype = "plantlike_rooted",
	waving = 1,
	paramtype = "light",
	tiles = {"flora_coral_skeleton.png"},
	special_tiles = {{name = "flora_coral_green.png", tileable_vertical = true}},
	inventory_image = "flora_coral_green.png",
	wield_image = "flora_coral_green.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "flora:coral_skeleton",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = coral_on_place,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "flora:coral_skeleton"})
	end,
})

minetest.register_node("flora:coral_pink", {
	description = S("Pink Coral"),
	drawtype = "plantlike_rooted",
	waving = 1,
	paramtype = "light",
	tiles = {"flora_coral_skeleton.png"},
	special_tiles = {{name = "flora_coral_pink.png", tileable_vertical = true}},
	inventory_image = "flora_coral_pink.png",
	wield_image = "flora_coral_pink.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "flora:coral_skeleton",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = coral_on_place,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "flora:coral_skeleton"})
	end,
})

minetest.register_node("flora:coral_cyan", {
	description = S("Cyan Coral"),
	drawtype = "plantlike_rooted",
	waving = 1,
	paramtype = "light",
	tiles = {"flora_coral_skeleton.png"},
	special_tiles = {{name = "flora_coral_cyan.png", tileable_vertical = true}},
	inventory_image = "flora_coral_cyan.png",
	wield_image = "flora_coral_cyan.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "flora:coral_skeleton",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = coral_on_place,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "flora:coral_skeleton"})
	end,
})

minetest.register_node("flora:coral_brown", {
	description = S("Brown Coral"),
	tiles = {"flora_coral_brown.png"},
	groups = {cracky = 3},
	drop = "flora:coral_skeleton",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("flora:coral_orange", {
	description = S("Orange Coral"),
	tiles = {"flora_coral_orange.png"},
	groups = {cracky = 3},
	drop = "flora:coral_skeleton",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("flora:coral_skeleton", {
	description = S("Coral Skeleton"),
	tiles = {"flora_coral_skeleton.png"},
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

-- Crafting

minetest.register_craft({
	output = "dye:cyan 3",
	recipe = {{"flora:coral_cyan"}}
})

minetest.register_craft({
	output = "dye:pink 3",
	recipe = {{"flora:coral_pink"}}
})

minetest.register_craft({
	output = "dye:brown 3",
	recipe = {{"flora:coral_brown"}}
})

minetest.register_craft({
	output = "dye:orange 3",
	recipe = {{"flora:coral_orange"}}
})

minetest.register_craft({
	output = "dye:dark_green 3",
	recipe = {{"flora:coral_green"}}
})