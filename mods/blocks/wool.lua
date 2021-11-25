local dyes = dye.dyes

for i = 1, #dyes do
	local name, desc = unpack(dyes[i])

	minetest.register_node("blocks:wool_" .. name, {
		description = desc .. " Wool",
		tiles = { "blocks_wool_" .. name .. ".png" },
		is_ground_content = false,
		groups = { snappy = 2, choppy = 2, oddly_breakable_by_hand = 3, flammable = 3, wool = 1 },
		sounds = default.node_sound_defaults(),
	})

	minetest.register_craft({
		type = "shapeless",
		output = "wool:" .. name,
		recipe = { "group:dye,color_" .. name, "group:wool" },
	})
end

-- Dummy calls to S() to allow translation scripts to detect the strings.
-- To update this run:
-- for _,e in ipairs(dye.dyes) do print(("S(%q)"):format(e[2].." Wool")) end

--[[
S("White Wool")
S("Grey Wool")
S("Dark Grey Wool")
S("Black Wool")
S("Violet Wool")
S("Blue Wool")
S("Cyan Wool")
S("Dark Green Wool")
S("Green Wool")
S("Yellow Wool")
S("Brown Wool")
S("Orange Wool")
S("Red Wool")
S("Magenta Wool")
S("Pink Wool")
--]]
