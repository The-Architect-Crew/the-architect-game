-- support for MT game translation.
local S = default.get_translator

function blocks.register_mesepost(name, def)
	minetest.register_craft({
		output = name .. " 4",
		recipe = {
			{'', 'blocks:glass', ''},
			{'blocks:mese_crystal', 'blocks:mese_crystal', 'blocks:mese_crystal'},
			{'', def.material, ''},
		}
	})

	local post_texture = def.texture .. "^blocks_mese_post_light_side.png^[makealpha:0,0,0"
	local post_texture_dark = def.texture .. "^blocks_mese_post_light_side_dark.png^[makealpha:0,0,0"
	-- Allow almost everything to be overridden
	local default_fields = {
		wield_image = post_texture,
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{-2 / 16, -8 / 16, -2 / 16, 2 / 16, 8 / 16, 2 / 16},
			},
		},
		paramtype = "light",
		tiles = {def.texture, def.texture, post_texture_dark, post_texture_dark, post_texture, post_texture},
		use_texture_alpha = "opaque",
		light_source = default.LIGHT_MAX,
		sunlight_propagates = true,
		is_ground_content = false,
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, loot = 3},
		sounds = default.node_sound_wood_defaults(),
	}
	for k, v in pairs(default_fields) do
		if def[k] == nil then
			def[k] = v
		end
	end

	def.texture = nil
	def.material = nil

	minetest.register_node(name, def)
end

minetest.register_node("blocks:meselamp", {
	description = S("Mese Lamp"),
	drawtype = "glasslike",
	tiles = {"blocks_meselamp.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3, loot = 3},
	sounds = default.node_sound_glass_defaults(),
	light_source = default.LIGHT_MAX,
})

blocks.register_mesepost("blocks:mese_post_light", {
	description = S("Apple Wood Mese Post Light"),
	texture = "blocks_wood.png",
	material = "blocks:wood",
})

blocks.register_mesepost("blocks:mese_post_light_acacia_wood", {
	description = S("Acacia Wood Mese Post Light"),
	texture = "blocks_acacia_wood.png",
	material = "blocks:acacia_wood",
})

blocks.register_mesepost("blocks:mese_post_light_junglewood", {
	description = S("Jungle Wood Mese Post Light"),
	texture = "blocks_junglewood.png",
	material = "blocks:junglewood",
})

blocks.register_mesepost("blocks:mese_post_light_pine_wood", {
	description = S("Pine Wood Mese Post Light"),
	texture = "blocks_pine_wood.png",
	material = "blocks:pine_wood",
})

blocks.register_mesepost("blocks:mese_post_light_aspen_wood", {
	description = S("Aspen Wood Mese Post Light"),
	texture = "blocks_aspen_wood.png",
	material = "blocks:aspen_wood",
})

-- Semiprecious Lanterns
minetest.register_node("blocks:amethyst_lantern", {
	description = S("Amethyst Lantern"),
	tiles = {"blocks_amethyst.png^blocks_mosaic_frame.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 1, loot = 2},
	sounds = default.node_sound_glass_defaults(),
	light_source = 13,
})

minetest.register_node("blocks:garnet_lantern", {
	description = S("Garnet Lantern"),
	tiles = {"blocks_garnet.png^blocks_mosaic_frame.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 1, loot = 2},
	sounds = default.node_sound_glass_defaults(),
	light_source = 13,
})
--
-- == CRAFTS
--
minetest.register_craft({
	output = "blocks:meselamp",
	recipe = {
		{"blocks:glass"},
		{"blocks:mese_crystal"},
	}
})

minetest.register_craft({
	output = "blocks:amethyst_lantern",
	recipe = {
		{"blocks:steel_ingot", "blocks:amethyst", "blocks:steel_ingot"},
		{"blocks:amethyst", "blocks:torch", "blocks:amethyst"},
		{"blocks:steel_ingot", "blocks:amethyst", "blocks:steel_ingot"},
	}
})

minetest.register_craft({
	output = "blocks:garnet_lantern",
	recipe = {
		{"blocks:steel_ingot", "blocks:garnet", "blocks:steel_ingot"},
		{"blocks:garnet", "blocks:torch", "blocks:garnet"},
		{"blocks:steel_ingot", "blocks:garnet", "blocks:steel_ingot"},
	}
})
