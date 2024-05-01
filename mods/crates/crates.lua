
crates:register_storage("crates:crate", {
    description = "Crate",
    columns = 6, -- 4 * row_slots inventory spaces
    sorting = true, -- enable sorting functions
    portable = true, -- enable portability (Able to be picked up)
    colorlabel = "tag2", -- enable colorlabels (Ability to add little colour labels)
    lock_order = {"lock", "protect", "public", "mail"}, -- order of locking modes
    drawtype = "mesh",
    mesh = "crates_crate.obj",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, loot = 3},
    tiles = {"crates_crate.png"},
    filled_tiles = {"crates_crate.png^crates_crate_filled.png"},
    sunlight_propagates = true,
    use_texture_alpha = "opaque",
    paramtype = "light",
    paramtype2 = "facedir",
    sounds = default.node_sound_wood_defaults(),
})

local crate_types = {
    { "acacia", "Acacia Wood Crate", {"crates_acacia_crate.png"}, {"crates_acacia_crate.png^crates_crate_filled.png"} },
    { "aspen", "Aspen Wood Crate", {"crates_aspen_crate.png"}, {"crates_aspen_crate.png^crates_crate_filled.png"} },
    { "bonewood", "Bonewood Crate", {"crates_bonewood_crate.png"}, {"crates_bonewood_crate.png^crates_crate_filled.png"} },
    { "firewood", "Firewood Crate", {"crates_firewood_crate.png"}, {"crates_firewood_crate.png^crates_crate_filled.png"} },
    { "junglewood", "Jungle Wood Crate", {"crates_junglewood_crate.png"}, {"crates_junglewood_crate.png^crates_crate_filled.png"} },
    { "azure_wood", "Azure Mushroom Wood Crate", {"crates_mushroom_wood_crate.png"}, {"crates_mushroom_wood_crate.png^crates_crate_filled.png"} },
    { "pine_wood", "Pine Wood Crate", {"crates_pine_crate.png"}, {"crates_pine_crate.png^crates_crate_filled.png"} },
    { "cherry_wood", "Cherry Wood Crate", {"crates_cherry_crate.png"}, {"crates_cherry_crate.png^crates_crate_filled.png"} },
    { "amber_wood", "Amber Wood Crate", {"crates_amber_crate.png"}, {"crates_amber_crate.png^crates_crate_filled.png"} },
    { "dark_wood", "Dark Mushroom Wood Crate", {"crates_darkwood_crate.png"}, {"crates_darkwood_crate.png^crates_crate_filled.png"} },
    { "ghost_wood", "Ghostshroom Wood Crate", {"crates_ghostwood_crate.png"}, {"crates_ghostwood_crate.png^crates_crate_filled.png"} },
    { "viridis_wood", "Viridis Wood Crate", {"crates_viridis_crate.png"}, {"crates_viridis_crate.png^crates_crate_filled.png"} },
}

for _, row in ipairs(crate_types) do
    local crate_type = row[1]
    local desc = row[2]
    local variant_tiles = row[3]
    local variant_filled_tiles = row[4]

    crates:register_storage("crates:crate_"..crate_type, {
        description = desc,
        columns = 6, -- 4 * row_slots inventory spaces
        sorting = true, -- enable sorting functions
        portable = true, -- enable portability (Able to be picked up)
        colorlabel = "tag2", -- enable colorlabels (Ability to add little colour labels)
        lock_order = {"lock", "protect", "public", "mail"}, -- order of locking modes
        drawtype = "mesh",
        mesh = "crates_crate.obj",
        groups = {choppy = 2, oddly_breakable_by_hand = 2, loot = 3},
        tiles = variant_tiles,
        filled_tiles = variant_filled_tiles,
        sunlight_propagates = true,
        use_texture_alpha = "opaque",
        paramtype = "light",
        paramtype2 = "facedir",
        sounds = default.node_sound_wood_defaults(),
    })
end

local crate_crafts = {
    { "", "blocks:wood" },
    { "acacia", "blocks:wood_acacia" },
    { "aspen", "blocks:wood_aspen" },
    { "bonewood", "blocks:wood_bone" },
    { "firewood", "blocks:wood_fire" },
    { "junglewood", "blocks:wood_jungle" },
    { "azure_wood", "blocks:wood_azure" },
    { "pine_wood", "blocks:wood_pine" },
    { "cherry_wood", "blocks:wood_cherry" },
    { "amber_wood", "blocks:wood_amber" },
    { "dark_wood", "blocks:wood_dark" },
    { "ghost_wood", "blocks:wood_ghost" },
    { "viridis_wood", "blocks:wood_viridis" }
}

for _, row in ipairs(crate_crafts) do
    local craft_name = row[1]
    if (craft_name ~= "") then
        craft_name = "_"..craft_name;
    end
    local craft_item = row[2]
    minetest.register_craft({
        output = "crates:crate"..craft_name,
        recipe = {
            {craft_item, craft_item, craft_item},
            {craft_item, "crates:chest", craft_item},
            {craft_item, craft_item, craft_item},
        }
    })
end
