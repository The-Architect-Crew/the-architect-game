local tree_shapes_list = {
    {"tree", "tree"},
    {"tree_jungle", "jungletree"},
    {"tree_pine", "pine_tree"},
    {"tree_acacia", "acacia_tree"},
    {"tree_aspen", "aspen_tree"},
    {"tree_cherry", "cherry_tree"},
    {"tree_bone", "bone_tree"},
}
local treebark_shapes_list = {"treebark", "treebark_jungle", "treebark_pine", "treebark_acacia", "treebark_aspen", "treebark_cherry", "treebark_bone"}

for _, rows in ipairs(tree_shapes_list) do
    local names = rows[1]
    local texnames = rows[2]
	shapes:register_shape("flora:"..names, {
		cube_tiles = {"flora_"..texnames.."_top.png","flora_"..texnames.."_top.png", "shapes_"..texnames.."_2.png", "flora_"..texnames..".png", "flora_"..texnames..".png", "shapes_"..texnames.."_2.png"},
		cube1_tiles = {"flora_"..texnames.."_top.png","flora_"..texnames.."_top.png", "shapes_"..texnames.."_2.png", "flora_"..texnames..".png", "flora_"..texnames..".png", "shapes_"..texnames.."_2.png"},
		cube2_tiles = {"flora_"..texnames.."_top.png","flora_"..texnames.."_top.png", "shapes_"..texnames.."_2.png", "flora_"..texnames..".png", "flora_"..texnames..".png", "shapes_"..texnames.."_2.png"},
		cube4_tiles = {"flora_"..texnames.."_top.png","flora_"..texnames.."_top.png", "shapes_"..texnames.."_2.png", "flora_"..texnames..".png", "flora_"..texnames..".png", "shapes_"..texnames.."_2.png"},
		cube12_tiles = {"flora_"..texnames.."_top.png","flora_"..texnames.."_top.png", "shapes_"..texnames.."_2.png", "flora_"..texnames..".png", "flora_"..texnames..".png", "shapes_"..texnames.."_2.png"},
		cube14_tiles = {"flora_"..texnames.."_top.png","flora_"..texnames.."_top.png", "shapes_"..texnames.."_2.png", "flora_"..texnames..".png", "flora_"..texnames..".png", "shapes_"..texnames.."_2.png"},
		step_tiles = {"flora_"..texnames.."_top.png","flora_"..texnames.."_top.png", "flora_"..texnames..".png", "flora_"..texnames..".png", "flora_"..texnames..".png", "shapes_"..texnames.."_2.png^[transformFY"},
		corner_tiles = {"flora_"..texnames.."_top.png","flora_"..texnames.."_top.png", "shapes_"..texnames.."_3.png^[transformFY]", "flora_"..texnames..".png", "shapes_"..texnames.."_3.png^[transformFYFX", "flora_"..texnames..".png"},
		halfstair_tiles = {"flora_"..texnames.."_top.png","flora_"..texnames.."_top.png", "shapes_"..texnames.."_2.png", "flora_"..texnames..".png", "flora_"..texnames..".png", "shapes_"..texnames..".png"},
		righthalfstair_tiles = {"flora_"..texnames.."_top.png","flora_"..texnames.."_top.png", "flora_"..texnames..".png", "shapes_"..texnames.."_2.png", "flora_"..texnames..".png", "shapes_"..texnames..".png"},
		stair_tiles = {"flora_"..texnames.."_top.png","flora_"..texnames.."_top.png", "flora_"..texnames..".png", "flora_"..texnames..".png", "flora_"..texnames..".png", "shapes_"..texnames..".png"},
		outerstair_tiles = {"flora_"..texnames.."_top.png","flora_"..texnames.."_top.png", "shapes_"..texnames..".png", "flora_"..texnames..".png", "flora_"..texnames..".png", "shapes_"..texnames..".png"},
		innerstair_tiles = {"flora_"..texnames.."_top.png","flora_"..texnames.."_top.png", "shapes_"..texnames.."_3.png^[transformFX", "flora_"..texnames..".png", "flora_"..texnames..".png", "shapes_"..texnames.."_3.png"},
		forkstair_tiles = {"flora_"..texnames.."_top.png","flora_"..texnames.."_top.png", "shapes_"..texnames.."_4.png^[transformFX", "flora_"..texnames..".png", "flora_"..texnames..".png", "shapes_"..texnames.."_4.png"},
		splitstair1_tiles = {"flora_"..texnames.."_top.png","flora_"..texnames.."_top.png", "flora_"..texnames..".png", "flora_"..texnames..".png", "shapes_"..texnames..".png^[transformFY.png", "shapes_"..texnames..".png"},
		splitstair4_tiles = {"flora_"..texnames.."_top.png","flora_"..texnames.."_top.png", "flora_"..texnames..".png", "flora_"..texnames..".png", "shapes_"..texnames..".png^[transformFY.png", "shapes_"..texnames..".png"},
		splitstair_tiles = {"flora_"..texnames.."_top.png","flora_"..texnames.."_top.png", "flora_"..texnames..".png", "flora_"..texnames..".png", "shapes_"..texnames..".png^[transformFY.png", "shapes_"..texnames..".png"},
		pole_tiles = {"shapes_"..texnames.."_fence_top.png", "shapes_"..texnames.."_fence_top.png", "flora_"..texnames..".png"},
		wallpole_tiles = {"shapes_"..texnames.."_fence_top_2.png", "shapes_"..texnames.."_fence_top_2.png^[transformFY", "flora_"..texnames..".png"},
		cornerpole_tiles = {"shapes_"..texnames.."_fence_top_3.png", "shapes_"..texnames.."_fence_top_3.png^[transformFY", "flora_"..texnames..".png"},
		pillar_tiles = {"shapes_"..texnames.."_wall_top.png", "shapes_"..texnames.."_wall_top.png", "flora_"..texnames..".png"},
		wallpillar_tiles = {"shapes_"..texnames.."_wall_top_2.png", "shapes_"..texnames.."_wall_top_2.png^[transformFY", "flora_"..texnames..".png"},
		halfpillar_tiles = {"shapes_"..texnames.."_wall_top_3.png", "shapes_"..texnames.."_wall_top_3.png^[transformFY", "flora_"..texnames..".png"},
		pillarcrown_tiles = {"flora_"..texnames..".png^shapes_"..texnames.."_wall_top.png", "flora_"..texnames..".png"},
		halfpillarcrown_tiles = {"flora_"..texnames..".png^shapes_"..texnames.."_wall_top_3.png", "flora_"..texnames..".png"},
		wallpillarcrown_tiles = {"flora_"..texnames..".png^shapes_"..texnames.."_wall_top_2.png", "flora_"..texnames..".png"},
		crosscrown_tiles = {"flora_"..texnames..".png^shapes_"..texnames.."_wall_top.png", "flora_"..texnames..".png"},
		beam_tiles = {"flora_"..texnames..".png", "flora_"..texnames..".png", "flora_"..texnames..".png^[transformR90", "flora_"..texnames..".png^[transformR90", "shapes_"..texnames.."_wall_top_2.png^[transformFY", "shapes_"..texnames.."_wall_top_2.png^[transformFY"},
		crossbeam_tiles = {"flora_"..texnames..".png", "flora_"..texnames..".png", "flora_"..texnames..".png^[transformR90^shapes_"..texnames.."_wall_top_2.png^[transformFY"},
		linkdown_tiles = {"flora_"..texnames..".png", "flora_"..texnames..".png", "flora_"..texnames..".png^[transformR90", "flora_"..texnames..".png^[transformR90", "flora_"..texnames..".png^shapes_"..texnames.."_wall_top_2.png", "flora_"..texnames..".png^shapes_"..texnames.."_wall_top_2.png"},
		texture = "flora_"..texnames..".png",
		align_style = "node",
		use_texture_alpha = "opaque",
	})
end

for _, names in ipairs(treebark_shapes_list) do
    shapes:register_shape("flora:"..names, {
		disabled = "cat:pole, cat:pillar, cat:pillarcrown, cat:beam, cat:fence",
	})
end