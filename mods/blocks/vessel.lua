local vessels_shelf_formspec = "size[8,7;]"
	.. "list[context;vessels;0,0.3;8,2;]"
	.. "list[current_player;main;0,2.85;8,1;]"
	.. "list[current_player;main;0,4.08;8,3;8]"
	.. "listring[context;vessels]"
	.. "listring[current_player;main]"
	.. default.get_hotbar_bg(0, 2.85)

local function update_vessels_shelf(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local invlist = inv:get_list("vessels")

	local formspec = vessels_shelf_formspec
	-- Inventory slots overlay
	local vx, vy = 0, 0.3
	local n_items = 0
	for i = 1, 16 do
		if i == 9 then
			vx = 0
			vy = vy + 1
		end
		if not invlist or invlist[i]:is_empty() then
			formspec = formspec .. "image[" .. vx .. "," .. vy .. ";1,1;blocks_vesselshelf_slot.png]"
		else
			local stack = invlist[i]
			if not stack:is_empty() then
				n_items = n_items + stack:get_count()
			end
		end
		vx = vx + 1
	end
	meta:set_string("formspec", formspec)
	if n_items == 0 then
		meta:set_string("infotext", "Empty Vessels Shelf")
	else
		meta:set_string("infotext", "Vessels Shelf (" .. n_items .. " items)")
	end
end

minetest.register_node("blocks:vesselshelf", {
	description = "Vessels Shelf",
	tiles = {
		"blocks_wood.png",
		"blocks_wood.png",
		"blocks_wood.png",
		"blocks_wood.png",
		"blocks_vesselshelf.png",
		"blocks_vesselshelf.png",
	},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = { choppy = 3, oddly_breakable_by_hand = 2, flammable = 3 },
	sounds = default.node_sound_wood_defaults(),

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		update_vessels_shelf(pos)
		local inv = meta:get_inventory()
		inv:set_size("vessels", 8 * 2)
	end,
	can_dig = function(pos, player)
		local inv = minetest.get_meta(pos):get_inventory()
		return inv:is_empty("vessels")
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if minetest.get_item_group(stack:get_name(), "vessel") ~= 0 then
			return stack:get_count()
		end
		return 0
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log(
			"action",
			player:get_player_name() .. " moves stuff in vessels shelf at " .. minetest.pos_to_string(pos)
		)
		update_vessels_shelf(pos)
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log(
			"action",
			player:get_player_name() .. " moves stuff to vessels shelf at " .. minetest.pos_to_string(pos)
		)
		update_vessels_shelf(pos)
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log(
			"action",
			player:get_player_name() .. " takes stuff from vessels shelf at " .. minetest.pos_to_string(pos)
		)
		update_vessels_shelf(pos)
	end,
	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "vessels", drops)
		drops[#drops + 1] = "blocks:vesselshelf"
		minetest.remove_node(pos)
		return drops
	end,
})

minetest.register_craft({
	output = "blocks:vesselshelf",
	recipe = {
		{ "group:wood", "group:wood", "group:wood" },
		{ "group:vessel", "group:vessel", "group:vessel" },
		{ "group:wood", "group:wood", "group:wood" },
	},
})

minetest.register_node("blocks:glass_bottle", {
	description = "Empty Glass Bottle",
	drawtype = "plantlike",
	tiles = { "blocks_glass_bottle.png" },
	inventory_image = "blocks_glass_bottle.png",
	wield_image = "blocks_glass_bottle.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.3, 0.25 },
	},
	groups = { vessel = 1, dig_immediate = 3, attached_node = 1 },
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
	output = "blocks:glass_bottle 10",
	recipe = {
		{ "blocks:glass", "", "blocks:glass" },
		{ "blocks:glass", "", "blocks:glass" },
		{ "", "blocks:glass", "" },
	},
})

minetest.register_node("blocks:drinking_glass", {
	description = "Empty Drinking Glass",
	drawtype = "plantlike",
	tiles = { "blocks_drinking_glass.png" },
	inventory_image = "blocks_drinking_glass_inv.png",
	wield_image = "blocks_drinking_glass.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.3, 0.25 },
	},
	groups = { vessel = 1, dig_immediate = 3, attached_node = 1 },
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
	output = "blocks:drinking_glass 14",
	recipe = {
		{ "blocks:glass", "", "blocks:glass" },
		{ "blocks:glass", "", "blocks:glass" },
		{ "blocks:glass", "blocks:glass", "blocks:glass" },
	},
})

minetest.register_node("blocks:steel_bottle", {
	description = "Empty Heavy Steel Bottle",
	drawtype = "plantlike",
	tiles = { "blocks_steel_bottle.png" },
	inventory_image = "blocks_steel_bottle.png",
	wield_image = "blocks_steel_bottle.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.3, 0.25 },
	},
	groups = { vessel = 1, dig_immediate = 3, attached_node = 1 },
	sounds = default.node_sound_defaults(),
})

minetest.register_craft({
	output = "blocks:steel_bottle 5",
	recipe = {
		{ "blocks:steel_ingot", "", "blocks:steel_ingot" },
		{ "blocks:steel_ingot", "", "blocks:steel_ingot" },
		{ "", "blocks:steel_ingot", "" },
	},
})

-- Glass and steel recycling

minetest.register_craftitem("blocks:glass_fragments", {
	description = "Glass Fragments",
	inventory_image = "blocks_glass_fragments.png",
})

minetest.register_craft({
	type = "shapeless",
	output = "blocks:glass_fragments",
	recipe = {
		"blocks:glass_bottle",
		"blocks:glass_bottle",
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "blocks:glass_fragments",
	recipe = {
		"blocks:drinking_glass",
		"blocks:drinking_glass",
	},
})

minetest.register_craft({
	type = "cooking",
	output = "blocks:glass",
	recipe = "blocks:glass_fragments",
})

minetest.register_craft({
	type = "cooking",
	output = "blocks:steel_ingot",
	recipe = "blocks:steel_bottle",
})

minetest.register_craft({
	type = "fuel",
	recipe = "blocks:vesselshelf",
	burntime = 30,
})

-- Register glass fragments as dungeon loot
if minetest.global_exists("dungeon_loot") then
	dungeon_loot.register({
		name = "blocks:glass_fragments",
		chance = 0.35,
		count = { 1, 4 },
	})
end
