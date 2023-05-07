winv = {}
-- default inventories
winv.default = {}
winv.default.left = "crafting"
winv.default.right = "player"
winv.inventories = {} -- definitions of each inventory
winv.data = {} -- cached active inventory per player
winv.listrings = {} -- listrings between two inventories
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
	formspec_function = function(player)
		local inv_helpers = ""
		if player then
			local name = player:get_player_name()
			if minetest.is_creative_enabled(name) then
				inv_helpers =
					"button[7.85,0.25;0.5,0.5;winv_player_row_up;Ʌ]"..
					"button[7.85,0.85;0.5,0.5;winv_player_row_down;V]"..
					"button[7.85,1.45;0.5,0.5;winv_player_row_clear;1]"..
					"button[7.85,2.05;0.5,0.5;winv_player_clear;X]"..
					"tooltip[winv_player_row_up;Move everything one row up]"..
					"tooltip[winv_player_row_down;Move everything one row down]"..
					"tooltip[winv_player_row_clear;Clear first row]"..
					"tooltip[winv_player_clear;Clear inventory]"
			else
				inv_helpers =
					"button[7.85,0.25;0.5,0.5;winv_player_row_up;Ʌ]"..
					"button[7.85,0.85;0.5,0.5;winv_player_row_down;V]"..
					"tooltip[winv_player_row_up;Move everything one row up]"..
					"tooltip[winv_player_row_down;Move everything one row down]"
			end
		end
		local formspec = {
			"image[0,0;7.75,7.75;winv_bg.png]",
			"list[current_player;main;0.25,0.25;6,6;]",
			inv_helpers
		}
		return table.concat(formspec, "")
	end,
	on_player_receive_fields = function(player, formname, fields)
		local name = player:get_player_name()
		local inv = player:get_inventory()
		local inlist = inv:get_list("main")
		local row_slots = 6
		local tslots = 6 * row_slots
		local uslots = tslots - row_slots
		if fields.winv_player_row_up then
			local newlist = {}
			for i = 1, row_slots do
				newlist[uslots+i] = inlist[i]
			end
			for i = row_slots, tslots do
				if (i - row_slots) == 0 then
					newlist[1] = inlist[i]
				else
					newlist[i-row_slots] = inlist[i]
				end
			end
			inv:set_list("main", newlist)
		elseif fields.winv_player_row_down then
			local newlist = {}
			for i = uslots, tslots do
				if (uslots - i) == 0 then
					newlist[1] = inlist[i]
				else
					newlist[i-uslots] = inlist[i]
				end
			end
			for i = 1, uslots do
				newlist[i + row_slots] = inlist[i]
			end
			inv:set_list("main", newlist)
		end
		if minetest.is_creative_enabled(name) then
			if fields.winv_player_row_clear then
				local newlist = {}
				for i = 1, row_slots do
					newlist[uslots+i] = ItemStack("")
				end
				for i = row_slots, tslots do
					if (i - row_slots) == 0 then
						newlist[1] = inlist[i]
					else
						newlist[i-row_slots] = inlist[i]
					end
				end
				inv:set_list("main", newlist)
			elseif fields.winv_player_clear then
				inv:set_list("main", {})
			end
		end
	end
})

dofile(path.."/crafting.lua")
dofile(path.."/creative.lua")
dofile(path.."/home.lua")
--dofile(path.."/remote.lua")

