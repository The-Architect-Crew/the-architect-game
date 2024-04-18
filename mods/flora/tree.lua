local S = default.get_translator

-- Required wrapper to allow customization of default.after_place_leaves
local function after_place_leaves(...)
	return default.after_place_leaves(...)
end

-- Required wrapper to allow customization of default.grow_sapling
local function grow_sapling(...)
	return flora.grow_sapling(...)
end

minetest.register_node("flora:tree", {
	description = S("Apple Log"),
	tiles = {"flora_tree_top.png", "flora_tree_top.png", "flora_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})

minetest.register_node("flora:treebark", {
	description = S("Apple Tree Bark"),
	tiles = {"flora_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {bark = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})

minetest.register_node("flora:sapling", {
	description = S("Apple Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"flora_sapling.png"},
	inventory_image = "flora_sapling.png",
	wield_image = "flora_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300,1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = flora.sapling_on_place(itemstack, placer, pointed_thing,
			"flora:sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -3, y = 1, z = -3},
			{x = 3, y = 6, z = 3},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

minetest.register_node("flora:sapling_big", {
	description = S("Big Apple Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"flora_sapling_big.png"},
	inventory_image = "flora_sapling_big.png",
	wield_image = "flora_sapling_big.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = flora.sapling_on_place(itemstack, placer, pointed_thing,
			"flora:sapling_big",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -6, y = 2, z = -6},
			{x = 6, y = 24, z = 6},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

minetest.register_node("flora:leaves", {
	description = S("Apple Tree Leaves"),
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = {"flora_leaves.png"},
	special_tiles = {"flora_leaves_simple.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {"flora:sapling"},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {"flora:leaves"},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = after_place_leaves,
})

minetest.register_node("flora:apple", {
	description = S("Apple"),
	drawtype = "plantlike",
	tiles = {"flora_apple.png"},
	inventory_image = "flora_apple.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-3 / 16, -7 / 16, -3 / 16, 3 / 16, 4 / 16, 3 / 16}
	},
	groups = {fleshy = 3, dig_immediate = 3, flammable = 2,
		leafdecay = 3, leafdecay_drop = 1, food_apple = 1},
	on_use = minetest.item_eat(2),
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = function(pos, placer, itemstack)
		minetest.set_node(pos, {name = "flora:apple", param2 = 1})
	end,

	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		if oldnode.param2 == 0 then
			minetest.set_node(pos, {name = "flora:apple_mark"})
			minetest.get_node_timer(pos):start(math.random(300, 1500))
		end
	end,
})

minetest.register_node("flora:apple_mark", {
	description = S("Apple Marker"),
	inventory_image = "flora_apple.png^flora_invisible_node_overlay.png",
	wield_image = "flora_apple.png^default_invisible_node_overlay.png",
	drawtype = "airlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	groups = {not_in_creative_inventory = 1},
	on_timer = function(pos, elapsed)
		if not minetest.find_node_near(pos, 1, "flora:leaves") then
			minetest.remove_node(pos)
		elseif minetest.get_node_light(pos) < 11 then
			minetest.get_node_timer(pos):start(200)
		else
			minetest.set_node(pos, {name = "flora:apple"})
		end
	end
})


minetest.register_node("flora:tree_jungle", {
	description = S("Jungle Log"),
	tiles = {"flora_jungletree_top.png", "flora_jungletree_top.png",
		"flora_jungletree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})

minetest.register_node("flora:treebark_jungle", {
	description = S("Jungle Tree Bark"),
	tiles = {"flora_jungletree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {bark = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})

minetest.register_node("flora:leaves_jungle", {
	description = S("Jungle Tree Leaves"),
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = {"flora_jungleleaves.png"},
	special_tiles = {"flora_jungleleaves_simple.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"flora:junglesapling"}, rarity = 20},
			{items = {"flora:jungleleaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = after_place_leaves,
})

minetest.register_node("flora:sapling_jungle", {
	description = S("Jungle Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"flora_junglesapling.png"},
	inventory_image = "flora_junglesapling.png",
	wield_image = "flora_junglesapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = flora.sapling_on_place(itemstack, placer, pointed_thing,
			"flora:junglesapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 15, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

minetest.register_node("flora:sapling_emergent_jungle", {
	description = S("Emergent Jungle Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"flora_emergent_jungle_sapling.png"},
	inventory_image = "flora_emergent_jungle_sapling.png",
	wield_image = "flora_emergent_jungle_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = flora.sapling_on_place(itemstack, placer, pointed_thing,
			"flora:emergent_jungle_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			{x = -3, y = -5, z = -3},
			{x = 3, y = 31, z = 3},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})


minetest.register_node("flora:tree_pine", {
	description = S("Pine Log"),
	tiles = {"flora_pine_tree_top.png", "flora_pine_tree_top.png",
		"flora_pine_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})

minetest.register_node("flora:treebark_pine", {
	description = S("Pine Tree Bark"),
	tiles = {"flora_pine_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {bark = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})

minetest.register_node("flora:needles_pine",{
	description = S("Pine Needles"),
	drawtype = "allfaces_optional",
	tiles = {"flora_pine_needles.png"},
	waving = 1,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"flora:pine_sapling"}, rarity = 20},
			{items = {"flora:pine_needles"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = after_place_leaves,
})

minetest.register_node("flora:sapling_pine", {
	description = S("Pine Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"flora_pine_sapling.png"},
	inventory_image = "flora_pine_sapling.png",
	wield_image = "flora_pine_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 3,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = flora.sapling_on_place(itemstack, placer, pointed_thing,
			"flora:pine_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 14, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

minetest.register_node("flora:sapling_big_pine", {
	description = S("Big Pine Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"flora_pine_sapling_big.png"},
	inventory_image = "flora_pine_sapling_big.png",
	wield_image = "flora_pine_sapling_big.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = flora.sapling_on_place(itemstack, placer, pointed_thing,
			"flora:pine_sapling_big",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -6, y = 2, z = -6},
			{x = 6, y = 28, z = 6},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

minetest.register_node("flora:tree_acacia", {
	description = S("Acacia Log"),
	tiles = {"flora_acacia_tree_top.png", "flora_acacia_tree_top.png",
		"flora_acacia_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})

minetest.register_node("flora:treebark_acacia", {
	description = S("Acacia Tree Bark"),
	tiles = {"flora_acacia_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {bark = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})

minetest.register_node("flora:leaves_acacia", {
	description = S("Acacia Tree Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"flora_acacia_leaves.png"},
	special_tiles = {"flora_acacia_leaves_simple.png"},
	waving = 1,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"flora:acacia_sapling"}, rarity = 20},
			{items = {"flora:acacia_leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = after_place_leaves,
})

minetest.register_node("flora:sapling_acacia", {
	description = S("Acacia Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"flora_acacia_sapling.png"},
	inventory_image = "flora_acacia_sapling.png",
	wield_image = "flora_acacia_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = flora.sapling_on_place(itemstack, placer, pointed_thing,
			"flora:acacia_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -4, y = 1, z = -4},
			{x = 4, y = 7, z = 4},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

minetest.register_node("flora:sapling_big_acacia", {
	description = S("Big Acacia Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"flora_acacia_sapling_big.png"},
	inventory_image = "flora_acacia_sapling_big.png",
	wield_image = "flora_acacia_sapling_big.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = flora.sapling_on_place(itemstack, placer, pointed_thing,
			"flora:acacia_sapling_big",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -7, y = 2, z = -7},
			{x = 7, y = 24, z = 7},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})


minetest.register_node("flora:tree_aspen", {
	description = S("Aspen Log"),
	tiles = {"flora_aspen_tree_top.png", "flora_aspen_tree_top.png",
		"flora_aspen_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})

minetest.register_node("flora:treebark_aspen", {
	description = S("Aspen Tree Bark"),
	tiles = {"flora_aspen_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {bark = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})

minetest.register_node("flora:leaves_aspen", {
	description = S("Aspen Tree Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"flora_aspen_leaves.png"},
	waving = 1,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"flora:aspen_sapling"}, rarity = 20},
			{items = {"flora:aspen_leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = after_place_leaves,
})

minetest.register_node("flora:sapling_aspen", {
	description = S("Aspen Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"flora_aspen_sapling.png"},
	inventory_image = "flora_aspen_sapling.png",
	wield_image = "flora_aspen_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-3 / 16, -0.5, -3 / 16, 3 / 16, 0.5, 3 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 3,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = flora.sapling_on_place(itemstack, placer, pointed_thing,
			"flora:aspen_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 12, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

minetest.register_node("flora:sapling_big_aspen", {
	description = S("Big Aspen Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"flora_aspen_sapling_big.png"},
	inventory_image = "flora_aspen_sapling_big.png",
	wield_image = "flora_aspen_sapling_big.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = flora.sapling_on_place(itemstack, placer, pointed_thing,
			"flora:aspen_sapling_big",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -4, y = 2, z = -4},
			{x = 4, y = 24, z = 4},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

minetest.register_node("flora:tree_cherry", {
	description = S("Cherry Log"),
	tiles = {"flora_cherry_tree_top.png", "flora_cherry_tree_top.png", "flora_cherry_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})

minetest.register_node("flora:treebark_cherry", {
	description = S("Cherry Tree Bark"),
	tiles = {"flora_cherry_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {bark = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})

minetest.register_node("flora:sapling_cherry", {
	description = S("Cherry Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"flora_cherry_sapling.png"},
	inventory_image = "flora_cherry_sapling.png",
	wield_image = "flora_cherry_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = flora.sapling_on_place(itemstack, placer, pointed_thing,
			"flora:cherry_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -4, y = 1, z = -4},
			{x = 4, y = 11, z = 4},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

minetest.register_node("flora:sapling_big_cherry", {
	description = S("Big Cherry Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"flora_cherry_sapling_big.png"},
	inventory_image = "flora_cherry_sapling_big.png",
	wield_image = "flora_cherry_sapling_big.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = flora.sapling_on_place(itemstack, placer, pointed_thing,
			"flora:cherry_sapling_big",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -8, y = 1, z = -8},
			{x = 8, y = 25, z = 8},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

minetest.register_node("flora:leaves_cherry", {
	description = S("Cherry Tree Leaves"),
	drawtype = "allfaces",
	waving = 1,
	tiles = {"flora_cherry_leaves.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {"flora:cherry_sapling"},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {"flora:cherry_leaves"},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = after_place_leaves,
})

minetest.register_node("flora:leaves_dry", {
	description = S("Dry Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"flora_dry_leaves.png"},
	waving = 1,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = after_place_leaves,
})

minetest.register_node("flora:tree_bone", {
	description = S("Ossified Log"),
	tiles = {"flora_bone_tree_top.png", "flora_bone_tree_top.png", "flora_bone_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})

minetest.register_node("flora:treebark_bone", {
	description = S("Ossified Bark"),
	tiles = {"flora_bone_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {bark = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})

minetest.register_node("flora:sapling_bone", {
	description = S("Bone Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"flora_bone_sapling.png"},
	inventory_image = "flora_bone_sapling.png",
	wield_image = "flora_bone_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = flora.sapling_on_place(itemstack, placer, pointed_thing,
			"flora:bone_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -3, y = 1, z = -3},
			{x = 3, y = 18, z = 3},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

minetest.register_node("flora:sapling_big_bone", {
	description = S("Big Bone Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"flora_bone_sapling_big.png"},
	inventory_image = "flora_bone_sapling_big.png",
	wield_image = "flora_bone_sapling_big.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = flora.sapling_on_place(itemstack, placer, pointed_thing,
			"flora:bone_sapling_big",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -5, y = 1, z = -5},
			{x = 5, y = 26, z = 5},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

minetest.register_node("flora:leaves_crimson", {
	description = S("Crimson Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"flora_crimson_leaves.png"},
	waving = 1,
	paramtype = "light",
	is_ground_content = false,
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {"flora:bone_sapling"},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {"flora:crimson_leaves"},
			}
		}
	},
	groups = {snappy = 3, leafdecay = 3, leaves = 1},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = after_place_leaves,
})

-- Bonsai Trees

minetest.register_node("flora:bonsai_jungle", {
	description = ccore.comment("Bonsai Jungle Tree", "Doesn't grow"),
	drawtype = "plantlike",
	tiles = {"flora_junglesapling.png"},
	inventory_image = "flora_junglesapling.png",
	wield_image = "flora_junglesapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:bonsai_big_jungle", {
	description = ccore.comment("Bonsai Big Jungle Tree", "Doesn't grow"),
	drawtype = "plantlike",
	tiles = {"flora_emergent_jungle_sapling.png"},
	inventory_image = "flora_emergent_jungle_sapling.png",
	wield_image = "flora_emergent_jungle_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:bonsai", {
	description = ccore.comment("Bonsai Apple Tree", "Doesn't grow"),
	drawtype = "plantlike",
	tiles = {"flora_sapling.png"},
	inventory_image = "flora_sapling.png",
	wield_image = "flora_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:bonsai_big", {
	description = ccore.comment("Bonsai Big Apple Tree", "Doesn't grow"),
	drawtype = "plantlike",
	tiles = {"flora_sapling_big.png"},
	inventory_image = "flora_sapling_big.png",
	wield_image = "flora_sapling_big.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:bonsai_pine", {
	description = ccore.comment("Bonsai Pine Tree", "Doesn't grow"),
	drawtype = "plantlike",
	tiles = {"flora_pine_sapling.png"},
	inventory_image = "flora_pine_sapling.png",
	wield_image = "flora_pine_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:bonsai_big_pine", {
	description = ccore.comment("Bonsai Big Pine Tree", "Doesn't grow"),
	drawtype = "plantlike",
	tiles = {"flora_pine_sapling_big.png"},
	inventory_image = "flora_pine_sapling_big.png",
	wield_image = "flora_pine_sapling_big.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:bonsai_acacia", {
	description = ccore.comment("Bonsai Acacia Tree", "Doesn't grow"),
	drawtype = "plantlike",
	tiles = {"flora_acacia_sapling.png"},
	inventory_image = "flora_acacia_sapling.png",
	wield_image = "flora_acacia_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:bonsai_big_acacia", {
	description = ccore.comment("Bonsai Big Acacia Tree", "Doesn't grow"),
	drawtype = "plantlike",
	tiles = {"flora_acacia_sapling_big.png"},
	inventory_image = "flora_acacia_sapling_big.png",
	wield_image = "flora_acacia_sapling_big.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:bonsai_aspen", {
	description = ccore.comment("Bonsai Aspen Tree", "Doesn't grow"),
	drawtype = "plantlike",
	tiles = {"flora_aspen_sapling.png"},
	inventory_image = "flora_aspen_sapling.png",
	wield_image = "flora_aspen_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:bonsai_big_aspen", {
	description = ccore.comment("Bonsai Big Aspen Tree", "Doesn't grow"),
	drawtype = "plantlike",
	tiles = {"flora_aspen_sapling_big.png"},
	inventory_image = "flora_aspen_sapling_big.png",
	wield_image = "flora_aspen_sapling_big.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:bonsai_cherry", {
	description = ccore.comment("Bonsai Cherry Tree", "Doesn't grow"),
	drawtype = "plantlike",
	tiles = {"flora_cherry_sapling.png"},
	inventory_image = "flora_cherry_sapling.png",
	wield_image = "flora_cherry_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:bonsai_big_cherry", {
	description = ccore.comment("Bonsai Big Cherry Tree", "Doesn't grow"),
	drawtype = "plantlike",
	tiles = {"flora_cherry_sapling_big.png"},
	inventory_image = "flora_cherry_sapling_big.png",
	wield_image = "flora_cherry_sapling_big.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:bonsai_bone", {
	description = ccore.comment("Bonsai Bone Tree", "Doesn't grow"),
	drawtype = "plantlike",
	tiles = {"flora_bone_sapling.png"},
	inventory_image = "flora_bone_sapling.png",
	wield_image = "flora_bone_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:bonsai_big_bone", {
	description = ccore.comment("Bonsai Big Bone Tree", "Doesn't grow"),
	drawtype = "plantlike",
	tiles = {"flora_bone_sapling_big.png"},
	inventory_image = "flora_bone_sapling_big.png",
	wield_image = "flora_bone_sapling_big.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),
})

-- Shrubbery

minetest.register_node("flora:shrubbery", {
	description = "Apple Tree Shrubbery",
	drawtype = "mesh",
	mesh = "shrubbery.obj",
	tiles = {"flora_tree.png", "flora_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_big", {
	description = "Big Apple Tree Shrubbery Base",
	drawtype = "mesh",
	mesh = "shrubbery_big.obj",
	tiles = {"flora_tree.png", "flora_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_top", {
	description = "Big Apple Tree Shrubbery",
	drawtype = "allfaces",
	tiles = {"flora_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_tall", {
	description = "Tall Apple Tree Shrubbery",
	drawtype = "mesh",
	mesh = "shrubbery_tall.obj",
	tiles = {"flora_tree.png", "flora_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	collision_box = {
		type = "fixed",
		fixed = {
			{-8/16, -8/16, -8/16, 8/16, 24/16, 8/16},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-8/16, -8/16, -8/16, 8/16, 24/16, 8/16},
		}
	},
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_acacia", {
	description = "Acacia Tree Shrubbery",
	drawtype = "mesh",
	mesh = "shrubbery.obj",
	tiles = {"flora_acacia_tree.png", "flora_acacia_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_big_acacia", {
	description = "Big Acacia Tree Shrubbery Base",
	drawtype = "mesh",
	mesh = "shrubbery_big.obj",
	tiles = {"flora_acacia_tree.png", "flora_acacia_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_top_acacia", {
	description = "Big Acacia Tree Shrubbery",
	drawtype = "allfaces",
	tiles = {"flora_acacia_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_tall_acacia", {
	description = "Tall Acacia Tree Shrubbery",
	drawtype = "mesh",
	mesh = "shrubbery_tall.obj",
	tiles = {"flora_acacia_tree.png", "flora_acacia_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	collision_box = {
		type = "fixed",
		fixed = {
			{-8/16, -8/16, -8/16, 8/16, 24/16, 8/16},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-8/16, -8/16, -8/16, 8/16, 24/16, 8/16},
		}
	},
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_aspen", {
	description = "Aspen Tree Shrubbery",
	drawtype = "mesh",
	mesh = "shrubbery.obj",
	tiles = {"flora_aspen_tree.png", "flora_aspen_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_big_aspen", {
	description = "Big Aspen Tree Shrubbery Base",
	drawtype = "mesh",
	mesh = "shrubbery_big.obj",
	tiles = {"flora_aspen_tree.png", "flora_aspen_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_top_aspen", {
	description = "Big Aspen Tree Shrubbery",
	drawtype = "allfaces",
	tiles = {"flora_aspen_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_tall_aspen", {
	description = "Tall Aspen Tree Shrubbery",
	drawtype = "mesh",
	mesh = "shrubbery_tall.obj",
	tiles = {"flora_aspen_tree.png", "flora_aspen_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	collision_box = {
		type = "fixed",
		fixed = {
			{-8/16, -8/16, -8/16, 8/16, 24/16, 8/16},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-8/16, -8/16, -8/16, 8/16, 24/16, 8/16},
		}
	},
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_bone", {
	description = "Bone Tree Shrubbery",
	drawtype = "mesh",
	mesh = "shrubbery.obj",
	tiles = {"flora_bone_tree.png", "flora_crimson_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_big_bone", {
	description = "Big Bone Tree Shrubbery Base",
	drawtype = "mesh",
	mesh = "shrubbery_big.obj",
	tiles = {"flora_bone_tree.png", "flora_crimson_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_top_bone", {
	description = "Big Bone Tree Shrubbery",
	drawtype = "allfaces",
	tiles = {"flora_crimson_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_tall_bone", {
	description = "Tall Bone Tree Shrubbery",
	drawtype = "mesh",
	mesh = "shrubbery_tall.obj",
	tiles = {"flora_bone_tree.png", "flora_crimson_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	collision_box = {
		type = "fixed",
		fixed = {
			{-8/16, -8/16, -8/16, 8/16, 24/16, 8/16},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-8/16, -8/16, -8/16, 8/16, 24/16, 8/16},
		}
	},
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_cherry", {
	description = "Cherry Tree Shrubbery",
	drawtype = "mesh",
	mesh = "shrubbery.obj",
	tiles = {"flora_cherry_tree.png", "flora_cherry_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_big_cherry", {
	description = "Big Cherry Tree Shrubbery Base",
	drawtype = "mesh",
	mesh = "shrubbery_big.obj",
	tiles = {"flora_cherry_tree.png", "flora_cherry_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_top_cherry", {
	description = "Big Cherry Tree Shrubbery",
	drawtype = "allfaces",
	tiles = {"flora_cherry_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_tall_cherry", {
	description = "Tall Cherry Tree Shrubbery",
	drawtype = "mesh",
	mesh = "shrubbery_tall.obj",
	tiles = {"flora_cherry_tree.png", "flora_cherry_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	collision_box = {
		type = "fixed",
		fixed = {
			{-8/16, -8/16, -8/16, 8/16, 24/16, 8/16},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-8/16, -8/16, -8/16, 8/16, 24/16, 8/16},
		}
	},
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_dry", {
	description = "Dry Shrubbery",
	drawtype = "mesh",
	mesh = "shrubbery.obj",
	tiles = {"flora_tree.png", "flora_dry_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_big_dry", {
	description = "Dry Big Shrubbery Base",
	drawtype = "mesh",
	mesh = "shrubbery_big.obj",
	tiles = {"flora_tree.png", "flora_dry_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_top_dry", {
	description = "Dry Big Shrubbery",
	drawtype = "allfaces",
	tiles = {"flora_dry_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})


minetest.register_node("flora:shrubbery_tall_dry", {
	description = "Dry Tall Shrubbery",
	drawtype = "mesh",
	mesh = "shrubbery_tall.obj",
	tiles = {"flora_tree.png", "flora_dry_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	collision_box = {
		type = "fixed",
		fixed = {
			{-8/16, -8/16, -8/16, 8/16, 24/16, 8/16},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-8/16, -8/16, -8/16, 8/16, 24/16, 8/16},
		}
	},
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_jungle", {
	description = "Jungle Tree Shrubbery",
	drawtype = "mesh",
	mesh = "shrubbery.obj",
	tiles = {"flora_jungletree.png", "flora_jungle_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_big_jungle", {
	description = "Big Jungle Tree Shrubbery Base",
	drawtype = "mesh",
	mesh = "shrubbery_big.obj",
	tiles = {"flora_jungletree.png", "flora_jungle_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_top_jungle", {
	description = "Big Jungle Tree Shrubbery",
	drawtype = "allfaces",
	tiles = {"flora_jungle_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})


minetest.register_node("flora:shrubbery_tall_jungle", {
	description = "Tall Jungle Tree Shrubbery",
	drawtype = "mesh",
	mesh = "shrubbery_tall.obj",
	tiles = {"flora_jungletree.png", "flora_jungle_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	collision_box = {
		type = "fixed",
		fixed = {
			{-8/16, -8/16, -8/16, 8/16, 24/16, 8/16},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-8/16, -8/16, -8/16, 8/16, 24/16, 8/16},
		}
	},
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_pine", {
	description = "Pine Tree Shrubbery",
	drawtype = "mesh",
	mesh = "shrubbery.obj",
	tiles = {"flora_pine_tree.png", "flora_pine_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_big_pine", {
	description = "Big Pine Tree Shrubbery Base",
	drawtype = "mesh",
	mesh = "shrubbery_big.obj",
	tiles = {"flora_pine_tree.png", "flora_pine_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_top_pine", {
	description = "Big Pine Tree Shrubbery",
	drawtype = "allfaces",
	tiles = {"flora_pine_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flora:shrubbery_tall_pine", {
	description = "Tall Pine Tree Shrubbery",
	drawtype = "mesh",
	mesh = "shrubbery_tall.obj",
	tiles = {"flora_pine_tree.png", "flora_pine_shrubbery.png"},
	paramtype = "light",
	use_texture_alpha = "clip",
	sunlight_propagates = true,
	collision_box = {
		type = "fixed",
		fixed = {
			{-8/16, -8/16, -8/16, 8/16, 24/16, 8/16},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-8/16, -8/16, -8/16, 8/16, 24/16, 8/16},
		}
	},
	groups = {snappy = 2, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
})

--
-- register trees for leafdecay
--

if minetest.get_mapgen_setting("mg_name") == "v6" then
	default.register_leafdecay({
		trunks = {"flora:tree"},
		leaves = {"flora:apple", "flora:leaves"},
		radius = 2,
	})

	default.register_leafdecay({
		trunks = {"flora:tree_jungle"},
		leaves = {"flora:leaves_jungle"},
		radius = 3,
	})
else
	default.register_leafdecay({
		trunks = {"flora:tree"},
		leaves = {"flora:apple", "flora:leaves"},
		radius = 3,
	})

	default.register_leafdecay({
		trunks = {"flora:tree_jungle"},
		leaves = {"flora:leaves_jungle"},
		radius = 2,
	})
end

default.register_leafdecay({
	trunks = {"flora:tree_pine"},
	leaves = {"flora:needles_pine"},
	radius = 3,
})

default.register_leafdecay({
	trunks = {"flora:tree_acacia"},
	leaves = {"flora:leaves_acacia"},
	radius = 2,
})

default.register_leafdecay({
	trunks = {"flora:tree_aspen"},
	leaves = {"flora:leaves_aspen"},
	radius = 3,
})

default.register_leafdecay({
	trunks = {"flora:tree_cherry"},
	leaves = {"flora:leaves_cherry"},
	radius = 3,
})

default.register_leafdecay({
	trunks = {"flora:tree_bone"},
	leaves = {"flora:leaves_crimson"},
	radius = 2,
})

--
-- == CRAFTS
--

minetest.register_craft({
	output = "flora:sapling_emergent_jungle",
	recipe = {
		{"flora:sapling_jungle", "flora:sapling_jungle", "flora:sapling_jungle"},
		{"flora:sapling_jungle", "flora:sapling_jungle", "flora:sapling_jungle"},
		{"flora:sapling_jungle", "flora:sapling_jungle", "flora:sapling_jungle"},
	}
})

minetest.register_craft({
	output = "flora:bonsai_big_jungle",
	recipe = {
		{"flora:sapling_emergent_jungle"},
	}
})

minetest.register_craft({
	output = "flora:sapling_emergent_jungle",
	recipe = {
		{"flora:bonsai_big_jungle"},
	}
})

minetest.register_craft({
	output = "flora:bonsai_jungle",
	recipe = {
		{"flora:sapling_jungle"},
	}
})

minetest.register_craft({
	output = "flora:sapling_jungle",
	recipe = {
		{"flora:bonsai_jungle"},
	}
})

minetest.register_craft({
	output = "flora:sapling_big",
	recipe = {
		{"flora:sapling", "flora:sapling", "flora:sapling"},
		{"flora:sapling", "flora:sapling", "flora:sapling"},
		{"flora:sapling", "flora:sapling", "flora:sapling"},
	}
})

minetest.register_craft({
	output = "flora:bonsai_big",
	recipe = {
		{"flora:sapling_big"},
	}
})

minetest.register_craft({
	output = "flora:sapling_big",
	recipe = {
		{"flora:bonsai_big"},
	}
})

minetest.register_craft({
	output = "flora:bonsai",
	recipe = {
		{"flora:sapling"},
	}
})

minetest.register_craft({
	output = "flora:sapling",
	recipe = {
		{"flora:bonsai"},
	}
})

minetest.register_craft({
	output = "flora:sapling_big_pine",
	recipe = {
		{"flora:sapling_pine", "flora:sapling_pine", "flora:sapling_pine"},
		{"flora:sapling_pine", "flora:sapling_pine", "flora:sapling_pine"},
		{"flora:sapling_pine", "flora:sapling_pine", "flora:sapling_pine"},
	}
})

minetest.register_craft({
	output = "flora:bonsai_big_pine",
	recipe = {
		{"flora:sapling_big_pine"},
	}
})

minetest.register_craft({
	output = "flora:sapling_big_pine",
	recipe = {
		{"flora:bonsai_big_pine"},
	}
})

minetest.register_craft({
	output = "flora:bonsai_pine",
	recipe = {
		{"flora:sapling_pine"},
	}
})

minetest.register_craft({
	output = "flora:sapling_pine",
	recipe = {
		{"flora:bonsai_pine"},
	}
})

minetest.register_craft({
	output = "flora:sapling_big_acacia",
	recipe = {
		{"flora:sapling_acacia", "flora:sapling_acacia", "flora:sapling_acacia"},
		{"flora:sapling_acacia", "flora:sapling_acacia", "flora:sapling_acacia"},
		{"flora:sapling_acacia", "flora:sapling_acacia", "flora:sapling_acacia"},
	}
})

minetest.register_craft({
	output = "flora:bonsai_big_acacia",
	recipe = {
		{"flora:sapling_big_acacia"},
	}
})

minetest.register_craft({
	output = "flora:sapling_big_acacia",
	recipe = {
		{"flora:bonsai_big_acacia"},
	}
})

minetest.register_craft({
	output = "flora:bonsai_acacia",
	recipe = {
		{"flora:sapling_acacia"},
	}
})

minetest.register_craft({
	output = "flora:sapling_acacia",
	recipe = {
		{"flora:bonsai_acacia"},
	}
})

minetest.register_craft({
	output = "flora:sapling_big_aspen",
	recipe = {
		{"flora:sapling_aspen", "flora:sapling_aspen", "flora:sapling_aspen"},
		{"flora:sapling_aspen", "flora:sapling_aspen", "flora:sapling_aspen"},
		{"flora:sapling_aspen", "flora:sapling_aspen", "flora:sapling_aspen"},
	}
})

minetest.register_craft({
	output = "flora:bonsai_big_aspen",
	recipe = {
		{"flora:sapling_big_aspen"},
	}
})

minetest.register_craft({
	output = "flora:sapling_big_aspen",
	recipe = {
		{"flora:bonsai_big_aspen"},
	}
})

minetest.register_craft({
	output = "flora:bonsai_aspen",
	recipe = {
		{"flora:sapling_aspen"},
	}
})

minetest.register_craft({
	output = "flora:sapling_aspen",
	recipe = {
		{"flora:bonsai_aspen"},
	}
})

minetest.register_craft({
	output = "flora:sapling_big_cherry",
	recipe = {
		{"flora:sapling_cherry", "flora:sapling_cherry", "flora:sapling_cherry"},
		{"flora:sapling_cherry", "flora:sapling_cherry", "flora:sapling_cherry"},
		{"flora:sapling_cherry", "flora:sapling_cherry", "flora:sapling_cherry"},
	}
})

minetest.register_craft({
	output = "flora:bonsai_big_cherry",
	recipe = {
		{"flora:sapling_big_cherry"},
	}
})

minetest.register_craft({
	output = "flora:sapling_big_cherry",
	recipe = {
		{"flora:bonsai_big_cherry"},
	}
})

minetest.register_craft({
	output = "flora:bonsai_cherry",
	recipe = {
		{"flora:sapling_cherry"},
	}
})

minetest.register_craft({
	output = "flora:sapling_cherry",
	recipe = {
		{"flora:bonsai_cherry"},
	}
})

minetest.register_craft({
	output = "flora:sapling_big_bone",
	recipe = {
		{"flora:sapling_bone", "flora:sapling_bone", "flora:sapling_bone"},
		{"flora:sapling_bone", "flora:sapling_bone", "flora:sapling_bone"},
		{"flora:sapling_bone", "flora:sapling_bone", "flora:sapling_bone"},
	}
})

minetest.register_craft({
	output = "flora:bonsai_big_bone",
	recipe = {
		{"flora:sapling_big_bone"},
	}
})

minetest.register_craft({
	output = "flora:sapling_big_bone",
	recipe = {
		{"flora:bonsai_big_bone"},
	}
})

minetest.register_craft({
	output = "flora:bonsai_bone",
	recipe = {
		{"flora:sapling_bone"},
	}
})

minetest.register_craft({
	output = "flora:sapling_bone",
	recipe = {
		{"flora:bonsai_bone"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery",
	recipe = {
		{"flora:leaves", "flora:leaves"},
		{"flora:leaves", "flora:leaves"},
		{"blocks:stick", "blocks:stick"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_big",
	recipe = {
		{"flora:leaves", "flora:leaves", "flora:leaves"},
		{"flora:leaves", "flora:leaves", "flora:leaves"},
		{"blocks:stick", "blocks:stick", "blocks:stick"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_top",
	recipe = {
		{"flora:leaves", "flora:leaves", "flora:leaves"},
		{"flora:leaves", "flora:leaves", "flora:leaves"},
		{"flora:leaves", "flora:leaves", "flora:leaves"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_tall",
	recipe = {
		{"flora:shrubbery"},
		{"flora:shrubbery"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_acacia",
	recipe = {
		{"flora:leaves_acacia", "flora:leaves_acacia"},
		{"flora:leaves_acacia", "flora:leaves_acacia"},
		{"blocks:stick", "blocks:stick"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_big_acacia",
	recipe = {
		{"flora:leaves_acacia", "flora:leaves_acacia", "flora:leaves_acacia"},
		{"flora:leaves_acacia", "flora:leaves_acacia", "flora:leaves_acacia"},
		{"blocks:stick", "blocks:stick", "blocks:stick"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_top_acacia",
	recipe = {
		{"flora:leaves_acacia", "flora:leaves_acacia", "flora:leaves_acacia"},
		{"flora:leaves_acacia", "flora:leaves_acacia", "flora:leaves_acacia"},
		{"flora:leaves_acacia", "flora:leaves_acacia", "flora:leaves_acacia"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_tall_acacia",
	recipe = {
		{"flora:shrubbery_acacia"},
		{"flora:shrubbery_acacia"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_aspen",
	recipe = {
		{"flora:leaves_aspen", "flora:leaves_aspen"},
		{"flora:leaves_aspen", "flora:leaves_aspen"},
		{"blocks:stick", "blocks:stick"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_big_aspen",
	recipe = {
		{"flora:leaves_aspen", "flora:leaves_aspen", "flora:leaves_aspen"},
		{"flora:leaves_aspen", "flora:leaves_aspen", "flora:leaves_aspen"},
		{"blocks:stick", "blocks:stick", "blocks:stick"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_top_aspen",
	recipe = {
		{"flora:leaves_aspen", "flora:leaves_aspen", "flora:leaves_aspen"},
		{"flora:leaves_aspen", "flora:leaves_aspen", "flora:leaves_aspen"},
		{"flora:leaves_aspen", "flora:leaves_aspen", "flora:leaves_aspen"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_tall_aspen",
	recipe = {
		{"flora:shrubbery_aspen"},
		{"flora:shrubbery_aspen"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_bone",
	recipe = {
		{"flora:leaves_crimson", "flora:leaves_crimson"},
		{"flora:leaves_crimson", "flora:leaves_crimson"},
		{"blocks:bone", "blocks:bone"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_big_bone",
	recipe = {
		{"flora:leaves_crimson", "flora:leaves_crimson", "flora:leaves_crimson"},
		{"flora:leaves_crimson", "flora:leaves_crimson", "flora:leaves_crimson"},
		{"blocks:bone", "blocks:bone", "blocks:bone"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_top_bone",
	recipe = {
		{"flora:leaves_crimson", "flora:leaves_crimson", "flora:leaves_crimson"},
		{"flora:leaves_crimson", "flora:leaves_crimson", "flora:leaves_crimson"},
		{"flora:leaves_crimson", "flora:leaves_crimson", "flora:leaves_crimson"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_tall_bone",
	recipe = {
		{"flora:shrubbery_bone"},
		{"flora:shrubbery_bone"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_cherry",
	recipe = {
		{"flora:leaves_cherry", "flora:leaves_cherry"},
		{"flora:leaves_cherry", "flora:leaves_cherry"},
		{"blocks:stick", "blocks:stick"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_big_cherry",
	recipe = {
		{"flora:leaves_cherry", "flora:leaves_cherry", "flora:leaves_cherry"},
		{"flora:leaves_cherry", "flora:leaves_cherry", "flora:leaves_cherry"},
		{"blocks:stick", "blocks:stick", "blocks:stick"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_top_cherry",
	recipe = {
		{"flora:leaves_cherry", "flora:leaves_cherry", "flora:leaves_cherry"},
		{"flora:leaves_cherry", "flora:leaves_cherry", "flora:leaves_cherry"},
		{"flora:leaves_cherry", "flora:leaves_cherry", "flora:leaves_cherry"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_tall_cherry",
	recipe = {
		{"flora:shrubbery_cherry"},
		{"flora:shrubbery_cherry"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_dry",
	recipe = {
		{"flora:leaves_dry", "flora:leaves_dry"},
		{"flora:leaves_dry", "flora:leaves_dry"},
		{"flora:dry_shrub", "flora:dry_shrub"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_big_dry",
	recipe = {
		{"flora:leaves_dry", "flora:leaves_dry", "flora:leaves_dry"},
		{"flora:leaves_dry", "flora:leaves_dry", "flora:leaves_dry"},
		{"flora:dry_shrub", "flora:dry_shrub", "flora:dry_shrub"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_top_dry",
	recipe = {
		{"flora:leaves_dry", "flora:leaves_dry", "flora:leaves_dry"},
		{"flora:leaves_dry", "flora:leaves_dry", "flora:leaves_dry"},
		{"flora:leaves_dry", "flora:leaves_dry", "flora:leaves_dry"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_tall_dry",
	recipe = {
		{"flora:shrubbery_dry"},
		{"flora:shrubbery_dry"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_jungle",
	recipe = {
		{"flora:leaves_jungle", "flora:leaves_jungle"},
		{"flora:leaves_jungle", "flora:leaves_jungle"},
		{"blocks:stick", "blocks:stick"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_big_jungle",
	recipe = {
		{"flora:leaves_jungle", "flora:leaves_jungle", "flora:leaves_jungle"},
		{"flora:leaves_jungle", "flora:leaves_jungle", "flora:leaves_jungle"},
		{"blocks:stick", "blocks:stick", "blocks:stick"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_top_jungle",
	recipe = {
		{"flora:leaves_jungle", "flora:leaves_jungle", "flora:leaves_jungle"},
		{"flora:leaves_jungle", "flora:leaves_jungle", "flora:leaves_jungle"},
		{"flora:leaves_jungle", "flora:leaves_jungle", "flora:leaves_jungle"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_tall_jungle",
	recipe = {
		{"flora:shrubbery_jungle"},
		{"flora:shrubbery_jungle"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_pine",
	recipe = {
		{"flora:needles_pine", "flora:needles_pine"},
		{"flora:needles_pine", "flora:needles_pine"},
		{"blocks:stick", "blocks:stick"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_big_pine",
	recipe = {
		{"flora:needles_pine", "flora:needles_pine", "flora:needles_pine"},
		{"flora:needles_pine", "flora:needles_pine", "flora:needles_pine"},
		{"blocks:stick", "blocks:stick", "blocks:stick"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_top_pine",
	recipe = {
		{"flora:needles_pine", "flora:needles_pine", "flora:needles_pine"},
		{"flora:needles_pine", "flora:needles_pine", "flora:needles_pine"},
		{"flora:needles_pine", "flora:needles_pine", "flora:needles_pine"},
	}
})

minetest.register_craft({
	output = "flora:shrubbery_tall_pine",
	recipe = {
		{"flora:shrubbery_pine"},
		{"flora:shrubbery_pine"},
	}
})




local bark_craft_list = {
    {"tree", "treebark"},
    {"tree_jungle", "treebark_jungle"},
    {"tree_pine", "treebark_pine"},
    {"tree_acacia", "treebark_acacia"},
    {"tree_aspen", "treebark_aspen"},
    {"tree_cherry", "treebark_cherry"},
    {"tree_bone", "tree_bone"}
}

for _, rows in ipairs(bark_craft_list) do
	minetest.register_craft({
		output = "flora:"..rows[1].." 4",
		recipe = {
			{"flora:"..rows[2]},
		}
	})

	minetest.register_craft({
		output = "flora:"..rows[2],
		recipe = {
			{"flora:"..rows[1], "flora:"..rows[1]},
			{"flora:"..rows[1], "flora:"..rows[1]},
		}
	})
end

minetest.register_craft({
	type = "cooking",
	output = "flora:leaves_dry",
	recipe = "group:leaves",
})