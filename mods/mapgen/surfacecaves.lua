

minetest.register_decoration({
	name = "blocks:dirt_with_grass_sfcave",
	deco_type = "simple",
	place_on = {"blocks:dirt"},
	fill_ratio = 10.0,
	y_max = 0,
	y_min = mapgen.underground_start,
	flags = "all_floors, force_placement",
	place_offset_y = -1, -- Requires force_placement
	decoration = "blocks:dirt_with_grass",
	spawn_by = "air",
	num_spawn_by = 3,
})

minetest.register_decoration({
	name = "blocks:dry_dirt_with_dry_grass_sfcave",
	deco_type = "simple",
	place_on = {"blocks:dry_dirt"},
	fill_ratio = 10.0,
	y_max = 0,
	y_min = mapgen.underground_start,
	flags = "all_floors, force_placement",
	place_offset_y = -1, -- Requires force_placement
	decoration = "blocks:dry_dirt_with_dry_grass",
	spawn_by = "air",
	num_spawn_by = 3,
})
minetest.register_decoration({
	name = "blocks:mossy_stone_sfcave",
	deco_type = "simple",
	place_on = {"blocks:stone"},
	fill_ratio = 10.0,
	y_max = 0,
	y_min = mapgen.underground_start,
	flags = "all_floors, force_placement",
	place_offset_y = -1, -- Requires force_placement
	decoration = "blocks:mossy_stone",
	spawn_by = "blocks:dirt_with_grass",
	num_spawn_by = 1,
})

minetest.register_decoration({
	name = "flora:vines_horizontal_sfcave",
	deco_type = "simple",
	place_on = {"blocks:dirt", "blocks:mossy_stone", "mossy_cobble"},
	fill_ratio = 1.25,
	y_max = 8,
	y_min = mapgen.underground_start,
	flags = "all_ceilings",
	decoration = "flora:vines_horizontal",
})
minetest.register_decoration({
	name = "flora:vines_moonstone_sfcave",
	deco_type = "simple",
	place_on = {"blocks:dirt", "blocks:mossy_stone", "mossy_cobble"},
	fill_ratio = 0.5,
	y_max = 8,
	height = 3,
    height_max = 8,
	y_min = mapgen.underground_start,
	flags = "all_ceilings",
	decoration = "flora:vines_with_moonstone",
})
minetest.register_decoration({
	name = "flora:vines_sfcave",
	deco_type = "simple",
	place_on = {"blocks:dirt", "blocks:mossy_stone", "mossy_cobble"},
	fill_ratio = 2.0,
	y_max = 8,
	height = 3,
    height_max = 8,
	y_min = mapgen.underground_start,
	flags = "all_ceilings",
	decoration = "flora:vines",
})
for i=1,5 do
minetest.register_decoration({
	name = "flora:moonflower_" .. i .. "_sfcave",
	deco_type = "simple",
	place_on = {"blocks:dirt_with_grass", "blocks:mossy_stone", "mossy_cobble"},
	fill_ratio = 0.01,
	y_max = 0,
	y_min = mapgen.underground_start,
	flags = "all_floors",
	decoration = "flora:moonflower_" .. i,
})
end
for i=1,5 do
	minetest.register_decoration({
		name = "flora:grass_" .. i .. "_sfcave",
		deco_type = "simple",
		place_on = {"blocks:dirt_with_grass", "blocks:mossy_stone", "mossy_cobble"},
		fill_ratio = 0.1,
		y_max = 0,
		y_min = mapgen.underground_start,
		flags = "all_floors",
		decoration = "flora:grass_" .. i,
	})
end