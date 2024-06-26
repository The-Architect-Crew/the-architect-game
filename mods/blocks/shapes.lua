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
	slab_tiles = {"blocks_glass.png","blocks_glass.png", "shapes_glass.png"},
	slab1_tiles = {"blocks_glass.png","blocks_glass.png", "shapes_glass_top.png"},
	slab2_tiles = {"blocks_glass.png","blocks_glass.png", "shapes_glass_top.png"},
	slab4_tiles = {"blocks_glass.png","blocks_glass.png", "shapes_glass_4.png"},
	slab12_tiles = {"blocks_glass.png","blocks_glass.png", "shapes_glass_12.png"},
	slab14_tiles = {"blocks_glass.png","blocks_glass.png", "shapes_glass_14.png"},
	cube_tiles = {"shapes_glass_2.png","shapes_glass_2.png^[transformFXR90", "shapes_glass_2.png^[transformFY"},
	cube1_tiles = {"shapes_glass_2.png","shapes_glass_2.png^[transformFXR90", "shapes_glass_top.png"},
	cube2_tiles = {"shapes_glass_2.png","shapes_glass_2.png^[transformFXR90", "shapes_glass_top.png"},
	cube4_tiles = {"shapes_glass_2.png","shapes_glass_2.png^[transformFXR90", "shapes_glass_5.png"},
	cube12_tiles = {"shapes_glass_2.png","shapes_glass_2.png^[transformFXR90", "shapes_glass_13.png"},
	cube14_tiles = {"shapes_glass_2.png","shapes_glass_2.png^[transformFXR90", "shapes_glass_15.png"},
	step_tiles = {"shapes_glass.png","shapes_glass.png", "shapes_glass_2.png^[transformFY", "shapes_glass_2.png^[transformFY", "shapes_glass.png", "shapes_glass.png"},
	corner_tiles = {"shapes_glass_3.png","shapes_glass_3.png^[transformFY", "shapes_glass.png"},
	halfstair_tiles = {"shapes_glass_2.png^[transformFXR90","shapes_glass_2.png^[transformFYR90", "shapes_glass_3.png^[transformFX", "shapes_glass_3.png", "shapes_glass_2.png^[transformFXR90", "shapes_glass_2.png^[transformFXR90"},
	righthalfstair_tiles = {"shapes_glass_2.png^[transformFXR90","shapes_glass_2.png^[transformFYR90", "shapes_glass_3.png^[transformFX", "shapes_glass_3.png", "shapes_glass_2.png^[transformFXR90", "shapes_glass_2.png^[transformFXR90"},
	stair_tiles = {"shapes_glass.png","blocks_glass.png", "shapes_glass_3.png^[transformFX", "shapes_glass_3.png", "blocks_glass.png", "shapes_glass.png"},
	outerstair_tiles = {"shapes_glass_3.png^[transformFX","blocks_glass.png", "shapes_glass_2.png", "shapes_glass_3.png", "shapes_glass_3.png^[transformFX", "shapes_glass_2.png"},
	innerstair_tiles = {"shapes_glass_3.png^[transformFY","blocks_glass.png", "shapes_glass_3.png^[transformFX", "blocks_glass.png", "blocks_glass.png", "shapes_glass_3.png"},
	forkstair_tiles = {"shapes_glass_6.png", "shapes_glass_3.png", "shapes_glass_6.png",},
	splitstair1_tiles = {"shapes_glass.png", "shapes_glass.png", "shapes_glass_top.png"},
	splitstair_tiles = {"shapes_glass.png", "shapes_glass.png", "shapes_glass.png"},
	pole_tiles = {"shapes_glass_fence_top.png", "shapes_glass_fence_top.png", "shapes_glass_fence.png"},
	wallpole_tiles = {"shapes_glass_fence_top_2.png", "shapes_glass_fence_top_2.png^[transformFY", "shapes_glass_fence_2.png", "shapes_glass_fence_2.png^[transformFX", "shapes_glass_fence.png", "shapes_glass_fence.png"},
	cornerpole_tiles = {"shapes_glass_fence_top_3.png", "shapes_glass_fence_top_3.png^[transformFY", "shapes_glass_fence_2.png", "shapes_glass_fence_2.png^[transformFX", "shapes_glass_fence_2.png", "shapes_glass_fence_2.png^[transformFX"},
	pillar_tiles = {"shapes_glass_wall_top.png", "shapes_glass_wall_top.png", "shapes_glass_wall.png"},
	wallpillar_tiles = {"shapes_glass_wall_top_2.png", "shapes_glass_wall_top_2.png^[transformFY", "shapes_glass_wall_2.png", "shapes_glass_wall_2.png^[transformFX", "shapes_glass_wall.png", "shapes_glass_wall.png"},
	halfpillar_tiles = {"shapes_glass_wall_top_3.png", "shapes_glass_wall_top_3.png^[transformFY", "shapes_glass_4.png^[transformR90", "shapes_glass_4.png^[transformR90", "shapes_glass_wall.png", "shapes_glass_wall.png"},
	pane_flat_tiles = {"shapes_glass_top.png", "shapes_glass_top.png", "shapes_glass.png^[transformFXR90", "shapes_glass.png^[transformFXR90", "blocks_glass.png"},
	pane_tiles = {"shapes_glass_top.png", "shapes_glass_top.png", "blocks_glass.png"},
	disabled = "fence, fencerail, wall, cat:pillarcrown, cat:beam",
	enabled = "cat:pane",
	texture = "blocks_glass.png",
	align_style = "node",
})

shapes:register_shape("blocks:obsidian_glass", {
	slab_tiles = {"blocks_obsidian_glass.png","blocks_obsidian_glass.png", "shapes_obsidian_glass.png"},
	slab1_tiles = {"blocks_obsidian_glass.png","blocks_obsidian_glass.png", "shapes_obsidian_glass_top.png"},
	slab2_tiles = {"blocks_obsidian_glass.png","blocks_obsidian_glass.png", "shapes_obsidian_glass_top.png"},
	slab4_tiles = {"blocks_obsidian_glass.png","blocks_obsidian_glass.png", "shapes_obsidian_glass_4.png"},
	slab12_tiles = {"blocks_obsidian_glass.png","blocks_obsidian_glass.png", "shapes_obsidian_glass_12.png"},
	slab14_tiles = {"blocks_obsidian_glass.png","blocks_obsidian_glass.png", "shapes_obsidian_glass_14.png"},
	cube_tiles = {"shapes_obsidian_glass_2.png","shapes_obsidian_glass_2.png^[transformFXR90", "shapes_obsidian_glass_2.png^[transformFY"},
	cube1_tiles = {"shapes_obsidian_glass_2.png","shapes_obsidian_glass_2.png^[transformFXR90", "shapes_obsidian_glass_top.png"},
	cube2_tiles = {"shapes_obsidian_glass_2.png","shapes_obsidian_glass_2.png^[transformFXR90", "shapes_obsidian_glass_top.png"},
	cube4_tiles = {"shapes_obsidian_glass_2.png","shapes_obsidian_glass_2.png^[transformFXR90", "shapes_obsidian_glass_5.png"},
	cube12_tiles = {"shapes_obsidian_glass_2.png","shapes_obsidian_glass_2.png^[transformFXR90", "shapes_obsidian_glass_13.png"},
	cube14_tiles = {"shapes_obsidian_glass_2.png","shapes_obsidian_glass_2.png^[transformFXR90", "shapes_obsidian_glass_15.png"},
	step_tiles = {"shapes_obsidian_glass.png","shapes_obsidian_glass.png", "shapes_obsidian_glass_2.png^[transformFY", "shapes_obsidian_glass_2.png^[transformFY", "shapes_obsidian_glass.png", "shapes_obsidian_glass.png"},
	corner_tiles = {"shapes_obsidian_glass_3.png","shapes_obsidian_glass_3.png^[transformFY", "shapes_obsidian_glass.png"},
	halfstair_tiles = {"shapes_obsidian_glass_2.png^[transformFXR90","shapes_obsidian_glass_2.png^[transformFYR90", "shapes_obsidian_glass_3.png^[transformFX", "shapes_obsidian_glass_3.png", "shapes_obsidian_glass_2.png^[transformFXR90", "shapes_obsidian_glass_2.png^[transformFXR90"},
	righthalfstair_tiles = {"shapes_obsidian_glass_2.png^[transformFXR90","shapes_obsidian_glass_2.png^[transformFYR90", "shapes_obsidian_glass_3.png^[transformFX", "shapes_obsidian_glass_3.png", "shapes_obsidian_glass_2.png^[transformFXR90", "shapes_obsidian_glass_2.png^[transformFXR90"},
	stair_tiles = {"shapes_obsidian_glass.png","blocks_obsidian_glass.png", "shapes_obsidian_glass_3.png^[transformFX", "shapes_obsidian_glass_3.png", "blocks_obsidian_glass.png", "shapes_obsidian_glass.png"},
	outerstair_tiles = {"shapes_obsidian_glass_3.png^[transformFX","blocks_obsidian_glass.png", "shapes_obsidian_glass_2.png", "shapes_obsidian_glass_3.png", "shapes_obsidian_glass_3.png^[transformFX", "shapes_obsidian_glass_2.png"},
	innerstair_tiles = {"shapes_obsidian_glass_3.png^[transformFY","blocks_obsidian_glass.png", "shapes_obsidian_glass_3.png^[transformFX", "blocks_obsidian_glass.png", "blocks_obsidian_glass.png", "shapes_obsidian_glass_3.png"},
	forkstair_tiles = {"shapes_obsidian_glass_6.png", "shapes_obsidian_glass_3.png", "shapes_obsidian_glass_6.png",},
	splitstair1_tiles = {"shapes_obsidian_glass.png", "shapes_obsidian_glass.png", "shapes_obsidian_glass_top.png"},
	splitstair_tiles = {"shapes_obsidian_glass.png", "shapes_obsidian_glass.png", "shapes_obsidian_glass.png"},
	pole_tiles = {"shapes_obsidian_glass_fence_top.png", "shapes_obsidian_glass_fence_top.png", "shapes_obsidian_glass_fence.png"},
	wallpole_tiles = {"shapes_obsidian_glass_fence_top_2.png", "shapes_obsidian_glass_fence_top_2.png^[transformFY", "shapes_obsidian_glass_fence_2.png", "shapes_obsidian_glass_fence_2.png^[transformFX", "shapes_obsidian_glass_fence.png", "shapes_obsidian_glass_fence.png"},
	cornerpole_tiles = {"shapes_obsidian_glass_fence_top_3.png", "shapes_obsidian_glass_fence_top_3.png^[transformFY", "shapes_obsidian_glass_fence_2.png", "shapes_obsidian_glass_fence_2.png^[transformFX", "shapes_obsidian_glass_fence_2.png", "shapes_obsidian_glass_fence_2.png^[transformFX"},
	pillar_tiles = {"shapes_obsidian_glass_wall_top.png", "shapes_obsidian_glass_wall_top.png", "shapes_obsidian_glass_wall.png"},
	wallpillar_tiles = {"shapes_obsidian_glass_wall_top_2.png", "shapes_obsidian_glass_wall_top_2.png^[transformFY", "shapes_obsidian_glass_wall_2.png", "shapes_obsidian_glass_wall_2.png^[transformFX", "shapes_obsidian_glass_wall.png", "shapes_obsidian_glass_wall.png"},
	halfpillar_tiles = {"shapes_obsidian_glass_wall_top_3.png", "shapes_obsidian_glass_wall_top_3.png^[transformFY", "shapes_obsidian_glass_4.png^[transformR90", "shapes_obsidian_glass_4.png^[transformR90", "shapes_obsidian_glass_wall.png", "shapes_obsidian_glass_wall.png"},
	pane_flat_tiles = {"shapes_obsidian_glass_top.png", "shapes_obsidian_glass_top.png", "shapes_obsidian_glass.png^[transformFXR90", "shapes_obsidian_glass.png^[transformFXR90", "blocks_obsidian_glass.png"},
	pane_tiles = {"shapes_obsidian_glass_top.png", "shapes_obsidian_glass_top.png", "blocks_obsidian_glass.png"},
	disabled = "fence, fencerail, wall, cat:pillarcrown, cat:beam",
	enabled = "cat:pane",
	texture = "blocks_obsidian_glass.png",
	align_style = "node",
})

shapes:register_shape("blocks:medieval_glass", {
	slab_tiles = {"blocks_medieval_glass.png","blocks_medieval_glass.png", "shapes_medieval_glass.png"},
	slab1_tiles = {"blocks_medieval_glass.png", "blocks_medieval_glass.png", "shapes_medieval_glass_top.png"},
	slab2_tiles = {"blocks_medieval_glass.png", "blocks_medieval_glass.png", "shapes_medieval_glass_top.png"},
	slab4_tiles = {"blocks_medieval_glass.png","blocks_medieval_glass.png", "shapes_medieval_glass_4.png"},
	slab12_tiles = {"blocks_medieval_glass.png","blocks_medieval_glass.png", "shapes_medieval_glass_12.png"},
	slab14_tiles = {"blocks_medieval_glass.png","blocks_medieval_glass.png", "shapes_medieval_glass_14.png"},
	cube_tiles = {"shapes_medieval_glass_2.png","shapes_medieval_glass_2.png^[transformFXR90", "shapes_medieval_glass_2.png^[transformFY"},
	cube1_tiles = {"shapes_medieval_glass_2.png","shapes_medieval_glass_2.png^[transformFXR90", "shapes_medieval_glass_top.png"},
	cube2_tiles = {"shapes_medieval_glass_2.png","shapes_medieval_glass_2.png^[transformFXR90", "shapes_medieval_glass_top.png"},
	cube4_tiles = {"shapes_medieval_glass_2.png","shapes_medieval_glass_2.png^[transformFXR90", "shapes_medieval_glass_5.png"},
	cube12_tiles = {"shapes_medieval_glass_2.png","shapes_medieval_glass_2.png^[transformFXR90", "shapes_medieval_glass_13.png"},
	cube14_tiles = {"shapes_medieval_glass_2.png","shapes_medieval_glass_2.png^[transformFXR90", "shapes_medieval_glass_15.png"},
	step_tiles = {"shapes_medieval_glass.png","shapes_medieval_glass.png", "shapes_medieval_glass_2.png^[transformFY", "shapes_medieval_glass_2.png^[transformFY", "shapes_medieval_glass.png", "shapes_medieval_glass.png"},
	corner_tiles = {"shapes_medieval_glass_3.png","shapes_medieval_glass_3.png^[transformFY", "shapes_medieval_glass.png"},
	halfstair_tiles = {"shapes_medieval_glass_2.png^[transformFXR90","shapes_medieval_glass_2.png^[transformFYR90", "shapes_medieval_glass_3.png^[transformFX", "shapes_medieval_glass_3.png", "shapes_medieval_glass_2.png^[transformFXR90", "shapes_medieval_glass_2.png^[transformFXR90"},
	righthalfstair_tiles = {"shapes_medieval_glass_2.png^[transformFXR90","shapes_medieval_glass_2.png^[transformFYR90", "shapes_medieval_glass_3.png^[transformFX", "shapes_medieval_glass_3.png", "shapes_medieval_glass_2.png^[transformFXR90", "shapes_medieval_glass_2.png^[transformFXR90"},
	stair_tiles = {"shapes_medieval_glass.png","blocks_medieval_glass.png", "shapes_medieval_glass_3.png^[transformFX", "shapes_medieval_glass_3.png", "blocks_medieval_glass.png", "shapes_medieval_glass.png"},
	outerstair_tiles = {"shapes_medieval_glass_3.png^[transformFX","blocks_medieval_glass.png", "shapes_medieval_glass_2.png", "shapes_medieval_glass_3.png", "shapes_medieval_glass_3.png^[transformFX", "shapes_medieval_glass_2.png"},
	innerstair_tiles = {"shapes_medieval_glass_3.png^[transformFY","blocks_medieval_glass.png", "shapes_medieval_glass_3.png^[transformFX", "blocks_medieval_glass.png", "blocks_medieval_glass.png", "shapes_medieval_glass_3.png"},
	forkstair_tiles = {"shapes_medieval_glass_6.png", "shapes_medieval_glass_3.png", "shapes_medieval_glass_6.png",},
	splitstair1_tiles = {"shapes_medieval_glass.png", "shapes_medieval_glass.png", "shapes_medieval_glass_top.png"},
	splitstair_tiles = {"shapes_medieval_glass.png", "shapes_medieval_glass.png", "shapes_medieval_glass.png"},
	pole_tiles = {"shapes_medieval_glass_fence_top.png", "shapes_medieval_glass_fence_top.png", "shapes_medieval_glass_fence.png"},
	wallpole_tiles = {"shapes_medieval_glass_fence_top_2.png", "shapes_medieval_glass_fence_top_2.png^[transformFY", "shapes_medieval_glass_fence_2.png", "shapes_medieval_glass_fence_2.png^[transformFX", "shapes_medieval_glass_fence.png", "shapes_medieval_glass_fence.png"},
	cornerpole_tiles = {"shapes_medieval_glass_fence_top_3.png", "shapes_medieval_glass_fence_top_3.png^[transformFY", "shapes_medieval_glass_fence_2.png", "shapes_medieval_glass_fence_2.png^[transformFX", "shapes_medieval_glass_fence_2.png", "shapes_medieval_glass_fence_2.png^[transformFX"},
	pillar_tiles = {"shapes_medieval_glass_wall_top.png", "shapes_medieval_glass_wall_top.png", "shapes_medieval_glass_wall.png"},
	wallpillar_tiles = {"shapes_medieval_glass_wall_top_2.png", "shapes_medieval_glass_wall_top_2.png^[transformFY", "shapes_medieval_glass_wall_2.png", "shapes_medieval_glass_wall_2.png^[transformFX", "shapes_medieval_glass_wall.png", "shapes_medieval_glass_wall.png"},
	halfpillar_tiles = {"shapes_medieval_glass_wall_top_3.png", "shapes_medieval_glass_wall_top_3.png^[transformFY", "shapes_medieval_glass_4.png^[transformR90", "shapes_medieval_glass_4.png^[transformR90", "shapes_medieval_glass_wall.png", "shapes_medieval_glass_wall.png"},
	pane_flat_tiles = {"shapes_medieval_glass_top.png", "shapes_medieval_glass_top.png", "shapes_medieval_glass.png^[transformFXR90", "shapes_medieval_glass.png^[transformFXR90", "blocks_medieval_glass.png"},
	pane_tiles = {"shapes_medieval_glass_top.png", "shapes_medieval_glass_top.png", "blocks_medieval_glass.png"},
	disabled = "fence, fencerail, wall, cat:pillarcrown, cat:beam",
	enabled = "cat:pane",
	texture = "blocks_medieval_glass.png",
	align_style = "node",
})
-- bars.lua
shapes:register_shape("blocks:wood_bars", {
	enabled = "cat:panemc, slab1, slab",
	panemc_tiles = {"shapes_wood_bars_top.png", "blocks_wood_bars.png", "blocks_wood_bars.png"},
	panemc_flat_tiles = {"shapes_wood_bars_top.png", "blocks_wood_bars.png", "blocks_wood_bars.png"},
	texture = "blocks_wood_bars.png",
})

shapes:register_shape("blocks:wood_grille", {
	enabled = "cat:pane, slab1, slab",
	pane_flat_tiles = {"shapes_wood_bars_top.png", "shapes_wood_bars_top.png", "blocks_wood_grille.png"},
	pane_tiles = {"shapes_wood_bars_top.png", "shapes_wood_bars_top.png", "blocks_wood_grille.png",},
	texture = "blocks_wood_grille.png",
})

shapes:register_shape("blocks:steel_bars", {
	enabled = "cat:panemc, slab1, slab",
	panemc_tiles = {"shapes_steel_bars_top.png", "blocks_steel_bars.png", "blocks_steel_bars.png"},
	panemc_flat_tiles = {"shapes_steel_bars_top.png", "blocks_steel_bars.png", "blocks_steel_bars.png"},
	texture = "blocks_steel_bars.png",
})

shapes:register_shape("blocks:steel_grille", {
	enabled = "cat:pane, slab1, slab",
	pane_flat_tiles = {"shapes_steel_bars_top.png", "shapes_steel_bars_top.png", "blocks_steel_grille.png"},
	pane_tiles = {"shapes_steel_bars_top.png", "shapes_steel_bars_top.png", "blocks_steel_grille.png",},
	texture = "blocks_steel_grille.png",
})
-- ore.luablocks_gravel
shapes:register_shape("blocks:steelblock")
shapes:register_shape("blocks:copperblock")
shapes:register_shape("blocks:tinblock")
shapes:register_shape("blocks:bronzeblock")
shapes:register_shape("blocks:goldblock")
shapes:register_shape("blocks:diamondblock")
shapes:register_shape("blocks:mithrilblock")
shapes:register_shape("blocks:amber")
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
shapes:register_shape("blocks:mineral_salt")
shapes:register_shape("blocks:mineral_salt_cobble")
-- plank.lua
shapes:register_shape("blocks:wood", {groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},})
shapes:register_shape("blocks:wood_jungle", {groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},})
shapes:register_shape("blocks:wood_pine", {groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},})
shapes:register_shape("blocks:wood_acacia", {groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},})
shapes:register_shape("blocks:wood_aspen", {groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},})
shapes:register_shape("blocks:wood_cherry", {groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},})
shapes:register_shape("blocks:wood_bone", {groups = {choppy = 3, oddly_breakable_by_hand = 2},})
shapes:register_shape("blocks:wood_azure", {groups = {choppy = 3, oddly_breakable_by_hand = 2},})
shapes:register_shape("blocks:wood_amber", {groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},})
shapes:register_shape("blocks:wood_dark", {groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},})
shapes:register_shape("blocks:wood_ghost", {groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},})
shapes:register_shape("blocks:wood_viridis", {groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},})
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
shapes:register_shape("blocks:stone", {groups = {cracky = 3},})
shapes:register_shape("blocks:cobble", {groups = {cracky = 3},})
shapes:register_shape("blocks:mossycobble", {groups = {cracky = 3},})
shapes:register_shape("blocks:desert_stone", {groups = {cracky = 3},})
shapes:register_shape("blocks:desert_cobble", {groups = {cracky = 3},})
shapes:register_shape("blocks:sandstone")
shapes:register_shape("blocks:desert_sandstone")
shapes:register_shape("blocks:silver_sandstone")
shapes:register_shape("blocks:obsidian")
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
-- streets.lua
shapes:register_shape("blocks:asphalt")
shapes:register_shape("blocks:asphalt_line", "cat:splitstair, cat:pane, cat:fence, cat:pole, cat:pillar, cat:pillarcrown, cat:beam")
shapes:register_shape("blocks:asphalt_dashed_line", "cat:splitstair, cat:pane, cat:fence, cat:pole, cat:pillar, cat:pillarcrown, cat:beam")
shapes:register_shape("blocks:concrete")