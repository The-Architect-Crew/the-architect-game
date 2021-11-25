-- == Unutilized code

--
-- Lavacooling
--

default.cool_lava = function(pos, node)
	if node.name == "default:lava_source" then
		minetest.set_node(pos, { name = "default:obsidian" })
	else -- Lava flowing
		minetest.set_node(pos, { name = "default:stone" })
	end
	minetest.sound_play("default_cool_lava", { pos = pos, max_hear_distance = 16, gain = 0.25 }, true)
end

if minetest.settings:get_bool("enable_lavacooling") ~= false then
	minetest.register_abm({
		label = "Lava cooling",
		nodenames = { "default:lava_source", "default:lava_flowing" },
		neighbors = { "group:cools_lava", "group:water" },
		interval = 2,
		chance = 2,
		catch_up = false,
		action = function(...)
			default.cool_lava(...)
		end,
	})
end

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_aspen_wood",
	burntime = 5,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_pine_wood",
	burntime = 6,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_wood",
	burntime = 7,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_acacia_wood",
	burntime = 8,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_junglewood",
	burntime = 9,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_rail_aspen_wood",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_rail_pine_wood",
	burntime = 4,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_rail_wood",
	burntime = 5,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_rail_acacia_wood",
	burntime = 6,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_rail_junglewood",
	burntime = 7,
})
