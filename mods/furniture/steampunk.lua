local S = default.get_translator

minetest.register_node("furniture:scaffolding_steel", {
	description = S("Steel Scaffolding"),
    drawtype = "mesh",
    mesh = "scaffolding.obj",
	tiles = {{name = "furniture_scaffolding_steel.png", backface_culling = true}},
    paramtype = "light",
    sunlight_propagates = true,
    use_texture_alpha = "clip",
	groups = {cracky = 1, level = 2, loot = 3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("furniture:scaffolding_rust", {
	description = S("Rust Scaffolding"),
    drawtype = "mesh",
    mesh = "scaffolding.obj",
	tiles = {{name = "furniture_scaffolding_rust.png", backface_culling = true}},
    paramtype = "light",
    sunlight_propagates = true,
    use_texture_alpha = "clip",
	groups = {cracky = 1, level = 2, loot = 3},
	sounds = default.node_sound_metal_defaults(),
})

furniture.pipe_sizes = {"small", "large"}
furniture.pipe_types = {"straight", "corner", "t", "x"}
furniture.pipe_crafting = {
    straight_small = {
        {0,0,0,0,0},
        {0,0,0,0,0},
        {1,1,1,1,1},
        {0,0,0,0,0},
        {0,0,0,0,0},
    },
    straight_large = {
        {0,0,0,0,0},
        {1,1,1,1,1},
        {1,1,1,1,1},
        {1,1,1,1,1},
        {0,0,0,0,0},
    },
    corner_small = {
        {0,0,0,0,0},
        {0,0,0,0,0},
        {0,0,1,1,1},
        {0,0,1,0,0},
        {0,0,1,0,0},
    },
    corner_large = {
        {0,0,0,0,0},
        {0,1,1,1,1},
        {0,1,1,1,1},
        {0,1,1,1,1},
        {0,1,1,1,0},
    },
    t_small = {
        {0,0,0,0,0},
        {0,0,0,0,0},
        {1,1,1,1,1},
        {0,0,1,0,0},
        {0,0,1,0,0},
    },
    t_large = {
        {0,0,0,0,0},
        {1,1,1,1,1},
        {1,1,1,1,1},
        {1,1,1,1,1},
        {0,1,1,1,0},
    },
    x_small = {
        {0,0,1,0,0},
        {0,0,1,0,0},
        {1,1,1,1,1},
        {0,0,1,0,0},
        {0,0,1,0,0},
    },
    x_large = {
        {0,1,1,1,0},
        {1,1,1,1,1},
        {1,1,1,1,1},
        {1,1,1,1,1},
        {0,1,1,1,0},
    },
    converter = {
        {0,1,1,1,0},
        {0,1,1,1,0},
        {0,1,1,1,0},
        {0,0,1,0,0},
        {0,0,1,0,0},
    },
    valve_small = {
        {0,0,0,0,0},
        {0,1,1,1,0},
        {0,1,0,1,0},
        {0,1,1,1,0},
        {0,0,0,0,0},
    },
    valve_large = {
        {0,1,1,1,0},
        {1,0,1,0,1},
        {1,1,1,1,1},
        {1,0,1,0,1},
        {0,1,1,1,0},
    }
}

function furniture.register_pipe_recipe(cname, item, material)
    local recipe = {{}, {}, {}, {}, {}}
    for rw=1,5 do
        for cl=1,5 do
            if (furniture.pipe_crafting[cname][rw][cl] == 1) then
                recipe[rw][cl] = item
            else
                recipe[rw][cl] = ""
            end
        end
    end
    if (material) then
        workbench:register_craft({
            type = "furniture",
            output = {
                {"furniture:pipe_" .. cname .. "_" .. material .. " 3"}
            },
            input = recipe,
        })
    else
        workbench:register_craft({
            type = "furniture",
            output = {
                {"furniture:pipe_" .. cname .. " 3"}
            },
            input = recipe,
        })
    end
end

function furniture.register_pipes(cname, sname, craftitem)
    for i=1,#furniture.pipe_sizes do
        for j=1,#furniture.pipe_types do
            local psize = furniture.pipe_sizes[i]
            local ptype = furniture.pipe_types[j]
            minetest.register_node("furniture:pipe_" .. ptype .. "_" .. psize .. "_" .. cname, {
                description = ccore.comment(sname .. " Pipe", "Segment: " .. ptype .. "\nSize: " .. psize),
                drawtype = "mesh",
                mesh = "pipe_" .. ptype .. "_" .. psize .. ".obj",
                tiles = {{name = "furniture_pipe_" .. ptype .. "_" .. cname .. ".png", backface_culling = true},
                    {name = "furniture_pipe_straight_" .. cname .. ".png", backface_culling = true}, -- Sides are always straight
                    {name = "furniture_void.png", backface_culling = true}
                },
                paramtype = "light",
                paramtype2 = "facedir",
                sunlight_propagates = true,
                use_texture_alpha = "clip",
                groups = {cracky = 1, level = 2, loot = 4},
                sounds = default.node_sound_metal_defaults(),
            })
            furniture.register_pipe_recipe(ptype .. "_" .. psize, craftitem, cname)
        end
    end
    -- Size Converter
    minetest.register_node("furniture:pipe_converter_" .. cname, {
        description = ccore.comment(sname .. " Pipe", "Segment: size converter"),
        drawtype = "mesh",
        mesh = "pipe_size_converter.obj",
        tiles = {{name = "furniture_pipe_straight_" .. cname .. ".png", backface_culling = true},
            {name = "furniture_pipe_converter_" .. cname .. ".png", backface_culling = true},
            {name = "furniture_void.png", backface_culling = true}
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        groups = {cracky = 1, level = 2, loot = 4},
        sounds = default.node_sound_metal_defaults(),
    })
    furniture.register_pipe_recipe("converter", craftitem, cname)
    -- Small Valve
    minetest.register_node("furniture:pipe_valve_small_" .. cname, {
        description = ccore.comment(sname .. " Pipe", "Segment: straight\nSize: small\nWith a valve"),
        drawtype = "mesh",
        mesh = "pipe_valve_small.obj",
        tiles = {{name = "furniture_pipe_straight_" .. cname .. ".png", backface_culling = true},
            {name = "furniture_pipe_straight_" .. cname .. ".png", backface_culling = true},
            {name = "furniture_void.png", backface_culling = true},
            {name = "furniture_valve.png", backface_culling = true}
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        groups = {cracky = 1, level = 2, loot = 5},
        sounds = default.node_sound_metal_defaults(),
    })
    furniture.register_pipe_recipe("valve_small", craftitem, cname)
end

-- Large Valve
minetest.register_node("furniture:pipe_valve_large", {
    description = "Large Pipe Valve",
    drawtype = "mesh",
    mesh = "pipe_valve_large.obj",
    tiles = {{name = "furniture_valve.png", backface_culling = true}},
    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    use_texture_alpha = "clip",
    groups = {cracky = 1, level = 2, loot = 5},
    sounds = default.node_sound_metal_defaults(),
})

furniture.register_pipe_recipe("valve_large", "blocks:steel_ingot")

furniture.register_pipes("copper", "Copper", "blocks:copper_ingot")
furniture.register_pipes("steel", "Steel", "blocks:steel_ingot")
furniture.register_pipes("rust", "Rusted", "blocks:rust_ingot")

-- Crafting

minetest.register_craft({
    output = "furniture:scaffolding_steel",
    recipe = {
        {"blocks:steel_stick", "", "blocks:steel_stick"},
        {"", "blocks:steel_stick", ""},
        {"blocks:steel_stick", "", "blocks:steel_stick"},
    }
})

minetest.register_craft({
    output = "furniture:scaffolding_rust",
    recipe = {
        {"blocks:rust_stick", "", "blocks:rust_stick"},
        {"", "blocks:rust_stick", ""},
        {"blocks:rust_stick", "", "blocks:rust_stick"},
    }
})