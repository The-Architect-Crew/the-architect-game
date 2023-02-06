minetest.register_node("furniture:gas_lamp_test", {
	description = "Gas Lamp",
	tiles = {"variations_steelblock.png^[sheet:3x3:1,0", "blocks_glass.png", {
        name = "blocks_fire_animated.png",
        animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0}
    }},
    drawtype = "mesh",
    light_source = 16,
    paramtype = "light",
    paramtype2 = "facedir",
    mesh = "wall_lamp_gas.obj",
	groups = {cracky = 3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("furniture:gas_lamp_big_test", {
	description = "Big Gas Lamp",
	tiles = {"variations_steelblock.png^[sheet:3x3:1,0", "blocks_glass.png", {
        name = "blocks_fire_animated.png",
        animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0}
    }},
    drawtype = "mesh",
    light_source = 16,
    paramtype = "light",
    paramtype2 = "facedir",
    mesh = "big_lamp_gas.obj",
	groups = {cracky = 3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("furniture:gas_lamp_street_test", {
	description = "Gas Street Lamp",
	tiles = {"variations_steelblock.png^[sheet:3x3:1,0", "blocks_glass.png", {
        name = "blocks_fire_animated.png",
        animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0}
    }},
    drawtype = "mesh",
    light_source = 16,
    paramtype = "light",
    paramtype2 = "facedir",
    mesh = "street_lamp_gas.obj",
	groups = {cracky = 3},
	sounds = default.node_sound_metal_defaults(),
})