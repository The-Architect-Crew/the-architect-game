workbench = {}
local path = minetest.get_modpath("workbench")
dofile(path.."/api/common.lua")
dofile(path.."/api/register.lua")
dofile(path.."/api/functions.lua")
dofile(path.."/api/fuel.lua")
-- Builtin craft types
workbench:register_crafttype("normal")
workbench:register_crafttype("cooking")
workbench:register_fueltype("normal")

dofile(path.."/craftbench.lua")
dofile(path.."/furnace.lua")

dofile(path.."/craftguide.lua")