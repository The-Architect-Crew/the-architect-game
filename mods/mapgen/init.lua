mapgen = {}
--
-- Detect mapgen to select functions
--

minetest.clear_registered_biomes()
minetest.clear_registered_ores()
minetest.clear_registered_decorations()

local path = minetest.get_modpath("mapgen")
dofile(path .. "/alias.lua")
dofile(path .. "/oregen.lua")
dofile(path .. "/mapgen.lua")
dofile(path .. "/flowergen.lua")
dofile(path .. "/grassspread.lua")
dofile(path .. "/mossspread.lua")

local mg_name = minetest.get_mapgen_setting("mg_name")

if mg_name == "v6" then
	mapgen.register_mgv6_ores()
	mapgen.register_mgv6_decorations()
else
	mapgen.register_biomes()
	mapgen.register_ores()
	mapgen.register_decorations()
end
