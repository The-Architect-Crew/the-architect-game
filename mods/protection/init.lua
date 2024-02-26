protection = {}

protection.grid_xz = 24
protection.grid_y = 48

local path = minetest.get_modpath("protection")
dofile(path.."/entities.lua")
dofile(path.."/marker.lua")
dofile(path.."/protector.lua")
dofile(path.."/tools.lua")
dofile(path.."/functions.lua")