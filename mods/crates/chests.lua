crates:register_storage("crates:chest", {
	description = "Chest",
	columns = 6,
	sorting = true,
	lock_order = {"lock", "protect", "public", "mail"},
	groups = {choppy = 2, oddly_breakable_by_hand = 2},
	tiles = {
		"crates_chest_top.png",
		"crates_chest_top.png",
		"crates_chest_side.png",
		"crates_chest_side.png",
		"crates_chest_side.png",
		"crates_chest_front.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = "crates:chest",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
	}
})