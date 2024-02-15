patterns = {}

workbench:register_crafttype("engraving", {
	description = ccore.comment("Engraving", "Use a pattern engraver"),
	icon = "crafticon_patterns.png",
})

patterns.check_limit = function(term, table)
	if (table == nil) then
		return true
	else
		for i=1, #table do
			if (term == table[i]) then
				return true
			end
		end
	end
end

local patterns_path = minetest.get_modpath("patterns")
dofile(patterns_path.."/patterns.lua")
dofile(patterns_path.."/corners.lua")

patterns.all_colors = {"black", "brown", "cyan", "dark_blue", "dark_green", "dark_grey", "dark_pink", "green", "grey", "orange", "pink", "purple", "red", "white", "yellow"}

-- Acrylic (hsl)
patterns.obsidian_colors = {"cyan", "dark_pink", "green", "red"}

-- Colorize
patterns.stone_colors = {"black", "brown", "dark_green"}
patterns.sandstone_colors = {"dark_blue", "dark_green", "pink", "purple"}
patterns.silver_sandstone_colors = {"black", "brown", "cyan", "dark_blue", "dark_green", "dark_grey", "dark_pink", "green", "grey", "orange", "pink", "purple", "red", "white", "yellow"}

-- Registers (30 * number of colors) nodes per material
patterns.register_patterns("blocks:stone", patterns.stone_colors)
patterns.register_patterns("blocks:sandstone", patterns.sandstone_colors)
patterns.register_patterns("blocks:silver_sandstone", patterns.silver_sandstone_colors)
patterns.register_patterns("blocks:obsidian", patterns.obsidian_colors, "hsl")

-- Registers 30 nodes per material
patterns.register_corners("blocks:stone")
