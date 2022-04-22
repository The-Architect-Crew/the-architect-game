workbench.crafts = {}
function workbench:register_crafttype(name)
	workbench.crafts[name] = {}
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
	rdata.items = {}
	for i = 1, height do
		for j = 1, width do
			local ni = #rdata.items + 1
			local ritem = ItemStack(input[i][j])
			rdata.items[ni] = {}
			rdata.items[ni].stack = ritem
			rdata.items[ni].name = ritem:get_name()
			rdata.items[ni].count = ritem:get_count()
		end
	end
	return rdata
end

local function send_error(ctype, ercat, input, output, errordesc)
	minetest.log("error", "[workbench] Error registering recipe - "..errordesc..
		": type: "..ctype..", category: "..ercat..", input: "..dump(input)..", output: "..dump(output))
end

function workbench:register_craft(def)
	def = def or {}
	local ctype = def.type or "normal"
	-- ERROR CHECKS
	-- ensure essential values are present
	local ercat = def.cat or "none"
	if not def.output or not def.input or not ctype then
		return send_error(ctype, ercat, def.input, def.output, "Incorrect recipe format")
	end
	-- ensure valid format
	if type(def.output[1]) ~= "table" or type(def.input[1]) ~= "table" then
		return send_error(ctype, ercat, def.input, def.output, "Invalid input/output format")
	end
	-- ensure craft type is already registered first
	if not workbench.crafts[ctype] then
		return send_error(ctype, ercat, def.input, def.output, "Invalid crafting type")
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
	-- save data
	local iwidth = #def.input[1]
	local iheight = #def.input
	local rdata = cache_recipe(def.input, iwidth, iheight)
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
		-- input data
		i_width = iwidth,
		i_height = iheight,
		i_size = (#def.input[1] * #def.input),
		i_stacks = get_recipe_stacks(def.input, iwidth, iheight),
		i_items = rdata.items,
		-- output data
		o_width = #def.output[1],
		o_height = #def.output,
	})
end