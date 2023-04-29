workbench_crafts = {}
workbench_crafts.input = {}
workbench_crafts.output = {}
workbench_crafts.output_by_name = {}
workbench_crafts.data = {}

-- new craft type
function workbench:register_crafttype(name, def)
	workbench_crafts.input[name] = {}
	workbench_crafts.output[name] = {}
	workbench_crafts.data[name] = {}

	if def then
		local ctype_data = workbench_crafts.data[name]
		if def.description then
			ctype_data.description = def.description
		end

		if def.icon then
			ctype_data.icon = def.icon
		end
	end
end

-- get input size
local function get_recipe_stacks(input, width, height)
	-- recipe items amount
	local scount = 0
	for i = 1, height do
		for j = 1, width do
			if input[i][j] ~= "" then
				scount = scount + 1
			end
		end
	end
	return scount
end

local function cache_recipe(input, width, height)
	local rdata = {}
	-- cache all names and counts
	for i = 1, height do
		for j = 1, width do
			local ni = #rdata + 1
			local ritem = ItemStack(input[i][j])
			rdata[ni] = {}
			rdata[ni].stack = ritem -- recipe item stack
			rdata[ni].name = ritem:get_name() -- recipe item name
			rdata[ni].count = ritem:get_count() -- recipe item count
		end
	end
	return rdata -- table of a single recipe consisting of all above data
end

local function send_error(ctype, ercat, input, output, errordesc)
	minetest.log("error", "[workbench] Error registering recipe - "..errordesc..
		": type: "..ctype..", category: "..ercat..", input: "..dump(input)..", output: "..dump(output))
end

if minetest.settings:get_bool("workbench_disable_crafts") then
	minetest.log("warning", "[workbench] All workbench crafts are disabled!")
end

local function no_match_output(output_table, output_name)
    for index, value in pairs(output_table) do
        if output_name == value then
            return nil
        end
    end
    return true
end

local function trim_front_columns(twidth, def, iwidth, iheight)
	local trimmed_width = twidth
	for col = 1, iwidth do
		for row = 1, iheight do
			if (def.input)[row][col] ~= "" then
				return trimmed_width
			end
		end
		trimmed_width = trimmed_width - 1
	end
	return trimmed_width
end

local function trim_front_rows(theight, def, iwidth, iheight)
	local trimmed_height = theight
	for row = 1, iheight do
		for col = 1, iwidth do
			if (def.input)[row][col] ~= "" then
				return trimmed_height
			end
		end
		trimmed_height = trimmed_height - 1
	end
	return trimmed_height
end

local function trim_back_columns(twidth, input, iwidth, iheight)
	local trimmed_width = twidth
	for col = 0, (iwidth - 1) do
		for row = 1, iheight do
			if (input)[row][iwidth - col] ~= "" then
				return trimmed_width
			end
		end
		trimmed_width = trimmed_width - 1
	end
	return trimmed_width
end

local function trim_back_rows(theight, input, iwidth, iheight)
	local trimmed_height = theight
	for row = 0, (iheight - 1) do
		for col = 1, iwidth do
			if (input)[iheight - row][col] ~= "" then
				return trimmed_height
			end
		end
		trimmed_height = trimmed_height - 1
	end
	return trimmed_height
end

function workbench:register_craft(def)
	if minetest.settings:get_bool("workbench_disable_crafts") then
		return
	end

	def = def or {}
	local ctype = def.type or "normal" -- recipe type
	local ercat = def.category or ""
	local ctime = def.time or 0
	-- ensure essential values are present
	if not def.output or not def.input or not ctype then
		return send_error(ctype, ercat, def.input, def.output, "Incorrect recipe format")
	end
	-- ensure valid format
	if type(def.output[1]) ~= "table" or type(def.input[1]) ~= "table" then
		return send_error(ctype, ercat, def.input, def.output, "Invalid input/output format")
	end
	-- ensure craft type is already registered first
	if not workbench_crafts.input[ctype] then
		return send_error(ctype, ercat, def.input, def.output, "Invalid crafting type")
	end
	-- ensure time is a number
	if not tonumber(ctime) then
		return send_error(ctype, ercat, def.input, def.output, "Invalid time")
	end
	-- ensure width exists
	local first_width = #def.input[1]
	local second_width = #def.output[1]
	if first_width < 1 or second_width < 1 then
		return send_error(ctype, ercat, def.input, def.output, "Invalid width")
	end
	-- ensure all input widths are matching
	for i = 1, #def.input do
		if #def.input[i] ~= first_width then
			return send_error(ctype, ercat, def.input, def.output, "Unequal input width")
		end
	end
	-- ensure all output widths are matching
	for i = 1, #def.output do
		if #def.output[i] ~= second_width then
			return send_error(ctype, ercat, def.input, def.output, "Unequal output width")
		end
	end
	-- ensure valid replacements
	if def.replacements and type(def.replacements[1]) ~= "table" then
		return send_error(ctype, ercat, def.input, def.output, "Invalid replacements format")
	end
	-- ensure valid transfer_meta
	if def.transfer_meta and type(def.transfer_meta[1]) ~= "table" then
		return send_error(ctype, ercat, def.input, def.output, "Invalid transfer_meta format")
	end
	-- ensure multi id isn't a number
	if tonumber(def.multi_id) then
		return send_error(ctype, ercat, def.input, def.output, "multi_id must be a string, not a number")
	end

	-- save input data
	local iwidth = #def.input[1] -- recipe width
	local iheight = #def.input -- recipe height

	local trimmed_width = iwidth
	trimmed_width = trim_front_columns(trimmed_width, def, iwidth, iheight)
	local trimmed_height = iheight
	trimmed_height = trim_front_rows(trimmed_height, def, iwidth, iheight)

	local trimmed_input = table.copy(def.input)
	if (trimmed_width ~= iwidth) or (trimmed_height ~= iheight) then
		-- adjust list according to trim
		for row = 1, trimmed_height do
			for col = 1, trimmed_width do
				trimmed_input[row][col] = (def.input)[row + (iheight - trimmed_height)][col + (iwidth - trimmed_width)]
			end
		end
		iwidth = trimmed_width
		iheight = trimmed_height
	end

	iwidth = trim_back_columns(trimmed_width, trimmed_input, iwidth, iheight) --trimmed_width
	iheight = trim_back_rows(trimmed_height, trimmed_input, iwidth, iheight) --trimmed_height

	local new_id = #workbench_crafts.input[ctype] + 1 -- recipe ID
	local stackcount = get_recipe_stacks(trimmed_input, iwidth, iheight)
	local i_items = cache_recipe(trimmed_input, iwidth, iheight)


	local input_index
	if def.multi_id then -- creates singular input for multiple output (create only when it doesn't exist yet)
		local multi_oid = workbench_crafts.output[ctype][def.multi_id]
		if not multi_oid then -- id doesn't exists
			table.insert(workbench_crafts.input[ctype], {
				cat = def.category, -- category
				mod = def.mod, -- modification (supported: shapeless)
				time = ctime, -- timed craft
				width = iwidth, -- width
				height = iheight, -- height
				stacks = stackcount, -- stack count
				items = i_items, -- items table
				input = trimmed_input, -- raw input
				replacements = def.replacements or {},
				id = def.multi_id, -- output id
			})
			workbench_crafts.output[ctype][def.multi_id] = {}
			input_index = #workbench_crafts.input[ctype]
		else
            -- extract input index
            for index, value in pairs(workbench_crafts.input[ctype]) do
                if value.id == def.multi_id then
                    input_index = index
                end
            end
        end
	else
		table.insert(workbench_crafts.input[ctype], {
			cat = def.category, -- category
			mod = def.mod, -- modification (supported: shapeless)
			time = ctime, -- timed craft
			width = iwidth, -- width
			height = iheight, -- height
			stacks = stackcount, -- stack count
			items = i_items, -- items table
			input = trimmed_input, -- raw input
			replacements = def.replacements or {},
			id = new_id, -- output id
		})
		workbench_crafts.output[ctype][new_id] = {}
		input_index = #workbench_crafts.input[ctype]
	end

	-- save output data
	local o_items = workbench.to_invlist(def.output)
	local o_id = def.multi_id or new_id
	table.insert(workbench_crafts.output[ctype][o_id], {
		cat = def.category,
		output = def.output, -- primary output
		items = o_items,
		residue = def.residue or {}, -- secondary output
		extra = def.extra or {}, -- tertiary output
		transfer_meta = def.transfer_meta or {},
		width = #def.output[1],
		height = #def.output,
		id = o_id,
	})
    local output_index = #workbench_crafts.output[ctype][o_id]

	-- cache output by item name
	local output_count = #def.output[1] * #def.output
	if output_count == 1 then
		local output_item = def.output[1][1]
		local output_stack = ItemStack(output_item)
		local output_itemname = output_stack:get_name()
		if not workbench_crafts.output_by_name[output_itemname] then
			workbench_crafts.output_by_name[output_itemname] = {}
		end
		table.insert(workbench_crafts.output_by_name[output_itemname], {
			input_index = input_index,
            output_index = output_index,
			ctype = ctype,
		})
	else -- sort multiple output
        local sorted_output_names = {} -- table to sort output names (prevent duplicates)
        for i = 1, #def.output do -- height
            for j = 1, #def.output do -- width
                local output_item = ItemStack(def.output[i][j])
                local output_itemname = output_item:get_name()
                if no_match_output(sorted_output_names, output_itemname) then
                    sorted_output_names[#sorted_output_names + 1] = output_itemname
                end
            end
        end

        if #sorted_output_names > 0 then
            for index, value in pairs(sorted_output_names) do
                if not workbench_crafts.output_by_name[value] then
                    workbench_crafts.output_by_name[value] = {}
                end
                table.insert(workbench_crafts.output_by_name[value], {
                    input_index = input_index,
                    output_index = output_index,
                    ctype = ctype,
                })
            end
        end
	end
end
