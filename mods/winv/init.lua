winv = {}
winv.default = {}
winv.default.left = "crafting"
winv.default.right = "player"
winv.inventories = {}
winv.listrings = {}
winv.mod_storage = minetest.get_mod_storage()

local path = minetest.get_modpath("winv")
dofile(path.."/register.lua") -- handle registerations
dofile(path.."/api.lua")

-- player inventory
winv:register_inventory("player", {
	lists = {
		{"main", 6 * 6},
	},
	button = {
		texture = "winv_icon_player.png",
		tooltip = "Player Inventory",
	},
	formspec =  {
		"image[0,0;7.75,7.75;winv_bg.png]",
		"list[current_player;main;0.25,0.25;6,6;]",
	},
})

dofile(path.."/crafting.lua")
dofile(path.."/creative.lua")
dofile(path.."/home.lua")
--dofile(path.."/remote.lua")