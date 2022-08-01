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

-- get output size
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