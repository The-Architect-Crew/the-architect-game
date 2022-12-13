furniture.assembler = {}

workbench:register_crafttype("furniture") -- adds a new crafting type called "furniture"
-- for full details; see https://github.com/Craigs-Crew/edgy-dark-ominous-game/blob/main/mods/workbench/api/api.txt#L4
-- otherwise it works similar to how minetest.register_craft does, but output is uses a table format

local function assembler_formspec_crafting(pos, player, add)
	local spos = pos.x..","..pos.y..","..pos.z -- node position for node inventory
	local meta = minetest.get_meta(pos)
	local winv_listring = ""
    local pmeta = player:get_meta()
    local playername = player:get_player_name()
    -- =======================================================
    -- this part is for ONLY listring for winv inventories
    -- there are currently only 3 inventories you need to worry about
    -- "player" - player inv
    -- "crafting" - crafting grid inv
    -- "creative" - creative inv
    local right_inv = pmeta:get_string("winv:right") -- player_meta "winv:right" contains the info to get the inventory name
    if right_inv == "player" then
        winv_listring =
            "listring[current_player;main]"..
            "listring[nodemeta:"..spos..";input]"..
            "listring[current_player;main]"..
            "listring[nodemeta:"..spos..";output]"
    elseif right_inv == "crafting" then
        winv_listring =
            "listring[nodemeta:"..spos..";input]"..
            "listring[detached:winv_craft_"..playername..";input]"..
            "listring[nodemeta:"..spos..";input]"..
            "listring[nodemeta:"..spos..";output]"..
            "listring[detached:winv_craft_"..playername..";input]"..
            "listring[detached:winv_craft_"..playername..";output]"
    elseif right_inv == "creative" then
        winv_listring =
            "listring[detached:winv_creative_"..playername..";main]"..
            "listring[nodemeta:"..spos..";input]"..
            "listring[detached:trash;main]"..
            "listring[nodemeta:"..spos..";output]"..
            "listring[detached:trash;main]"
    end
    -- =======================================================
	local winv_formspec = {
		"image[0,0;7.75,10.25;winv_bg.png]",
		-- input
		"list[nodemeta:"..spos..";input;0.875,0.25;5,5;]",
		-- arrow
		"image[3.375,6.5;1,1;gui_arrow.png^[transformFY]",
		-- multiplier
		"style[furniture_multiplier;border=false]",
		"box[4.625,6.5;1,1;#00000040]",
		"field[4.625,6.5;1,1;furniture_multiplier;;x"..meta:get_int("multiplier").."]", -- craft multiplier
		"field_close_on_enter[furniture_multiplier;false]",
		-- output
		"list[nodemeta:"..spos..";output;3.35,7.75;2,2;]",
		winv_listring, -- listring from above inputted here
		-- lock
        -- =======================================================
        -- interaces with locks API
		"style_type[image;noclip=true]",
		"image[-1.4,8.8;1.4,1.4;gui_tab.png]",
        -- {} includes the lock types, there's 4 supported lock types
        -- "lock" - fully locked, owner only
        -- "protect" -- protected area OR if unprotected == public
        -- "public" -- public access
        -- "mail" -- like locked, but anyone can add stuff in (but cant take out)
		"image_button[-1.1,8.95;1.05,1.05;"..locks.icons(pos, "furniture_assembler", {"lock", "protect", "public"}).."]",
        -- =======================================================
		add
	}
    -- return full set of inventory
    -- winv.init_inventory appends the inventory, so the node inventory above is combined with winv inventories (on the right)
    -- data for winv inventories is defined inside of winv (or any mod that make use of the winv API)
	return winv.init_inventory(player, table.concat(winv_formspec, ""))
end

-- quick simplified minetest.show_formspec
local function assembler_show_formspec(pos, player, add)
	local playername = player:get_player_name()
	minetest.show_formspec(playername, "furniture:assembler", assembler_formspec_crafting(pos, player, add)) -- calls above formspec handler
end

-- applies craft result
local function assembler_apply_craft_result(pos, listname, index, stack, player, multiplier)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local craftlist = inv:get_list("input") -- get input list
    -- =======================================================
    -- workbench crafting handler "workbench.craft_output"
    -- craftlist is input list
    -- "furniture" is crafting type, for custom version, use whatever name you defined
    -- "normal" is for normal crafting recipes
    -- "nil" is for crafting category (subcategory of crafting type) -- for more complicated types -- for basic types just put "nil" here
    -- "5" is input list width 5 = (5x5)
    -- "multiplier" is craft multiplier, if you aren't adding multiplier, set to 1

    -- IF you are doing something like shapes crafting, whereby a single recipe can have multiple outputs, the final "nil" players a part here
    -- Setting to true will unlock advanced multi recipe output, if you want to do that, contact me.
    -- more info: https://github.com/Craigs-Crew/edgy-dark-ominous-game/blob/main/mods/workbench/api/api.txt#L110
	local output = workbench.craft_output(craftlist, "furniture", nil, 5, multiplier, nil)
    -- returns a table
    -- for all variables see: https://github.com/Craigs-Crew/edgy-dark-ominous-game/blob/main/mods/workbench/api/api.txt#L129
    -- otherwise important data: ensure output is not nil and output.item exists
    -- =======================================================
	if output and output.item then -- if either is nil, it means there's no valid output
		inv:set_list("output", output.item) -- output.item is an inventory list (make sure your crafting table's output list is large enough to accomodate this list)
	else
		inv:set_list("output", {}) -- no valid output, hence remove output table
	end
end

local function assembler_update(pos, listname, index, stack, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local craftlist = inv:get_list("input")
	local outlist = inv:get_list("output")
	local multiplier = meta:get_int("multiplier")
	-- update output list when item placed in input
	if listname == "input" then
		assembler_apply_craft_result(pos, listname, index, stack, player, multiplier)
	end
	-- remove items when taking from output
	if listname == "output" then
		local output = workbench.craft_output(craftlist, "furniture", nil, 5, multiplier, nil) -- same as above, but this is to get the decremented input (what happens to input after item is crafted)
		local remainder = workbench.output_stack(outlist) -- check how many stacks are left in output slot
		-- ensure there's nothing remaining in the output list, otherwise prevent modifying the input list
		if output and output.dinput and meta:get_string("crafted") == "" then
			inv:set_list("input", output.dinput) -- set the decremented input once output item is taken
			if remainder > 0 then
				meta:set_string("crafted", "remainder")
			end
		end
		if remainder == 0 then
			meta:set_string("crafted", "")
		end
		-- if theres spare input, apply crafting again
		if inv:is_empty("input") ~= true and inv:is_empty("output") then
			assembler_apply_craft_result(pos, listname, index, stack, player, multiplier)
		end
	end
end

-- initialize various data and inventory variables
local function assembler_on_construct(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	inv:set_size("input", 5*5) -- input list size
	inv:set_size("output", 1*1) -- output list size
	meta:set_string("lock", "lock") -- default lock size, see "locks.icons" above, make sure the state used here is included in the array above!
	meta:set_int("multiplier", 1) -- multiplier default size
	meta:set_string("crafted", "") -- required for multiple output, bit complex to explain here, if you dont understand what i said above, ask me
	meta:set_string("owner", "") -- owner name
	locks.init_infotext(pos, "Furniture Assembler") -- locks infotext, automatically adds "Locked/Unlocked/Public/Protected" to "assembler" based on lock state
end

-- after place node to set owner name & update infotext
local function assembler_after_place_node(pos, placer, itemstack, pointed_thing)
	local meta = minetest.get_meta(pos)
	local playername = placer:get_player_name()
	meta:set_string("owner", playername)
	locks.init_infotext(pos, "Furniture Assembler")
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "furniture:assembler" or not player then
		return
	end
	local playername = player:get_player_name()
	local pos = furniture.assembler[playername]
	local meta = minetest.get_meta(pos)
	if not locks.can_access(pos, player) then -- ensure player can access, hence modify locks
		return 0
	end
	if locks.fields(pos, player, fields, "furniture_assembler", "assembler") then
		assembler_show_formspec(pos, player)
	end
	if fields.key_enter_field == "furniture_multiplier" then
		local sub_multiplier = string.gsub(fields.furniture_multiplier, "x", "") -- allow player to set multiplier
		if tonumber(sub_multiplier) then
			local multiplier = tonumber(sub_multiplier)
			if multiplier > 99 then
				multiplier = 99
			elseif multiplier < 1 then
				multiplier = 1
			end
			meta:set_int("multiplier", multiplier)
			assembler_update(pos, "input")
			assembler_show_formspec(pos, player)
		end
	end
	if not fields.quit then -- ensure exiting the formspec doesnt trigger the update as well
		winv.node_receive_fields(player, formname, fields) -- contains all winv inventories fields handling
		if winv.node_refresh(player) then -- winv.node_refresh tells the player if there's an update in winv inventories, requiring a refresh of node inventory
			assembler_show_formspec(pos, player)
		end
	end
end)

-- Registration
for i=1,#furniture.craftstation_materials do
	local material = furniture.craftstation_materials[i]
	local secondary_tile = {name = "variations_steelblock.png^[sheet:3x3:1,0", backface_culling = true}
	if (type(furniture.craftstation_materials[i]) == "table") then
		material = furniture.craftstation_materials[i][1]
		local secondary_material = furniture.craftstation_materials[i][2]
		local secondary_sname = string.match(secondary_material, ':(.*)')
		secondary_tile = {name = "variations_" .. secondary_sname .. ".png^[sheet:3x3:1,0", backface_culling = true}
	end
	local base_definition = minetest.registered_nodes[material]
	local sname = string.match(material, ':(.*)')
	local description = base_definition.description .. " Furniture Assembler"
	local groups = base_definition.groups
	local sounds = base_definition.sounds
	local box = {-16/16, -8/16, -8/16, 16/16, 23/16, 8/16}
	minetest.register_node("furniture:assembler_" .. sname, {
		drawtype = "mesh",
		mesh = "assembler.obj",
		selection_box = {
			type = "fixed",
			fixed = box,
		},
		collision_box = {
			type = "fixed",
			fixed = box,
		},
		tiles = {{name = "variations_" .. sname .. ".png^[sheet:3x3:1,0", backface_culling = true}, secondary_tile,
				{
					name = "furniture_assembler_animated.png",
					animation = {
					type = "vertical_frames",
					aspect_w = 16,
					aspect_h = 16,
					length = 2.0,
				},
				},
		{name = "furniture_assembler_static.png", backface_culling = true},
		{name = "furniture_assembler_void.png", backface_culling = true}},
		description = description,
		paramtype = "light",
		paramtype2 = "facedir",
		groups = groups,
		sounds = sounds,
		can_dig = function(pos, player)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			if inv:is_empty("input") and inv:is_empty("fuel") and inv:is_empty("output") then -- ensure table is empty
				if locks.can_access(pos, player) == true then -- utilize locks API, automatically checks the lock state and whether player can access
					return true
				end
			end
			return false
		end,
		on_construct = assembler_on_construct, -- calls above function
		after_place_node = assembler_after_place_node, -- calls above function
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			local playername = clicker:get_player_name()
			local meta = minetest.get_meta(pos)
			if not meta or meta and meta:get_string("owner") == "" then -- recreate meta if it doesnt exist (prevents crashes from worldedit schems)
				assembler_on_construct(pos)
				assembler_after_place_node(pos, clicker, itemstack, pointed_thing)
			end

			if not locks.can_access(pos, clicker) then -- utilize locks API, automatically checks the lock state and whether player can access
				return itemstack
			end
			assembler_show_formspec(pos, clicker) -- calls formspec if player can
			furniture.assembler[playername] = pos -- store data for fields
		end,
		on_metadata_inventory_put = function(pos, listname, index, stack, player)
			assembler_update(pos, listname, index, stack, player)
		end,
		on_metadata_inventory_take = function(pos, listname, index, stack, player)
			assembler_update(pos, listname, index, stack, player)
		end,
		on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
			local meta = minetest.get_meta(pos)
			local stack = meta:get_inventory():get_stack(from_list, from_index)
			assembler_update(pos, from_list, from_index, stack, player)
		end,
		allow_metadata_inventory_put = function(pos, listname, index, stack, player)
			local meta = minetest.get_meta(pos)
			if not locks.can_access(pos, player) then
				return 0
			end
			if listname == "input" then
				if meta:get_string("crafted") == "" then
					return stack:get_count()
				else
					local playername = player:get_player_name()
					minetest.chat_send_player(playername, "[Furniture Assembler] Please remove all output items first.")
					return 0
				end
			else
				return 0
			end
		end,
		allow_metadata_inventory_take = function(pos, listname, index, stack, player)
			local meta = minetest.get_meta(pos)
			if not locks.can_access(pos, player) then
				return 0
			end
			if listname == "input" then
				if meta:get_string("crafted") == "" then
					return stack:get_count()
				else
					local playername = player:get_player_name()
					minetest.chat_send_player(playername, "[Furniture Assembler] Please remove all output items first.")
					return 0
				end
			elseif listname == "output" then
				return stack:get_count()
			else
				return 0
			end
		end,
		allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
			if not locks.can_access(pos, player) then
				return 0
			end
			-- disallow moving things in from within inventory to output
			if to_list == "output" then
				return 0
			end
			-- ensure output is empty before allowing modification of input
			if from_list == "input" then
				local meta = minetest.get_meta(pos)
				local stack = meta:get_inventory():get_stack(from_list, from_index)
				if meta:get_string("crafted") == "" then
					return stack:get_count()
				else
					local playername = player:get_player_name()
					minetest.chat_send_player(playername, "[Furniture Assembler] Please remove all output items first.")
					return 0
				end
			else
				return 0
			end
		end
	})
end