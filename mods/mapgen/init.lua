mapgen = {}

-- Mapgen settings
minetest.set_mapgen_setting("mg_name", "carpathian", true)
minetest.set_mapgen_setting("mg_flags", "caves, dungeons, light, decorations, biomes, ores", true)
minetest.set_mapgen_setting("mgcarpathian_spflags", "caverns, rivers", true)
-- Clear default biomes, ores and decorations
minetest.clear_registered_biomes()
minetest.clear_registered_ores()
minetest.clear_registered_decorations()

local path = minetest.get_modpath("mapgen")
dofile(path.."/alias.lua")
dofile(path.."/noise.lua")
dofile(path.."/oregen.lua")
dofile(path.."/mapgen.lua")
dofile(path.."/flowergen.lua")
dofile(path.."/grassspread.lua")
dofile(path.."/mossspread.lua")
-- Register biomes, ores and decorations
mapgen.register_biomes()
mapgen.register_ores()
mapgen.register_decorations()
