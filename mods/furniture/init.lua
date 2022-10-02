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
        description = "Square Table",
        special_material = false,
        box = {-0.5, -0.5, -0.5, 0.5, 0.125, 0.5}
    },
    {
        name = "table_round",
        description = "Round Table",
        special_material = false,
        box = {-0.5, -0.5, -0.5, 0.5, 0.125, 0.5}
    },
    {
        name = "cabinet",
        description = "Cabinet",
        special_material = false,
        storage = 4,
        box = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    },
    {
        name = "half_cabinet",
        description = "Half Cabinet",
        special_material = false,
        storage = 2,
        box = {-0.5, -2/16, -0.5, 0.5, 0.5, 0.5}
    },
    {
        name = "wardrobe",
        description = "Wardrobe",
        special_material = false,
        storage = 8,
        box = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5}
    },
    {
        name = "window_glass",
        base = "window",
        description = "Glass Window",
        special_material = "blocks:glass",
        box = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125}
    },
    {
        name = "window_obsidian_glass",
        base = "window",
        description = "Obisdian Glass Window",
        special_material = "blocks:obsidian_glass",
        box = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125}
    },
    {
        name = "window_medieval_glass",
        base = "window",
        description = "Medieval Glass Window",
        special_material = "blocks:medieval_glass",
        box = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125}
    },
    {
        name = "window_amethyst",
        base = "window",
        description = "Amethyst Window",
        special_material = "blocks:amethyst",
        box = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125}
    },
    {
        name = "window_garnet",
        base = "window",
        description = "Garnet Window",
        special_material = "blocks:garnet",
        box = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125}
    },
    {
        name = "window_amber",
        base = "window",
        description = "Amber Glass Window",
        special_material = "blocks:amber_glass",
        box = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125}
    },
    {
        name = "window_amber_medieval",
        base = "window",
        description = "Medieval Amber Glass Window",
        special_material = "blocks:amber_medieval_glass",
        box = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125}
    },
    {
        name = "shelf_small",
        description = "Small Empty Shelf",
        special_material = false,
        storage = 2,
        box = {-0.5, -0.5, -0.0625, 0.5, 0.5, 0.5}
    },
    {
        name = "shelf_wide",
        description = "Wide Empty Shelf",
        special_material = false,
        storage = 4,
        box = {-1.0, -0.5, -0.0625, 1.0, 0.5, 0.5}
    },
    -- Stonelike
    {
        name = "window_glass_thick",
        base = "window_thick",
        description = "Glass Window",
        special_material = "blocks:glass",
        box = {-0.5, -0.5, -0.1875, 0.5, 0.5, 0.1875}
    },
    {
        name = "window_obsidian_glass_thick",
        base = "window_thick",
        description = "Obisidan Glass Window",
        special_material = "blocks:obsidian_glass",
        box = {-0.5, -0.5, -0.1875, 0.5, 0.5, 0.1875}
    },
    {
        name = "window_medieval_glass_thick",
        base = "window_thick",
        description = "Medieval Glass Window",
        special_material = "blocks:medieval_glass",
        box = {-0.5, -0.5, -0.1875, 0.5, 0.5, 0.1875}
    },
    {
        name = "window_amethyst_thick",
        base = "window_thick",
        description = "Amethyst Window",
        special_material = "blocks:amethyst",
        box = {-0.5, -0.5, -0.1875, 0.5, 0.5, 0.1875}
    },
    {
        name = "window_garnet_thick",
        base = "window_thick",
        description = "Garnet Window",
        special_material = "blocks:garnet",
        box = {-0.5, -0.5, -0.1875, 0.5, 0.5, 0.1875}
    },
    {
        name = "window_amber_thick",
        base = "window_thick",
        description = "Amber Glass Window",
        special_material = "blocks:amber_glass",
        box = {-0.5, -0.5, -0.1875, 0.5, 0.5, 0.1875}
    },
    {
        name = "window_amber_medieval_thick",
        base = "window_thick",
        description = "Medieval Amber Glass Window",
        special_material = "blocks:amber_medieval_glass",
        box = {-0.5, -0.5, -0.1875, 0.5, 0.5, 0.1875}
    },
    {
        name = "chair_thick",
        description = "Chair",
        special_material = false,
        box = {-6/16, -0.5, -5/16, 6/16, 0.5, 7/16}
    },
    {
        name = "table_square_thick",
        description = "Square Table",
        special_material = false,
        box = {-0.5, -0.5, -0.5, 0.5, 0.125, 0.5}
    },
    {
        name = "table_round_thick",
        description = "Round Table",
        special_material = false,
        box = {-0.5, -0.5, -0.5, 0.5, 0.125, 0.5}
    },
    {
        name = "shelf_small_thick",
        description = "Small Empty Shelf",
        special_material = false,
        storage = 2,
        box = {-0.5, -0.5, -0.0625, 0.5, 0.5, 0.5}
    },
    {
        name = "shelf_wide_thick",
        description = "Wide Empty Shelf",
        special_material = false,
        storage = 4,
        box = {-1.0, -0.5, -0.0625, 1.0, 0.5, 0.5}
    },
    {
        name = "cabinet_thick",
        description = "Cabinet",
        special_material = false,
        storage = 4,
        box = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    },
    {
        name = "half_cabinet_thick",
        description = "Half Cabinet",
        special_material = false,
        storage = 2,
        box = {-0.5, -2/16, -0.5, 0.5, 0.5, 0.5}
    },
    {
        name = "wardrobe_thick",
        description = "Wardrobe",
        special_material = false,
        storage = 8,
        box = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5}
    },
    {
        name = "mirror",
        description = "Mirror",
        special_material = "blocks:glass_full",
        box = {-4/16, -7/16, 6/16, 4/16, 7/16, 8/16}
    },
    {
        name = "flowerpot",
        description = "Flowerpot",
        special_material = "blocks:dirt",
        box = {-7/16, -8/16, -7/16, 7/16, 8/16, 7/16}
    },
    -- Glasslike
}

furniture.woodlike_set = {
    "chair",
    "table_square",
    "table_round",
    "shelf_small",
    "shelf_wide",
    "window_glass",
    "window_obsidian_glass",
    "window_medieval_glass",
    "window_amethyst",
    "window_garnet",
    "window_amber",
    "window_amber_medieval",
    "cabinet",
    "half_cabinet",
    "wardrobe",
    "mirror",
    "flowerpot",
}

furniture.stonelike_set = {
    "chair_thick",
    "table_square_thick",
    "table_round_thick",
    "shelf_small_thick",
    "shelf_wide_thick",
    "cabinet_thick",
    "half_cabinet_thick",
    "wardrobe_thick",
    "window_glass_thick",
    "window_obsidian_glass_thick",
    "window_medieval_glass_thick",
    "window_amethyst_thick",
    "window_garnet_thick",
    "window_amber_thick",
    "window_amber_medieval_thick",
    "mirror",
    "flowerpot",
}

-- furniture.glasslike_set = {}

-- To be replaced by the core version
furniture.table_contains = function(term, table)
    if (table == nil) then
        return true
    else
        for i=1, #table do
            if (term == table[i]) then
                return true
            end
        end
    end
end

function furniture.register(base_node, limit)
    for i=1, #furniture.types do
        local base_definition = minetest.registered_nodes[base_node]
        if (furniture.table_contains(furniture.types[i].name, limit)) then
            local sname = string.match(base_node, ':(.*)')
            local furniture_name = "furniture:" .. furniture.types[i].name .. "_" .. sname
            local furniture_description =  base_definition.description .. " " .. furniture.types[i].description
            local furniture_mesh = (furniture.types[i].base or furniture.types[i].name) .. ".obj"
            local tiles = {"variations_" .. sname .. ".png"}
            local alpha = base_definition.use_texture_alpha
            if (furniture.types[i].special_material) then           
                local special_definition
                if (type(furniture.types[i].special_material) == "table") then -- In case of multiple materials
                    local special_definition
                    local special_tile
                    for j=1, #furniture.types[i].special_material do
                        special_definition = minetest.registered_nodes[furniture.types[i].special_material[j]]
                        special_tile = special_definition.tiles[1]
                        tiles[j + 1] = special_tile -- Since the first tile is base
                    end
                    alpha = "blend" -- Just in case that transparency is needed
                else
                    special_node = furniture.types[i].special_material
                    special_definition = minetest.registered_nodes[special_node]
                    special_sname = string.match(special_node, ':(.*)')
                    tiles = {"variations_" .. sname .. ".png", special_definition.tiles[1]}
                    alpha = special_definition.use_texture_alpha
                    furniture_name = furniture_name .. "_" .. special_sname
                end
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
                use_texture_alpha = alpha,
                paramtype = "light",
                paramtype2 = "facedir",
                sunlight_propagates = true, -- Its a mesh so I am assuming it has a few holes in it
            })
            --[[
            if (furniture.types[i].storage) then
                crates.register_storage(furniture_name, {
                    description = furniture_description,
                    tiles = tiles,
                    groups = base_definition.groups,
                    drawtype = 'mesh',
                    mesh = furniture_mesh,
                    collision_box = collision_box,
                    selection_box = collision_box,
                    use_texture_alpha = alpha,
                    storage = furniture.types[i].storage * 8,
                    paramtype = "light",
                    paramtype2 = "facedir",
                    sunlight_propagates = true, -- Its a mesh so I am assuming it has a few holes in it
                })
            else
                minetest.register_node(furniture_name, {
                    description = furniture_description,
                    tiles = tiles,
                    groups = base_definition.groups,
                    drawtype = 'mesh',
                    mesh = furniture_mesh,
                    collision_box = collision_box,
                    selection_box = collision_box,
                    use_texture_alpha = alpha,
                    paramtype = "light",
                    paramtype2 = "facedir",
                    sunlight_propagates = true, -- Its a mesh so I am assuming it has a few holes in it
                })
            end]]--
        end
    end
end

furniture.register("blocks:wood", furniture.woodlike_set)
furniture.register("blocks:steelblock", furniture.woodlike_set)

furniture.register("blocks:basalt", furniture.stonelike_set)
furniture.register("blocks:sandstone", furniture.stonelike_set)
furniture.register("blocks:marble", furniture.stonelike_set)