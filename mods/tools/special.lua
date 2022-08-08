
-- Tools that are quest rewards and similar

-- Translation support

local S = default.get_translator

-- Moonlight, a pickaxe with no wear

minetest.register_tool("tools:moonlight", {
	description = S("Moonlight"),
	inventory_image = "tools_moonlight.png",
	tool_capabilities = {
		full_punch_interval = 0.1,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=1.8, [2]=0.9, [3]=0.45}, uses=0, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {pickaxe = 1}
})