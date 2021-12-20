function ccore.register_craftcopy(copy_from, copy_to)
	minetest.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
		if itemstack:get_name() ~= copy_to then
			return
		end
		local original
		for i = 1, #old_craft_grid do
			if old_craft_grid[i]:get_name() == copy_from then
				original = old_craft_grid[i]
			end
		end
		if not original then
			return
		end
		local copymeta = original:get_meta():to_table()
		itemstack:get_meta():from_table(copymeta)
	end)
end