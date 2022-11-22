local S = default.get_translator

minetest.register_node("furniture:gear_big_steel", {
	description = S("Big Steel Gear"),
    drawtype = "mesh",
	tiles = {{
        name = "furniture_gear_steel_big.png",
        animation = {type = "vertical_frames", aspect_w = 128, aspect_h = 128, length = 4.0}
    },
    {
        name = "furniture_gear_steel_big_inner.png",
        animation = {type = "vertical_frames", aspect_w = 128, aspect_h = 128, length = 4.0}
    }},
    mesh = "gear.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    light_source = 1,
	groups = {cracky = 1, level = 2, dig_immediate = 3}, -- dig_immediate cause drawing a crack animation on a texture of this size is extremely resource-intensive
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("furniture:gear_big_rust", {
	description = S("Big Rust Gear"),
    drawtype = "mesh",
	tiles = {{
        name = "furniture_gear_rust_big.png",
        animation = {type = "vertical_frames", aspect_w = 128, aspect_h = 128, length = 4.0}
    },
    {
        name = "furniture_gear_rust_big_inner.png",
        animation = {type = "vertical_frames", aspect_w = 128, aspect_h = 128, length = 4.0}
    }},
    mesh = "gear.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    light_source = 1,
	groups = {cracky = 1, level = 2, dig_immediate = 3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("furniture:scaffolding_steel", {
	description = S("Steel Scaffolding"),
    drawtype = "mesh",
    mesh = "scaffolding.obj",
	tiles = {{name = "furniture_scaffolding_steel.png", backface_culling = true}},
    paramtype = "light",
    sunlight_propagates = true,
    use_texture_alpha = "clip",
	groups = {cracky = 1, level = 2},
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
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})