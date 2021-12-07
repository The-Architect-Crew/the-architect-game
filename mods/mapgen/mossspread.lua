--
-- Moss growth on cobble near water
--

local moss_correspondences = {
	["blocks:cobble"] = "blocks:mossycobble",
	["blocks:shapes_cobble_slab"] = "blocks:shapes_mossycobble_slab",
	["blocks:shapes_cobble_stair"] = "blocks:shapes_mossycobble_stair",
	["blocks:shapes_cobble_outerstair"] = "blocks:shapes_mossycobble_outerstair",
	["blocks:shapes_cobble_innerstair"] = "blocks:shapes_mossycobble_innerstair",
	["blocks:shapes_cobble_wall"] = "blocks:shapes_mossycobble_wall",
}
minetest.register_abm({
	label = "Moss growth",
	nodenames = {"blocks:cobble", "blocks:shapes_cobble_slab", "blocks:shapes_cobble_stair",
		"blocks:shapes_cobble_outerstair", "blocks:shapes_cobble_innerstair",
		"blocks:shapes_cobble_wall"},
	neighbors = {"group:water"},
	interval = 16,
	chance = 200,
	catch_up = false,
	action = function(pos, node)
		node.name = moss_correspondences[node.name]
		if node.name then
			minetest.set_node(pos, node)
		end
	end
})