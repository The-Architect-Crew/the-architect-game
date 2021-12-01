furniture = {}

furniture.parts = {
	{
		name = "chair",
		description = "Chair",
		mesh = "chair.obj",
		collision_box = {
			{-0.25, -0.50, -0.25, 0.25, 0.00, 0.25},
			{-0.25, 0.00, 0.15, 0.25, 0.55, 0.25},
		},
	},
	{
		name = "big_chair",
		description = "Big Chair",
		mesh = "chair_big.obj",
		collision_box = {
			{-0.5, -0.5, -0.5, 0.5, 0.15, 0.5},
			{-0.5, 0.15, 0.25, 0.5, 1.30, 0.5},
		},
		custom_tiles = {"wool_black.png"},
	},
	{
		name = "flowerpot",
		description = "Flower Pot",
		mesh = "flowerpot.obj",
		collision_box = {-0.4, -0.5, -0.4, 0.4, 0.5, 0.4},
		custom_tiles = {"default_dirt.png",
										"default_gold_block.png"},
	},
	{
		name = "stool",
		description = "Stool",
		mesh = "stool.obj",
		collision_box = {-0.35, -0.5, -0.25, 0.35, -0.1, 0.25},
	},
	{
		name = "shelves",
		description = "Shelves",
		mesh = "shelves.obj",
		collision_box = {0.5, 0.5, 0.5, -0.5, -0.5, -0.0625},
	},
}

function furniture.register_for_base(base_node)
	local base_definition = minetest.registered_nodes[base_node]

	for _, part in ipairs(furniture.parts) do
		-- We get an iterator function over substrings split by :
		local base_node_full_name = string.gmatch(base_node, "([^:]+)")

		-- First call will give us the modname
		-- local base_node_modname = base_node_full_name()

		-- Unused variable warning...
		base_node_full_name()

		-- and the second will give us the node name
		local base_node_name = base_node_full_name()

		local part_name = "furniture:" .. base_node_name .. "_" .. part.name
		local part_description = base_definition.description .. " " .. part.description

		local collision_box = {
			type = "fixed",
			fixed = part.collision_box,
		}

		-- Of course lua table indicies start with one, why wouldn't they?
		local tiles = {base_definition.tiles[1]}

		-- Of course lua doesn't have a built-in table append function,
		-- why would it?
		if part.custom_tiles then
			for _, tile in ipairs(part.custom_tiles) do
					table.insert(tiles, tile)
			end
		end

		minetest.register_node(part_name, {
			description = part_description,

			tiles = tiles,
			groups = base_definition.groups,

			collision_box = collision_box,
			selection_box = collision_box,

			drawtype = "mesh",
			mesh = part.mesh,
			paramtype = "light",
			paramtype2 = "facedir",
		})
	end
end

-- For testing
furniture.register_for_base("default:stone")
furniture.register_for_base("default:wood")
furniture.register_for_base("default:tree")
