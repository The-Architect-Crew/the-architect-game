crates.label_list = {}
local winv_exists = minetest.global_exists("winv")
local colors = {	-- label colors
	{"red", "#FF0000"},
	{"orange", "#FFA500"},
	{"yellow", "#FFFF00"},
	{"green", "#008000"},
	{"blue", "#0000FF"},
	{"purple", "#800080"},
	{"black", "#000000"},
	{"white", "#FFFFFF"},
}

function crates:register_label(name, def)
	table.insert(crates.label_list, {
		name = name,
		tiles = def.tiles,
		use_texture_alpha = def.use_texture_alpha,
		nodebox = def.nodebox,
	})
end

crates:register_label("tag", {
	tiles = {"crates_blank.png", "crates_blank.png", "crates_blank.png", "crates_blank.png", "crates_label.png"},
	use_texture_alpha = "opaque",
	nodebox = {
		{0.125, 0, 0.46875, 0.3125, 0.5, 0.5},
		{0.125, -0.125, 0.46875, 0.1875, 0, 0.5},
		{0.25, -0.125, 0.46875, 0.3125, 0, 0.5},
	},
})

crates:register_label("tag2", {
	tiles = {"crates_blank.png", "crates_blank.png", "crates_blank.png", "crates_blank.png", "crates_label.png"},
	use_texture_alpha = "opaque",
	nodebox = {
		{0.125, 0, 0.46875, 0.3125, 0.5, 0.5},
		{0.125, -0.125, 0.46875, 0.1875, 0, 0.5},
		{0.25, -0.125, 0.46875, 0.3125, 0, 0.5},
		{0.125, 0.4375, 0.5, 0.3125, 0.5, 0.5625},
	},
})

crates:register_label("sign", {
	tiles = {"crates_blank.png", "crates_blank.png", "crates_blank.png", "crates_blank.png", "crates_label3.png"},
	use_texture_alpha = "opaque",
	nodebox = {
		{-0.1875, -0.125, 0.46875, 0.1875, 0.125, 0.5},
		{-0.125, -0.125, 0.5, 0.125, 0.125, 0.5625},
	},
})

for i in ipairs(colors) do
	local cname = colors[i][1]
	local chex = colors[i][2]
	for j, labeldata in ipairs(crates.label_list) do
		local name = labeldata.name
		local use_texture_alpha = labeldata.use_texture_alpha
		local nodebox = labeldata.nodebox
		local tiles = labeldata.tiles
		-- create color tiles
		local colortiles = {}
		for k in ipairs(tiles) do
			colortiles[k] = tiles[k].."^[colorize:"..chex..":180"
		end
		-- create labels
		minetest.register_node("crates:label_"..name.."_"..cname, {
			drawtype = "nodebox",
			tiles = colortiles,
			paramtype = "light",
			paramtype2 = "facedir",
			sunlight_propagates = true,
			walkable = false,
			pointable = false,
			diggable = false,
			buildable_to = true,
			use_texture_alpha = use_texture_alpha,
			groups = {not_in_creative_inventory = 1, storage_label = 1},
			drop = "",
			node_box = {
				type = "fixed",
				fixed = nodebox,
			},
			on_rotate = false,
		})
	end
end

function crates.label_formspec()
	local lcstr
	if winv_exists then
		lcstr =
			"style[storage_label_remove;bgimg=gui_cross_big.png;border=false;bgimg_hovered=gui_cross_big.png^[brighten;bgimg_pressed=gui_cross_big.png^[brighten]"..
			"button[6.515,0.12;0.3,0.3;storage_label_remove;]"..
			"tooltip[storage_label_remove;Remove colored label]"..
			"style[storage_label_repos;bgimg=gui_refresh.png;border=false;bgimg_hovered=gui_refresh.png^[brighten;bgimg_pressed=gui_refresh.png^[brighten]"..
			"button[6.215,0.12;0.3,0.3;storage_label_repos;]"..
			"tooltip[storage_label_repos;Rotate position of colored label]"
		for i in ipairs(colors) do
			lcstr = lcstr..
				"style[storage_label_"..colors[i][1]..";bgimg=gui_white.png;border=true;bgcolor="..colors[i][2].."]"..
				"button["..(6.28 - (i * 0.35))..",0.155;0.25,0.25;storage_label_"..colors[i][1]..";]"..
				"tooltip[storage_label_"..colors[i][1]..";Adds a "..colors[i][1].."-colored label.]"
		end
	else
		lcstr =
			"style[storage_label_remove;bgimg=gui_cross_big.png;border=false;bgimg_hovered=gui_cross_big.png^[brighten;bgimg_pressed=gui_cross_big.png^[brighten]"..
			"button[9.265,0.25;0.3,0.3;storage_label_remove;]"..
			"tooltip[storage_label_remove;Remove colored label]"..
			"style[storage_label_repos;bgimg=gui_refresh.png;border=false;bgimg_hovered=gui_refresh.png^[brighten;bgimg_pressed=gui_refresh.png^[brighten]"..
			"button[8.965,0.25;0.3,0.3;storage_label_repos;]"..
			"tooltip[storage_label_repos;Rotate position of colored label]"
		for i in ipairs(colors) do
			lcstr = lcstr..
				"style[storage_label_"..colors[i][1]..";bgimg=gui_white.png;border=true;bgcolor="..colors[i][2].."]"..
				"button["..(9.03 - (i * 0.35))..",0.285;0.25,0.25;storage_label_"..colors[i][1]..";]"..
				"tooltip[storage_label_"..colors[i][1]..";Adds a "..colors[i][1].."-colored label.]"
		end
	end
	return lcstr
end

local function label_coords(pos)
	local lc = {
		{{x=pos.x, y=pos.y, z=pos.z-1}, 0},
		{{x=pos.x-1, y=pos.y, z=pos.z}, 1},
		{{x=pos.x, y=pos.y, z=pos.z+1}, 2},
		{{x=pos.x+1, y=pos.y, z=pos.z}, 3},
		{{x=pos.x, y=pos.y+1, z=pos.z}, 4},
	}
	return lc
end

function crates.label_exists(pos)
	local labelc = label_coords(pos)
	for i in ipairs(labelc) do
		local labelpos = labelc[i][1]
		if minetest.get_item_group(minetest.get_node(labelpos).name, "storage_label") == 1 then
			local labelp2 = minetest.get_node(labelpos).param2
			return labelpos, i, labelp2
		end
	end
end

function crates.label_remove(pos)
	local labelc = label_coords(pos)
	for i in ipairs(labelc) do
		local labelpos = labelc[i][1]
		if minetest.get_item_group(minetest.get_node(labelpos).name, "storage_label") == 1 then
			minetest.remove_node(labelpos)
		end
	end
end

function crates.label_add(pos, start, labelcol, labelno, repos)
	local labelc = label_coords(pos)
	-- label at top (rotation at top)
	if repos and start >= 5 then
		local labelup = labelc[5][1]
		if minetest.get_node(labelup).name == "air" then
			if repos == 4 then
				minetest.add_node(labelup, {name = "crates:label_"..labelno.."_"..labelcol, param2 = 13})
				return labelup, 5
			elseif repos == 13 then
				minetest.add_node(labelup, {name = "crates:label_"..labelno.."_"..labelcol, param2 = 10})
				return labelup, 5
			elseif repos == 10 then
				minetest.add_node(labelup, {name = "crates:label_"..labelno.."_"..labelcol, param2 = 19})
				return labelup, 5
			else
				if repos ~= 19 then
					minetest.add_node(labelup, {name = "crates:label_"..labelno.."_"..labelcol, param2 = 4})
					return labelup, 5
				end
			end
		end
	end
	for i = start, #labelc do
		local labelpos = labelc[i][1]
		if minetest.get_node(labelpos).name == "air" then
			minetest.add_node(labelpos, {name = "crates:label_"..labelno.."_"..labelcol, param2 = labelc[i][2]})
			return labelpos, i
		end
	end
	-- looparound
	if start > 1 then
		for i = 1, start do
			local labelpos = labelc[i][1]
			if minetest.get_node(labelpos).name == "air" then
				minetest.add_node(labelpos, {name = "crates:label_"..labelno.."_"..labelcol, param2 = labelc[i][2]})
				return labelpos, i
			end
		end
	end
end

function crates.label_receive_fields(player, formname, fields, pos, labelno)
	local playername = player:get_player_name()
	local meta = minetest.get_meta(pos)
	local currcolor = meta:get_string("colorlabel")
	-- color buttons
	for i = 1, #colors do
		local labelcolor = colors[i][1]
		if fields["storage_label_"..labelcolor] then
			local labelex = crates.label_exists(pos)
			-- if there's existing labels, replace
			if labelex then
				local labelpos, _, labelp2 = crates.label_exists(pos)
				minetest.set_node(labelpos, {name = "crates:label_"..labelno.."_"..labelcolor, param2 = labelp2})
				meta:set_string("colorlabel", labelcolor)
			-- if no labels, add a new label
			else
				local addlabel = crates.label_add(pos, 1, labelcolor, labelno)
				meta:set_string("colorlabel", labelcolor)
				if not addlabel then
					minetest.chat_send_player(playername, "[crates] Insufficient space to add a label, ensure there is at least an empty space (air) next to the storage.")
					meta:set_string("colorlabel", "")
				end
			end
		end
	end
	-- remove labels
	if fields.storage_label_remove then
		crates.label_remove(pos)
		meta:set_string("colorlabel", "")
	-- reposition labels
	elseif fields.storage_label_repos then
		local labelex = crates.label_exists(pos)
		-- ensuring there is existing labels
		if labelex and currcolor ~= "" then
			local _, labelord, labelp2 = crates.label_exists(pos)
			crates.label_remove(pos)
			local addlabel = crates.label_add(pos, labelord+1, currcolor, labelno, labelp2)
			if not addlabel then
				minetest.chat_send_player(playername, "[crates] Insufficient space to add a label, ensure there is at least an empty space (air) next to the storage.")
				meta:set_string("colorlabel", "")
			end
		else
			minetest.chat_send_player(playername, "[crates] No existing labels found to reposition!")
		end
	end
end