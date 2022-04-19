furniture = {}

furniture.types = {
    {
        name = "chair",
        description = "Chair",
        special_material = false,
        box = {-0.3125, -0.5, -0.375, 0.3125, 0.6875, 0.3125}
    },
}

function furniture.register_for_base(base_node, support_node)
    local base_definition = minetest.registered_nodes[base_node]
    local support_definition = minetest.registered_nodes[support_node]
    for i=1, #furniture.types do
        local sname = string.match(base_node, ':(.*)')
        local supsname = string.match(support_node, ':(.*)')
        local furniture_name = "furniture:" .. furniture.types[i].name .. "_" .. sname .. "_" .. supsname
        local furniture_description = base_definition.description .. " " .. furniture.types[i].description
        local furniture_mesh = furniture.types[i].name .. ".obj"
        local tiles = {base_definition.tiles[1], support_definition.tiles[1]}
        if (furniture.types[i].special_material ~= false) then -- For types that have a mandatory predefined third component
            local special_node = furniture.types[i].special_material
            local special_definition = minetest.registered_nodes[special_node]
            tiles = {base_definition.tiles[1], support_definition.tiles[1], special_definition.tiles[1]}
        end
        local collision_box = {
            type = "fixed",
            fixed = furniture.types[i].box,
        }
        minetest.register_node(furniture_name, {
			description = furniture_description,
			tiles = tiles,
			groups = base_definition.groups,
			drawtype = 'mesh',
            mesh = furniture_mesh,
            collision_box = collision_box,
            selection_box = collision_box,
			use_texture_alpha = base_definition.use_texture_alpha, -- Who cares? Yes.
			paramtype = "light",
            paramtype2 = "facedir",
			sunlight_propagates = true, -- Its a mesh so I am assuming it has a few holes in it
		})
    end
end
--Test nodes
furniture.register_for_base("blocks:stone", "blocks:steelblock")
furniture.register_for_base("blocks:obsidian", "blocks:steelblock")
furniture.register_for_base("blocks:steelblock", "blocks:steelblock")
furniture.register_for_base("blocks:malachite", "blocks:steelblock")
furniture.register_for_base("blocks:granite", "blocks:steelblock")
furniture.register_for_base("blocks:marble", "blocks:steelblock")
furniture.register_for_base("blocks:amethyst", "blocks:ice")
