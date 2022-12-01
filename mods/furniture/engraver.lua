-- Registration
minetest.register_node("furniture:engraver", {
	drawtype = "mesh",
	mesh = "engraver.obj",
	tiles = {{name = "variations_wood.png^[sheet:3x3:1,0", backface_culling = true},
    {name = "variations_steelblock.png^[sheet:3x3:1,0", backface_culling = true},
    {name = "furniture_engraver_static.png", backface_culling = true}, {
				name = "furniture_engraver_animated.png",
				animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 20.0,
			}
        }
    },
	description = ccore.comment("Patterns Engraver", "Test"),
    use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand = 2},
	sounds = default.node_sound_wood_defaults(),
})