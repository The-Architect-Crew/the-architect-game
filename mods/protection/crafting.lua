minetest.register_craft({
	output = "protection:lost_mese_core",
	recipe = {
		{"", "", "blocks:steel_ingot"},
		{"", "blocks:lost_mese", ""},
		{"blocks:steel_ingot", "", ""},
	}
})
minetest.register_craft({
	output = "protection:lost_mese_flare",
	recipe = {
		{"", "", ""},
		{"", "blocks:lost_mese_crystal", ""},
		{"blocks:steel_ingot", "", "blocks:steel_ingot"},
	}
})
minetest.register_craft({
	output = "protection:map_display",
	recipe = {
		{"blocks:steel_ingot", "blocks:mese_fiber", "blocks:steel_ingot"},
		{"blocks:glass", "protection:lost_mese_core", "blocks:glass"},
		{"blocks:steel_ingot", "blocks:mese_fiber", "blocks:steel_ingot"},
	}
})
minetest.register_craft({
	output = "protection:protector",
	recipe = {
		{"furniture:arm", "", "furniture:case"},
		{"", "protection:map_display", "blocks:wood"},
		{"blocks:wood", "blocks:wood", "blocks:wood"},
	}
})
minetest.register_craft({
	output = "protection:area_manager",
	recipe = {
		{"", "", ""},
		{"blocks:steelblock", "protection:map_display", "blocks:steelblock"},
		{"blocks:wood", "furniture:case", "blocks:wood"},
	}
})
minetest.register_craft({
	output = "protection:marker",
	recipe = {
		{"", "protection:lost_mese_flare", ""},
		{"", "protection:lost_mese_flare", ""},
		{"", "blocks:steel_ingot", ""},
	}
})