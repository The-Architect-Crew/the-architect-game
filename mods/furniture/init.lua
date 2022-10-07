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
    {
        name = "door",
        description = "Door",
        type = "active",
        activate_sound = {default = "doors_door_open", wood = "doors_door_open", steelblock = "doors_steel_door_open"},
        deactivate_sound = {default = "doors_door_close", wood = "doors_door_close", steelblock = "doors_steel_door_close"},
        special_material = false,
        generate_locked = true,
        box = {-0.5, -0.5, -0.5, 0.5, 1.5, -6/16},
        box_activated = {-0.5, -0.5, -0.5, -6/16, 1.5, 0.5}
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
    "door",
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

-- Don't remember if we did this already somewhere else
furniture.table_copy = function(table)
    local copy = {}
    for table_key, table_value in pairs(table) do
        copy[table_key] = table_value
    end
    return copy
end

function furniture.register(base_node, limit)
    for i=1, #furniture.types do
        local fdef = furniture.types[i]
        if (furniture.table_contains(fdef.name, limit)) then
            if (fdef.type == "active") then
            furniture.generate_active(base_node, i)
            elseif (fdef.type == "storage") then
                furniture.generate_storage(base_node, i)
            else
                furniture.generate_normal(base_node, i)
            end
        end
    end
end

function furniture.pick_special_textures(base_node, fdefid, tiles, furniture_name)
    local fdef = furniture.types[fdefid]
    local special_definition
    local special_sname
    if (type(fdef.special_material) == "table") then -- In case of multiple materials
        local special_tile
        special_sname = string.match(fdef.special_material[1], ':(.*)') -- Take first node as identifier (for now)
        for j=1, #fdef.special_material do
            special_definition = minetest.registered_nodes[fdef.special_material[j]]
            special_tile = special_definition.tiles[1]
            tiles[j + 1] = special_tile -- Since the first tile is base
        end
        return tiles, furniture_name .. "_" .. special_sname
    else
        special_node = fdef.special_material
        special_definition = minetest.registered_nodes[special_node]
        special_sname = string.match(special_node, ':(.*)')
        tiles[2] = special_definition.tiles[1]
        alpha = special_definition.use_texture_alpha
        return  tiles, furniture_name .. "_" .. special_sname
    end
end

function furniture.generate_normal(base_node, fdefid)
    local base_definition = minetest.registered_nodes[base_node]
    local fdef = furniture.types[fdefid]
    local sname = string.match(base_node, ':(.*)')
    local furniture_name = "furniture:" .. fdef.name .. "_" .. sname
    local furniture_description =  base_definition.description .. " " .. fdef.description
    local furniture_mesh = (fdef.base or fdef.name) .. ".obj"
    local tiles = {"variations_" .. sname .. ".png^[sheet:3x3:1,0"}
    local alpha = base_definition.use_texture_alpha
    local sounds = base_definition.sounds
    if (fdef.special_material) then          
        tiles, furniture_name = furniture.pick_special_textures(base_node, fdefid, tiles, furniture_name)
        alpha = "blend" -- Just in case that transparency is needed
    end

    local collision_box = {
        type = "fixed",
        fixed = fdef.box,
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
        sunlight_propagates = true,
        sounds = sounds,
    })
end

function furniture.generate_storage(base_node, fdefid)
end

function furniture.generate_active(base_node, fdefid)
    local fdef = furniture.types[fdefid]
    local base_definition = minetest.registered_nodes[base_node]
    local sname = string.match(base_node, ':(.*)')
    local furniture_name = "furniture:" .. fdef.name .. "_" .. sname
    local furniture_description =  base_definition.description .. " " .. fdef.description
    local furniture_mesh = (fdef.base or fdef.name) .. ".obj"
    local tiles = {"variations_" .. sname .. ".png^[sheet:3x3:1,0"}
    local alpha = base_definition.use_texture_alpha
    local sounds = base_definition.sounds
    local groups_hidden = furniture.table_copy(base_definition.groups)
    groups_hidden.not_in_creative_inventory = 1

    if (fdef.special_material) then           
        tiles, furniture_name = furniture.pick_special_textures(base_node, fdefid, tiles, furniture_name)
        alpha = "blend" -- Just in case that transparency is needed
    end

    local collision_box = {
        type = "fixed",
        fixed = fdef.box,
    }

    local collision_box_activated = {
        type = "fixed",
        fixed = fdef.box_activated,
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
        sunlight_propagates = true,
        sounds = sounds,
        on_rightclick = function(pos, node)
            minetest.swap_node(pos, {name = furniture_name .. "_activated", param2 = node.param2})
            minetest.sound_play(fdef.activate_sound[sname] or fdef.activate_sound.default,
            {pos = pos, max_hear_distance = 10}, true)
        end
    })
    minetest.register_node(furniture_name .. "_activated", {
        description = furniture_description,
        tiles = tiles,
        groups = groups_hidden,
        drawtype = 'mesh',
        mesh = (fdef.base or fdef.name) .. "_activated.obj",
        collision_box = collision_box_activated,
        selection_box = collision_box_activated,
        use_texture_alpha = alpha,
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
        sounds = sounds,
        drop = furniture_name,
        on_rightclick = function(pos, node)
            minetest.swap_node(pos, {name = furniture_name, param2 = node.param2})
            minetest.sound_play(fdef.deactivate_sound[sname] or fdef.deactivate_sound.default,
            {pos = pos, max_hear_distance = 10}, true)
        end
    })
    if fdef.generate_locked == true then
        minetest.register_node(furniture_name .. "_locked", {
            description = "Locked " .. furniture_description,
            tiles = tiles,
            groups = base_definition.groups,
            drawtype = 'mesh',
            mesh = furniture_mesh,
            collision_box = collision_box,
            selection_box = collision_box,
            use_texture_alpha = alpha,
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = true,
            sounds = sounds,
            after_place_node = function(pos, placer)
                local meta = minetest.get_meta(pos)
                local playername = placer:get_player_name()
                meta:set_string("owner", playername)
                meta:set_string("infotext", "Locked " .. furniture_description .. "\nOwned by " .. playername .. ".")
            end,
            on_rightclick = function(pos, node, clicker)
                local meta = minetest.get_meta(pos)
                local owner = meta:get_string("owner")
                local playername = clicker:get_player_name()
                if (playername == owner) then
                    minetest.swap_node(pos, {name = furniture_name .. "_locked_activated", param2 = node.param2})
                    minetest.sound_play(fdef.activate_sound[sname] or fdef.activate_sound.default,
                    {pos = pos, max_hear_distance = 10}, true)
                else
                    minetest.chat_send_player(playername, "This Locked " .. furniture_description .. " is protected by " .. owner .. ".")
                end
            end
        })
        minetest.register_node(furniture_name .. "_locked_activated", {
            description = furniture_description,
            tiles = tiles,
            groups = groups_hidden,
            drawtype = 'mesh',
            mesh = (fdef.base or fdef.name) .. "_activated.obj",
            collision_box = collision_box_activated,
            selection_box = collision_box_activated,
            use_texture_alpha = alpha,
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = true,
            sounds = sounds,
            drop = furniture_name .. "_locked",
            on_rightclick = function(pos, node, clicker)
                local meta = minetest.get_meta(pos)
                local owner = meta:get_string("owner")
                local playername = clicker:get_player_name()
                if (playername == owner) then
                    minetest.swap_node(pos, {name = furniture_name .. "_locked", param2 = node.param2})
                    minetest.sound_play(fdef.deactivate_sound[sname] or fdef.deactivate_sound.default,
                    {pos = pos, max_hear_distance = 10}, true)
                else
                    minetest.chat_send_player(playername, "This Locked " .. furniture_description .. " is protected by " .. owner .. ".")
                end
            end
        })
    end
end

furniture.register("blocks:wood", furniture.woodlike_set)
furniture.register("blocks:steelblock", furniture.woodlike_set)

furniture.register("blocks:basalt", furniture.stonelike_set)
furniture.register("blocks:sandstone", furniture.stonelike_set)
furniture.register("blocks:marble", furniture.stonelike_set)