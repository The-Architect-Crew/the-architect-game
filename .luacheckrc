unused_args = false
allow_defined_top = true
max_line_length = 1000

globals = {
	"minetest",
	"core",
	"table",
	"areas",
	"dye",
	"player_api",
	
}

exclude_files = {"mods/external"}

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
