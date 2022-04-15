workbench.crafts = {}
function workbench:register_crafttype(name)
	workbench.crafts[name] = {}
end

function workbench:register_craft(def)
	def = def or {}
	local ctype = def.type or "normal"
	-- ERROR CHECKS
	-- ensure essential values are present
	local ercat = def.cat or "none"
	if def.output == nil or def.input == nil or ctype == nil then
		return minetest.log("error",
			"[workbench] Error registering recipe - Incorrect recipe format: "..
			"type: "..ctype..", category: "..ercat..", input: "..dump(def.input)..", output: "..dump(def.output)
		)
	end
	-- ensure valid format
	if type(def.output[1]) ~= "table" or type(def.input[1]) ~= "table" then
		return minetest.log("error",
			"[workbench] Error registering recipe - Invalid input/output format: "..
			"type: "..ctype..", category: "..ercat
		)
	end
	-- ensure craft type is already registered first
	if workbench.crafts[ctype] == nil then
		return minetest.log("error",
			"[workbench] Error registering recipe - Invalid crafting type: "..
			"type: "..ctype..", category: "..ercat..", input: "..dump(def.input)..", output: "..dump(def.output)
		)
	end
	-- ensure width exists
	local first_width = #def.input[1]
	local second_width = #def.output[1]
	if first_width < 1 or second_width < 1 then
		return minetest.log("error",
			"[workbench] Error registering recipe - Invalid width: "..
			"type: "..ctype..", category: "..ercat..", input: "..dump(def.input)..", output: "..dump(def.output)
		)
	end
	-- ensure all input widths are matching
	for i = 1, #def.input do
		if #def.input[i] ~= first_width then
			return minetest.log("error",
				"[workbench]  Error registering recipe - Unequal width: "..
				"type: "..ctype..", category: "..ercat..", input: "..dump(def.input)..", output: "..dump(def.output)
			)
		end
	end
	-- ensure all output widths are matching
	for i = 1, #def.output do
		if #def.output[i] ~= second_width then
			return minetest.log("error",
				"[workbench]  Error registering recipe - Unequal width: "..
				"type: "..ctype..", category: "..ercat..", input: "..dump(def.input)..", output: "..dump(def.output)
			)
		end
	end
	-- ensure valid replacements
	if def.replacements ~= nil and type(def.output[1]) ~= "table" then
		return minetest.log("error",
			"[workbench] Error registering recipe - Invalid replacements format: "..
			"type: "..ctype..", category: "..ercat..", input: "..dump(def.input)..", output: "..dump(def.output)
		)
	end
	-- save data
	table.insert(workbench.crafts[ctype], {
		time = def.time or 0, -- timed craft
		cat = def.cat, -- category
		mod = def.mod, -- modification (supported: shapeless)
		input = def.input,
		-- outputs
		output = def.output, -- primary output
		residue = def.residue or {}, -- secondary output
		extra = def.extra or {}, -- tertiary output
		replacements = def.replacements or {},
		transfer_meta = def.transfer_meta or {},
		-- input w/h
		i_width = #def.input[1],
		i_height = #def.input,
		-- output w/h
		o_width = #def.output[1],
		o_height = #def.output,
	})
end

-- reconstruct list into inventory list
function workbench.to_invlist(list)
	local new_list = {}
	for i = 1, #list do
		for j = 1, #list[i] do
			new_list[(i - 1) * #list[i] + j] = ItemStack(list[i][j])
		end
	end
	return new_list
end

-- get starting index
local function get_startindex(ilist)
	for i = 1, #ilist do
		if ilist[i]:is_empty() ~= true then
			return i
		end
	end
end

-- group matches
local function groupcheck(ritem, citem)
	local prefix, groupname = string.match(ritem:get_name(), '(.*):'), string.match(ritem:get_name(), ':(.*)')
	if prefix == "group" then
		-- form a list of groups required separated by commas
		local group_list = {}
		for group in string.gmatch(groupname, '([^,]+)') do
			table.insert(group_list, group)
		end
		-- check item fulfill all groups
		for i = 1, #group_list do
			if minetest.get_item_group(citem:get_name(), group_list[i]) == 0 then
				return nil
			end
		end
		return true
	end
end

-- shapeless matches
local function shapeless_match(ilist2, ritem)
	for i in pairs(ilist2) do
		if ilist2[i] then
			local citem = ilist2[i]
			-- find matches
			if (ritem:get_name() == citem:get_name() or groupcheck(ritem, citem)) then -- name match or group match
				if citem:get_count() >= ritem:get_count() then -- TODO: match higher count recipe with higher count items rather than grabbing the first found
					local maxamt = math.floor(citem:get_count() / ritem:get_count())
					ilist2[i] = nil -- remove match to prevent doublecount
					return ilist2, citem, i, maxamt
				end
			end
		end
	end
end

-- add replacements to decremented inputs
local function craft_replacements(ilist, rcdata, d_ilist)
	local rplist = rcdata.replacements
	for i in ipairs(rplist) do
		local rd_item = ItemStack(rplist[i][1]) -- to be replaced item
		local rg_item = ItemStack(rplist[i][2]) -- replacing item
		for j = 1, #ilist do
			if d_ilist[j]:is_empty() then -- ensure slot is empty and hence replaceable
				local citem = ilist[j]
				if (rd_item:get_name() == citem:get_name() or groupcheck(rd_item, citem)) then -- name match or group match
					d_ilist[j] = rg_item
					break
				end
			end
		end
	end
end

-- transferring meta from input to output
local function transfer_metadata(ilist, rcdata)
	if rcdata.transfer_meta[1] then
		local tmlist = rcdata.transfer_meta
		local oplist = workbench.to_invlist(rcdata.output)
		for i in ipairs(tmlist) do
			local fr_item = ItemStack(tmlist[i][1]) -- item to extract metadata
			local to_item = ItemStack(tmlist[i][2]) -- item to transfer metadata
			for j = 1, #ilist do
				local citem = ilist[j]
				if (fr_item:get_name() == citem:get_name() or groupcheck(fr_item, citem)) then -- name match or group match
					for k = 1, #oplist do
						local oitem = oplist[k]
						if (to_item:get_name() == oitem:get_name() or groupcheck(to_item, oitem)) then -- name match or group match
							local copymeta = citem:get_meta():to_table()
							oitem:get_meta():from_table(copymeta)
							break
						end
					end
				end
			end
		end
		return oplist
	end
end

-- toolrepair recipe
local function toolrepair(ilist)
	-- craft items
	local fitems = 0
	for i = 1, #ilist do
		if ilist[i]:is_empty() ~= true then
			fitems = fitems + 1 -- full length of craft
		end
	end
	if fitems ~= 2 then
		return nil
	end
	local first_item = nil
	local first_index = 0
	local d_ilist = table.copy(ilist)
	for i = 1, #d_ilist do
		if d_ilist[i]:is_empty() ~= true then
			-- ensure tools
			if not minetest.registered_tools[ilist[i]:get_name()] then
				return nil
			end
			-- apply toolrepair
			if not first_item then
				first_item = d_ilist[i]
				first_index = i
			else
				if ilist[i]:get_name() == first_item:get_name() then
					local second_wear = ilist[i]:get_wear()
					local additional_wear = -0.02
					local total_wear = 65536 - ( (65536 - first_item:get_wear()) + (65536 - second_wear) + 65536 * additional_wear )
					-- remove both items
					d_ilist[i] = ilist[i]:peek_item(ilist[i]:get_count() - 1)
					d_ilist[first_index] = first_item:peek_item(first_item:get_count() - 1)
					-- generate new tool
					local new_tool = ItemStack(ilist[i]:get_name().." "..ilist[i]:get_count())
					if total_wear < 0 then
						new_tool:set_wear(0)
					else
						new_tool:set_wear(total_wear)
					end
					return {new_tool}, d_ilist
				end
			end
		end
	end
end

local function wbcraft_output(rcdata, ilist, iw)
	local ih = #ilist / iw
	-- ensure amount of crafting ingredients is the same
	-- craft items amount
	local fitems = 0
	for i = 1, #ilist do
		if ilist[i]:is_empty() ~= true then
			fitems = fitems + 1 -- full length of craft
		end
	end
	-- recipe items amount
	local ritems = 0
	for i = 1, rcdata.i_height do
		for j = 1, rcdata.i_width do
			if rcdata.input[i][j] ~= "" then
				ritems = ritems + 1
			end
		end
	end
	-- ensure craft item amount == recipe item amount
	if fitems ~= ritems then
		return nil
	end
	-- shapeless crafting
	if rcdata.mod == "shapeless" then
		local oamt = 0
		local d_ilist = table.copy(ilist) -- decremented list
		local ilist2 = table.copy(ilist) -- list to match
		for i = 1, rcdata.i_height do
			for j = 1, rcdata.i_width do
				local ritem = ItemStack(rcdata.input[i][j]) -- recipe item
				local ilist_match, citem, cindex, maxamt = shapeless_match(ilist2, ritem)
				if ilist_match then
					-- construct decremented list
					local d_citem = citem:peek_item(citem:get_count() - ritem:get_count())
					d_ilist[cindex] = d_citem
					-- remove match to prevent doublecount
					ilist2 = ilist_match
					-- get max multiplier
					if maxamt ~= 0 then
						if oamt == 0 or maxamt < oamt then
							oamt = maxamt
						end
					end
				end
			end
		end
		-- ensure list has been fully processed and all matches are empty
		for i in pairs(ilist2) do
			if ilist2[i]:is_empty() ~= true then
				return nil
			end
		end
		if oamt > 0 then
			if rcdata.replacements[1] then
				craft_replacements(ilist, rcdata, d_ilist)
			end
			local oplist = transfer_metadata(ilist, rcdata) or workbench.to_invlist(rcdata.output)
			return oplist, oamt, d_ilist, rcdata.time, rcdata.input, rcdata.replacements, rcdata.residue, rcdata.extra
		else
			return nil
		end
	end
	-- shaped crafting
	local oamt = 0
	local d_ilist = table.copy(ilist) -- decremented list
	if iw == rcdata.i_width and ih == rcdata.i_height then
		for i = 1, #ilist do
			local rrow = math.ceil(i / iw)
			local rcol = i - (rrow - 1) * iw
			local ritem = ItemStack(rcdata.input[rrow][rcol]) -- recipe item
			local citem = ilist[i] -- input item
			-- ensure enough count and matches name, if not return nil (name matches)
			if (ritem:get_name() == citem:get_name() or groupcheck(ritem, citem)) then -- name match or group match
				if citem:get_count() >= ritem:get_count() then
					-- construct decremented list
					local d_citem = citem:peek_item(citem:get_count() - ritem:get_count())
					d_ilist[i] = d_citem
					-- get max multiplier
					local maxamt = math.floor(citem:get_count() / ritem:get_count())
					if maxamt ~= 0 then
						if oamt == 0 or maxamt < oamt then
							oamt = maxamt
						end
					end
				else
					return nil
				end
			else
				return nil
			end
		end
	else
		local istart = get_startindex(ilist)
		local istartrow = 1
		-- ensure grid isn't empty
		if not istart then
			return nil
		end
		-- get starting row
		if istart > iw then
			istartrow = math.ceil(istart / iw)
		end
		-- run within starting row & total row
		for i = istartrow, (istartrow + rcdata.i_height - 1) do
			for j = 1, rcdata.i_width do
				local ritem = ItemStack(rcdata.input[i - istartrow + 1][j]) -- recipe item
				local cindex = istart + ((i - istartrow) * iw) + j - 1
				local citem = ilist[cindex] -- craft item
				-- ensure enough count and matches name, if not return nil
				if (ritem:get_name() == citem:get_name() or groupcheck(ritem, citem)) then -- name match or group match
					if citem:get_count() >= ritem:get_count() then
						-- construct decremented list
						local d_citem = citem:peek_item(citem:get_count() - ritem:get_count())
						d_ilist[cindex] = d_citem
						-- get max multiplier
						local maxamt = math.floor(ritem:get_count())
						if maxamt ~= 0 then
							if oamt == 0 or maxamt < oamt then
								oamt = maxamt
							end
						end
					else
						return nil
					end
				else
					return nil
				end
			end
		end
	end
	if oamt > 0 then
		-- if replacements exists modify list accordingly
		if rcdata.replacements[1] then
			craft_replacements(ilist, rcdata, d_ilist)
		end
		local oplist = transfer_metadata(ilist, rcdata) or workbench.to_invlist(rcdata.output)
		return oplist, oamt, d_ilist, rcdata.time, rcdata.input, rcdata.replacements, rcdata.residue, rcdata.extra
	else
		return nil
	end
end

-- combined output function
-- inventory list, craft type, craft category, list width
function workbench.craft_output(ilist, ctype, cat, iw)
	-- workbench crafts
	local rclist = workbench.crafts[ctype]
	for i in pairs(rclist) do -- run through recipe data
		if rclist[i].cat == cat then -- ensure same category
			local output, amount, dinput, otime, recipe, replacements, residue, extra = wbcraft_output(rclist[i], ilist, iw)
			if output then
				return output, amount, dinput, otime, recipe, replacements, residue, extra
			end
		end
	end
	-- new toolrepair to overwrite -- default toolrepair wear isn't obtainable > provide backward compability
	local tr_output, tr_dinput = toolrepair(ilist)
	if tr_output then
		return tr_output, 1, tr_dinput, 0, nil, {}, {}, {}
	end
	-- default crafting
	if ctype == "normal" or ctype == "cooking" then -- backward compability for default crafts
		local output, dinput = minetest.get_craft_result({method = ctype, width = iw, items = ilist})
		if output and output.item then
			-- obtain max possible crafts
			local doamt = 0
			for i = 1, #ilist do
				local citem = ilist[i]
				local newcount = citem:get_count()
				if newcount ~= 0 then
					if doamt == 0 or newcount < doamt then
						doamt = newcount
					end
				end
			end
			if output.item:get_count() > 0 and doamt > 0 then
				local olist = workbench.to_invlist({{output.item:get_name().." "..output.item:get_count()}})
				return olist, doamt, dinput.items, output.time, nil, output.replacements, {}, {}
			end
		end
	end
end