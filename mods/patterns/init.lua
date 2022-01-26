patterns = {}

patterns.patterns = {
	{
		name = "terminal_top";
		description = "Top Terminal";
		texture = "0,0";
		tiles = {12, 8, 1, 1, 1, 1};
	},
	{
		name = "terminal_left";
		description = "Left Terminal";
		texture = "1,0";
		tiles = {2, 2, 8, 12, 4, 2};
	},
	{
		name = "horizontal";
		description = "Horizontal";
		texture = "2,0";
		tiles = {12, 12, 3, 3, 3, 3};
	},
	{
		name = "terminal_right";
		description = "Right Terminal";
		texture = "3,0";
		tiles = {4, 4, 12, 8, 2, 4};
	},
	{
		name = "vertical";
		description = "Vertical";
		texture = "0,1";
		tiles = {8, 8, 5, 5, 5, 5};
	},
	{
		name = "corner_tl";
		description = "Top-Left Corner";
		texture = "1,1";
		tiles = {12, 5, 3, 12, 7, 6};
	},
	{
		name = "corner_tr";
		description = "Top-Right Corner";
		texture = "2,1";
		tiles = {12, 5, 12, 3, 6, 7};
	},
	{
		name = "center";
		description = "Center";
		texture = "3,1";
		tiles = {8, 8, 8, 8, 8, 8};
	},
	{
		name = "terminal_bottom";
		description = "Bottom Terminal";
		texture = "0,2";
		tiles = {8, 12, 9, 9, 9, 9};
	},
	{
		name = "corner_bl";
		description = "Bottom-Left Corner";
		texture = "1,2";
		tiles = {5, 12, 3, 12, 11, 10};
	},
	{
		name = "corner_br";
		description = "Bottom-Right Corner";
		texture = "2,2";
		tiles = {5, 12, 12, 3, 10, 11};
	},
	{
		name = "rune";
		description = "Rune";
		texture = "3,2";
		tiles = {12, 12, 12, 12, 12, 12};
	}
}

patterns.patterns_single = {
	{
		name = "square";
		description = "Square";
		texture = "0,0";
	},
	{
		name = "triangle";
		description = "Triangle";
		texture = "0,1";
	},
	{
		name = "circle";
		description = "Circle";
		texture = "0,2";
	},
}

patterns.colors = {
	{"black", "Black", "1d1d1d"},
	{"brown", "Brown", "43282b"},
	{"cyan", "Cyan", "41aab9"},
	{"dark_blue", "Dark Blue", "3d73a3"},
	{"dark_pink", "Dark Pink", "b73fb3"},
	{"green", "Green", "4ab12e"},
	{"purple", "Purple", "493da3"},
	{"red", "Red", "b03f43"},
	{"yellow", "Yellow", "bdb537"},
}

patterns.pattern_types = {
	{"x", "X"},
	{"spiral", "Spiral"}
}

function patterns.assemble_pattern(pattern_data, pattern_type, color)

	local name = pattern_data.name
	local texture = pattern_data.texture
	
	local result = "((patterns_" .. pattern_type .. "_shading.png^[sheet:4x3:" .. texture .. ")^[opacity:64)^((patterns_" .. pattern_type .. "_color.png^[sheet:4x3:" .. texture .. ")^[multiply:#" .. color .. ")"

	return result
end

function patterns.register_patterns(base_node)

	patterns.register_patterns_single(base_node)
	
	for _, colors in ipairs(patterns.colors) do
		for _, types in ipairs(patterns.pattern_types) do

		local pattern_type = types[1]
		local pattern_type_description = types[2]
		local base_definition = minetest.registered_nodes[base_node]

		local color_string = colors[1]
		local color_name = colors[2]
		local color = colors[3]

		for _, pattern in ipairs(patterns.patterns) do
			local sname = string.match(base_node, ':(.*)')
			local pattern_name = "patterns:" .. sname .. "_" .. pattern_type .. "_" .. pattern.name .. "_" .. color_string
			local pattern_description = base_definition.description .. " with a " .. color_name .. " " .. pattern_type_description .. " Pattern " .. pattern.description
			
			local tiles = {base_definition.tiles[1] .. "^" .. patterns.assemble_pattern(patterns.patterns[pattern.tiles[1]], pattern_type, color),
						base_definition.tiles[1] .. "^" .. patterns.assemble_pattern(patterns.patterns[pattern.tiles[2]], pattern_type, color),
						base_definition.tiles[1] .. "^" .. patterns.assemble_pattern(patterns.patterns[pattern.tiles[3]], pattern_type, color),
						base_definition.tiles[1] .. "^" .. patterns.assemble_pattern(patterns.patterns[pattern.tiles[4]], pattern_type, color),
						base_definition.tiles[1] .. "^" .. patterns.assemble_pattern(patterns.patterns[pattern.tiles[5]], pattern_type, color),
						base_definition.tiles[1] .. "^" .. patterns.assemble_pattern(patterns.patterns[pattern.tiles[6]], pattern_type, color),
			}

			minetest.register_node(pattern_name, {
				description = pattern_description,
				tiles = tiles,
				groups = base_definition.groups,
				drawtype = base_definition.drawtype,
				paramtype2 = facedir
				})
			end
		end
	end
end

function patterns.register_patterns_single(base_node)
	local base_definition = minetest.registered_nodes[base_node]
	for _, colors in ipairs(patterns.colors) do
		for _, patterns in ipairs(patterns.patterns_single) do

			local color_string = colors[1]
			local color_name = colors[2]
			local color = colors[3]

			local sname = string.match(base_node, ':(.*)')
			local pattern_name = "patterns:" .. sname .. "_" .. patterns.name .. "_" .. color_string
			local pattern_description = base_definition.description .. " with a " .. color_name .. " " .. patterns.description .. " Pattern"
			local tiles = {"(" .. base_definition.tiles[1] .. "^((patterns_single_shading.png^[sheet:1x3:" .. patterns.texture .. ")^[opacity:64))^((patterns_single_color.png^[sheet:1x3:" .. patterns.texture .. ")^[multiply:#" .. color .. ")"}
			minetest.register_node(pattern_name, {
				description = pattern_description,
				tiles = tiles,
				groups = base_definition.groups,
				drawtype = base_definition.drawtype
			})
		end
	end
end

-- Corners

patterns.corner_materials = {
	{"sandstone", "Sandstone"},
	{"steelblock", "Steel"},
	{"malachite", "Malachite"},
	{"brick", "Brick"},
	{"obsidian", "Obsidian"},
	{"ice", "Ice"}
}

function patterns.register_corners(base_node)

for _, corner_materials in ipairs(patterns.corner_materials) do

	local base_definition = minetest.registered_nodes[base_node]
	local sname = string.match(base_node, ':(.*)')
	local corner_name = "patterns:" .. sname .. "_corner_" .. corner_materials[1]
	local base_texture = base_definition.tiles[1]
	local corner_material = "variations_" .. corner_materials[1] .. ".png"
	local corner_description = base_definition.description .. " with a " .. corner_materials[2] .. " Corner"

	-- Extract Required pieces

	-- Segments of medium tile, clockwise from top center

	local segment1 = "((" .. corner_material .. "\\^[sheet\\:3x3\\:2,0)\\^[mask\\:patterns_mask_segment1.png)"
	local segment2 = "((" .. corner_material .. "\\^[sheet\\:3x3\\:2,0)\\^[mask\\:patterns_mask_segment2.png)"
	local segment3 = "((" .. corner_material .. "\\^[sheet\\:3x3\\:2,0)\\^[mask\\:patterns_mask_segment3.png)"
	local segment4 = "((" .. corner_material .. "^[sheet:3x3:2,0)^[mask:patterns_mask_segment4.png)"

	-- Segments of tall tile, top-right then bottom

	local segment5 = "((" .. corner_material .. "^[sheet:3x3:0,1)^[mask:patterns_mask_segment5.png)"
	local segment6 = "((" .. corner_material .. "\\^[sheet\\:3x3\\:0,1)\\^[mask\\:patterns_mask_segment6.png)"

	local segment7 = "((" .. corner_material .. "\\^[sheet\\:3x3\\:1,2)\\^[mask\\:patterns_mask_segment7.png)"

	-- Combine overlays

	local overlay_right = "(" .. segment5 .. "^([combine:16x16:-4,0=" .. segment1 .. ":0,0=" .. segment2 .. "))"
	local overlay_left = "(([combine:16x16:-2,0=" .. segment6 .. ":4,0=" .. segment3 .. ")^" .. segment4 .. ")"

	local overlay_top = "([combine:16x16:10,0=" .. segment6 .. ":0,0=" .. segment7 .. ")"
	local overlay_bottom = "(" .. overlay_top .. "^[transformR90)"

	minetest.register_node(corner_name, {
		description = corner_description,
		tiles = {base_texture .. "^" .. overlay_top,
				"(" .. base_texture .. "^patterns_shadow_overlay_bottom.png)^" .. overlay_bottom,
				"(" .. base_texture .. "^patterns_shadow_overlay_left.png)^" .. overlay_left,
				base_texture,
				base_texture,
				"(" .. base_texture .. "^patterns_shadow_overlay_right.png)^" .. overlay_right},
			groups = base_definition.groups,
			drawtype = base_definition.drawtype,
			paramtype2 = "facedir"
	})
	end
end

patterns.register_patterns("blocks:clay")
patterns.register_patterns("blocks:stone")
patterns.register_patterns("blocks:sandstone")

patterns.register_corners("blocks:stone")
