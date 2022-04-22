patterns = {}

patterns.check_limit = function(term, table)
    local state = false
    if (table == nil) then
        state = true
    else
        for i=1, #table do
            if (term == table[i]) then
                state = true
            else
            end
        end
    end
    return state
end

local patterns_path = minetest.get_modpath("patterns")
dofile(patterns_path.."/patterns.lua")
dofile(patterns_path.."/corners.lua")

patterns.all_colors = {"black", "brown", "cyan", "dark_blue", "dark_green", "dark_grey", "dark_pink", "green", "grey", "orange", "pink", "purple", "red", "white", "yellow"}

patterns.stone_colors = {"black", "brown", "green"}
patterns.sandstone_colors = {"dark_blue", "dark_green", "pink", "purple", "red"}
patterns.silver_sandstone_colors = {"black", "brown", "cyan", "dark_blue", "dark_green", "dark_grey", "dark_pink", "green", "grey", "orange", "pink", "purple", "red", "white", "yellow"}

-- Registers (27 * number of colors) nodes per material
patterns.register_patterns("blocks:stone", patterns.stone_colors)
patterns.register_patterns("blocks:sandstone", patterns.sandstone_colors)
patterns.register_patterns("blocks:silver_sandstone", patterns.silver_sandstone_colors)
patterns.register_patterns("blocks:obsidian", {"white"})

-- Registers 30 nodes per material
patterns.register_corners("blocks:stone")
