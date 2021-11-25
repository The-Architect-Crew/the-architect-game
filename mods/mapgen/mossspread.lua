--
-- Moss growth on cobble near water
--

local moss_correspondences = {
	["blocks:cobble"] = "blocks:mossycobble",
	--["stairs:slab_cobble"] = "stairs:slab_mossycobble",
	--["stairs:stair_cobble"] = "stairs:stair_mossycobble",
	--["stairs:stair_inner_cobble"] = "stairs:stair_inner_mossycobble",
	--["stairs:stair_outer_cobble"] = "stairs:stair_outer_mossycobble",
	--["walls:cobble"] = "walls:mossycobble",
}
minetest.register_abm({
	label = "Moss growth",
	--[[nodenames = {"default:cobble", "stairs:slab_cobble", "stairs:stair_cobble",
		"stairs:stair_inner_cobble", "stairs:stair_outer_cobble",
		"walls:cobble"},]]
	nodenames = { "blocks:cobble" },
	neighbors = { "group:water" },
	interval = 16,
	chance = 200,
	catch_up = false,
	action = function(pos, node)
		node.name = moss_correspondences[node.name]
		if node.name then
			minetest.set_node(pos, node)
		end
	end,
})
