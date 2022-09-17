mapgen = {}
mapgen.underground_start = -48 -- The level where surface caves end and underground begins
mapgen.underground_limit = -512 - 128 -- The lower limit of the underground "biome", first caverns appear at -512
mapgen.hell_level = -2048 + 128 -- The upper limit of hell
mapgen.world_bottom = -2048 -- Map bottom limit
--[[mapgen.sfcaves_level = -16
mapgen.sfcave_limit = 512
mapgen.clay_transformer_limit = -30 -- Probably -32 actually

mapgen.surface_cave_np = {
	offset = -0.9 * 160,
	scale = 160,
	spread = {x = 96, y = 96, z = 96},
	seed = 261,
	octaves = 2,
	persistence = 0.5,
	lacunarity = 3,
}

mapgen.cave_opening_noise = { -- Should be same as mapgen.surface_cave_np but with insane scale and a bit smaller offset
	offset = -1.0 * 1024 * 1024, -- Its just 1.25, but we have to multiply by scale because its not normalized
	scale = 1024 * 1024,
	spread = {x = 96, y = 96, z = 96},
	seed = 261,
	octaves = 2, -- These are for adding detail on the resulting ravines
	persistence = 0.5,
	lacunarity = 3,
	--flags = "eased",
}]]--

mapgen.np_stalagmites = {
	offset = -0.5,
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
					"rainforest", "rainforest_swamp", "rainforest_ocean"}
mapgen.icy_biomes = {"cold_desert", "cold_desert_under", "cold_desert_ocean",
					"taiga", "taiga_ocean", "taiga_under",
					"snowy_grassland", "snowy_grassland_ocean", "snowy_grassland_under",
					"icesheet", "icesheet_ocean", "icesheet_under",
					"tundra", "tundra_highland", "tundra_under", "tundra_ocean", "tundra_beach"}
mapgen.hot_biomes = {"desert", "desert_ocean", "desert_under",
					"sandstone_desert", "sandstone_desert_ocean", "sandstone_desert_under",
					"savanna", "savanna_shore", "savanna_ocean"}
--[[
minetest.register_on_generated(function(minp, maxp, seed)
	if (minp.y > -32) then
		local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
		minetest.fix_light(emin, emax)
	end
end)
]]--

-- Clear default biomes, ores and decorations
minetest.clear_registered_biomes()
minetest.clear_registered_ores()
minetest.clear_registered_decorations()

local path = minetest.get_modpath("mapgen")
dofile(path.."/alias.lua")
dofile(path.."/noise.lua")
dofile(path.."/mapgen.lua")
dofile(path.."/oregen.lua")
dofile(path.."/decorations.lua")
dofile(path.."/flowergen.lua")
dofile(path.."/grassspread.lua")
dofile(path.."/mossspread.lua")
-- Register biomes, ores and decorations
local mapgen_name = minetest.get_mapgen_setting("mg_name")
if mapgen_name ~= "singlenode" and mapgen_name ~= "flat" then
	mapgen.register_biomes()
	mapgen.register_ores()
	mapgen.register_decorations()
end