local S = default.get_translator

-- Required wrapper to allow customization of default.after_place_leaves
local function after_place_leaves(...)
	return default.after_place_leaves(...)
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

--
-- register trees for leafdecay
--

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