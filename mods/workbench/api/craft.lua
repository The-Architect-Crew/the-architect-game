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

local function wbcraft_output(rcdata, ilist, cdata, rdata)
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
	if cdata.width == rcdata.i_width and cdata.height == rcdata.i_height then
		for i = 1, cdata.length do
			local rrow = math.ceil(i / cdata.width)
			local rcol = i - (rrow - 1) * cdata.width
			local ritem = rdata.items[i].stack -- recipe item
			local rname = rdata.items[i].name
			local rcount = rdata.items[i].count
			local citem = ilist[i] -- input item
			local cname = cdata.items[i].name
			local ccount = cdata.items[i].count
			-- ensure enough count and matches name, if not return nil (name matches)
			if (rname == cname or groupcheck(ritem, citem)) then -- name match or group match
				if ccount >= rcount then
					-- construct decremented list
					local d_citem = citem:peek_item(ccount - rcount)
					d_ilist[i] = d_citem
					-- get max multiplier
					local maxamt = math.floor(ccount / rcount)
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
		if istart > cdata.width then
			istartrow = math.ceil(istart / cdata.width)
		end
		-- run within starting row & total row
		for i = istartrow, (istartrow + rcdata.i_height - 1) do
			for j = 1, rcdata.i_width do
				local rindex = ((i - istartrow) * rdata.width) + j
				local ritem = rdata.items[rindex].stack -- recipe item
				local rname = rdata.items[rindex].name
				local rcount = rdata.items[rindex].count
				local cindex = istart + ((i - istartrow) * cdata.width) + j - 1
				local citem = ilist[cindex] -- craft item
				local cname = cdata.items[cindex].name
				local ccount = cdata.items[cindex].count
				-- ensure enough count and matches name, if not return nil
				if (rname == cname or groupcheck(ritem, citem)) then -- name match or group match
					if ccount >= rcount then
						-- construct decremented list
						local d_citem = citem:peek_item(ccount - rcount)
						d_ilist[cindex] = d_citem
						-- get max multiplier
						local maxamt = math.floor(rcount)
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

-- check for invlist matches, returns true if everything matches else returns nil
local function check_list_matches(old_list, new_list)
	if not old_list or not new_list then
		return nil
	end
	for i in ipairs(old_list) do
		if old_list[i]:get_name() ~= new_list[i]:get_name() then
			return nil
		end
		if old_list[i]:get_count() ~= new_list[i]:get_count() then
			return nil
		end
	end
	return true
end

local function multiply_output(olist, multiplier, multipler_table)
	for i in ipairs(olist) do
		local current_count = olist[i]:get_count()
		if multipler_table then
			olist[i]:set_count(current_count * multipler_table[i])
		else
			olist[i]:set_count(current_count * multiplier)
		end
	end
	return olist
end

local function check_max_possible_multiplier(olist)
	local h_multipler
	local l_multipler
	local multipler_table
	for i in ipairs(olist) do
		local c_count = olist[i]:get_count()
		local m_count = olist[i]:get_stack_max()
		local m_multi = math.floor(m_count / c_count)
		if not h_multipler or not l_multipler then
			h_multipler = m_multi
			l_multipler = m_multi
		end
		if h_multipler < m_multi then -- get highest possible multipler
			h_multipler = m_multi
		elseif l_multipler > m_multi then -- get lowest possible multipler
			l_multipler = m_multi
		end
	end	
	return l_multipler, h_multipler
end

local function cache_input(ilist, iw)
	local cdata = {}
	-- full length of craft
	local scount = 0
	for i = 1, #ilist do
		if ilist[i]:is_empty() ~= true then
			scount = scount + 1 
		end
	end
	cdata.stacks = scount
	cdata.length = #ilist
	cdata.height = #ilist / iw
	cdata.width = iw
	-- cache all names and counts
	cdata.items = {}
	for i = 1, #ilist do
		local citem = ilist[i]
		cdata.items[i] = {}
		cdata.items[i].stack = citem
		cdata.items[i].name = citem:get_name()
		cdata.items[i].count = citem:get_count()
	end
	return cdata
end

local function cache_recipe(rcdata)
	local rdata = {}
	rdata.length = #rcdata
	rdata.height = rcdata.i_height
	rdata.width = rcdata.i_width
	-- cache all names and counts
	rdata.items = {}
	for i = 1, rdata.height do
		for j = 1, rdata.width do
			local ni = #rdata.items + 1
			local ritem = ItemStack(rcdata.input[i][j])
			rdata.items[ni] = {}
			rdata.items[ni].stack = ritem
			rdata.items[ni].name = ritem:get_name()
			rdata.items[ni].count = ritem:get_count()
		end
	end
	return rdata
end

local function craft_multiply(ilist, multiplier, rcdata, output, cdata, rdata)
	local multi = multiplier or 1
	local final_input = ilist
	local match_output = output
	local min_multi = check_max_possible_multiplier(output)
	for j = 1, multi do
		local cdata = cache_input(final_input, cdata.width)
		local r_output, r_amount, r_dinput = wbcraft_output(rcdata, final_input, cdata, rdata) -- find craft
		if not r_output or r_amount < 1 -- break the loop if there's no valid output
			or not check_list_matches(match_output, r_output) -- break the loop if output name/count is different
			or j > min_multi then -- break the loop if it exceeds max output stack
			return {multiply_output(output, j - 1), r_amount, final_input, j - 1}
		end
		final_input = r_dinput -- update decremented input
	end
	return {multiply_output(output, multi), 1, final_input, multi}
end

local function get_recipe_stacks(rcdata)
	-- recipe items amount
	local scount = 0
	for i = 1, rcdata.i_height do
		for j = 1, rcdata.i_width do
			if rcdata.input[i][j] ~= "" then
				scount = scount + 1
			end
		end
	end
	return scount
end

-- combined output function
-- inventory list, craft type, craft category, list width
function workbench.craft_output(ilist, ctype, cat, iw, multiplier, listall)
	-- ensure valid input list
	if not ilist or #ilist < 1 then
		return nil
	end
	-- workbench crafts
	local rclist = workbench.crafts[ctype]
	local multi = multiplier or 1
	local listall_output = {}
	local cdata = cache_input(ilist, iw)
	for i in pairs(rclist) do -- run through recipe data
		if rclist[i].cat == cat then -- ensure same category
			if cdata.stacks == get_recipe_stacks(rclist[i]) then -- ensure craft item amount == recipe item amount
				local rdata = cache_recipe(rclist[i])
				local output, amount, dinput, otime, recipe, replacements, residue, extra = wbcraft_output(rclist[i], ilist, cdata, rdata)
				if output then -- run through recipe list and find a match
					local multioutput = craft_multiply(ilist, multiplier, rclist[i], output, cdata, rdata)
					if not listall then -- return single output
						return multioutput[1], multioutput[2], multioutput[3], otime, recipe, replacements, residue, extra, multioutput[4]
					elseif listall then -- store multiple output
						listall_output[#listall_output + 1] = {item = multioutput[1], max = multioutput[2], dinput = multioutput[3], time = otime, recipe = recipe, replacements = replacements, residue = residue, extra = extra, multiply = multioutput[4]}
					end
				end
			end
		end
	end
	if listall and #listall_output > 0 then -- return multiple output
		return listall_output
	end
	-- new toolrepair to overwrite -- default toolrepair wear isn't obtainable > provide backward compability
	local tr_output, tr_dinput = toolrepair(ilist)
	if tr_output then
		return tr_output, 1, tr_dinput, 0, nil, {}, {}, {}
	end
	-- default crafting
	if ctype == "normal" or ctype == "cooking" then -- backward compability for default crafts
		-- single output
		if multi == 1 then
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
					return olist, doamt, dinput.items, output.time, nil, output.replacements, {}, {}, 1
				end
			end
		-- multiple output
		elseif multi > 1 then
			local final_input = ilist
			local match_output
			for i = 1, multi do
				local r_output, r_dinput = minetest.get_craft_result({method = ctype, width = iw, items = final_input})
				if r_output and r_output.item then
					if not match_output then
						match_output = r_output
						final_input = r_dinput.items
					elseif match_output.item:get_name() ~= r_output.item:get_name() -- break the loop if output name is different
						or match_output.item:get_count() ~= r_output.item:get_count() -- break the loop if output count is different
						or (match_output.item:get_count() * i) > match_output.item:get_stack_max() then -- break the loop if it exceeds max output stack
						local olist = workbench.to_invlist({{match_output.item:get_name().." "..(match_output.item:get_count() * (i - 1))}})
						return olist, 1, final_input, match_output.time, nil, match_output.replacements, {}, {}, i - 1
					else
						final_input = r_dinput.items
					end
				else -- break the loop if there's no valid output
					local olist = workbench.to_invlist({{match_output.item:get_name().." "..(match_output.item:get_count() * (i - 1))}})
					return olist, 1, final_input, match_output.time, nil, match_output.replacements, {}, {}, i - 1
				end
			end
			local olist = workbench.to_invlist({{match_output.item:get_name().." "..(match_output.item:get_count() * multi)}})
			return olist, 1, final_input, match_output.time, nil, match_output.replacements, {}, {}, multi
		end
	end
end