
-- This file alias some legacy inconsistent namings for various blocks
-- Impact is likely very minor and is just for compatibility

local shapes_list = {
    {"slab1"},
    {"slab2"},
    {"slab4"},
    {"slab"},
    {"slab12"},
    {"slab14"},
    {"cube1"},
    {"cube2"},
    {"cube4"},
    {"cube"},
    {"cube12"},
    {"cube14"},
    {"step1"},
    {"step2"},
    {"step4"},
    {"step"},
    {"step12"},
    {"step14"},
    {"corner"},
    {"stair"},
    {"halfstair"},
    {"righthalfstair"},
    {"outerstair"},
    {"innerstair"},
    {"forkstair"},
    {"splitstair1"},
    {"splitstair4"},
    {"splitstair"},
    {"pole"},
    {"wallpole"},
    {"cornerpole"},
    {"pillar"},
    {"wallpillar"},
    {"halfpillar"},
    {"pillarcrown"},
    {"wallpillarcrown"},
    {"halfpillarcrown"},
    {"crosscrown"},
    {"beam"},
    {"crossbeam"},
    {"linkdown"},
    {"sphere"},
    {"slope"},
    {"slope2"},
    {"slope3"},
    {"innerslope"},
    {"innerslope2"},
    {"innerslope3"},
    {"cutinnerslope"},
    {"cutinnerslope2"},
    {"cutinnerslope3"},
    {"outerslope"},
    {"outerslope2"},
    {"outerslope3"},
    {"cutouterslope"},
    {"cutouterslope2"},
    {"cutouterslope3"},
    {"cutouterslope4"},
    {"fence"},
    {"fencerail"},
    {"wall"},
    {"pane_flat"},
    {"pane"},
    {"panemc_flat"},
    {"panemc"},
}

local function register_shapes_alias(oldname, newname)
    for _, row in ipairs(shapes_list) do
        local old_mname = string.match(oldname, '(.*):')
        local old_sname = string.match(oldname, ':(.*)')
        local new_mname = string.match(newname, '(.*):')
        local new_sname = string.match(newname, ':(.*)')

        minetest.register_alias(old_mname..":shapes_"..old_sname.."_"..row[1], new_mname..":shapes_"..new_sname.."_"..row[1])
    end
end

-- stick
minetest.register_alias("blocks:mushroom_stick", "blocks:stick_mushroom")
-- wood
minetest.register_alias("blocks:junglewood", "blocks:wood_jungle")
register_shapes_alias("blocks:junglewood", "blocks:wood_jungle")
minetest.register_alias("blocks:pine_wood", "blocks:wood_pine")
register_shapes_alias("blocks:pine_wood", "blocks:wood_pine")
minetest.register_alias("blocks:acacia_wood", "blocks:wood_acacia")
register_shapes_alias("blocks:acacia_wood", "blocks:wood_acacia")
minetest.register_alias("blocks:aspen_wood", "blocks:wood_aspen")
register_shapes_alias("blocks:aspen_wood", "blocks:wood_aspen")
minetest.register_alias("blocks:cherry_wood", "blocks:wood_cherry")
minetest.register_alias("blocks:bonewood", "blocks:wood_bone")
minetest.register_alias("blocks:firewood", "blocks:wood_fire")
minetest.register_alias("blocks:azure_wood", "blocks:wood_azure")
minetest.register_alias("blocks:amber_wood", "blocks:wood_amber")
minetest.register_alias("blocks:dark_wood", "blocks:wood_dark")
minetest.register_alias("blocks:ghost_wood", "blocks:wood_ghost")
minetest.register_alias("blocks:viridis_wood", "blocks:wood_viridis")
-- tree
minetest.register_alias("flora:tree_bark", "flora:treebark")
register_shapes_alias("flora:tree_bark", "flora:treebark")
minetest.register_alias("flora:jungletree", "flora:tree_jungle")
register_shapes_alias("flora:jungletree", "flora:tree_jungle")
minetest.register_alias("flora:jungletree_bark", "flora:treebark_jungle")
register_shapes_alias("flora:jungletree_bark", "flora:treebark_jungle")
minetest.register_alias("flora:jungleleaves", "flora:leaves_jungle")
minetest.register_alias("flora:junglesapling", "flora:sapling_emergent_jungle")
minetest.register_alias("flora:pine_tree", "flora:tree_pine")
register_shapes_alias("flora:pine_tree", "flora:tree_pine")
minetest.register_alias("flora:pine_tree_bark", "flora:treebark_pine")
register_shapes_alias("flora:pine_tree_bark", "flora:treebark_pine")
minetest.register_alias("flora:pine_needles", "flora:needles_pine")
minetest.register_alias("flora:pine_sapling", "flora:sapling_pine")
minetest.register_alias("flora:pine_sapling_big", "flora:sapling_big_pine")
minetest.register_alias("flora:acacia_tree", "flora:tree_acacia")
register_shapes_alias("flora:acacia_tree", "flora:tree_acacia")
minetest.register_alias("flora:acacia_tree_bark", "flora:treebark_acacia")
register_shapes_alias("flora:acacia_tree_bark", "flora:treebark_acacia")
minetest.register_alias("flora:acacia_leaves", "flora:leaves_acacia")
minetest.register_alias("flora:acacia_sapling", "flora:sapling_acacia")
minetest.register_alias("flora:acacia_sapling_big", "flora:sapling_big_acacia")
minetest.register_alias("flora:aspen_tree", "flora:tree_aspen")
register_shapes_alias("flora:aspen_tree", "flora:tree_aspen")
minetest.register_alias("flora:aspen_tree_bark", "flora:treebark_aspen")
register_shapes_alias("flora:aspen_tree_bark", "flora:treebark_aspen")
minetest.register_alias("flora:aspen_leaves", "flora:leaves_aspen")
minetest.register_alias("flora:aspen_sapling", "flora:sapling_aspen")
minetest.register_alias("flora:aspen_sapling_big", "flora:sapling_big_aspen")
minetest.register_alias("flora:cherry_tree", "flora:tree_cherry")
register_shapes_alias("flora:cherry_tree", "flora:tree_cherry")
minetest.register_alias("flora:cherry_tree_bark", "flora:treebark_cherry")
register_shapes_alias("flora:cherry_tree_bark", "flora:treebark_cherry")
minetest.register_alias("flora:cherry_sapling", "flora:sapling_cherry")
minetest.register_alias("flora:cherry_sapling_big", "flora:sapling_big_cherry")
minetest.register_alias("flora:cherry_leaves", "flora:leaves_cherry")
minetest.register_alias("flora:dry_leaves", "flora:leaves_dry")
minetest.register_alias("flora:bone_tree", "flora:tree_bone")
register_shapes_alias("flora:bone_tree", "flora:tree_bone")
minetest.register_alias("flora:bone_tree_bark", "flora:treebark_bone")
register_shapes_alias("flora:bone_tree_bark", "flora:treebark_bone")
minetest.register_alias("flora:bone_sapling", "flora:sapling_bone")
minetest.register_alias("flora:bone_sapling_big", "flora:sapling_big_bone")
minetest.register_alias("flora:crimson_leaves", "flora:leaves_crimson")
-- bonsai
minetest.register_alias("flora:jungle_tree_bonsai", "flora:bonsai_jungle")
minetest.register_alias("flora:jungle_tree_big_bonsai", "flora:bonsai_big_jungle")
minetest.register_alias("flora:tree_bonsai", "flora:bonsai")
minetest.register_alias("flora:tree_big_bonsai", "flora:bonsai_big")
minetest.register_alias("flora:pine_tree_bonsai", "flora:bonsai_pine")
minetest.register_alias("flora:pine_tree_big_bonsai", "flora:bonsai_big_pine")
minetest.register_alias("flora:acacia_tree_bonsai", "flora:bonsai_acacia")
minetest.register_alias("flora:acacia_tree_big_bonsai", "flora:bonsai_big_acacia")
minetest.register_alias("flora:aspen_tree_bonsai", "flora:bonsai_aspen")
minetest.register_alias("flora:aspen_tree_big_bonsai", "flora:bonsai_big_aspen")
minetest.register_alias("flora:cherry_tree_bonsai", "flora:bonsai_cherry")
minetest.register_alias("flora:cherry_tree_big_bonsai", "flora:bonsai_big_cherry")
minetest.register_alias("flora:bone_tree_bonsai", "flora:bonsai_bone")
minetest.register_alias("flora:bone_tree_big_bonsai", "flora:bonsai_big_bone")
-- shrubbery
minetest.register_alias("flora:acacia_tree_shrubbery", "flora:shrubbery_acacia")
minetest.register_alias("flora:acacia_tree_shrubbery_big", "flora:shrubbery_big_acacia")
minetest.register_alias("flora:acacia_tree_shrubbery_top", "flora:shrubbery_top_acacia")
minetest.register_alias("flora:acacia_tree_shrubbery_tall", "flora:shrubbery_tall_acacia")
minetest.register_alias("flora:aspen_tree_shrubbery", "flora:shrubbery_aspen")
minetest.register_alias("flora:aspen_tree_shrubbery_big", "flora:shrubbery_big_aspen")
minetest.register_alias("flora:aspen_tree_shrubbery_top", "flora:shrubbery_top_aspen")
minetest.register_alias("flora:aspen_tree_shrubbery_tall", "flora:shrubbery_tall_aspen")
minetest.register_alias("flora:bone_tree_shrubbery", "flora:shrubbery_bone")
minetest.register_alias("flora:bone_tree_shrubbery_big", "flora:shrubbery_big_bone")
minetest.register_alias("flora:bone_tree_shrubbery_top", "flora:shrubbery_top_bone")
minetest.register_alias("flora:bone_tree_shrubbery_tall", "flora:shrubbery_tall_bone")
minetest.register_alias("flora:cherry_tree_shrubbery", "flora:shrubbery_cherry")
minetest.register_alias("flora:cherry_tree_shrubbery_big", "flora:shrubbery_big_cherry")
minetest.register_alias("flora:cherry_tree_shrubbery_top", "flora:shrubbery_top_cherry")
minetest.register_alias("flora:cherry_tree_shrubbery_tall", "flora:shrubbery_tall_cherry")
minetest.register_alias("flora:dry_shrubbery", "flora:shrubbery_dry")
minetest.register_alias("flora:dry_shrubbery_big", "flora:shrubbery_big_dry")
minetest.register_alias("flora:dry_shrubbery_top", "flora:shrubbery_top_dry")
minetest.register_alias("flora:dry_shrubbery_tall", "flora:shrubbery_tall_dry")
minetest.register_alias("flora:jungle_tree_shrubbery", "flora:shrubbery_jungle")
minetest.register_alias("flora:jungle_tree_shrubbery_big", "flora:shrubbery_big_jungle")
minetest.register_alias("flora:jungle_tree_shrubbery_top", "flora:shrubbery_top_jungle")
minetest.register_alias("flora:jungle_tree_shrubbery_tall", "flora:shrubbery_tall_jungle")
minetest.register_alias("flora:pine_tree_shrubbery", "flora:shrubbery_pine")
minetest.register_alias("flora:pine_tree_shrubbery_big", "flora:shrubbery_big_pine")
minetest.register_alias("flora:pine_tree_shrubbery_top", "flora:shrubbery_top_pine")
minetest.register_alias("flora:pine_tree_shrubbery_tall", "flora:shrubbery_tall_pine")

minetest.register_alias("variations:stone_brick", "variations:brick_stone")
register_shapes_alias("variations:stone_brick", "variations:brick_stone")
minetest.register_alias("variations:stone_big_tile", "variations:tile_big_stone")
register_shapes_alias("variations:stone_big_tile", "variations:tile_big_stone")
minetest.register_alias("variations:stone_tile", "variations:tile_stone")
register_shapes_alias("variations:stone_tile", "variations:tile_stone")
minetest.register_alias("variations:stone_hexagon", "variations:hexagon_stone")
register_shapes_alias("variations:stone_hexagon", "variations:hexagon_stone")
minetest.register_alias("variations:stone_small_brick", "variations:brick_small_stone")
register_shapes_alias("variations:stone_small_brick", "variations:brick_small_stone")
minetest.register_alias("variations:stone_small_tile", "variations:tile_small_stone")
register_shapes_alias("variations:stone_small_tile", "variations:tile_small_stone")
minetest.register_alias("variations:stone_stripe", "variations:stripe_stone")
register_shapes_alias("variations:stone_stripe", "variations:stripe_stone")
minetest.register_alias("variations:stone_cross_tile", "variations:tile_cross_stone")
register_shapes_alias("variations:stone_cross_tile", "variations:tile_cross_stone")
minetest.register_alias("variations:stone_spiral_tile", "variations:tile_spiral_stone")
register_shapes_alias("variations:stone_spiral_tile", "variations:tile_spiral_stone")

--minetest.register_alias("blocks:oldname", "blocks:newname")