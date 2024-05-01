
crates:register_storage("crates:barrel", {
	description = "Barrel",
	columns = 4,
	sorting = true,
	portable = true,
	colorlabel = "sign",
	lock_order = {"lock", "protect", "public", "mail"},
	drawtype = "mesh",
	mesh = "crates_barrel.obj",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, loot = 3},
	tiles = {"crates_barrel.png"},
	filled_tiles = {"crates_barrel.png^crates_barrel_filled.png"},
	sunlight_propagates = true,
	use_texture_alpha = "opaque",
	paramtype = "light",
	paramtype2 = "facedir",
	sounds = default.node_sound_wood_defaults(),
})

local barrel_types = {
    { "acacia", "Acacia Wood Barrel", {"crates_acacia_barrel.png"}, {"crates_acacia_barrel.png^crates_barrel_filled.png"} },
    { "aspen", "Aspen Wood Barrel", {"crates_aspen_barrel.png"}, {"crates_aspen_barrel.png^crates_barrel_filled.png"} },
    { "bonewood", "Bonewood Barrel", {"crates_bonewood_barrel.png"}, {"crates_bonewood_barrel.png^crates_barrel_filled.png"} },
    { "firewood", "Firewood Barrel", {"crates_firewood_barrel.png"}, {"crates_firewood_barrel.png^crates_barrel_filled.png"} },
    { "junglewood", "Jungle Wood Barrel", {"crates_junglewood_barrel.png"}, {"crates_junglewood_barrel.png^crates_barrel_filled.png"} },
    { "mushroom_wood", "Azure Mushroom Wood Barrel", {"crates_mushroom_wood_barrel.png"}, {"crates_mushroom_wood_barrel.png^crates_barrel_filled.png"} },
    { "pine_wood", "Pine Wood Barrel", {"crates_pine_barrel.png"}, {"crates_pine_barrel.png^crates_barrel_filled.png"} },
    { "cherry_wood", "Cherry Wood Barrel", {"crates_cherry_barrel.png"}, {"crates_cherry_barrel.png^crates_barrel_filled.png"} },
    { "amber_wood", "Amber Wood Barrel", {"crates_amber_barrel.png"}, {"crates_amber_barrel.png^crates_barrel_filled.png"} },
    { "dark_wood", "Dark Mushroom Wood Barrel", {"crates_darkwood_barrel.png"}, {"crates_darkwood_barrel.png^crates_barrel_filled.png"} },
    { "ghost_wood", "Ghostshroom Wood Barrel", {"crates_ghostwood_barrel.png"}, {"crates_ghostwood_barrel.png^crates_barrel_filled.png"} },
    { "viridis_wood", "Viridis Wood Barrel", {"crates_viridis_barrel.png"}, {"crates_viridis_barrel.png^crates_barrel_filled.png"} },
}

for _, row in ipairs(barrel_types) do
    local barrel_type = row[1]
    local desc = row[2]
    local variant_tiles = row[3]
    local variant_filled_tiles = row[4]

    crates:register_storage("crates:barrel_"..barrel_type, {
        description = desc,
        columns = 4,
        sorting = true,
        portable = true,
        colorlabel = "sign",
        lock_order = {"lock", "protect", "public", "mail"},
        drawtype = "mesh",
        mesh = "crates_barrel.obj",
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

local barrel_crafts = {
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

for _, row in ipairs(barrel_crafts) do
    local craft_name = row[1]
    if (craft_name ~= "") then
        craft_name = "_"..craft_name;
    end
    local craft_item = row[2]
    minetest.register_craft({
        output = "crates:barrel"..craft_name,
        recipe = {
            {craft_item},
            {"crates:chest"},
            {craft_item},
        }
    })
end
