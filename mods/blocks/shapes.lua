-- brick.lua
shapes:register_shapes("blocks:clay")
shapes:register_shapes("blocks:brick", {
	disabled = "pane, fence, pole, wall",
})
-- dirt.lua
shapes:register_shapes("blocks:dirt")
shapes:register_shapes("blocks:dry_dirt")
shapes:register_shapes("blocks:dirt_with_grass", {
	disabled = "splitstair1, splitstair4, pane, fence, pole, wall, pillar, wallpillar, halfpillar, pillarcrown, wallpillarcrown, halfpillarcrown, crossbeam, beam, linkdown, crosslink",
	global_tiles = {"blocks_grass.png"},
	groups = {crumbly = 3},
})
-- glass.lua
shapes:register_shapes("blocks:glass", {
	slab_tiles = {"blocks_glass.png","blocks_glass.png", "shapes_glass.png", "shapes_glass.png", "shapes_glass.png", "shapes_glass.png"},
	cube_tiles = {"shapes_glass_2.png","shapes_glass_2.png^[transformFXR90", "shapes_glass_2.png^[transformFY", "shapes_glass_2.png^[transformFY", "shapes_glass_2.png^[transformFY", "shapes_glass_2.png^[transformFY"},
	step_tiles = {"shapes_glass.png","shapes_glass.png", "shapes_glass_2.png^[transformFY", "shapes_glass_2.png^[transformFY", "shapes_glass.png", "shapes_glass.png"},
	halfstair_tiles = {"shapes_glass_2.png^[transformFXR90","shapes_glass_2.png^[transformFYR90", "shapes_glass_3.png^[transformFX", "shapes_glass_3.png", "shapes_glass_2.png^[transformFXR90", "shapes_glass_2.png^[transformFXR90"},
	stair_tiles = {"shapes_glass.png","blocks_glass.png", "shapes_glass_3.png^[transformFX", "shapes_glass_3.png", "blocks_glass.png", "shapes_glass.png"},
	outerstair_tiles = {"shapes_glass_3.png^[transformFX","blocks_glass.png", "shapes_glass_2.png", "shapes_glass_3.png", "shapes_glass_3.png^[transformFX", "shapes_glass_2.png"},
	innerstair_tiles = {"shapes_glass_3.png^[transformFY","blocks_glass.png", "shapes_glass_3.png^[transformFX", "blocks_glass.png", "blocks_glass.png", "shapes_glass_3.png"},
	pole_tiles = {"shapes_glass_fence_top.png", "shapes_glass_fence_top.png", "shapes_glass_fence.png"},
	pillar_tiles = {"shapes_glass_wall_top.png", "shapes_glass_wall_top.png", "shapes_glass_wall.png"},
	pane_flat_tiles = {"shapes_glass_top.png", "shapes_glass_top.png", "shapes_glass.png^[transformFXR90", "shapes_glass.png^[transformFXR90", "blocks_glass.png"},
	pane_tiles = {"shapes_glass_top.png", "shapes_glass_top.png", "blocks_glass.png"},
	disabled = "fence, wall",
	texture = "blocks_glass.png",
})

shapes:register_shapes("blocks:obsidian_glass", {
	slab_tiles = {"blocks_obsidian_glass.png","blocks_obsidian_glass.png", "shapes_obsidian_glass.png", "shapes_obsidian_glass.png", "shapes_obsidian_glass.png", "shapes_obsidian_glass.png"},
	cube_tiles = {"shapes_obsidian_glass_2.png","shapes_obsidian_glass_2.png^[transformFXR90", "shapes_obsidian_glass_2.png^[transformFY", "shapes_obsidian_glass_2.png^[transformFY", "shapes_obsidian_glass_2.png^[transformFY", "shapes_obsidian_glass_2.png^[transformFY"},
	step_tiles = {"shapes_obsidian_glass.png","shapes_obsidian_glass.png", "shapes_obsidian_glass_2.png^[transformFY", "shapes_obsidian_glass_2.png^[transformFY", "shapes_obsidian_glass.png", "shapes_obsidian_glass.png"},
	halfstair_tiles = {"shapes_obsidian_glass_2.png^[transformFXR90","shapes_obsidian_glass_2.png^[transformFYR90", "shapes_obsidian_glass_3.png^[transformFX", "shapes_obsidian_glass_3.png", "shapes_obsidian_glass_2.png^[transformFXR90", "shapes_obsidian_glass_2.png^[transformFXR90"},
	stair_tiles = {"shapes_obsidian_glass.png","blocks_obsidian_glass.png", "shapes_obsidian_glass_3.png^[transformFX", "shapes_obsidian_glass_3.png", "blocks_obsidian_glass.png", "shapes_obsidian_glass.png"},
	outerstair_tiles = {"shapes_obsidian_glass_3.png^[transformFX","blocks_obsidian_glass.png", "shapes_obsidian_glass_2.png", "shapes_obsidian_glass_3.png", "shapes_obsidian_glass_3.png^[transformFX", "shapes_obsidian_glass_2.png"},
	innerstair_tiles = {"shapes_obsidian_glass_3.png^[transformFY","blocks_obsidian_glass.png", "shapes_obsidian_glass_3.png^[transformFX", "blocks_obsidian_glass.png", "blocks_obsidian_glass.png", "shapes_obsidian_glass_3.png"},
	pole_tiles = {"shapes_obsidian_glass_fence_top.png", "shapes_obsidian_glass_fence_top.png", "shapes_obsidian_glass_fence.png"},
	pillar_tiles = {"shapes_obsidian_glass_wall_top.png", "shapes_obsidian_glass_wall_top.png", "shapes_obsidian_glass_wall.png"},
	pane_flat_tiles = {"shapes_obsidian_glass_top.png", "shapes_obsidian_glass_top.png", "shapes_obsidian_glass.png^[transformFXR90", "shapes_obsidian_glass.png^[transformFXR90", "blocks_obsidian_glass.png"},
	pane_tiles = {"shapes_obsidian_glass_top.png", "shapes_obsidian_glass_top.png", "blocks_obsidian_glass.png"},
	disabled = "fence, wall",
	texture = "blocks_obsidian_glass.png",
})
-- ore.lua
shapes:register_shapes("blocks:steelblock")
shapes:register_shapes("blocks:copperblock")
shapes:register_shapes("blocks:tinblock")
shapes:register_shapes("blocks:bronzeblock")
shapes:register_shapes("blocks:goldblock")
shapes:register_shapes("blocks:diamondblock")
-- plank.lua
shapes:register_shapes("blocks:wood")
shapes:register_shapes("blocks:junglewood")
shapes:register_shapes("blocks:pine_wood")
shapes:register_shapes("blocks:acacia_wood")
shapes:register_shapes("blocks:aspen_wood")
-- sand.lua
shapes:register_shapes("blocks:sand", {
	disabled = "splitstair1, splitstair4, splitstair, pane, fence, pole, wall, pillar, wallpillar, halfpillar, pillarcrown, wallpillarcrown, halfpillarcrown, crossbeam, beam, linkdown, crosslink",
})
shapes:register_shapes("blocks:desert_sand", {
	disabled = "splitstair1, splitstair4, splitstair, pane, fence, pole, wall, pillar, wallpillar, halfpillar, pillarcrown, wallpillarcrown, halfpillarcrown, crossbeam, beam, linkdown, crosslink",
})
shapes:register_shapes("blocks:silver_sand", {
	disabled = "splitstair1, splitstair4, splitstair, pane, fence, pole, wall, pillar, wallpillar, halfpillar, pillarcrown, wallpillarcrown, halfpillarcrown, crossbeam, beam, linkdown, crosslink",
})
shapes:register_shapes("blocks:gravel", {
	disabled = "splitstair1, splitstair4, splitstair, pane, fence, pole, wall, pillar, wallpillar, halfpillar, pillarcrown, wallpillarcrown, halfpillarcrown, crossbeam, beam, linkdown, crosslink",
})
-- snow.lua
shapes:register_shapes("blocks:snowblock", {
	disabled = "splitstair1, splitstair4, splitstair, pane, fence, pole, wall, pillar, wallpillar, halfpillar, pillarcrown, wallpillarcrown, halfpillarcrown, crossbeam, beam, linkdown, crosslink",
})
shapes:register_shapes("blocks:ice")
shapes:register_shapes("blocks:permafrost", {
	disabled = "splitstair1, splitstair4, pane, fence, pole, wall, pillar, wallpillar, halfpillar, pillarcrown, wallpillarcrown, halfpillarcrown, crossbeam, beam, linkdown, crosslink",
})
-- stone.lua
shapes:register_shapes("blocks:stone")
shapes:register_shapes("blocks:cobble")
shapes:register_shapes("blocks:stonebrick")
shapes:register_shapes("blocks:stone_block")
shapes:register_shapes("blocks:mossycobble")
shapes:register_shapes("blocks:desert_stone")
shapes:register_shapes("blocks:desert_cobble")
shapes:register_shapes("blocks:desert_stonebrick")
shapes:register_shapes("blocks:desert_stone_block")
shapes:register_shapes("blocks:sandstone")
shapes:register_shapes("blocks:sandstonebrick")
shapes:register_shapes("blocks:sandstone_block")
shapes:register_shapes("blocks:desert_sandstone")
shapes:register_shapes("blocks:desert_sandstone_brick")
shapes:register_shapes("blocks:desert_sandstone_block")
shapes:register_shapes("blocks:silver_sandstone")
shapes:register_shapes("blocks:silver_sandstone_brick")
shapes:register_shapes("blocks:silver_sandstone_block")
shapes:register_shapes("blocks:obsidian")
shapes:register_shapes("blocks:obsidianbrick")
shapes:register_shapes("blocks:obsidian_block")
-- wool.lua
shapes:register_shapes("blocks:wool_white")
shapes:register_shapes("blocks:wool_grey")
shapes:register_shapes("blocks:wool_dark_grey")
shapes:register_shapes("blocks:wool_black")
shapes:register_shapes("blocks:wool_violet")
shapes:register_shapes("blocks:wool_blue")
shapes:register_shapes("blocks:wool_cyan")
shapes:register_shapes("blocks:wool_dark_green")
shapes:register_shapes("blocks:wool_green")
shapes:register_shapes("blocks:wool_yellow")
shapes:register_shapes("blocks:wool_brown")
shapes:register_shapes("blocks:wool_orange")
shapes:register_shapes("blocks:wool_red")
shapes:register_shapes("blocks:wool_magenta")
shapes:register_shapes("blocks:wool_pink")