workbench = {}
local path = minetest.get_modpath("workbench")
dofile(path.."/api/common.lua")
dofile(path.."/api/register.lua")
dofile(path.."/api/functions.lua")
dofile(path.."/api/fuel.lua")
-- Builtin craft types
workbench:register_crafttype("normal", {
	description = ccore.comment("Crafting", "Use your crafting grid or a craftbench"),
	icon = "workbench_crafticon_crafting.png"
})

workbench:register_crafttype("cooking", {
	description = ccore.comment("Cooking", "Use a furnace"),
	icon = "workbench_crafticon_cooking.png"
})

workbench:register_fueltype("normal")

dofile(path.."/craftbench.lua")
dofile(path.."/furnace.lua")
dofile(path.."/craftguide.lua")
dofile(path.."/crafting.lua")