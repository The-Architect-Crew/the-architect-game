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
-- == CRAFTS
--

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
