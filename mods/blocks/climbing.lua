local S = default.get_translator

minetest.register_node("blocks:ladder_wood", {
	description = S("Wooden Ladder"),
	drawtype = "signlike",
	tiles = {"blocks_ladder_wood.png"},
	inventory_image = "blocks_ladder_wood.png",
	wield_image = "blocks_ladder_wood.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
		--wall_top = = <default>
		--wall_bottom = = <default>
		--wall_side = = <default>
	},
	groups = {choppy = 2, oddly_breakable_by_hand = 3, flammable = 2},
	legacy_wallmounted = true,
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("blocks:ladder_steel", {
	description = S("Steel Ladder"),
	drawtype = "signlike",
	tiles = {"blocks_ladder_steel.png"},
	inventory_image = "blocks_ladder_steel.png",
	wield_image = "blocks_ladder_steel.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
		--wall_top = = <default>
		--wall_bottom = = <default>
		--wall_side = = <default>
	},
	groups = {cracky = 2},
	sounds = default.node_sound_metal_defaults(),
})
-- Chain
minetest.register_node("blocks:chain", {
	description = "Chain",
	drawtype = "signlike",
	tiles = {"blocks_chain.png"},
	inventory_image = "blocks_chain.png",
	wield_image = "blocks_chain.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	climbable = true,
	selection_box = {
		type = "wallmounted",
	},
	groups = {snappy=1,cracky=2,oddly_breakable_by_hand=2},
	legacy_wallmounted = true
})

minetest.register_node("blocks:rope", {
	description = ccore.comment("Climbing Rope", "Use with more rope to lower"),
	drawtype = "plantlike",
	tiles = {"blocks_rope.png"},
	inventory_image = "blocks_rope.png",
	wield_image = "blocks_rope.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	node_placement_prediction = "",
	groups = {snappy=1,cracky=2,oddly_breakable_by_hand=2},
	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.above
		local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}
		local pos_under = pointed_thing.under

		if minetest.get_node(pos_under).name == "blocks:rope" then
			while (minetest.get_node(pos_under).name  == "blocks:rope") do
				pos_under = {x = pos_under.x, y = pos_under.y - 1, z = pos_under.z}
			end
			if minetest.get_node(pos_under).name == "air" then
				minetest.item_place_node(itemstack, placer, {type = "node", under = {x = pos_under.x, y = pos_under.y + 1, z = pos_under.z}, above = pos_under})
				return itemstack
			end
		else
			if minetest.get_node(pos_above).name ~= "air" then
				minetest.item_place_node(itemstack, placer, pointed_thing)
				return itemstack
			else
				minetest.chat_send_player(placer:get_player_name(), "The climbing rope needs something to attach to!")
			end
		end
	end,
	after_dig_node = function(pos, node, metadata, digger)
		ccore.dig_dir(pos, {node.name}, 1, digger)
		ccore.dig_dir(pos, {node.name}, -1, digger)
	end,
})
--
-- == CRAFTS
--

minetest.register_craft({
	output = "blocks:ladder_wood 5",
	recipe = {
		{"group:stick", "", "group:stick"},
		{"group:stick", "group:stick", "group:stick"},
		{"group:stick", "", "group:stick"},
	}
})

minetest.register_craft({
	output = "blocks:ladder_steel 15",
	recipe = {
		{"blocks:steel_ingot", "", "blocks:steel_ingot"},
		{"blocks:steel_ingot", "blocks:steel_ingot", "blocks:steel_ingot"},
		{"blocks:steel_ingot", "", "blocks:steel_ingot"},
	}
})

minetest.register_craft({
	output = "blocks:chain 3",
	recipe = {
		{"blocks:steel_ingot"},
		{"blocks:steel_ingot"},
		{"blocks:steel_ingot"}
	}
})

minetest.register_craft({
	output = "blocks:rope 3",
	recipe = {
		{"group:stick"},
		{"group:stick"},
		{"group:stick"},
	}
})
-- Recycle
minetest.register_craft({
	type = "cooking",
	output = "blocks:steel_ingot",
	recipe = "blocks:chain"
})