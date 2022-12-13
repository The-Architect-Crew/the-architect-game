-- Registration
for i=1,#furniture.craftstation_materials do
	local material = furniture.craftstation_materials[i]
	local secondary_tile = {name = "variations_steelblock.png^[sheet:3x3:1,0", backface_culling = true}
	if (type(furniture.craftstation_materials[i]) == "table") then
		material = furniture.craftstation_materials[i][1]
		local secondary_material = furniture.craftstation_materials[i][2]
		local secondary_sname = string.match(secondary_material, ':(.*)')
		secondary_tile = {name = "variations_" .. secondary_sname .. ".png^[sheet:3x3:1,0", backface_culling = true}
	end
	local base_definition = minetest.registered_nodes[material]
	local sname = string.match(material, ':(.*)')
	local description = base_definition.description .. " Patterns Engraver"
	local groups = base_definition.groups
	local sounds = base_definition.sounds
	local box = {-16/16, -8/16, -16/16, 16/16, 20/16, 15/16}
	minetest.register_node("furniture:engraver_" .. sname, {
		drawtype = "mesh",
		mesh = "engraver.obj",
		selection_box = {
			type = "fixed",
			fixed = box,
		},
		collision_box = {
			type = "fixed",
			fixed = box,
		},
		tiles = {{name = "variations_" .. sname .. ".png^[sheet:3x3:1,0", backface_culling = true}, secondary_tile,
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
		description = description,
		use_texture_alpha = "blend",
		paramtype = "light",
		paramtype2 = "facedir",
		groups = groups,
		sounds = sounds,
	})
end