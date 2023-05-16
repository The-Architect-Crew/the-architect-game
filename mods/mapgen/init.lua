mapgen = {}
mapgen.underground_start = -128 -- The level where surface caves end and underground begins
mapgen.underground_limit = -1024 -- The lower limit of the underground "biome", first caverns appear at -512
mapgen.hell_level = -8192 + 512 -- The upper limit of hell
mapgen.world_bottom = -8192 -- Map bottom limit
mapgen.sfcaves_level = -64
mapgen.sfcave_limit = -32 -- How high can sfcaves go

mapgen.surface_cave_np = {
	offset = -0.8 * 144,
	scale = 144,
	spread = {x = 144, y = 144, z = 144},
	seed = 261,
	octaves = 2,
	persistence = 0.5,
	lacunarity = 3,
}

mapgen.np_stalagmites = {
	offset = -0.85,
	scale = 1,
	spread = {x = 10, y = 10, z = 10},
	seed = 2620,
	octaves = 2,
	persistence = 1,
	lacunarity = 1,
	flags = "",
}

mapgen.lush_biomes = {"grassland", "grassland_dunes", "grassland_ocean",
					"coniferous_forest", "coniferous_forest_ocean", "coniferous_forest_dunes",
					"deciduous_forest", "deciduous_forest_shore", "deciduous_forest_ocean",
					"rainforest", "rainforest_swamp", "rainforest_ocean",
					"chalk_grassland", "chalk_grassland_ocean"}
mapgen.icy_biomes = {"cold_desert", "cold_desert_ocean",
					"taiga", "taiga_ocean",
					"snowy_grassland", "snowy_grassland_ocean",
					"icesheet", "icesheet_ocean",
					"tundra", "tundra_highland", "tundra_ocean", "tundra_beach"}
mapgen.hot_biomes = {"desert", "desert_ocean",
					"sandstone_desert", "sandstone_desert_ocean",
					"savanna", "savanna_shore", "savanna_ocean"}

-- Clear default biomes, ores and decorations
minetest.clear_registered_biomes()
minetest.clear_registered_ores()
minetest.clear_registered_decorations()

local path = minetest.get_modpath("mapgen")
local biomes_path = minetest.get_modpath("mapgen") .. "/underground_biomes"
dofile(path.."/alias.lua")
dofile(path.."/noise.lua")
dofile(path.."/mapgen.lua")
dofile(path.."/oregen.lua")
dofile(path.."/decorations.lua")
dofile(path.."/flowergen.lua")
dofile(path.."/grassspread.lua")
dofile(path.."/mossspread.lua")

dofile(biomes_path .. "/quarry.lua")
-- Register biomes, ores and decorations
local mapgen_name = minetest.get_mapgen_setting("mg_name")
if mapgen_name ~= "singlenode" and mapgen_name ~= "flat" then
	mapgen.register_quarry_biomes()
	mapgen.register_surface_biomes()

	mapgen.register_quarry_ores()
	mapgen.register_ores()

	mapgen.register_quarry_terrain_decorations()
	mapgen.register_decorations()
end