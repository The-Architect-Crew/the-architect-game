
local trash = minetest.create_detached_inventory("trash", {
	-- Allow the stack to be placed and remove it in on_put()
	-- This allows the creative inventory to restore the stack
	allow_put = function(inv, listname, index, stack, player)
		return stack:get_count()
	end,
	on_put = function(inv, listname)
		inv:set_list(listname, {})
	end,
})
trash:set_size("main", 1)

local function trash_formspec()
	return ""..
		"list[detached:trash;main;0.4,2.9;1,1;]"..
		"image[0.46,3;0.8,0.8;workbench_trash.png]"
end

local function create_tab(pos, def)
	local tabindex = def.index
	local tabimage = def.image
	local tabfield = def.field
	local tabdesc = def.desc
	local savename = def.data
	local savedesc = def.stdesc
	local meta = minetest.get_meta(pos)
	local stdata = meta:get_string(savename)
	local calcti = (tabindex * 1.2) + 1.2
	if stdata ~= "" then
		local stpos = minetest.deserialize(stdata)
		local stpostext = stpos.x..", "..stpos.y..", "..stpos.z
		return ""..
			"image_button["..calcti..",-1.2;1.1,1.1;"..tabimage..".png;"..tabfield..";;true;false;"..tabimage..".png]"..
			"tooltip["..tabfield..";"..tabdesc.." \nLinked to "..savedesc.." ("..stpostext..") \nRequires active "..savedesc.."]"
	else
		return ""..
			"image_button["..calcti..",-1.2;1.1,1.1;"..tabimage.."_locked.png;"..tabfield.."_locked;;true;false;"..tabimage.."_locked.png]"..
			"tooltip["..tabfield.."_locked;"..minetest.formspec_escape("[Locked]").." "..tabdesc.." \nAdd a "..savedesc.." nearby (within 5 nodes) to unlock!]"
	end
end

function workbench.tabs(pos, locked)
	return "formspec_version[4]"..
		"size[10.5,11.9]"..
		-- player
		"list[current_player;main;0.4,6.75;8,4;]" ..
		-- shapes
		"image_button[0,-1.2;1.1,1.1;workbench_tab_craft.png;wbtab_craft;;true;false;workbench_tab_craft.png]" ..
		"tooltip[wbtab_craft;Crafting Grid]" ..
		"image_button[1.2,-1.2;1.1,1.1;workbench_tab_basic.png;wbtab_shapes_basic;;true;false;workbench_tab_basic.png]" ..
		"tooltip[wbtab_shapes_basic;Simple Shapes (Fences, Slabs, Stairs, Step, Cube)]" ..
		create_tab(pos, {
			index = 1,
			image = "workbench_tab_complex",
			field = "wbtab_shapes_complex",
			desc = "Complex Shapes (Pillars, Beams, Doublesteps)",
			data = "station_shapes_complex",
			stdesc = "Tablesaw",
		}) ..
		create_tab(pos, {
			index = 2,
			image = "workbench_tab_slope",
			field = "wbtab_shapes_slope",
			desc = "Slope Shapes (Slopes, Spheres)",
			data = "station_shapes_slope",
			stdesc = "CNC Table",
		-- furnace
		}) ..
		create_tab(pos, {
			index = 3,
			image = "workbench_tab_furnace",
			field = "wbtab_furnace",
			desc = "Furnace (Cooking & Smelting)",
			data = "station_furnace",
			stdesc = "Furnace",
		}) ..
		-- trash
		trash_formspec() ..
		-- lock
		wb_lock.formspec(locked)
end