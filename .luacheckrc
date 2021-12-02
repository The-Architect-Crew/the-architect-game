unused_args = false
allow_defined_top = true
max_line_length = 300

globals = {
    "minetest",
}

read_globals = {
    string = {fields = {"split"}},
    table = {fields = {"copy", "getn"}},

    -- Builtin
    "vector", "ItemStack",
    "dump", "DIR_DELIM", "VoxelArea", "Settings",

		-- Legacy
		"spawn_falling_node",

    -- MTG
    "default", "sfinv", "creative",

    -- Mods
    "stairs", "stairsplus", "dungeon_loot",
}
