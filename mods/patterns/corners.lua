patterns.corner_materials = {

	{"amber", "Amber"},
	{"amethyst", "Amethyst"},
	{"brick", "Brick"},
	{"bronzeblock", "Bronze"},
	{"coalblock", "Coal Block"},
	{"copperblock", "Copper"},
	{"desert_sandstone", "Desert Sandstone"},
	{"desert_stone", "Desert Stone"},
	{"garnet", "Garnet"},
	{"goldblock", "Gold"},
	{"ice", "Ice"},
	{"lapis_lazuli", "Lapis Lazuli"},
	{"malachite", "Malachite"},
	{"mithrilblock", "Mithril"},
	{"obsidian", "Obsidian"},
	{"sandstone", "Sandstone"},
	{"silver_sandstone", "Silver Sandstone"},
	{"silverblock", "Silver"},
	{"steelblock", "Steel"},
	{"stone_black", "Black Stone"},
	{"stone_brown", "Brown Stone"},
	{"stone_cyan", "Cyan Stone"},
	{"stone_dark_blue", "Dark Blue Stone"},
	{"stone_dark_pink", "Dark Pink Stone"},
	{"stone_green", "Green Stone"},
	{"stone_purple", "Purple Stone"},
	{"stone_red", "Red Stone"},
	{"stone_yellow", "Yellow Stone"},
	{"stone", "Stone"},
	{"tinblock", "Tin"},
	{"turquoise", "Turquoise"},

}

function patterns.register_corners(base_node)

	for _, corner_materials in ipairs(patterns.corner_materials) do

		local base_definition = minetest.registered_nodes[base_node]
		local sname = string.match(base_node, ':(.*)')
		local corner_name = "patterns:" .. sname .. "_corner_" .. corner_materials[1]
		local base_texture = base_definition.tiles[1]
		local corner_material = "variations_" .. corner_materials[1] .. ".png"
		local corner_description = corner_materials[2] .. " Cornered " .. base_definition.description

		-- Extract Required pieces

		-- Segments of medium tile, clockwise from top right

		local segment1 = "((" .. corner_material .. "\\^[sheet\\:3x3\\:2,0)\\^[mask\\:patterns_mask_segment1.png)"
		local segment2 = "((" .. corner_material .. "\\^[sheet\\:3x3\\:2,0)\\^[mask\\:patterns_mask_segment2.png)"
		local segment3 = "((" .. corner_material .. "\\^[sheet\\:3x3\\:2,0)\\^[mask\\:patterns_mask_segment3.png)"
		local segment4 = "((" .. corner_material .. "^[sheet:3x3:2,0)^[mask:patterns_mask_segment4.png)"

		-- Segments of cross tile, right, left and bottom

		local segment5 = "((" .. corner_material .. "\\^[sheet\\:3x3\\:1,2)\\^[mask\\:patterns_mask_segment5.png)"

		local segment6 = "((" .. corner_material .. "\\^[sheet\\:3x3\\:1,2)\\^[mask\\:patterns_mask_segment6.png)"
		local segment7 = "((" .. corner_material .. "\\^[sheet\\:3x3\\:1,2)\\^[mask\\:patterns_mask_segment7.png)"

		-- Combine overlays

		local overlay_front = "([combine:16x16:0,-4=" .. segment5 .. ":-4,0=" .. segment1 .. ":0,0=" .. segment2 .. ")"
		local overlay_right = "(([combine:16x16:0,4=" .. segment6 .. ":4,0=" .. segment3 .. ")^" .. segment4 .. ")"

		local overlay_top = "([combine:16x16:12,4=" .. segment6 .. ":0,0=" .. segment7 .. ")"
		local overlay_bottom = "(" .. overlay_top .. "^[transformR90)"

		minetest.register_node(corner_name, {
			description = corner_description,
			tiles = {"(" .. base_texture.. "^patterns_shadow_overlay_top.png)^" .. overlay_top,
					"(" .. base_texture .. "^patterns_shadow_overlay_bottom.png)^" .. overlay_bottom,
					"(" .. base_texture .. "^patterns_shadow_overlay_right.png)^" .. overlay_right,
					base_texture,
					base_texture,
					"(" .. base_texture .. "^patterns_shadow_overlay_front.png)^" .. overlay_front},
				groups = ccore.groups_copy(base_definition.groups),
				drawtype = base_definition.drawtype,
				paramtype2 = "facedir"
		})
		workbench:register_craft({
			type = "engraving",
			input =	{
				{base_node, "blocks:" .. corner_materials[1]},
				{"blocks:" .. corner_materials[1], "blocks:" .. corner_materials[1]},
			},
			output = {
				{corner_name .. " 3"},
			},
		})
	end
end