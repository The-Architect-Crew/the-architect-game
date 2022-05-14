mapgen = {}
mapgen.underground_start = -32 -- The level where surface caves end and underground begins
mapgen.underground_limit = -512 - 128 -- The lower limit of the underground "biome", first caverns appear at -512
mapgen.hell_level = -2048 + 128 -- The upper limit of hell
mapgen.world_bottom = -2048 -- Map bottom limit
mapgen.sfcaves_level = -8

mapgen.surface_cave_np = {
	offset = -0.25 * 60,
	scale = 60,
	spread = {x = 15, y = 15, z = 15},
	seed = 261,
	octaves = 1
}

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
					"rainforest", "rainforest_swamp", "rainforest_ocean",
					"savanna", "savanna_shore", "savanna_ocean"}

--[[
minetest.register_on_generated(function(minp, maxp, seed)
	if (minp.y > -32) then
		local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
		minetest.fix_light(emin, emax)
	end
end)]]--

--
-- Detect mapgen to select functions
--

minetest.clear_registered_biomes()
minetest.clear_registered_ores()
minetest.clear_registered_decorations()

local path = minetest.get_modpath("mapgen")
dofile(path.."/alias.lua")
dofile(path.."/mapgen.lua")
dofile(path.."/oregen.lua")
dofile(path.."/undergroundgen.lua")
dofile(path.."/flowergen.lua")
dofile(path.."/surfacecaves.lua")
dofile(path.."/grassspread.lua")
dofile(path.."/mossspread.lua")

local mg_name = minetest.get_mapgen_setting("mg_name")

if mg_name == "v6" then
	mapgen.register_mgv6_ores()
	mapgen.register_mgv6_decorations()
else
	mapgen.register_biomes()
	mapgen.register_ores()
	mapgen.register_decorations()
end
