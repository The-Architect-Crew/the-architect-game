minetest.register_craft({
	output = "furniture:gear",
	recipe = {
		{"", "blocks:steel_ingot", ""},
		{"blocks:steel_ingot", "blocks:steel_ingot", "blocks:steel_ingot"},
		{"", "blocks:steel_ingot", ""},
	}
})
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
for i=1,#furniture.craftstation_materials do
	local material = furniture.craftstation_materials[i]
	local secondary_material
	if (type(material) == "table") then
		material = furniture.craftstation_materials[i][1]
		secondary_material = furniture.craftstation_materials[i][2]
	else
		secondary_material = material
	end
    local sname = string.match(material, ':(.*)')
	minetest.register_craft({
		output = "furniture:assembler_" .. sname,
		recipe = {
			{"furniture:display", "furniture:arm", "furniture:case"},
			{"furniture:arm", "furniture:arm", "furniture:cpu"},
			{material, secondary_material, material},
		}
	})
	minetest.register_craft({
		output = "furniture:brickmaker_" .. sname,
		recipe = {
			{"furniture:arm", secondary_material, "furniture:power_supply"},
			{"furniture:arm_cutter", "furniture:arm_drill", "furniture:arm_cutter"},
			{material, "furniture:cable", material},
		}
	})
	minetest.register_craft({
		output = "furniture:engraver_" .. sname,
		recipe = {
			{"furniture:cable", "furniture:holder", secondary_material},
			{"furniture:holder", "furniture:laser", "furniture:holder"},
			{material, "furniture:arm_engraver", material},
		}
	})
	minetest.register_craft({
		output = "furniture:tablesaw_" .. sname,
		recipe = {
			{"furniture:cable", "furniture:case", "furniture:arm"},
			{"furniture:arm", "furniture:sawblade", "furniture:arm"},
			{material, secondary_material, material},
		}
	})
end