workbench = {}
local path = minetest.get_modpath("workbench")
dofile(path.."/api/craft.lua")
dofile(path.."/api/fuel.lua")
-- Builtin craft types
workbench:register_crafttype("normal")
workbench:register_crafttype("cooking")
workbench:register_fueltype("normal")

function workbench.calc_pos(index, start_x, start_y, row)
	local crow = math.ceil(index / row) - 1
	local new_x = (index - crow * row - 1) * 1.25 + start_x
	local new_y = crow * 1.25 + start_y
	return new_x..","..new_y
end

function workbench.output_stack(outlist)
	local ocount = 0
	for i in ipairs(outlist) do
		local stack = outlist[i]
		if stack:is_empty() ~= true then
			ocount = ocount + 1
		end
	end
	return ocount
end

function workbench.debug(output, amount, d_input, otime, recipe, replacements, residue, extra)
	print("===== start of workbench debug ======")
	print("Output: "..dump(output))
	print("Amount: "..amount)
	print("Decremented: "..dump(d_input))
	print("Time: "..otime)
	print("Recipe: "..dump(recipe))
	print("Replacements: "..dump(replacements))
	print("Residue: "..dump(residue))
	print("Extra: "..dump(extra))
	print("===== end of workbench debug ======")
end

dofile(path.."/craftbench.lua")
dofile(path.."/furnace.lua")