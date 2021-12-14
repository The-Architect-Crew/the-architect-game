workbench:register_workstation("tablesaw", {
	fueltype = "fuel",
	savename = "shapes_complex",
	description = "Table Saw",
	mesh = "workbench_tablesaw.obj",
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
			{-0.125, 0.5, -0.5, 0.125, 0.75, 0.5},
		},
	},
	light_source = 3,
	groups = {choppy = 2,oddly_breakable_by_hand = 2},
	tiles = {"workbench_tablesaw.png"},
	animated_tiles = {{
		name = "workbench_tablesaw_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 30,
			aspect_h = 48,
			length = 0.5,
		},
	},},
	sounds = default.node_sound_wood_defaults(),
})

workbench:register_fuel({
	fueltype = "mese",
	name = "blocks:mese",
	time = 1800,
})

workbench:register_fuel({
	fueltype = "mese",
	name = "blocks:mese_crystal",
	time = 195,
})

workbench:register_fuel({
	fueltype = "mese",
	name = "blocks:mese_crystal_fragment",
	time = 20,
})

workbench:register_workstation("cnc", {
	fueltype = "mese",
	fueldesc = "Uses mese for fuel",
	savename = "shapes_slope",
	description = "CNC Table",
	mesh = "workbench_cnc.obj",
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
			{-0.4375, 0.5, -0.375, 0.4375, 1.125, 0.375},
		},
	},
	light_source = 6,
	groups = {choppy = 2,oddly_breakable_by_hand = 2},
	tiles = {"workbench_cnc.png"},
	animated_tiles = {{
		name = "workbench_cnc_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 46,
			aspect_h = 39,
			length = 0.5,
		},
	},},
	sounds = default.node_sound_wood_defaults(),
})

workbench:register_workstation("furnace", {
	fueltype = "fuel",
	savename = "furnace",
	description = "Furnace",
	mesh = "workbench_furnace.obj",
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
			{-0.375, 0.5, -0.375, 0.375, 1.5, 0.375},
		},
	},
	light_source = 8,
	groups = {choppy = 2,oddly_breakable_by_hand = 2},
	tiles = {"workbench_furnace.png"},
	animated_tiles = {{
		name = "workbench_furnace_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 70,
			aspect_h = 58,
			length = 1,
		},
	},},
	sounds = default.node_sound_wood_defaults(),
})