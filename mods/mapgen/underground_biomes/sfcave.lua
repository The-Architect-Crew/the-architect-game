mapgen.sfcave_top = 16
mapgen.sfcave_bottom = mapgen.underground_start + 1

mapgen.sfcave_middle = (mapgen.sfcave_top + mapgen.sfcave_bottom) / 2

mapgen.sfcave_biome_base_nodes = {
	{base = "blocks:dirt", floor = "blocks:dirt_sfcave", ceiling = "blocks:dirt_sfcave_ceiling"},
	{base = "blocks:dry_dirt", floor = "blocks:dry_dirt_sfcave", ceiling = "blocks:dry_dirt_sfcave_ceiling"},
	{base = "blocks:permafrost", floor = "blocks:permafrost_sfcave", ceiling = "blocks:permafrost_sfcave_ceiling"}
}

mapgen.register_sfcave_biomes = function()
end

mapgen.register_sfcave_ores = function()
end

mapgen.register_sfcave_decorations = function()
    mapgen.register_microbiome_base({
        y_min = mapgen.sfcave_bottom,
        y_max = mapgen.sfcave_top,
        noise_params = {
            offset = -1.0,
            scale = 1.0,
            spread = {x = 100, y = 100, z = 100},
            seed = 354,
            octaves = 4,
            persistence = 0.75,
            lacunarity = 4,
            flags = "eased"
        },
        base_nodes = mapgen.sfcave_biome_base_nodes
    })
    mapgen.place_microbiome_flora("moonstone", {
        y_min = mapgen.sfcave_bottom,
        y_max = mapgen.sfcave_top,
        seed = 162,
        surface_nodes = {"blocks:dirt_sfcave", "blocks:dirt_sfcave_ceiling"},
        small_plant_variation = true,
        grass_variation = true,
        grass = "flora:grass",
        small_plant = "flora:moonflower",
        plant_rarity = 0.15,
        grass_rarity = 1,
        vines = "flora:vines",
        vines_height = 8,
        secondary_vines = "flora:vines_moonstone",
        moss = "flora:vines_horizontal",
    })
    mapgen.place_microbiome_flora("moonstone_hot", {
        y_min = mapgen.sfcave_bottom,
        y_max = mapgen.sfcave_top,
        seed = 3444623,
        surface_nodes = {"blocks:dry_dirt_sfcave", "blocks:dry_dirt_sfcave_ceiling"},
        small_plant_variation = true,
        grass_variation = true,
        grass = "flora:dry_grass",
        small_plant = "flora:moonflower_dry",
        plant_rarity = 0.15,
        grass_rarity = 1,
        vines = "flora:vines_dry",
        vines_height = 8,
        secondary_vines = "flora:vines_dry_moonstone",
        moss = "flora:vines_dry_horizontal",
    })
    mapgen.place_microbiome_flora("moonstone_frosty", {
        y_min = mapgen.sfcave_bottom,
        y_max = mapgen.sfcave_top,
        seed = 82253663,
        surface_nodes = {"blocks:permafrost_sfcave", "blocks:permafrost_sfcave_ceiling"},
        small_plant_variation = true,
        grass_variation = true,
        grass = "flora:grass_frosty",
        small_plant = "flora:moonflower_frosty",
        plant_rarity = 0.15,
        grass_rarity = 1,
        vines = "flora:vines_frosty",
        vines_height = 8,
        secondary_vines = "flora:vines_frosty_moonstone",
        moss = "flora:vines_frosty_horizontal",
    })
    minetest.register_decoration({
        name = "sfcave_mossycobble",
        deco_type = "simple",
        place_on = {"blocks:stone"},
        fill_ratio = 10.0,
        y_min = mapgen.sfcave_bottom,
        y_max = mapgen.sfcave_top,
        spawn_by = "blocks:dirt_sfcave",
        num_spawn_by = 1,
        flags = "all_floors, force_placement",
        place_offset_y = -1,
        decoration = "blocks:mossycobble",
    })
end