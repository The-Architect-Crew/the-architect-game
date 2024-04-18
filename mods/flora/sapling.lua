local S = default.get_translator

-- Required wrapper to allow customization of default.grow_sapling
local function grow_sapling(...)
	return flora.grow_sapling(...)
end

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