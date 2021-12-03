variations = {}

variations.variations = {
	{
		name = "brick";
		description = "Brick";
		texture = "0,0";
	},
	{
		name = "block";
		description = "Block";
		texture = "1,0";
	},
	{
		name = "tile";
		description = "Tile";
		texture = "2,0";
	},
	{
		name = "tall_tile";
		description = "Tall Tile";
		texture = "0,1";
	},
	{
		name = "small_brick";
		description = "Small Brick";
		texture = "1,1";
	},
	{
		name = "small_tile";
		description = "Small Tile";
		texture = "2,1";
	},
	{
		name = "horizontal_brick";
		description = "Horizontal Brick";
		texture = "0,2";
	},
	{
		name = "cross_tile";
		description = "Cross Tile";
		texture = "1,2";
	},
	{
		name = "spiral_tile";
		description = "Spiral Tile";
		texture = "2,2";
	},
}

function variations.register_for_base(base_node, transparent)
	local base_definition = minetest.registered_nodes[base_node]
	for _, variation in ipairs(variations.variations) do
		-- We get an iterator function over substrings split by :
		local base_node_full_name = string.gmatch(base_node, "([^:]+)")
		-- First call will give us the modname
		-- local base_node_modname = base_node_full_name()
		-- Unused variable warning...
		base_node_full_name()
		-- and the second will give us the node name
		local base_node_name = base_node_full_name()
		local variation_name = "variations:" .. base_node_name .. "_" .. variation.name
		local variation_description = base_definition.description .. " " .. variation.description
		local tiles = {"variations_" .. base_node_name .. ".png^[sheet:3x3:" .. variation.texture}
		minetest.register_node(variation_name, {
			description = variation_description,
			tiles = tiles,
			groups = base_definition.groups,
			drawtype = base_definition.drawtype,
			use_texture_alpha = transparent,
			sunlight_propagates = transparent,
		})
	end
end

variations.register_for_base("blocks:stone")
variations.register_for_base("blocks:obsidian")
variations.register_for_base("blocks:desert_stone")
variations.register_for_base("blocks:sandstone")
variations.register_for_base("blocks:silver_sandstone")
variations.register_for_base("blocks:desert_sandstone")
variations.register_for_base("blocks:steel")
variations.register_for_base("blocks:copper")
variations.register_for_base("blocks:bronze")
variations.register_for_base("blocks:tin")
variations.register_for_base("blocks:gold")
variations.register_for_base("blocks:brick")
variations.register_for_base("blocks:ice")
variations.register_for_base("blocks:dirt")
variations.register_for_base("blocks:coal")
--[[
variations.register_for_base("blocks:amethyst", true)
variations.register_for_base("blocks:garnet", true)
variations.register_for_base("blocks:lapis_lazuli")
variations.register_for_base("blocks:malachite")
variations.register_for_base("blocks:turquoise")
variations.register_for_base("blocks:amber")
variations.register_for_base("blocks:silver")
variations.register_for_base("blocks:mithril")]]--
