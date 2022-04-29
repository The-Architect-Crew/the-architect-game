-- Rare items
-- [Player Warning] Spoilers ahead, don't read if you value surprises in your game

minetest.register_node("quests:null", {
	description = "description = \"/dev/null\",\ntiles = {\"quests_null.png\"}\nType: Self-propagating Glitch",
	inventory_image = "quests_rare.png",
	tiles = {"quests_null.png"},
	use_texture_alpha = "clip",
	groups = {oddly_breakable_by_hand = 1, cracky = 3}, -- not_in_creative_inventory = 1
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("quests:random", {
	description = "/dev/random\nType: Unresolvable Glitch",
	inventory_image = "quests_rare.png",
	tiles = {
		{
			name = "quests_random_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.0,
			}
		}
	},
	groups = {oddly_breakable_by_hand = 1, cracky = 3},  -- not_in_creative_inventory = 1
	sounds = default.node_sound_sand_defaults(),
})
minetest.register_node("quests:eye_spawner", {
	description = ("Eye See You\nType: Thoughtful Lovecraftian Horror"),
	inventory_image = "quests_rare.png",
	wield_image = "quests_rare.png",
	tiles = {"quests_rare.png"},
	drawtype = "airlike",
	groups = {},  -- not_in_creative_inventory = 1
	on_construct = function(pos)
		minetest.add_entity(pos, "quests:eye_floor")
		minetest.remove_node(pos)
	end
})

minetest.register_entity("quests:eye_floor", {
	initial_properties = {
		physical = false,
		selectionbox = {-1/16, -8/16, -1/16, 1/16, -4/16, 1/16},
		visual = "sprite",
		textures = {"quests_eye_floor.png"},
		visual_size = {x = 2, y = 2},
		use_texture_alpha = true,
		glow = 1,
	},
	on_punch = function(self)
		local pos = self.object:get_pos()
		minetest.add_item(pos, "quests:eye_spawner")
		self.object:remove()
	end
})

