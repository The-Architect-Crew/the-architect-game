-- Based on worldedit markers (probably identical)
minetest.register_entity("protection:pos", {
    initial_properties = {
        visual = "cube",
        textures = {
            "protection_marker.png^[opacity:128", "protection_marker.png^[opacity:128", "protection_marker.png^[opacity:128",
            "protection_marker.png^[opacity:128", "protection_marker.png^[opacity:128", "protection_marker.png^[opacity:128"
        },
        visual_size = {x = 1.1, y = 1.1},
        use_texture_alpha = true,
        glow = -1,
        collisionbox = {-0.55, -0.55, -0.55, 0.55, 0.55, 0.55},
		physical = false,
		static_save = false,
        pointable = false,
    },
    on_punch = function(self, hitter)
        if hitter:get_player_name() == self.player_name then
            protection.protector.remove_grid(self.player_name)
        else
            minetest.chat_send_player(hitter:get_player_name(), "Only the protector owner can remove this grid")
        end
    end
})

minetest.register_entity("protection:protector_edge", {
    initial_properties = {
        visual = "upright_sprite",
		textures = {"protection_protector_edge.png^[opacity:64"},
		visual_size = {x=1, y=1},
        use_texture_alpha = true,
        glow = -1,
		physical = false,
		static_save = false,
        pointable = false,
    },
    on_punch = function(self, hitter)
        if hitter:get_player_name() == self.player_name then
            protection.protector.remove_grid(self.player_name)
        else
            minetest.chat_send_player(hitter:get_player_name(), "Only the protector owner can remove this grid")
        end
    end
})

minetest.register_entity("protection:edge", {
    initial_properties = {
        visual = "upright_sprite",
		textures = {"protection_edge.png^[opacity:64"},
		visual_size = {x=1, y=1},
        use_texture_alpha = true,
        glow = -1,
		physical = false,
		static_save = false,
        pointable = false,
    }
})