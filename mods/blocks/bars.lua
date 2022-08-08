-- Wood
minetest.register_node("blocks:wood_bars", {
	description = "Wooden Bars",
	drawtype = "glasslike",
	tiles = {"blocks_wood_bars.png"},
	wield_image = "blocks_wood_bars.png",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {choppy=3},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_node("blocks:wood_grille", {
	description = "Wooden Grille",
	drawtype = "glasslike",
	tiles = {"blocks_wood_grille.png"},
	wield_image = "blocks_wood_grille.png",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {choppy=3},
	sounds = default.node_sound_wood_defaults()
})
-- Steel
minetest.register_node("blocks:steel_bars", {
	description = "Steel Bars",
	drawtype = "glasslike",
	tiles = {"blocks_steel_bars.png"},
	wield_image = "blocks_steel_bars.png",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults()
})

minetest.register_node("blocks:steel_grille", {
	description = "Steel Grille",
	drawtype = "glasslike",
	tiles = {"blocks_steel_grille.png"},
	wield_image = "blocks_steel_grille.png",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults()
})
--
-- Crafts
--
-- Wood
minetest.register_craft({
	output = "blocks:wood_bars 3",
	recipe = {
		{"group:stick","","group:stick"},
		{"group:stick","","group:stick"},
		{"group:stick","","group:stick"}
	}
})

minetest.register_craft({
	output = "blocks:wood_grille 2",
	recipe = {
		{"blocks:wood_bars", "blocks:wood_bars"},
		{"blocks:wood_bars", "blocks:wood_bars"}
	}
})
--Steel
minetest.register_craft({
	output = "blocks:steel_bars 3",
	recipe = {
		{"blocks:steel_ingot","","blocks:steel_ingot"},
		{"blocks:steel_ingot","","blocks:steel_ingot"},
		{"blocks:steel_ingot","","blocks:steel_ingot"}
	}
})

minetest.register_craft({
	output = "blocks:steel_grille 2",
	recipe = {
		{"blocks:steel_bars", "blocks:steel_bars"},
		{"blocks:steel_bars", "blocks:steel_bars"}
	}
})
-- Recycle
-- Wood
minetest.register_craft({
	output = "blocks:stick 2",
	recipe = {
		{"blocks:wood_bars"}
	}
})

minetest.register_craft({
	output = "blocks:stick 4",
	recipe = {
		{"blocks:wood_grille"}
	}
})
-- Steel
minetest.register_craft({
	type = "cooking",
	output = "blocks:steel_ingot 2",
	recipe = "blocks:steel_bars"
})

minetest.register_craft({
	type = "cooking",
	output = "blocks:steel_ingot 4",
	recipe = "blocks:steel_grille"
})
