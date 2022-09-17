blocks = {}

local path = minetest.get_modpath("blocks")
-- Ground
dofile(path.."/dirt.lua")
dofile(path.."/snow.lua")
dofile(path.."/sand.lua")
-- Underground
dofile(path.."/liquid.lua")
dofile(path.."/stone.lua")
dofile(path.."/ore.lua")
dofile(path.."/underground.lua")
dofile(path.."/sfcave.lua")
-- Deco blocks
dofile(path.."/plank.lua")
dofile(path.."/glass.lua")
dofile(path.."/wool.lua")
dofile(path.."/brick.lua")
dofile(path.."/streets.lua")
dofile(path.."/fire.lua")
dofile(path.."/misc.lua")
-- Deco items
dofile(path.."/climbing.lua")
dofile(path.."/torch.lua")
dofile(path.."/lamp.lua")
dofile(path.."/book.lua")
dofile(path.."/vessel.lua")
dofile(path.."/bars.lua")
-- Signs
dofile(path.."/sign.lua")
dofile(path.."/itemframe.lua")
-- Shapes
dofile(path.."/shapes.lua")