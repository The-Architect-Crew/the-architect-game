furniture = {}

furniture.types = {
    {
        name = "chair",
        description = "Chair",
        special_material = false,
        box = {-0.3125, -0.5, -0.375, 0.3125, 0.6875, 0.3125}
    },
    {
        name = "table_square",
        description = "Table",
        special_material = false,
        box = {-0.5, -0.5, -0.5, 0.5, 0.125, 0.5}
    },
    {
        name = "table_round",
        description = "Table",
        special_material = false,
        box = {-0.5, -0.5, -0.5, 0.5, 0.125, 0.5}
    },
    {
        name = "window",
        description = "Window",
        special_material = false,
        box = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125}
    },
    {
        name = "window_plain",
        description = "Window",
        special_material = false,
        box = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125}
    },
    {
        name = "shelf_small",
        description = "Empty Shelf",
        special_material = false,
        box = {-0.5, -0.5, -0.0625, 0.5, 0.5, 0.5}
    },
    {
        name = "shelf_medium",
        description = "Empty Shelf",
        special_material = false,
        box = {-0.5, -0.5, -0.0625, 0.5, 1.5, 0.5}
    },
    {
        name = "shelf_big",
        description = "Empty Shelf",
        special_material = false,
        box = {-1.0, -0.5, -0.0625, 1.0, 1.5, 0.5}
    },
    {
        name = "shelf_wide",
        description = "Empty Shelf",
        special_material = false,
        box = {-1.0, -0.5, -0.0625, 1.0, 0.5, 0.5}
    },
    {
        name = "flowerpot_small",
        description = "Flowerpot",
        special_material = "blocks:dirt",
        box = {-0.5625, -0.5, -0.5625, 0.5625, 0.5, 0.5625}
    },
}

function furniture.register_for_base(base_node, support_node, limit)

    local base_definition = minetest.registered_nodes[base_node]
    local support_definition = minetest.registered_nodes[support_node]
    for i=1, #furniture.types do
        if (furniture.check_limit(furniture.types[i].name, limit)) then
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
        else
        end
    end
end

furniture.check_limit = function(term, table)
    local state = false
    if (table == nil) then
        state = true
    else
        for i=1, #table do
            if (term == table[i]) then
                state = true
            else
            end
        end
    end
    return state
end

furniture.generate_set = function(materials, set)
    for i=1, #materials do
        furniture.register_for_base(materials[i][1], materials[i][2], set)
    end
end

furniture.basic_set = {
    "chair",
    "table_square",
    "table_round",
    "shelf_small",
    "shelf_medium",
    "shelf_big",
    "shelf_wide",
    "flowerpot_small",
}
furniture.basic_combinations = {
    {"blocks:stone", "blocks:wood"},
    {"blocks:steelblock", "blocks:steelblock"},
    {"blocks:stone", "blocks:basalt"},
    {"blocks:basalt", "blocks:goldblock"},
    {"blocks:amethyst", "blocks:ice"},
}

furniture.generate_set(furniture.basic_combinations, furniture.basic_set)
