local function loot_chest_roll_item()
	local itemstack = ""
	local random

	if math.random(0,2) == 1 then
		local rarity = math.random(1,6)
		local amount
		if  rarity <= 3 then
			random = math.random(1, #blocks.random_items)
			amount = math.random(2, 6)
			if string.find(blocks.random_items[random], "tools:") then
				amount = 1
			end
			itemstack = ItemStack(blocks.random_items[random])
			itemstack:set_count(amount)
		elseif rarity > 3 and rarity <= 5 then
			random = math.random(1, #blocks.rare_items)
			amount = math.random(1, 4)
			if string.find(blocks.rare_items[random], "tools:") then
				amount = 1
			end
			itemstack = ItemStack(blocks.rare_items[random])
			itemstack:set_count(amount)
		elseif rarity > 5 then
			random = math.random(1, #blocks.extra_rare_items)
			amount = math.random(1, 2)
			if string.find(blocks.extra_rare_items[random], "tools:") then
				amount = 1
			end
			itemstack = ItemStack(blocks.extra_rare_items[random])
			itemstack:set_count(amount)
		end
	end

	return itemstack
end

local function loot_chest_formspec(player, pos)
	local spos = pos.x..","..pos.y..","..pos.z
	local playername = player:get_player_name()

	local winv_listring = ""
	if winv_exists then
		local right_inv = winv.get_inventory(player, "right")
		if right_inv == "player" then
			winv_listring =
				"listring[nodemeta:"..spos..";main]"..
				"listring[current_player;main]"
		elseif right_inv == "crafting" then
			winv_listring =
				"listring[nodemeta:"..spos..";main]"..
				"listring[detached:winv_craft_"..playername..";input]"..
				"listring[nodemeta:"..spos..";main]"..
				"listring[detached:winv_craft_"..playername..";output]"..
				"listring[nodemeta:"..spos..";main]"
		elseif right_inv == "craftguide" then
			winv_listring =
				"listring[detached:winv_creative_"..playername..";main]"..
				"listring[nodemeta:"..spos..";main]"..
				"listring[detached:trash;main]"
		end
	end
	local winv_formspec = {
		"image[0,0;7.75,8.0;winv_bg.png]",
		-- storage
		"list[nodemeta:"..spos..";main;0.25,0.25;6,6;]",
		winv_listring
	}

	return winv.init_inventory(player, table.concat(winv_formspec, ""))
end

local function show_loot_chest_formspec(player, pos)
	local playername = player:get_player_name()
	minetest.show_formspec(playername, "quests:loot_chest_form", loot_chest_formspec(player, pos))
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "quests:loot_chest_form" or not player then
		return
	end

	local playername = player:get_player_name()
    local pos = quests.loot_chest[playername]

	if not fields.quit then
		winv.node_receive_fields(player, formname, fields)
		if winv.node_refresh(player) then
			show_loot_chest_formspec(player, pos)
		end
	end
end)

local function loot_chest_on_rightclick(pos, node, clicker, itemstack, pointed_thing)
	local meta = minetest.get_meta(pos)
	local playername = clicker:get_player_name()
	if meta:get_int("filled") == 0 then -- generate loot
		local inv = meta:get_inventory()
		inv:set_size("main", 6*6)
		for i=1,36 do
			inv:set_stack("main", i, loot_chest_roll_item())
		end
		meta:set_int("filled", 1)
	end
	quests.loot_chest[playername] = pos
	show_loot_chest_formspec(clicker, pos)
end

minetest.register_node("quests:quarry_loot_chest", {
	description = "Quarry Loot Chest",
	groups = {not_in_creative_inventory = 1, cracky = 2},
	tiles = {
		"quests_quarry_loot_chest_top.png",
		"quests_quarry_loot_chest_bottom.png",
		"quests_quarry_loot_chest_side.png",
		"quests_quarry_loot_chest_side.png",
		"quests_quarry_loot_chest_side.png",
		"quests_quarry_loot_chest_front.png"
	},
	drop = {
		items = {
			{
				rarity = 1,
				items = {"blocks:stone_chunk"},
			},
			{
				rarity = 2,
				items = {"blocks:stone_chunk"},
			},
			{
				rarity = 3,
				items = {"blocks:stone_chunk 2"},
			}
		},
	},
	paramtype = "light",
	paramtype2 = "facedir",
	on_dig = function(pos, node, digger)
		local meta = minetest.get_meta(pos)
		if meta:get_int("filled") == 0 then
			return
		else
			local inv = meta:get_inventory()
			if not inv:is_empty("main") then
				return
			end
		end
		minetest.node_dig(pos, node, digger)
	end,
	sounds = default.node_sound_stone_defaults(),
	on_rightclick = loot_chest_on_rightclick,
})