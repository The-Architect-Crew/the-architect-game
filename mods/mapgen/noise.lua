-- 2D noise that controls the shape/size of ridged mountains.
-- type: noise_params_2d
minetest.set_mapgen_setting_noiseparams("mgcarpathian_np_ridge_mnt", {
	offset = 0,
	scale = 8,
	spread = {x=525,y=525,z=525},
	seed = 5520,
	octaves = 6,
	persistence = 0.55,
	lacunarity = 2.0,
	flags = "eased",
}, true)
-- 2D noise that controls the shape/size of step mountains.
-- type: noise_params_2d
minetest.set_mapgen_setting_noiseparams("mgcarpathian_np_step_mnt", {
	offset = 0,
	scale = 8,
	spread = {x=502,y=502,z=502},
	seed = 2590,
	octaves = 5,
	persistence = 0.55,
	lacunarity = 2.0,
	flags = "eased",
}, true)

-- # Biome API noise parameters
-- Temperature variation for biomes.
-- type: noise_params_2d
minetest.set_mapgen_setting_noiseparams("mg_biome_np_heat", {
	offset = 48,
	scale = 48,
	spread = {x=1600,y=1600,z=1600},
	seed = 5349,
	octaves = 3,
	persistence = 0.5,
	lacunarity = 2.0,
	flags = "eased",
}, true)
-- Small-scale temperature variation for blending biomes on borders.
-- type: noise_params_2d
minetest.set_mapgen_setting_noiseparams("mg_biome_np_heat_blend", {
	offset = 0,
	scale = 1.5,
	spread = {x=12,y=12,z=12},
	seed = 13,
	octaves = 2,
	persistence = 1.0,
	lacunarity = 2.0,
	flags = "eased",
}, true)
-- Humidity variation for biomes.
-- type: noise_params_2d
minetest.set_mapgen_setting_noiseparams("mg_biome_np_humidity", {
	offset = 50,
	scale = 50,
	spread = {x=1000,y=1000,z=1000},
	seed = 842,
	octaves = 3,
	persistence = 0.5,
	lacunarity = 2.0,
	flags = "eased",
}, true)
-- Small-scale humidity variation for blending biomes on borders.
-- type: noise_params_2d
minetest.set_mapgen_setting_noiseparams("mg_biome_np_humidity_blend", {
	offset = 0,
	scale = 1.5,
	spread = {x=12,y=12,z=12},
	seed = 90003,
	octaves = 2,
	persistence = 1.0,
	lacunarity = 2.0,
	flags = "eased",
}, true)