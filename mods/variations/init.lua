variations = {}

variations.variations = {
	{
		name = "brick";
		description = "Brick";
		texture = "0,0";
	},
	{
		name = "big_tile";
		description = "Big Tile";
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

function variations.register_for_base(base_node, transparent, sunlight)
	local base_definition = minetest.registered_nodes[base_node]
	for _, variation in ipairs(variations.variations) do
		local sname = string.match(base_node, ':(.*)')
		local variation_name = "variations:" .. sname .. "_" .. variation.name
		local variation_description = base_definition.description .. " " .. variation.description
		local tiles = {"variations_" .. sname .. ".png^[sheet:3x3:" .. variation.texture}
		local paramtype_light = ""
		if not sunlight and transparent then
			sunlight = true
			paramtype_light = "light"
		end
		minetest.register_node(variation_name, {
			description = variation_description,
			tiles = tiles,
			groups = base_definition.groups,
			drawtype = base_definition.drawtype,
			use_texture_alpha = transparent or base_definition.use_texture_alpha,
			paramtype = paramtype_light or base_definition.paramtype,
			sunlight_propagates = sunlight or base_definition.sunlight_propagates,
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
variations.register_for_base("blocks:dirt")
variations.register_for_base("blocks:coalblock")
variations.register_for_base("blocks:amethyst")
variations.register_for_base("blocks:garnet")
variations.register_for_base("blocks:lapis_lazuli")
variations.register_for_base("blocks:malachite")
variations.register_for_base("blocks:turquoise")
--variations.register_for_base("blocks:amber")
variations.register_for_base("blocks:silverblock")
variations.register_for_base("blocks:mithrilblock")
