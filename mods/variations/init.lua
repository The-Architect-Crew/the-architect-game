variations = {}

variations.variations = {
	{
		name = "brick";
		description = "Brick";
		texture = "0,0";
		enabled_shapes = "cat:slab, cat:cube, cat:step, cat:stair, splitstair, cat:pillar, cat:pillarcrown, cat:beam, cat:corner, cat:slope";
	},
	{
		name = "big_tile";
		description = "Big Tile";
		texture = "1,0";
		enabled_shapes = "slab, cube, step, cat:stair, splitstair, cat:pillar, cat:pillarcown, corner, pane, pane_flat, slope, slope2, slope3, innerslope, innerslope2, innerslope3, outerslope, outerslope2, outerslope3";
	},
	{
		name = "tile";
		description = "Tile";
		texture = "2,0";
		enabled_shapes = "slab, cube, step, cat:stair, splitstair, cat:pillar, cat:pillarcown, corner, pane, pane_flat, slope, slope2, slope3, innerslope, innerslope2, innerslope3, outerslope, outerslope2, outerslope3";
	},
	{
		name = "tall_tile";
		description = "Tall Tile";
		texture = "0,1";
		enabled_shapes = "slab, cube, step, cat:stair, splitstair, cat:pillar, cat:pillarcown, corner, slope, slope2, slope3, innerslope, innerslope2, innerslope3, outerslope, outerslope2, outerslope3";
	},
	{
		name = "small_brick";
		description = "Small Brick";
		texture = "1,1";
		enabled_shapes = "slab, cube, step, cat:stair, splitstair, cat:pillar, cat:pillarcown, corner, slope, slope2, slope3, innerslope, innerslope2, innerslope3, outerslope, outerslope2, outerslope3";
	},
	{
		name = "small_tile";
		description = "Small Tile";
		texture = "2,1";
		enabled_shapes = "slab, cube, step, cat:stair, splitstair, cat:pillar, cat:pillarcown, corner, slope, slope2, slope3, innerslope, innerslope2, innerslope3, outerslope, outerslope2, outerslope3";
	},
	{
		name = "horizontal_brick";
		description = "Horizontal Brick";
		texture = "0,2";
		enabled_shapes = "slab, cube, step, cat:stair, splitstair, cat:pillar, cat:pillarcown, corner, slope, slope2, slope3, innerslope, innerslope2, innerslope3, outerslope, outerslope2, outerslope3";
	},
	{
		name = "cross_tile";
		description = "Cross Tile";
		texture = "1,2";
		enabled_shapes = "slab, cube, step, cat:stair, splitstair, cat:pillar, cat:pillarcown, corner, pane, pane_flat, slope, slope2, slope3";
	},
	{
		name = "spiral_tile";
		description = "Spiral Tile";
		texture = "2,2";
		enabled_shapes = "slab1, cat:pane";
	},
}

local function convert_craft(base_node, variant_node)
	minetest.register_craft({
		output = base_node,
		recipe = {
			{variant_node},
		}
	})
end

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
		shapes:register_shape(variation_name, {
			enabled = variation.enabled_shapes,
		})
		convert_craft(base_node, variation_name)
	end
end

function variations.register_support(base_node, transparent, sunlight)
	local base_definition = minetest.registered_nodes[base_node]
	for _, variation in ipairs(variations.variations) do
		local sname = string.match(base_node, ':(.*)')
		local variation_name = "variations:" .. sname .. "_" .. variation.name .. "_support"
		local variation_description = base_definition.description .. " with Support " .. variation.description
		local tiles = {"(variations_" .. sname .. ".png^[sheet:3x3:" .. variation.texture .. ")^(variations_support.png^[sheet:3x3:" .. variation.texture .. ")"}
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
		shapes:register_shape(variation_name, {
			enabled = variation.enabled_shapes,
		})
		convert_craft(base_node, variation_name)
	end
end

variations.frames = {
	{
		name = "top";
		description = "Top";
		texture = "0";
	},
	{
		name = "upper";
		description = "Upper";
		texture = "1";
	},
	{
		name = "middle";
		description = "Middle";
		texture = "2";
	},
	{
		name = "lower";
		description = "Lower";
		texture = "3";
	},
	{
		name = "bottom";
		description = "Bottom";
		texture = "4";
	},
}

variations.frame_variations = {
	{
		name = "square";
		description = "Square";
		texture = "0";
	},
	{
		name = "diamond";
		description = "Diamond";
		texture = "1";
	},
	{
		name = "bars";
		description = "Bars";
		texture = "2";
	},
}

function variations.register_frame(base_node)
	local base_definition = minetest.registered_nodes[base_node]
	for _, frame in ipairs(variations.frames) do
		for _, variation in ipairs(variations.frame_variations) do
			local sname = string.match(base_node, ':(.*)')
			local frame_name = "variations:" .. sname .. "_" .. variation.name .. "_" .. frame.name
			local frame_description = base_definition.description .. " " .. variation.description .. " " .. frame.description .. " Frame"
			local tiles = {"(variations_" .. sname .. ".png^[mask:(variations_glass_mask.png\\^[sheet\\:3x5\\:" .. variation.texture .. "," .. frame.texture .. "))", "variations_" .. sname .. ".png"}
			minetest.register_node(frame_name, {
				description = frame_description,
				tiles = tiles,
				groups = base_definition.groups,
				drawtype = "mesh",
				mesh = "frame.obj",
				collision_box = {
					type = "fixed",
					fixed = {
						{-0.5, -0.5, -0.1, 0.5, 0.5, 0.1},
					},
				},
				selection_box = {
					type = "fixed",
					fixed = {
						{-0.5, -0.5, -0.1, 0.5, 0.5, 0.1},
					},
				},
				use_texture_alpha = base_definition.use_texture_alpha,
				paramtype = "light",
				paramtype2 = "facedir",
				sunlight_propagates = true,
			})
			convert_craft(base_node, frame_name)
		end
	end
end

variations.register_frame("blocks:obsidian_glass")
variations.register_frame("blocks:glass")

variations.register_for_base("blocks:stone")
variations.register_for_base("blocks:obsidian")
variations.register_for_base("blocks:desert_stone")
variations.register_for_base("blocks:sandstone")
variations.register_for_base("blocks:silver_sandstone")
variations.register_for_base("blocks:desert_sandstone")
variations.register_for_base("blocks:steelblock")
variations.register_for_base("blocks:steelblock_hazard")
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
variations.register_for_base("blocks:amber")
variations.register_for_base("blocks:silverblock")
variations.register_for_base("blocks:mithrilblock")
variations.register_for_base("blocks:basalt")
variations.register_for_base("blocks:chalk")
variations.register_for_base("blocks:granite")
variations.register_for_base("blocks:marble")
variations.register_for_base("blocks:mud")
variations.register_for_base("blocks:porphyry")
variations.register_for_base("blocks:serpentine")
variations.register_for_base("blocks:slate")
variations.register_for_base("blocks:mineral_salt")
variations.register_for_base("blocks:concrete")
variations.register_for_base("blocks:wood")
variations.register_for_base("blocks:rustblock")
variations.register_for_base("blocks:rustblock_hazard")
variations.register_for_base("blocks:mese")

variations.register_support("blocks:stone")
variations.register_support("blocks:sandstone")
variations.register_support("blocks:chalk")

for _, color in ipairs(blocks.stone_colors) do
	variations.register_for_base("blocks:stone_" .. color[1])
end
