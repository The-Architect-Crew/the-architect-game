-- get starting index (first item in a recipe)
local function get_startindex(ilist, input_width, input_height)
	for i = 1, #ilist do
		if ilist[i]:is_empty() ~= true then
			if i == 1 then
				return i
			else
				local curr_row = math.ceil(i / input_width)
				local curr_col = (i % input_width)
				if curr_col == 0 then
					curr_col = input_width
				end
				for col = 1, (curr_col - 1) do
					for row = curr_row, input_height do
						local index = (row - 1) * input_width + col
						if ilist[index]:is_empty() ~= true then
							return (curr_row - 1) * input_width + col;
						end
					end
				end
				return i
			end
		end
	end
end

-- group matches
local function groupcheck(recipe_name, input_name)
	local prefix, groupname = string.match(recipe_name, '(.*):'), string.match(recipe_name, ':(.*)')
	if prefix == "group" then
		-- form a list of groups required separated by commas
		local group_list = {}
		for group in string.gmatch(groupname, '([^,]+)') do
			table.insert(group_list, group)
		end
		-- check item fulfill all groups
		for i = 1, #group_list do
			if minetest.get_item_group(input_name, group_list[i]) == 0 then
				return nil
			end
		end
		return true
	end
end

-- shapeless matches
local function shapeless_match(ilist2, recipe_item)
	local recipe_name = recipe_item:get_name()
	local recipe_count = recipe_item:get_count()
	for i in pairs(ilist2) do
		if ilist2[i] then
			local input_item = ilist2[i]
			local input_name = input_item:get_name()
			local input_count = input_item:get_count()
			-- find matches
			if (recipe_name == input_name or groupcheck(recipe_name, input_name)) then -- name match or group match
				if input_count >= recipe_count then -- TODO: match higher count recipe with higher count items rather than grabbing the first found
					local maxamt = math.floor(input_count / recipe_count)
					ilist2[i] = nil -- remove match to prevent doublecount
					return ilist2, input_item, i, maxamt
				end
			end
		end
	end
end

-- add replacements to decremented inputs
local function craft_replacements(ilist, rinput_data, d_ilist)
	local rplist = rinput_data.replacements
	for i in ipairs(rplist) do
		local rd_item = ItemStack(rplist[i][1]) -- to be replaced item
		local rg_item = ItemStack(rplist[i][2]) -- replacing item
		local rd_name = rd_item:get_name()
		for j = 1, #ilist do
			if d_ilist[j]:is_empty() then -- ensure slot is empty and hence replaceable
				local input_item = ilist[j]
				local input_name = input_item:get_name()
				if (rd_name == input_name or groupcheck(rd_name, input_name)) then -- name match or group match
					d_ilist[j] = rg_item
					break
				end
			end
		end
	end
end

-- transferring meta from input to output
local function transfer_metadata(ilist, rinput_data, odata)
	if odata.transfer_meta[1] then
		local tmlist = odata.transfer_meta
		local oplist = odata.items
		for i in ipairs(tmlist) do
			local fr_item = ItemStack(tmlist[i][1]) -- item to extract metadata
			local to_item = ItemStack(tmlist[i][2]) -- item to transfer metadata
			local fr_name = fr_item:get_name()
			local to_name = to_item:get_name()
			for j = 1, #ilist do
				local input_item = ilist[j]
				local input_name = input_item:get_name()
				if (fr_name == input_name or groupcheck(fr_name, input_name)) then -- name match or group match
					for k = 1, #oplist do
						local oitem = oplist[k]
						local oname = oitem:get_name()
						if (to_name == oname or groupcheck(to_name, oname)) then -- name match or group match
							local copymeta = input_item:get_meta():to_table()
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

local function wbcraft_compare(rinput_data, ilist, input_data)
	local recipe_data = rinput_data.items
	-- shapeless crafting
	if rinput_data.mod == "shapeless" then
		local ilist2 = table.copy(ilist) -- list to match
		for i = 1, rinput_data.height do
			for j = 1, rinput_data.width do
				local recipe_item = ItemStack(rinput_data.input[i][j]) -- recipe item
				local ilist_match = shapeless_match(ilist2, recipe_item)
				if ilist_match then
					-- remove match to prevent doublecount
					ilist2 = ilist_match
				end
			end
		end
		-- ensure list has been fully processed and all matches are empty
		for i in pairs(ilist2) do
			if ilist2[i]:is_empty() ~= true then
				return nil
			end
		end
		return "shapeless"
	end

	-- shaped crafting
	if input_data.width == rinput_data.width and input_data.height == rinput_data.height then -- input size == recipe size
		for i = 1, input_data.length do
			local recipe_name = recipe_data[i].name
			local recipe_count = recipe_data[i].count
			local input_name = input_data.items[i].name
			local input_count = input_data.items[i].count
			-- ensure enough count and matches name, if not return nil (name matches)
			if recipe_name ~= input_name and not groupcheck(recipe_name, input_name) -- both name and group doesn't match
				or input_count < recipe_count then -- not enough count
				return nil
			end
		end
		return "shaped_fit"
	else
		local istart = get_startindex(ilist, input_data.width, input_data.height)
		local istartrow = 1
		-- ensure grid isn't empty
		if not istart then
			return nil
		end
		-- get starting row
		if istart > input_data.width then
			istartrow = math.ceil(istart / input_data.width)
		end
		-- run within starting row & total row
		for i = istartrow, (istartrow + rinput_data.height - 1) do
			for j = 1, rinput_data.width do
				local rindex = ((i - istartrow) * rinput_data.width) + j
				local recipe_name = recipe_data[rindex].name
				local recipe_count = recipe_data[rindex].count
				local cindex = istart + ((i - istartrow) * input_data.width) + j - 1
				if (input_data.items[cindex]) then
					local input_name = input_data.items[cindex].name
					local input_count = input_data.items[cindex].count
					-- ensure enough count and matches name, if not return nil
					if recipe_name ~= input_name and not groupcheck(recipe_name, input_name) -- both name and group doesn't match
						or input_count < recipe_count then -- not enough count
						return nil
					end
				else
					return nil
				end
			end
		end
		return "shaped_big"
	end
end

local function wbcraft_genoutput(ctype, rinput_data, ilist, input_data, cresult, listall)
	local recipe_data = rinput_data.items
	local odata = workbench_crafts.output[ctype][rinput_data.id] -- output data
	local camt = 0
	local d_ilist = table.copy(ilist) -- decremented list

	if cresult == "shapeless" then
		local ilist2 = table.copy(ilist) -- list to match
		for i = 1, rinput_data.height do
			for j = 1, rinput_data.width do
				local recipe_item = ItemStack(rinput_data.input[i][j]) -- recipe item
				local ilist_match, input_item, cindex = shapeless_match(ilist2, recipe_item)
				local recipe_count = recipe_item:get_count()
				local input_count = input_item:get_count()
				if ilist_match then
					-- remove match to prevent doublecount
					ilist2 = ilist_match
					-- construct decremented list
					local d_input_item = input_item:peek_item(input_count - recipe_count)
					d_ilist[cindex] = d_input_item
					local maxamt = math.floor(input_count / recipe_count)
					if maxamt ~= 0 then
						if camt == 0 or maxamt < camt then
							camt = maxamt
						end
					end
				end
			end
		end
		-- if replacements exists modify list accordingly
		if rinput_data.replacements[1] then
			craft_replacements(ilist, rinput_data, d_ilist)
		end
		return camt, d_ilist, odata
	elseif cresult == "shaped_fit" then
		for i = 1, input_data.length do
			local recipe_count = recipe_data[i].count
			local input_item = ilist[i] -- input item
			local input_count = input_data.items[i].count

			if recipe_data[i].name ~= "" then -- ensure it is not an empty item
				if input_count >= recipe_count then -- ensure enough count
					-- construct decremented list
					local d_input_item = input_item:peek_item(input_count - recipe_count)
					d_ilist[i] = d_input_item
					-- get max multiplier
					local maxamt = math.floor(input_count / recipe_count)
					if maxamt ~= 0 then
						if camt == 0 or maxamt < camt then
							camt = maxamt
						end
					end
				end
			end
		end
	elseif cresult == "shaped_big" then
		local istart = get_startindex(ilist, input_data.width, input_data.height)
		local istartrow = 1
		-- ensure grid isn't empty
		if not istart then
			return nil
		end
		-- get starting row
		if istart > input_data.width then
			istartrow = math.ceil(istart / input_data.width)
		end
		-- run within starting row & total row
		for i = istartrow, (istartrow + rinput_data.height - 1) do
			for j = 1, rinput_data.width do
				local rindex = ((i - istartrow) * rinput_data.width) + j
				local recipe_count = recipe_data[rindex].count
				local cindex = istart + ((i - istartrow) * input_data.width) + j - 1
				local input_item = ilist[cindex] -- craft item

				--if (input_data.items[cindex]) then
					local input_count = input_data.items[cindex].count

					if recipe_data[rindex].name ~= "" then -- ensure it is not an empty item
						if input_count >= recipe_count then -- ensure enough count
							-- construct decremented list
							local d_input_item = input_item:peek_item(input_count - recipe_count)
							d_ilist[cindex] = d_input_item
							-- get max multiplier
							local maxamt = math.floor(input_count / recipe_count)
							if maxamt ~= 0 then
								if camt == 0 or maxamt < camt then
									camt = maxamt
								end
							end
						end
					end
				--end
			end
		end
	end

	if camt > 0 then
		-- if replacements exists modify list accordingly
		if rinput_data.replacements[1] then
			craft_replacements(ilist, rinput_data, d_ilist)
		end
		return camt, d_ilist, odata
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

local function multiply_output(olist, multiplier)
	local m_olist = {}
	for i in ipairs(olist) do
		local current_count = olist[i]:get_count()
		local stackcopy = ItemStack(olist[i])
		stackcopy:set_count(current_count * multiplier)
		m_olist[i] = stackcopy
	end
	return m_olist
end

local function check_max_possible_multiplier(olist)
	local h_multipler
	local l_multipler
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

local function cache_input(ilist, input_width)
	local input_data = {}
	-- full length of craft
	local scount = 0
	for i = 1, #ilist do
		if ilist[i]:is_empty() ~= true then
			scount = scount + 1
		end
	end
	input_data.stacks = scount
	input_data.length = #ilist
	input_data.height = #ilist / input_width
	input_data.width = input_width
	-- cache all names and counts
	input_data.items = {}
	for i = 1, #ilist do
		local input_item = ilist[i]
		input_data.items[i] = {}
		input_data.items[i].stack = input_item
		input_data.items[i].name = input_item:get_name()
		input_data.items[i].count = input_item:get_count()
	end
	return input_data
end

local function craft_multiply(final_input, ctype, multi, rinput_data, input_data, cresult, output, oamt, maxamt, listall)
	local min_multi = check_max_possible_multiplier(output[oamt].items)
	local m_output = transfer_metadata(final_input, rinput_data, output[oamt]) or output[oamt].items
	local runamt
	if multi >= maxamt then
		runamt = maxamt
	elseif multi < maxamt then
		runamt = multi
	end
	-- run loops to calculate multiplied values
	for j = 1, runamt do
		local newinput_data = cache_input(final_input, input_data.width)
		local r_maxamt, r_dinput, noutput = wbcraft_genoutput(ctype, rinput_data, final_input, newinput_data, cresult, listall)
		if not noutput[oamt].items or r_maxamt < 1  -- break the loop if there's no valid output
			or not check_list_matches(m_output, noutput[oamt].items) -- break the loop if output name/count is different
			or j > min_multi then
			return {
				item = multiply_output(m_output, j - 1),
				max = r_maxamt,
				dinput = final_input,
				time = rinput_data.time,
				recipe = rinput_data.input,
				replacements = rinput_data.replacements,
				residue = output[oamt].residue,
				extra = output[oamt].extra,
				multiply = j - 1,
			}
		end
		final_input = r_dinput -- update decremented input
	end
	return {
		item = multiply_output(m_output, runamt),
		max = 1,
		dinput = final_input,
		time = rinput_data.time,
		recipe = rinput_data.input,
		replacements = rinput_data.replacements,
		residue = output[oamt].residue,
		extra = output[oamt].extra,
		multiply = runamt,
	}
end

local function craft_genmultiply(ilist, ctype, multiplier, rinput_data, input_data, cresult, listall)
	local multi = multiplier or 1
	local maxamt, _, output = wbcraft_genoutput(ctype, rinput_data, ilist, input_data, cresult, listall) -- generate base output
	local oamt = #output
	if not listall then
		return craft_multiply(ilist, ctype, multi, rinput_data, input_data, cresult, output, oamt, maxamt)
	elseif listall then
		local listall_output = {}
		for i = 1, oamt do
			listall_output[#listall_output + 1] = craft_multiply(ilist, ctype, multi, rinput_data, input_data, cresult, output, i, maxamt, listall)
		end
		return listall_output
	end
end

-- combined output function
function workbench.craft_output(ilist, ctype, cat, input_width, multiplier, listall)
	-- ensure valid input list
	if not ilist or #ilist < 1 then
		return nil
	end
	-- workbench crafts
	local recipes_list = workbench_crafts.input[ctype]
	local multi = multiplier or 1
	local input_data = cache_input(ilist, input_width)
	for i, rinput_data in pairs(recipes_list) do -- run through recipe list data
		if rinput_data.cat == cat then -- ensure same category
			if input_data.stacks == rinput_data.stacks then -- ensure craft item amount == recipe item amount
				local cresult = wbcraft_compare(rinput_data, ilist, input_data) -- compare individual stack to ensure it matches
				if cresult then
					local multioutput = craft_genmultiply(ilist, ctype, multiplier, rinput_data, input_data, cresult, listall)
					return multioutput
				end
			end
		end
	end
	-- new toolrepair to overwrite -- default toolrepair wear isn't obtainable > provide backward compability
	local tr_output, tr_dinput = toolrepair(ilist)
	if tr_output then
		return {
			item = tr_output,
			max = 1,
			dinput = tr_dinput,
			time = 0,
			recipe = nil,
			replacements = {},
			residue = {},
			extra = {},
			multiply = 1
		}
	end
	-- default crafting
	if ctype == "normal" or ctype == "cooking" then -- backward compability for default crafts
		-- single output
		if multi == 1 then
			local output, dinput = minetest.get_craft_result({method = ctype, width = input_width, items = ilist})
			if output and output.item then
				-- obtain max possible crafts
				local doamt = 0
				for i = 1, #ilist do
					local input_item = ilist[i]
					local newcount = input_item:get_count()
					if newcount ~= 0 then
						if doamt == 0 or newcount < doamt then
							doamt = newcount
						end
					end
				end
				if output.item:get_count() > 0 and doamt > 0 then
					local olist = workbench.to_invlist({{output.item:get_name().." "..output.item:get_count()}})
					return {
						item = olist,
						max = doamt,
						dinput = dinput.items,
						time = output.time,
						recipe = nil,
						replacements = output.replacements,
						residue = {},
						extra = {},
						multiply = 1
					}
				end
			end
		-- multiple output
		elseif multi > 1 then
			local final_input = ilist
			local match_output
			local output = minetest.get_craft_result({method = ctype, width = input_width, items = ilist})
			if output and not output.item:is_empty() then
				for i = 1, multi do
					local r_output, r_dinput = minetest.get_craft_result({method = ctype, width = input_width, items = final_input})
					if r_output and r_output.item then
						if not match_output then
							match_output = r_output
							final_input = r_dinput.items
						elseif match_output.item:get_name() ~= r_output.item:get_name() -- break the loop if output name is different
							or match_output.item:get_count() ~= r_output.item:get_count() -- break the loop if output count is different
							or (match_output.item:get_count() * i) > match_output.item:get_stack_max() then -- break the loop if it exceeds max output stack
							local olist = workbench.to_invlist({{match_output.item:get_name().." "..(match_output.item:get_count() * (i - 1))}})
							return {
								item = olist,
								max = 1,
								dinput = final_input,
								time = match_output.time,
								recipe = nil,
								replacements = match_output.replacements,
								residue = {},
								extra = {},
								multiply = i - 1
							}
						else
							final_input = r_dinput.items
						end
					else -- break the loop if there's no valid output
						local olist = workbench.to_invlist({{match_output.item:get_name().." "..(match_output.item:get_count() * (i - 1))}})
						return {
							item = olist,
							max = 1,
							dinput = final_input,
							time = match_output.time,
							recipe = nil,
							replacements = match_output.replacements,
							residue = {},
							extra = {},
							multiply = i - 1
						}
					end
				end
				local olist = workbench.to_invlist({{match_output.item:get_name().." "..(match_output.item:get_count() * multi)}})
				return {
					item = olist,
					max = 1,
					dinput = final_input,
					time = match_output.time,
					recipe = nil,
					replacements = match_output.replacements,
					residue = {},
					extra = {},
					multiply = multi
				}
			end
		end
	end
end