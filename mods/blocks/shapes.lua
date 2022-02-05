-- brick.lua
shapes:register_shape("blocks:clay")
shapes:register_shape("blocks:brick", "cat:pane, cat:fence, cat:pole, wall")
-- dirt.lua
shapes:register_shape("blocks:dirt")
shapes:register_shape("blocks:dry_dirt")
shapes:register_shape("blocks:dirt_with_grass", {
	description_prefix = "Grass",
	disabled = "cat:splitstair, cat:pane, cat:fence, cat:pole, cat:pillar, cat:pillarcrown, cat:beam",
	global_tiles = {"blocks_grass.png"},
	groups = {crumbly = 3},
})
-- glass.lua
shapes:register_shape("blocks:glass", {
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

shapes:register_shape("blocks:obsidian_glass", {
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

shapes:register_shape("blocks:medieval_glass", {
	slab_tiles = {"blocks_medieval_glass.png","blocks_medieval_glass.png", "shapes_medieval_glass.png", "shapes_medieval_glass.png", "shapes_medieval_glass.png", "shapes_medieval_glass.png"},
	cube_tiles = {"shapes_medieval_glass_2.png","shapes_medieval_glass_2.png^[transformFXR90", "shapes_medieval_glass_2.png^[transformFY", "shapes_medieval_glass_2.png^[transformFY", "shapes_medieval_glass_2.png^[transformFY", "shapes_medieval_glass_2.png^[transformFY"},
	step_tiles = {"shapes_medieval_glass.png","shapes_medieval_glass.png", "shapes_medieval_glass_2.png^[transformFY", "shapes_medieval_glass_2.png^[transformFY", "shapes_medieval_glass.png", "shapes_medieval_glass.png"},
	halfstair_tiles = {"shapes_medieval_glass_2.png^[transformFXR90","shapes_medieval_glass_2.png^[transformFYR90", "shapes_medieval_glass_3.png^[transformFX", "shapes_medieval_glass_3.png", "shapes_medieval_glass_2.png^[transformFXR90", "shapes_medieval_glass_2.png^[transformFXR90"},
	stair_tiles = {"shapes_medieval_glass.png","blocks_medieval_glass.png", "shapes_medieval_glass_3.png^[transformFX", "shapes_medieval_glass_3.png", "blocks_medieval_glass.png", "shapes_medieval_glass.png"},
	outerstair_tiles = {"shapes_medieval_glass_3.png^[transformFX","blocks_medieval_glass.png", "shapes_medieval_glass_2.png", "shapes_medieval_glass_3.png", "shapes_medieval_glass_3.png^[transformFX", "shapes_medieval_glass_2.png"},
	innerstair_tiles = {"shapes_medieval_glass_3.png^[transformFY","blocks_medieval_glass.png", "shapes_medieval_glass_3.png^[transformFX", "blocks_medieval_glass.png", "blocks_medieval_glass.png", "shapes_medieval_glass_3.png"},
	pole_tiles = {"shapes_medieval_glass_fence_top.png", "shapes_medieval_glass_fence_top.png", "shapes_medieval_glass_fence.png"},
	pillar_tiles = {"shapes_medieval_glass_wall_top.png", "shapes_medieval_glass_wall_top.png", "shapes_medieval_glass_wall.png"},
	pane_flat_tiles = {"shapes_medieval_glass_top.png", "shapes_medieval_glass_top.png", "shapes_medieval_glass.png^[transformFXR90", "shapes_medieval_glass.png^[transformFXR90", "blocks_medieval_glass.png"},
	pane_tiles = {"shapes_medieval_glass_top.png", "shapes_medieval_glass_top.png", "blocks_medieval_glass.png"},
	disabled = "fence, wall",
	texture = "blocks_medieval_glass.png",
})
-- ore.lua
shapes:register_shape("blocks:steelblock")
shapes:register_shape("blocks:copperblock")
shapes:register_shape("blocks:tinblock")
shapes:register_shape("blocks:bronzeblock")
shapes:register_shape("blocks:goldblock")
shapes:register_shape("blocks:diamondblock")
shapes:register_shape("blocks:amethyst")
shapes:register_shape("blocks:garnet")
shapes:register_shape("blocks:lapis_lazuli")
shapes:register_shape("blocks:turquoise")
shapes:register_shape("blocks:malachite")
shapes:register_shape("blocks:basalt")
shapes:register_shape("blocks:basalt_cobble")
shapes:register_shape("blocks:chalk")
shapes:register_shape("blocks:granite")
shapes:register_shape("blocks:marble")
shapes:register_shape("blocks:mud")
shapes:register_shape("blocks:porphyry")
shapes:register_shape("blocks:serpentine")
shapes:register_shape("blocks:slate")
shapes:register_shape("blocks:slate_cobble")
-- plank.lua
shapes:register_shape("blocks:wood")
shapes:register_shape("blocks:junglewood")
shapes:register_shape("blocks:pine_wood")
shapes:register_shape("blocks:acacia_wood")
shapes:register_shape("blocks:aspen_wood")
-- sand.lua
shapes:register_shape("blocks:sand", "cat:splitstair, cat:pane, cat:fence, cat:pole, cat:pillar, cat:pillarcrown, cat:beam")
shapes:register_shape("blocks:desert_sand", "cat:splitstair, cat:pane, cat:fence, cat:pole, cat:pillar, cat:pillarcrown, cat:beam")
shapes:register_shape("blocks:silver_sand", "cat:splitstair, cat:pane, cat:fence, cat:pole, cat:pillar, cat:pillarcrown, cat:beam")
shapes:register_shape("blocks:gravel", "cat:splitstair, cat:pane, cat:fence, cat:pole, cat:pillar, cat:pillarcrown, cat:beam")
-- snow.lua
shapes:register_shape("blocks:snowblock", "cat:splitstair, cat:pane, cat:fence, cat:pole, cat:pillar, cat:pillarcrown, cat:beam")
shapes:register_shape("blocks:ice")
shapes:register_shape("blocks:permafrost", "cat:splitstair, cat:pane, cat:fence, cat:pole, cat:pillar, cat:pillarcrown, cat:beam")
-- stone.lua
shapes:register_shape("blocks:stone")
shapes:register_shape("blocks:cobble")
shapes:register_shape("blocks:stonebrick")
shapes:register_shape("blocks:stone_block")
shapes:register_shape("blocks:mossycobble")
shapes:register_shape("blocks:desert_stone")
shapes:register_shape("blocks:desert_cobble")
shapes:register_shape("blocks:desert_stonebrick")
shapes:register_shape("blocks:desert_stone_block")
shapes:register_shape("blocks:sandstone")
shapes:register_shape("blocks:sandstonebrick")
shapes:register_shape("blocks:sandstone_block")
shapes:register_shape("blocks:desert_sandstone")
shapes:register_shape("blocks:desert_sandstone_brick")
shapes:register_shape("blocks:desert_sandstone_block")
shapes:register_shape("blocks:silver_sandstone")
shapes:register_shape("blocks:silver_sandstone_brick")
shapes:register_shape("blocks:silver_sandstone_block")
shapes:register_shape("blocks:obsidian")
shapes:register_shape("blocks:obsidianbrick")
shapes:register_shape("blocks:obsidian_block")
for _, color in ipairs(blocks.stone_colors) do
	shapes:register_shape("blocks:stone_" .. color[1])
end
-- wool.lua
shapes:register_shape("blocks:wool_white")
shapes:register_shape("blocks:wool_grey")
shapes:register_shape("blocks:wool_dark_grey")
shapes:register_shape("blocks:wool_black")
shapes:register_shape("blocks:wool_violet")
shapes:register_shape("blocks:wool_blue")
shapes:register_shape("blocks:wool_cyan")
shapes:register_shape("blocks:wool_dark_green")
shapes:register_shape("blocks:wool_green")
shapes:register_shape("blocks:wool_yellow")
shapes:register_shape("blocks:wool_brown")
shapes:register_shape("blocks:wool_orange")
shapes:register_shape("blocks:wool_red")
shapes:register_shape("blocks:wool_magenta")
shapes:register_shape("blocks:wool_pink")
