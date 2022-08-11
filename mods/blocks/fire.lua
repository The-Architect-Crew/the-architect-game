local S = default.get_translator

blocks.fire_types = {
    {"amber", "Amber", "blocks:amber_shard"},
    {"amethyst", "Amethyst", "blocks:amethyst_crystal"},
    {"azure", "Azureshroom", "group:azure"},
    {"diamond", "Diamond", "blocks:diamond"},
    {"fire", "Fireshroom", "group:fire_biome"},
    {"garnet", "Garnet", "blocks:garnet_crystal"},
    {"malachite", "Malachite", "blocks:malachite"},
    {"mese", "Mese", "blocks:mese_crystal"},
    {"moonstone", "Moonstone", "blocks:moonstone_crystal"},
    {"lapis", "Lapis Lazuli", "blocks:lapis_lazuli"}
}

-- Fires

minetest.register_node("blocks:fire", {
    description = S("Fake Fire"),
    tiles = {{
        name = "blocks_fire_animated.png",
        animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0}
    }},
    inventory_image = "blocks_fire.png",
    drawtype = "firelike",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    floodable = true,
    light_source = default.LIGHT_MAX,
    groups = {oddly_breakable_by_hand = 1},
})

minetest.register_node("blocks:campfire", {
    description = S("Campfire"),
    tiles = {{
        name = "blocks_campfire_animated.png",
        animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 2.0}
    },
    {
        name = "blocks_firebranches_animated.png",
        animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0}
    }},
    inventory_image = "blocks_campfire.png",
    drawtype = "mesh",
    mesh = "campfire.obj",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    floodable = true,
    light_source = default.LIGHT_MAX,
    groups = {oddly_breakable_by_hand = 1},
    selection_box = {
        type = "fixed",
        fixed = {-14 / 16, -0.5, -14 / 16, 14 / 16, 16 / 16, 14 / 16},
    },
})

minetest.register_node("blocks:pyre", {
    description = S("Fake Pyre"),
    tiles = {{
        name = "blocks_pyre_animated.png",
        animation = {type = "vertical_frames", aspect_w = 64, aspect_h = 64, length = 2.0}
    }},
    inventory_image = "blocks_pyre.png",
    drawtype = "mesh",
    mesh = "pyre.obj",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    floodable = true,
    light_source = default.LIGHT_MAX,
    groups = {oddly_breakable_by_hand = 1},
    selection_box = {
        type = "fixed",
        fixed = {-20 / 16, -12 / 16, -20 / 16, 20 / 16, 48 / 16, 20 / 16},
    },
})

minetest.register_node("blocks:embers", {
    description = S("Glowing Embers"),
    tiles = {{
        name = "blocks_embers_animated.png",
        animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0}
    }},
    paramtype = "light",
    light_source = 6,
    groups = {oddly_breakable_by_hand = 1},
    sounds = default.node_sound_gravel_defaults()
})

-- Crafts

minetest.register_craft({
	output = "blocks:fire 3",
	recipe = {
		{"blocks:coal_lump", "blocks:coal_lump", "blocks:coal_lump"},
		{"group:stick", "group:stick", "group:stick"},
	}
})

minetest.register_craft({
    output = "blocks:embers",
    recipe = {
        {"blocks:fire"},
        {"group:wood"},
    }
})

minetest.register_craft({
    output = "blocks:campfire",
    recipe = {
        {"blocks:fire", "blocks:fire", "blocks:fire"},
        {"group:stick", "group:stick", "group:stick"},
    }
})

minetest.register_craft({
    output = "blocks:pyre",
    recipe = {
        {"", "blocks:fire", ""},
        {"blocks:fire", "blocks:coal_lump", "blocks:fire"},
        {"blocks:embers", "blocks:embers", "blocks:embers"},
    }
})

-- Colored Fires

for i=1,#blocks.fire_types do
    local name = blocks.fire_types[i][1]
    local fire_description = blocks.fire_types[i][2]
    local craft_material = blocks.fire_types[i][3]
    minetest.register_node("blocks:fire_" .. name, {
        description = S("Fake " .. fire_description .. " Fire"),
        tiles = {{
            name = "blocks_fire_" .. name .. "_animated.png",
            animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0}
        }},
        inventory_image = "blocks_fire_" .. name .. ".png",
        drawtype = "firelike",
        paramtype = "light",
        sunlight_propagates = true,
        walkable = false,
        floodable = true,
        light_source = default.LIGHT_MAX,
        groups = {oddly_breakable_by_hand = 1},
    })

    minetest.register_node("blocks:embers_" .. name, {
        description = S("Glowing " .. fire_description .. " Embers"),
        tiles = {{
            name = "blocks_embers_" .. name .. "_animated.png",
            animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0}
        }},
        paramtype = "light",
        light_source = 6,
        groups = {oddly_breakable_by_hand = 1},
        sounds = default.node_sound_gravel_defaults()
    })

    minetest.register_node("blocks:campfire_" .. name, {
        description = S(fire_description .. " Campfire"),
        tiles = {{
            name = "blocks_campfire_" .. name .. "_animated.png",
            animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 2.0}
        },
        {
            name = "blocks_firebranches_" .. name .. "_animated.png",
            animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0}
        }},
        inventory_image = "blocks_campfire_" .. name .. ".png",
        drawtype = "mesh",
        mesh = "campfire.obj",
        paramtype = "light",
        sunlight_propagates = true,
        walkable = false,
        floodable = true,
        light_source = default.LIGHT_MAX,
        groups = {oddly_breakable_by_hand = 1},
        selection_box = {
            type = "fixed",
            fixed = {-14 / 16, -0.5, -14 / 16, 14 / 16, 16 / 16, 14 / 16},
        },
    })

    minetest.register_node("blocks:pyre_" .. name, {
        description = S("Fake " .. fire_description .. " Pyre"),
        tiles = {{
            name = "blocks_pyre_" .. name .. "_animated.png",
            animation = {type = "vertical_frames", aspect_w = 64, aspect_h = 64, length = 2.0}
        }},
        inventory_image = "blocks_pyre_" .. name .. ".png",
        drawtype = "mesh",
        mesh = "pyre.obj",
        paramtype = "light",
        sunlight_propagates = true,
        walkable = false,
        floodable = true,
        light_source = default.LIGHT_MAX,
        groups = {oddly_breakable_by_hand = 1},
        selection_box = {
            type = "fixed",
            fixed = {-20 / 16, -12 / 16, -20 / 16, 20 / 16, 48 / 16, 20 / 16},
        },
    })

    -- Crafts

    minetest.register_craft({
        output = "blocks:fire_" .. name .. " 3",
        recipe = {
            {craft_material, craft_material, craft_material},
            {"group:stick", "group:stick", "group:stick"},
        }
    })

    minetest.register_craft({
        output = "blocks:embers_" .. name,
        recipe = {
            {"blocks:fire_" .. name},
            {"group:wood"},
        }
    })

    minetest.register_craft({
        output = "blocks:campfire_" .. name,
        recipe = {
            {"blocks:fire_" .. name, "blocks:fire_" .. name, "blocks:fire_" .. name},
            {"group:stick", "group:stick", "group:stick"},
        }
    })

    minetest.register_craft({
        output = "blocks:pyre_" .. name,
        recipe = {
            {"", "blocks:fire_" .. name, ""},
            {"blocks:fire_" .. name, craft_material, "blocks:fire_" .. name},
            {"blocks:embers_" .. name, "blocks:embers_" .. name, "blocks:embers_" .. name},
        }
    })

end