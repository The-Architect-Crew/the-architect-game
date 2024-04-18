
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
















minetest.register_alias("blocks:oldname", "blocks:newname")
