patterns.patterns = {
	{
		name = "terminal_top";
		description = "Top Terminal";
		texture = "0,0";
		tiles = {12, 8, 1, 1, 1, 1};
		position = 1;
	},
	{
		name = "terminal_left";
		description = "Left Terminal";
		texture = "1,0";
		tiles = {2, 2, 8, 12, 4, 2};
		position = 2;
	},
	{
		name = "horizontal";
		description = "Horizontal";
		texture = "2,0";
		tiles = {12, 12, 3, 3, 3, 3};
		position = 3;
	},
	{
		name = "terminal_right";
		description = "Right Terminal";
		texture = "3,0";
		tiles = {4, 4, 12, 8, 2, 4};
		position = 4;
	},
	{
		name = "vertical";
		description = "Vertical";
		texture = "0,1";
		tiles = {8, 8, 5, 5, 5, 5};
		position = 5;
	},
	{
		name = "corner_tl";
		description = "Top-Left Corner";
		texture = "1,1";
		tiles = {12, 5, 3, 12, 7, 6};
		position = 6;
	},
	{
		name = "corner_tr";
		description = "Top-Right Corner";
		texture = "2,1";
		tiles = {12, 5, 12, 3, 6, 7};
		position = 7;
	},
	{
		name = "center";
		description = "Center";
		texture = "3,1";
		tiles = {8, 8, 8, 8, 8, 8};
		position = 8;
	},
	{
		name = "terminal_bottom";
		description = "Bottom Terminal";
		texture = "0,2";
		tiles = {8, 12, 9, 9, 9, 9};
		position = 9;
	},
	{
		name = "corner_bl";
		description = "Bottom-Left Corner";
		texture = "1,2";
		tiles = {5, 12, 3, 12, 11, 10};
		position = 10;
	},
	{
		name = "corner_br";
		description = "Bottom-Right Corner";
		texture = "2,2";
		tiles = {5, 12, 12, 3, 10, 11};
		position = 11;
	},
	{
		name = "rune";
		description = "Rune";
		texture = "3,2";
		tiles = {12, 12, 12, 12, 12, 12};
		position = 12;
	}
}

patterns.patterns_single = {
	{
		name = "square";
		description = "Square";
		texture = "0,0";
		position = 1;
	},
	{
		name = "triangle";
		description = "Triangle";
		texture = "0,1";
		position = 2;
	},
	{
		name = "circle";
		description = "Circle";
		texture = "0,2";
		position = 3;
	},
	{
		name = "pillar";
		description = "Pillar";
		texture = "1,0";
		position = 4;
	},
	{
		name = "diagonal";
		description = "Diagonal";
		texture = "1,1";
		position = 5;
	},
	{
		name = "chain";
		description = "Chain";
		texture = "1,2";
		position = 6;
	},
}

-- Hue is from -180 to 180, Saturation is from 0 to 100
-- Acrylic coloring uses hsl shift and strong shading
patterns.colors = {
	{"black", "Black", "1d1d1d", 0, 0},
	{"brown", "Brown", "43282b", -7, 40},
	{"cyan", "Cyan", "41aab9", -173, 65},
	{"dark_blue", "Dark Blue", "3d73a3", -152, 63},
	{"dark_green", "Dark Green", "40924a", 127, 56},
	{"dark_grey", "Dark Grey", "626262", 0, 0},
	{"dark_pink", "Dark Pink", "b73fb3", -58, 66},
	{"green", "Green", "4ab12e", 107, 74},
	{"grey", "Grey", "9d9d9d", 0, 0},
	{"orange", "Orange", "b76f3f", 24, 66},
	{"pink", "Pink", "b6767d", -7, 35},
	{"purple", "Purple", "493da3", -113, 63},
	{"red", "Red", "b03f43", -2, 64},
	{"white", "White", "b8b8b8", 0, 0},
	{"yellow", "Yellow", "bdb537", 56, 71},
}

patterns.pattern_types = {
	{"x", "X", 1},
	{"spiral", "Spiral", 2}
}

function patterns.assemble_texture(base_texture, pattern_data, pattern_type, color_data, colortype)
	local pattern_texture = pattern_data.texture
	local result = ""
	local color = color_data[3]
	local hue = color_data[4]
	local saturation = color_data[5]

	if (colortype == "colorize") then
		result = "(" .. base_texture .. "^[overlay:(patterns_" .. pattern_type .. "_shading.png\\^[sheet\\:4x3\\:" .. pattern_texture .. "))" .. "^((" .. base_texture .. "^[colorize:#" .. color .. ":144)^[mask:(patterns_" .. pattern_type .. "_color.png\\^[sheet\\:4x3\\:" .. pattern_texture .. "))"
	elseif (colortype == "hsl") then
		result = "(" .. base_texture .. "^[overlay:(patterns_" .. pattern_type .. "_shading_strong.png\\^[sheet\\:4x3\\:" .. pattern_texture .. "))" .. "^((" .. base_texture .. "^[colorizehsl:" .. hue .. ":" .. saturation .. ")^[mask:(patterns_" .. pattern_type .. "_color.png\\^[sheet\\:4x3\\:" .. pattern_texture .. "))"
	end
	return result
end

function patterns.register_patterns(base_node, limit, colortype)

	if (colortype == nil) then
		colortype = "colorize"
	end

	patterns.register_patterns_single(base_node, limit, colortype)
	ccore.station_comment(base_node, "Patternable")

	for _, color in ipairs(patterns.colors) do
		if (patterns.check_limit(color[1], limit)) then
			for _, types in ipairs(patterns.pattern_types) do

			local pattern_type = types[1]
			local pattern_type_description = types[2]
			local base_definition = minetest.registered_nodes[base_node]

			local color_string = color[1]
			local color_name = color[2]

			for _, pattern in ipairs(patterns.patterns) do
				local sname = string.match(base_node, ':(.*)')
				local pattern_name = "patterns:" .. sname .. "_" .. pattern_type .. "_" .. pattern.name .. "_" .. color_string
				local pattern_description = "Patterned " .. base_definition.description .. "\nPattern: " .. pattern_type_description .. "\nColor: " .. color_name .. "\nSegment: " .. pattern.description

				local tiles = {patterns.assemble_texture(base_definition.tiles[1], patterns.patterns[pattern.tiles[1]], pattern_type, color, colortype),
							patterns.assemble_texture(base_definition.tiles[1], patterns.patterns[pattern.tiles[2]], pattern_type, color, colortype),
							patterns.assemble_texture(base_definition.tiles[1], patterns.patterns[pattern.tiles[3]], pattern_type, color, colortype),
							patterns.assemble_texture(base_definition.tiles[1], patterns.patterns[pattern.tiles[4]], pattern_type, color, colortype),
							patterns.assemble_texture(base_definition.tiles[1], patterns.patterns[pattern.tiles[5]], pattern_type, color, colortype),
							patterns.assemble_texture(base_definition.tiles[1], patterns.patterns[pattern.tiles[6]], pattern_type, color, colortype),
				}

				minetest.register_node(pattern_name, {
					description = pattern_description,
					tiles = tiles,
					groups = ccore.groups_copy(base_definition.groups),
					drawtype = base_definition.drawtype,
					paramtype2 = "facedir"
					})

				patterns.register_craft(base_node, pattern_type, pattern.name, color_string)
				end
			end
		end
	end
end

function patterns.register_patterns_single(base_node, limit, colortype)
	local base_definition = minetest.registered_nodes[base_node]
	for _, colors in ipairs(patterns.colors) do
		if (patterns.check_limit(colors[1], limit)) then
			for _, pattern in ipairs(patterns.patterns_single) do

				local color_string = colors[1]
				local color_name = colors[2]
				local color = colors[3]
				local hue = colors[4]
				local saturation = colors[5]

				local sname = string.match(base_node, ':(.*)')
				local pattern_name = "patterns:" .. sname .. "_" .. pattern.name .. "_" .. color_string
				local pattern_description = "Patterned " .. base_definition.description .. "\nPattern: " .. pattern.description .. "\nColor: " .. color_name
				local tiles = {}
				if (colortype == "colorize") then
					tiles = {"(" .. base_definition.tiles[1] .. "^[overlay:(patterns_single_shading.png\\^[sheet\\:2x3\\:" .. pattern.texture .. "))" .. "^((" .. base_definition.tiles[1] .. "^[colorize:#" .. color .. ":144)^[mask:(patterns_single_color.png\\^[sheet\\:2x3\\:" .. pattern.texture .. "))"}
				elseif (colortype == "hsl") then
					tiles = {"(" .. base_definition.tiles[1] .. "^[overlay:(patterns_single_shading_strong.png\\^[sheet\\:2x3\\:" .. pattern.texture .. "))" .. "^((" .. base_definition.tiles[1] .. "^[colorizehsl:" .. hue .. ": " .. saturation .. ")^[mask:(patterns_single_color.png\\^[sheet\\:2x3\\:" .. pattern.texture .. "))"}
				end
					minetest.register_node(pattern_name, {
					description = pattern_description,
					tiles = tiles,
					groups = ccore.groups_copy(base_definition.groups),
					drawtype = base_definition.drawtype
				})

				patterns.register_craft(base_node, "single", pattern.name, color_string)
			end
		end
	end
end

function patterns.register_craft(base_node, pattern_type, pattern, color)
	local pattern_node
	local sname = string.match(base_node, ':(.*)')
	if pattern_type == "single" then
		pattern_node = "patterns:" .. sname .. "_" .. pattern .. "_" .. color
	else
		pattern_node = "patterns:" .. sname .. "_" .. pattern_type .. "_" .. pattern .. "_" .. color
	end
	workbench:register_craft({
		type = "engraving",
		category = pattern_type .. "_" .. pattern,
		input =	{{base_node, "dye:" .. color}},
		output = {{pattern_node}},
	})
end