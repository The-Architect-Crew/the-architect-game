local S = default.get_translator

--
-- == STICKS
--

minetest.register_craftitem("blocks:stick", {
	description = S("Stick"),
	inventory_image = "blocks_stick.png",
	groups = {stick = 1, flammable = 2},
})

minetest.register_craftitem("blocks:stick_mushroom", {
	description = S("Mushroom Stick"),
	inventory_image = "blocks_mushroom_stick.png",
	groups = {stick = 1, flammable = 2},
})

minetest.register_craftitem("blocks:bone", {
	description = S("Bone"),
	inventory_image = "blocks_bone.png",
})

--
-- == PLANKS
--

minetest.register_node("blocks:wood", {
	description = S("Apple Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocks_wood.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("blocks:wood_jungle", {
	description = S("Jungle Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocks_junglewood.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("blocks:wood_pine", {
	description = S("Pine Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocks_pine_wood.png"},
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("blocks:wood_acacia", {
	description = S("Acacia Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocks_acacia_wood.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("blocks:wood_aspen", {
	description = S("Aspen Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocks_aspen_wood.png"},
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("blocks:wood_cherry", {
	description = S("Cherry Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocks_cherry_wood.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("blocks:wood_bone", {
	description = S("Ossified Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocks_bonewood.png"},
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("blocks:wood_fire", {
	description = ccore.comment("Firewood", "A block of ever-burning planks"),
	paramtype = "light",
	paramtype2 = "facedir",
	place_param2 = 0,
	light_source = 4,
	tiles = {"blocks_firewood.png"},
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, wood = 1, fire_biome = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("blocks:wood_azure", {
	description = S("Azure Mushroom Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocks_azure_wood.png"},
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, wood = 1, azure = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("blocks:wood_amber", {
	description = S("Amber Wood Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocks_amber_wood.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("blocks:wood_dark", {
	description = S("Dark Mushroom Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocks_dark_wood.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("blocks:wood_ghost", {
	description = S("Ghostshroom Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocks_ghost_wood.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("blocks:wood_viridis", {
	description = S("Viridis Mushroom Planks"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"blocks_viridis_wood.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

--
-- == CRAFTS
--

local stick_crafts = {
    {"blocks:wood"},
    {"blocks:wood_jungle"},
    {"blocks:wood_pine"},
    {"blocks:wood_aspen"},
    {"blocks:wood_cherry"},
    {"blocks:wood_acacia"},
    {"blocks:wood_amber"},
}

for _, row in ipairs(stick_crafts) do
    minetest.register_craft({
        output = "blocks:stick 4",
        recipe = {
            { row[1] },
        }
    })
end

local mushroom_stick_crafts = {
    {"blocks:wood_viridis"},
    {"blocks:wood_azure"},
    {"blocks:wood_ghost"},
    {"blocks:wood_dark"},
}

for _, row in ipairs(mushroom_stick_crafts) do
    minetest.register_craft({
        output = "blocks:stick_mushroom 2",
        recipe = {
            { row[1] },
        }
    })
end

minetest.register_craft({
	output = "blocks:bone 4",
	recipe = {
		{"blocks:wood_bone"},
	}
})

minetest.register_craft({
	output = "blocks:wood 4",
	recipe = {
		{"flora:tree"},
	}
})

minetest.register_craft({
	output = "blocks:wood_jungle 4",
	recipe = {
		{"flora:jungletree"},
	}
})

minetest.register_craft({
	output = "blocks:wood_pine 4",
	recipe = {
		{"flora:pine_tree"},
	}
})

minetest.register_craft({
	output = "blocks:wood_acacia 4",
	recipe = {
		{"flora:acacia_tree"},
	}
})

minetest.register_craft({
	output = "blocks:wood_aspen 4",
	recipe = {
		{"flora:aspen_tree"},
	}
})

minetest.register_craft({
	output = "blocks:wood_cherry 4",
	recipe = {
		{"flora:cherry_tree"},
	}
})

minetest.register_craft({
	output = "blocks:wood_bone 4",
	recipe = {
		{"flora:bone_tree"},
	}
})

minetest.register_craft({
	output = "blocks:wood_amber 4",
	recipe = {
		{"flora:amber_trunk"},
	}
})

minetest.register_craft({
	output = "blocks:wood_azure 4",
	recipe = {
		{"flora:azure_trunk"},
	}
})

minetest.register_craft({
	output = "blocks:wood 4",
	recipe = {
		{"flora:ghost_trunk"},
	}
})

minetest.register_craft({
	output = "blocks:wood_dark 4",
	recipe = {
		{"flora:dark_trunk"},
	}
})

minetest.register_craft({
	output = "blocks:wood_viridis 4",
	recipe = {
		{"flora:viridis_trunk"},
	}
})

minetest.register_craft({
	output = "blocks:wood_fire 4",
	recipe = {
		{"flora:fireshroom_trunk"},
	}
})

minetest.register_craft({
	output = "blocks:wood",
	recipe = {
		{"flora:bush_stem"},
	}
})

minetest.register_craft({
	output = "blocks:wood_acacia",
	recipe = {
		{"flora:acacia_bush_stem"},
	}
})

minetest.register_craft({
	output = "blocks:wood_pine",
	recipe = {
		{"flora:pine_bush_stem"},
	}
})

minetest.register_craft({
	output = "blocks:wood_bone",
	recipe = {
		{"flora:bone_bush_stem"},
	}
})

minetest.register_craft({
	output = "blocks:wood_fire",
	recipe = {
		{"flora:firebranches", "flora:fire_mycelium"},
		{"flora:fire_mycelium", "flora:firebranches"},
	}
})

minetest.register_craft({
	output = "blocks:wood_azure",
	recipe = {
		{"blocks:stick_mushroom", "flora:mycelium_azure"},
		{"flora:mycelium_azure", "blocks:stick_mushroom"},
	}
})

minetest.register_craft({
	output = "blocks:wood_viridis",
	recipe = {
		{"blocks:stick_mushroom", "blocks:viridis_mycelium"},
		{"blocks:viridis_mycelium", "blocks:stick_mushroom"},
	}
})

minetest.register_craft({
	output = "blocks:wood_dark",
	recipe = {
		{"blocks:stick_mushroom", "blocks:dark_mycelium"},
		{"blocks:dark_mycelium", "blocks:stick_mushroom"},
	}
})

minetest.register_craft({
	output = "blocks:wood_ghost",
	recipe = {
		{"blocks:stick_mushroom", "blocks:ghost_mycelium"},
		{"blocks:ghost_mycelium", "blocks:stick_mushroom"},
	}
})