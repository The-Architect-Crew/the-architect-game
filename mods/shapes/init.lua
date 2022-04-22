shapes = {}
shapes.shape_list = {}
shapes.registered_shape = {}
function shapes:register_shapedef(name, def)
	-- basic data list for generating shapes
	table.insert(shapes.shape_list, {
		name = name,
		description = def.description,
		cost = def.cost,
		node_box = def.node_box,
		mesh = def.mesh,
		collision_box = def.collision_box,
		selection_box = def.selection_box,
		category = def.category,
		groups = def.groups,
		sunlight_propagates = def.sunlight_propagates,
		drop = def.drop,
		connects_to = def.connects_to,
		connect_sides = def.connect_sides,
		backface_culling = def.backface_culling,
		align_style = def.align_style,
		overlay = def.overlay,
		disable_by_default = def.disable_by_default,
		crafting = def.crafting,
	})
end

shapes.rotate_node = function(itemstack, placer, pointed_thing)
	minetest.rotate_and_place(itemstack, placer, pointed_thing,
		minetest.settings:get_bool("creative_mode") or creative.is_enabled_for(placer:get_player_name()),
		{invert_wall = placer:get_player_control().sneak})
	local pos = pointed_thing.above
	minetest.check_single_for_falling(pos)
	return itemstack
end

local function no_placecube(itemstack, placer, pointed_thing)
	return itemstack
end

if minetest.global_exists("workbench") then
	workbench:register_crafttype("shapes")
end

local path = minetest.get_modpath("shapes")
dofile(path.."/shapedef.lua")
dofile(path.."/functions.lua")

-- return true if shape is enabled
local function check_enabled(disabled, enabled, shapename, groupname, default_disable)
	-- always enable cube
	if shapename == "cube" then
		if disabled then
			local disable_list = ", "..disabled..", "
			local namefind = string.find(disable_list, ", "..shapename..", ")
			local groupfind = string.find(disable_list, ", cat:"..groupname..", ")
			if namefind or groupfind then
				return "nocube"
			end
		end
		return true
	end
	-- enable all shapes if no options detected
	if not disabled and not enabled then
		if default_disable ~= true then -- ensure its not disabled by default
			return true
		end
	end
	-- if disabled by default and there's no enabler, leave it disabled
	if not enabled and default_disable == true then
		return nil
	end
	-- if part of enabled list, return true
	if enabled then
		local enabled_list = ", "..enabled..", "
		local namefind = string.find(enabled_list, ", "..shapename..", ")
		local groupfind = string.find(enabled_list, ", cat:"..groupname..", ")
		if namefind or groupfind then
			return true
		end
		-- without disabled list, assume all shpaes are disabled except in enabled
		if not disabled then
			return nil
		end
	end
	-- if part of disabled list, return nil
	if disabled then
		local disable_list = ", "..disabled..", "
		local namefind = string.find(disable_list, ", "..shapename..", ")
		local groupfind = string.find(disable_list, ", cat:"..groupname..", ")
		if namefind or groupfind then
			return nil
		end
	end
	-- enable rest of shapes
	return true
end

function shapes:register_shape(name, def)
	--add nodes with shape registrations into a list
	shapes.registered_shape[name] = true
	-- short form vs long form
	shapes.disabled = {}
	if type(def) == "table" then
		shapes.disabled = def.disabled
	else
		shapes.disabled = def
		def = {}
	end
	local disabled = shapes.disabled
	local enabled = def.enabled
	-- get names and data
	local sname = string.match(name, ':(.*)')
	local mname = string.match(name, '(.*):')
	local itemmeta = minetest.registered_items[name]
	if itemmeta == nil then
		minetest.log("error", "[shapes] "..name.." does not exist!")
		return
	end
	-- modifers
	local n_group = def.groups or itemmeta.groups
	local r_group = table.copy(n_group)
	r_group.not_in_creative_inventory = 1
	local stexture = def.texture or itemmeta.tiles[1]
	-- mass definitions
	for i in ipairs(shapes.shape_list) do
		local tname = shapes.shape_list[i].name
		local tdesc = shapes.shape_list[i].description
		local tnobo = shapes.shape_list[i].node_box
		local tmesh = shapes.shape_list[i].mesh
		local tcobo = shapes.shape_list[i].collision_box or tnobo
		local tsebo = shapes.shape_list[i].selection_box or tnobo or tcobo
		local tcate = shapes.shape_list[i].category
		local tgrou = shapes.shape_list[i].groups
		local tsunl = shapes.shape_list[i].sunlight_propagates or true
		local tdrop = shapes.shape_list[i].drop
		local tconn = shapes.shape_list[i].connects_to
		local tcosi = shapes.shape_list[i].connect_sides
		local tbfcg = shapes.shape_list[i].backface_culling or true
		local tagsy = shapes.shape_list[i].align_style or "world"
		local tovly = shapes.shape_list[i].overlay
		local tcraf = shapes.shape_list[i].crafting
		local tcost = shapes.shape_list[i].cost
		local tdbyd = shapes.shape_list[i].disable_by_default
		local troap = shapes.shape_list[i].rotate_and_place or true
		-- Add groups
		local u_group = table.copy(r_group)
		if tgrou then
			for gi in pairs(tgrou) do
				u_group[gi] = tgrou[gi]
			end
		end
		if tcost then
			if tnobo then
				u_group.shapes = tcost
			elseif tmesh then
				u_group.shapes_mesh = tcost
			end
		end
		-- Add overlay
		local stexture2
		local stexture3 = itemmeta.tiles
		if tovly then
			stexture2 = tovly.."^"..stexture.."^"..tovly.."^[makealpha:255,126,126"
			stexture3 = {stexture}
		end
		-- Drops
		if tdrop then
			tdrop = string.gsub(tdrop, "shapes:self", name)
			tdrop = string.gsub(tdrop, "shapes:shape", mname..":shapes_"..sname)
		end
		-- Description
		local udesc
		if tname == "cube" and check_enabled(disabled, enabled, tname, tcate, tdbyd) == "nocube" then
			if def.description_prefix then
				udesc = def.description_prefix.." Residue \n(For crafting only)"
			else
				udesc = def[tname.."_description"] or itemmeta.description.." Residue \n(For crafting only)"
			end
		else
			if def.description_prefix then
				udesc = def.description_prefix.." "..tdesc
			else
				udesc = def[tname.."_description"] or itemmeta.description.." "..tdesc
			end
		end
		-- rotate when place
		local rotate_function
		if tname == "cube" and check_enabled(disabled, enabled, tname, tcate, tdbyd) == "nocube" then
			rotate_function = no_placecube
		else
			if troap == true then
				rotate_function = shapes.rotate_node
			else
				rotate_function = minetest.item_place
			end
		end
		-- ensure enabled
		if check_enabled(disabled, enabled, tname, tcate, tdbyd) then
			-- registering nodebox
			if tnobo then
				-- align style and backface_culling
				local shape_images = {}
				local images = def[tname.."_tiles"] or def.global_tiles or stexture3
				for j, image in ipairs(images) do
					if type(image) == "string" then
						shape_images[j] = {
							name = image,
							backface_culling = def[tname.."_backface_culling"] or def.backface_culling or tbfcg,
							align_style = def[tname.."_align_style"] or def.align_style or tagsy,
						}
					end
				end
				-- register shape
				minetest.register_node(":"..mname..":shapes_"..sname.."_"..tname, {
					description = udesc,
					drawtype = "nodebox",
					groups = u_group,
					tiles = shape_images,
					inventory_image = stexture2,
					wield_image = stexture2,
					paramtype = "light",
					paramtype2 = "facedir",
					sunlight_propagates = def[tname.."_sunlight_propagates"] or tsunl,
					use_texture_alpha = def[tname.."_use_texture_alpha"] or def.use_texture_alpha or itemmeta.use_texture_alpha,
					drop = def[tname.."_drop"] or def.drop or tdrop,
					light_source = def[tname.."_light_source"] or def.light_source or itemmeta.light_source,
					sounds = itemmeta.sounds,
					node_box = tnobo,
					collision_box = tcobo,
					selection_box = tsebo,
					connects_to = def[tname.."_connects_to"] or def.connects_to or tconn,
					connect_sides = def[tname.."_connect_sides"] or def.connect_sides or tcosi,
					on_place = rotate_function,
				})
			-- registering models
			elseif tmesh then
				minetest.register_node(":"..mname..":shapes_"..sname.."_"..tname, {
					description = udesc,
					drawtype = "mesh",
					mesh = tmesh,
					groups = u_group,
					tiles = def[tname.."_tiles"] or def.global_tiles or itemmeta.tiles,
					paramtype = "light",
					paramtype2 = "facedir",
					sunlight_propagates = def[tname.."_sunlight_propagates"] or tsunl,
					use_texture_alpha = def[tname.."_use_texture_alpha"] or def.use_texture_alpha or itemmeta.use_texture_alpha,
					drop = def[tname.."_drop"] or def.drop or tdrop,
					light_source = def[tname.."_light_source"] or def.light_source or itemmeta.light_source,
					sounds = itemmeta.sounds,
					collision_box = tcobo,
					selection_box = tsebo,
					on_place = rotate_function,
				})
			end
			-- registering given crafting
			if tcraf then
				for j in ipairs(tcraf) do
					local recipes = {}
					for k in ipairs(tcraf[j].recipe) do
						recipes[k] = recipes[k] or {}
						for l, indg in ipairs(tcraf[j].recipe[k]) do
							recipes[k][l] = string.gsub(indg, "shapes:self", name)
							recipes[k][l] = string.gsub(recipes[k][l], "shapes:shape", mname..":shapes_"..sname)
						end
					end
					local amount = tcraf[j].amount or 1
					minetest.register_craft({
						output = mname..":shapes_"..sname.."_"..tname.." "..amount,
						recipe = recipes,
						replacements = tcraf.replacements,
					})
				end
			end
			-- converting shapes into cubes
			if tcost and tname ~= "cube" then
				minetest.register_craft({
					type = "shapeless",
					output = mname..":shapes_"..sname.."_cube "..tcost,
					recipe = {mname..":shapes_"..sname.."_"..tname},
				})
			end
		end
	end
	-- cubes into full blocks
	minetest.register_craft({
		type = "shapeless",
		output = name,
		recipe = {
			mname..":shapes_"..sname.."_cube", mname..":shapes_"..sname.."_cube", mname..":shapes_"..sname.."_cube",
			mname..":shapes_"..sname.."_cube", mname..":shapes_"..sname.."_cube", mname..":shapes_"..sname.."_cube",
			mname..":shapes_"..sname.."_cube", mname..":shapes_"..sname.."_cube",
		},
	})
	-- workbench crafting
	if minetest.global_exists("workbench") then
		--[[local sawlist = {}
		local sawrlist = {}
		local cnclist = {}
		local cncrlist = {}]]
		for i in ipairs(shapes.shape_list) do
			local tname = shapes.shape_list[i].name
			local tnobo = shapes.shape_list[i].node_box
			local tmesh = shapes.shape_list[i].mesh
			local tcate = shapes.shape_list[i].category
			local tdbyd = shapes.shape_list[i].disable_by_default
			local tcost = shapes.shape_list[i].cost
			if check_enabled(disabled, enabled, tname, tcate, tdbyd) then
				if tcost then
					-- create tablesaw output list
					if tnobo then
						if check_enabled(disabled, enabled, tname, tcate, tdbyd) ~= "nocube" then
							workbench:register_craft({
								type = "shapes",
								cat = "tablesaw",
								input =	{
									{name},
								},
								output = {
									{mname..":shapes_"..sname.."_"..tname.." "..math.floor(8/tcost)},
								},
								residue = {mname..":shapes_"..sname.."_cube "..(8 - (math.floor(8/tcost) * tcost))},
							})
							--sawlist[#sawlist+1] = mname..":shapes_"..sname.."_"..tname.." "..math.floor(8/tcost)
							--sawrlist[#sawrlist+1] = mname..":shapes_"..sname.."_cube "..(8 - (math.floor(8/tcost) * tcost))
						end
					end
					-- create cnc output list
					if tmesh then
						workbench:register_craft({
							type = "shapes",
							cat = "cnc",
							input =	{
								{name},
							},
							output = {
								{mname..":shapes_"..sname.."_"..tname.." "..math.floor(8/tcost)},
							},
							residue = {mname..":shapes_"..sname.."_cube "..(8 - (math.floor(8/tcost) * tcost))},
						})
						--cnclist[#cnclist+1] = mname..":shapes_"..sname.."_"..tname.." "..math.floor(8/tcost)
						--cncrlist[#cncrlist+1] = mname..":shapes_"..sname.."_cube "..(8 - (math.floor(8/tcost) * tcost))
					end
					-- create recycling (workbench)
					workbench:register_craft({
						type = "shapes",
						cat = "recycle",
						input =	{
							{mname..":shapes_"..sname.."_"..tname},
						},
						output = {
							{mname..":shapes_"..sname.."_cube "..tcost},
						},
					})
				end
			end
		end
		--[[
		-- tablesaw craft
		if sawlist[1] then
			workbench:register_craft({
				type = "shapes",
				cat = "tablesaw",
				input =	{
					{name},
				},
				output = {
					sawlist
				},
				residue = sawrlist,
			})
		end
		-- cnc craft
		if cnclist[1] then
			workbench:register_craft({
				type = "shapes",
				cat = "cnc",
				input =	{
					{name},
				},
				output = {
					cnclist
				},
				residue = cncrlist,
			})
		end]]
		-- cubes into full blocks
		workbench:register_craft({
			type = "normal",
			input =	{
				{mname..":shapes_"..sname.."_cube 8"},
			},
			output = {
				{name},
			},
		})
	end
end

workbench:register_craft({
	type = "normal",
	mod = "shapeless",
	input =	{
		{"group:stone 2", "blocks:stone 2"},
	},
	output = {
		{"blocks:stone 4"},
	},
})

workbench:register_craft({
	type = "normal",
	input =	{
		{"group:stone", "blocks:stone", "blocks:stone", "blocks:stone", "blocks:stone"},
		{"group:stone", "blocks:stone", "blocks:stone", "blocks:stone", "blocks:stone"},
		{"group:stone", "blocks:stone", "blocks:stone", "blocks:stone", "blocks:stone"},
		{"group:stone", "blocks:stone", "blocks:stone", "blocks:stone", "blocks:stone"},
		{"group:stone", "blocks:stone", "blocks:stone", "blocks:stone", "blocks:stone"},
	},
	output = {
		{"blocks:stone 25"},
	},
})


-- workbench crafter
if minetest.global_exists("workbench") then
	dofile(path.."/crafting.lua")
end