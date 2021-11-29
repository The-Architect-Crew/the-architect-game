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
variations.register_for_base("blocks:steelblock")
variations.register_for_base("blocks:copperblock")
variations.register_for_base("blocks:bronzeblock")
variations.register_for_base("blocks:tinblock")
variations.register_for_base("blocks:goldblock")
variations.register_for_base("blocks:brick")
variations.register_for_base("blocks:ice")
--[[
variations.register_for_base("semiprecious:amethyst_block", true)
variations.register_for_base("semiprecious:garnet_block", true)
variations.register_for_base("semiprecious:lapis_lazuli_block")
variations.register_for_base("semiprecious:malachite_block")
variations.register_for_base("semiprecious:turquoise_block") ]]--
