minetest.register_craft({
	output = "furniture:arm",
	recipe = {
		{"furniture:gear", "blocks:steel_ingot", "furniture:gear"},
		{"blocks:steel_ingot", "", "blocks:steel_ingot"},
		{"", "", "blocks:steel_ingot"},
	}
})
minetest.register_craft({
	output = "furniture:arm_cutter",
	recipe = {
		{"", "blocks:steel_ingot", ""},
		{"", "blocks:diamond", "furniture:arm"},
		{"", "blocks:steel_ingot", ""},
	}
})
minetest.register_craft({
	output = "furniture:arm_drill",
	recipe = {
		{"", "", "furniture:gear"},
		{"blocks:diamond", "blocks:diamond", "furniture:arm"},
		{"", "blocks:steel_ingot", "blocks:steel_ingot"},
	}
})
minetest.register_craft({
	output = "furniture:arm_engraver",
	recipe = {
		{"blocks:steel_ingot", "blocks:steel_ingot", "blocks:steel_ingot"},
		{"furniture:arm", "", "furniture:arm"},
		{"furniture:gear", "", "furniture:gear"},
	}
})
minetest.register_craft({
	output = "furniture:arm_holder",
	recipe = {
		{"blocks:mese_crystal_fragment", "", ""},
		{"blocks:mese_crystal_fragment", "blocks:steel_ingot", "furniture:arm"},
		{"blocks:mese_crystal_fragment", "furniture:gear", ""},
	}
})
minetest.register_craft({
	output = "furniture:case",
	recipe = {
		{"blocks:steelblock", "blocks:glass", ""},
		{"blocks:steelblock", "blocks:steel_ingot", ""},
		{"blocks:steelblock", "blocks:steel_ingot", ""},
	}
})
minetest.register_craft({
	output = "furniture:laser",
	recipe = {
		{"", "furniture:cpu", ""},
		{"blocks:steel_ingot", "blocks:mese_crystal", "blocks:steel_ingot"},
		{"", "blocks:glass", ""},
	}
})
minetest.register_craft({
	output = "furniture:power_supply",
	recipe = {
		{"blocks:steel_ingot", "blocks:diamond", ""},
		{"blocks:steel_ingot", "blocks:diamond", "furniture:cable"},
		{"blocks:steel_ingot", "furniture:cpu", "furniture:cable"},
	}
})
minetest.register_craft({
	output = "furniture:sawblade",
	recipe = {
		{"", "blocks:steel_ingot", ""},
		{"blocks:steel_ingot", "blocks:steelblock", "blocks:steel_ingot"},
		{"", "blocks:steel_ingot", ""},
	}
})
minetest.register_craft({
	output = "furniture:cable",
	recipe = {
		{"", "", ""},
		{"blocks:copper_ingot", "blocks:copper_ingot", "blocks:copper_ingot"},
		{"", "", ""},
	}
})
minetest.register_craft({
	output = "furniture:display_panel",
	recipe = {
		{"blocks:glass", "blocks:glass", "blocks:glass"},
		{"furniture:cable", "blocks:mese_tech_crystal", "furniture:cable"},
		{"blocks:mese_fiber", "blocks:mese_crystal", "blocks:mese_fiber"},
	}
})
minetest.register_craft({
	output = "furniture:cpu",
	recipe = {
		{"", "blocks:mese_fiber", ""},
		{"blocks:mese_fiber", "blocks:mese_crystal", "blocks:mese_fiber"},
		{"blocks:mese_fiber", "blocks:mese_tech_crystal", "blocks:mese_fiber"},
	}
})
minetest.register_craft({
	output = "furniture:display",
	recipe = {
		{"blocks:steel_ingot", "", "blocks:steel_ingot"},
		{"furniture:display_panel", "furniture:display_panel", "furniture:display_panel"},
		{"blocks:steel_ingot", "blocks:glass", "blocks:steel_ingot"},
	}
})
-- Craftstations
minetest.register_craft({
	output = "furniture:assembler",
	recipe = {
		{"furniture:display", "furniture:arm", "furniture:case"},
		{"furniture:arm", "furniture:arm", "furniture:cpu"},
		{"blocks:wood", "blocks:wood", "blocks:wood"},
	}
})
minetest.register_craft({
	output = "furniture:cutter",
	recipe = {
		{"furniture:arm", "blocks:wood", "furniture:power_supply"},
		{"furniture:arm_cutter", "furniture:arm_drill", "furniture:arm_cutter"},
		{"blocks:wood", "furniture:cable", "blocks:wood"},
	}
})
minetest.register_craft({
	output = "furniture:engraver",
	recipe = {
		{"furniture:cable", "furniture:holder", "blocks:wood"},
		{"furniture:holder", "furniture:laser", "furniture:holder"},
		{"blocks:wood", "furniture:arm_engraver", "blocks:wood"},
	}
})
minetest.register_craft({
	output = "furniture:tablesaw",
	recipe = {
		{"furniture:cable", "furniture:case", "furniture:arm"},
		{"furniture:arm", "furniture:sawblade", "furniture:arm"},
		{"blocks:wood", "blocks:wood", "blocks:wood"},
	}
})