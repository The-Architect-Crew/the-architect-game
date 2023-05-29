--[[
mapgen.register_microbiome_decorations("fire", {
	height_min = mapgen.underground_limit,
	height_max = mapgen.underground_start,
	seed = 262,
	base_node = {"blocks:cobble"}, -- surface_node matches the base_node, they also have to be the same length
	surface_node = {"blocks:cobble_firemoss"},
	surface_coverage = 1.95,
	grass_node = "flora:firegrass",
	main_small_plant = "flora:fireshroom",
	--secondary_small_plant
	plant_rarity = 0.1,
	grass_rarity = 1,
	main_large_plant = "flora:fireplant",
	secondary_large_plant = "blocks:garnet",
	main_vines = "flora:firevines",
	--secondary_vines
	moss = "flora:firemoss",
})

mapgen.register_microbiome_decorations("azure", {
	height_min = mapgen.underground_limit,
	height_max = mapgen.underground_start,
	seed = 263,
	base_node = {"blocks:desert_cobble", "blocks:sand", "blocks:desert_sand", "blocks:silver_sand", "blocks:dry_dirt"},
	surface_node = {"blocks:desert_cobble_azure", "blocks:sand_azure", "blocks:desert_sand_azure", "blocks:silver_sand_azure", "blocks:dry_dirt_azure"},
	surface_coverage = 1.5,
	grass_node = "flora:azure_grass",
	main_small_plant = "flora:azureshroom",
	--secondary_small_plant
	plant_rarity = 0.1,
	grass_rarity = 1,
	main_large_plant = "flora:azure_plant",
	secondary_large_plant = "blocks:lapis_lazuli",
	main_vines = "flora:azure_vines",
	--secondary_vines
	moss = "flora:azure_moss",
})]]--
--[[
mapgen.register_microbiome_decorations("moonstone", {
	height_min = mapgen.underground_start,
	height_max = mapgen.sfcave_limit,
	seed = 162,
	base_node = {"blocks:dirt"},
	surface_node = {"blocks:dirt_with_grass_sfcave"},
	surface_coverage = "full",
	grass_node = "flora:grass",
	main_small_plant = "flora:moonflower",
	--secondary_small_plant
	plant_rarity = 0.15,
	grass_rarity = 1,
	--main_large_plant
	--secondary_large_plant
	main_vines = "flora:vines",
	secondary_vines = "flora:vines_moonstone",
	moss = "flora:vines_horizontal",
})

mapgen.register_microbiome_decorations("hot", {
	height_min = mapgen.underground_start,
	height_max = mapgen.sfcave_limit,
	seed = 3444623,
	base_node = {"blocks:dry_dirt"},
	surface_node = {"blocks:dry_dirt_with_dry_grass_sfcave"},
	surface_coverage = "full",
	grass_node = "flora:dry_grass",
	main_small_plant = "flora:moonflower_dry",
	--secondary_small_plant
	plant_rarity = 0.15,
	grass_rarity = 1,
	--main_large_plant
	--secondary_large_plant
	main_vines = "flora:vines_dry",
	secondary_vines = "flora:vines_dry_moonstone",
	moss = "flora:vines_dry_horizontal",
})

mapgen.register_microbiome_decorations("frosty", {
	height_min = mapgen.underground_start,
	height_max = mapgen.sfcave_limit,
	seed = 82253663,
	base_node = {"blocks:permafrost"},
	surface_node = {"blocks:permafrost_with_snow"},
	surface_coverage = "full",
	grass_node = "flora:grass_frosty",
	main_small_plant = "flora:moonflower_frosty",
	secondary_small_plant = "blocks:snow",
	plant_rarity = 0.15,
	grass_rarity = 1,
	--main_large_plant
	--secondary_large_plant
	main_vines = "flora:vines_frosty",
	secondary_vines = "flora:vines_frosty_moonstone",
	moss = "flora:vines_frosty_horizontal",
})
mapgen.register_microbiome_decorations("hell", {
	small_plant_variation = false,
	grass_variation = false,
	height_min = mapgen.world_bottom,
	height_max = mapgen.hell_level,
	seed = 7734,
	base_node = {"blocks:obsidian", "blocks:dark_dirt"}, -- surface_node matches the base_node, they also have to be the same length
	surface_node = {"blocks:embers", "blocks:embers"},
	surface_coverage = 5.0,
	grass_node = "blocks:fire",
	main_small_plant = "blocks:pyre",
	--secondary_small_plant
	plant_rarity = 0.005,
	grass_rarity = 0.05,
	main_large_plant = "variations:obsidian_big_tile";
	--secondary_large_plant
	main_vines = "blocks:obsidian",
	--secondary_vines
	moss = "blocks:obsidian",
})]]--
--[[
-- Should be the mese biome, but there are too many exceptions
mapgen.register_microbiome_decorations("mese", {
	height_min = mapgen.world_bottom,
	height_max = mapgen.underground_limit,
	seed = 26262,
	base_node = {"blocks:stone"}, -- surface_node matches the base_node, they also have to be the same length
	surface_node = {"blocks:stone_mese_circuits"},
	surface_coverage = 2.5,
	grass_node = "flora:grass_mese",
	main_small_plant = "flora:flower_mese",
	--secondary_small_plant
	plant_rarity = 0.002,
	grass_rarity = 1,
	--main_large_plant = "flora:plant_garnet",
	--secondary_large_plant = "blocks:garnet",
	main_vines = "flora:vines_mese",
	--secondary_vines
	moss = "flora:moss_mese",
})]]--

-- Mese micro-biome
--[[
mapgen.mese_biome_base_noise = {
	offset = -2.35,
	scale = 4,
	spread = {x = 50, y = 50, z = 50},
	seed = 26262,
	octaves = 1,
	flags = "eased",
}

-- Two base nodes, one for the ground decorations and one for ceiling ones

minetest.register_decoration({
	name = "mese_surface",
	deco_type = "simple",
	place_on = {"blocks:stone"},
	noise_params = mapgen.mese_biome_base_noise,
	y_max = mapgen.underground_limit,
	y_min = mapgen.world_bottom,
	spawn_by = "air",
	num_spawn_by = 3,
	flags = "all_floors, force_placement",
	place_offset_y = -1,
	decoration = "blocks:stone_mese_circuits",
})

minetest.register_decoration({
	name = "mese_ceiling",
	deco_type = "simple",
	place_on = {"blocks:stone"},
	noise_params = mapgen.mese_biome_base_noise,
	y_max = mapgen.underground_limit,
	y_min = mapgen.world_bottom,
	spawn_by = "air",
	num_spawn_by = 3,
	flags = "all_ceilings, force_placement",
	place_offset_y = -1,
	decoration = "blocks:stone_mese_circuits_under",
})

minetest.register_decoration({
	name = "mese_surface_marble",
	deco_type = "simple",
	place_on = {"blocks:marble"},
	noise_params = mapgen.mese_biome_base_noise,
	y_max = mapgen.underground_limit,
	y_min = mapgen.world_bottom,
	spawn_by = "air",
	num_spawn_by = 3,
	flags = "all_floors, force_placement",
	place_offset_y = -1,
	decoration = "blocks:marble_mese_circuits",
})

minetest.register_decoration({
	name = "mese_ceiling_marble",
	deco_type = "simple",
	place_on = {"blocks:marble"},
	noise_params = mapgen.mese_biome_base_noise,
	y_max = mapgen.underground_limit,
	y_min = mapgen.world_bottom,
	spawn_by = "air",
	num_spawn_by = 3,
	flags = "all_ceilings, force_placement",
	place_offset_y = -1,
	decoration = "blocks:marble_mese_circuits_under",
})

minetest.register_decoration({
	name = "mese_tech_crystal",
	deco_type = "simple",
	place_on = {"blocks:stone_mese_circuits", "blocks:marble_mese_circuits"},
	sidelen = 12,
	fill_ratio = 0.05,
	y_max = mapgen.underground_limit,
	y_min = mapgen.world_bottom,
	flags = "all_floors",
	height = 3,
	height_max = 6,
	decoration = "blocks:mese_tech_crystal",
})

minetest.register_decoration({
	name = "mese_vines",
	deco_type = "simple",
	place_on = {"blocks:stone_mese_circuits_under", "blocks:marble_mese_circuits_under"},
	noise_params = {
		offset = -0.25,
		scale = 1,
		spread = {x = 4, y = 4, z = 4},
		seed = 62262226,
		octaves = 1,
		flags = "eased",
	},
	y_max = mapgen.underground_limit,
	y_min = mapgen.world_bottom,
	flags = "all_ceilings",
	height = 3,
	height_max = 8,
	decoration = "flora:vines_mese",
})

minetest.register_decoration({
	name = "mese_moss",
	deco_type = "simple",
	place_on = {"blocks:stone_mese_circuits_under", "blocks:marble_mese_circuits_under"},
	noise_params = {
		offset = -0.25,
		scale = 2,
		spread = {x = 4, y = 4, z = 4},
		seed = 262226222,
		octaves = 1,
		flags = "absvalue, eased",
	},
	y_max = mapgen.underground_limit,
	y_min = mapgen.world_bottom,
	flags = "all_ceilings",
	decoration = "flora:moss_mese",
})

for i=1,5 do
	-- Small plants
	minetest.register_decoration({
		name = "mese_flower_" .. i,
		deco_type = "simple",
		place_on = {"blocks:stone_mese_circuits", "blocks:marble_mese_circuits"},
		fill_ratio = 0.1/5,
		y_max = mapgen.underground_limit,
		y_min = mapgen.world_bottom,
		param2 = 1,
		flags = "all_floors",
		decoration = "flora:flower_mese_" .. i,
	})
end

for i=1,5 do
	-- Grassamethyst
	minetest.register_decoration({
		name = "mese_grass_" .. i,
		deco_type = "simple",
		place_on = {"blocks:stone_mese_circuits", "blocks:marble_mese_circuits"},
		fill_ratio = 1/5,
		y_max = mapgen.underground_limit,
		y_min = mapgen.world_bottom,
		param2 = 1,
		flags = "all_floors",
		decoration = "flora:grass_mese_" .. i,
	})
end
]]--

-- Other Decorations

minetest.register_decoration({
	name = "sfcave_mossycobble",
	deco_type = "simple",
	place_on = {"blocks:stone"},
	fill_ratio = 10.0,
	y_max = 0,
	y_min = mapgen.underground_start,
	spawn_by = "blocks:dirt_with_grass",
	num_spawn_by = 1,
	flags = "all_floors, all_ceilings, force_placement",
	place_offset_y = -1, -- Requires force_placement
	decoration = "blocks:mossycobble",
})

minetest.register_decoration({
	name = "tree_vines",
	deco_type = "simple",
	place_on = {"flora:leaves"},
	fill_ratio = 0.2,
	y_max = 31000,
	y_min = mapgen.underground_start,
	flags = "all_ceilings",
	height = 3,
	height_max = 8,
	decoration = "flora:vines",
})