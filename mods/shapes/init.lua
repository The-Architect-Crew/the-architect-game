shapes = {}

shapes.shape_list = {}
function shapes:register_shapedef(name, def)
	table.insert(shapes.shape_list, {
		name = name,
		description = def.description,
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

local path = minetest.get_modpath("shapes")
dofile(path.."/shapedef.lua")
dofile(path.."/functions.lua")

-- return true if shape is disabled
local function check_disabled(disabled, name, groupname, dbd)
	-- enable all shapes if no disable detected
	if not disabled then
		if dbd then
			return true
		elseif not dbd then
			return nil
		end
	end
	local disabled2 = ", "..disabled..", "
	-- name check
	local namefind = string.find(disabled2, ", "..name..", ")
	if namefind then
		if not dbd then
			return true
		elseif dbd then
			return nil
		end
	end
	-- category check
	local groupfind = string.find(disabled2, ", cat:"..groupname..", ")
	if groupfind then
		if not dbd then
			return true
		elseif dbd then
			return nil
		end
	end
	-- disable_by_default
	if dbd then
		return true
	end
end

function shapes:register_shape(name, def)
	-- short form vs long form
	shapes.disabled = {}
	if type(def) == "table" then
		shapes.disabled = def.disabled
	else
		shapes.disabled = def
		def = {}
	end
	local disabled = shapes.disabled
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
		local tdbyd = shapes.shape_list[i].disable_by_default
		local tcraf = shapes.shape_list[i].crafting
		-- Add groups
		local u_group = table.copy(r_group)
		if tgrou then
			for gi in pairs(tgrou) do
				u_group[gi] = tgrou[gi]
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
		if def.description_prefix then
			udesc = def.description_prefix.." "..tdesc
		else
			udesc = def[tname.."_description"] or itemmeta.description.." "..tdesc
		end
		-- ensure enabled
		if not check_disabled(disabled, tname, tcate, tdbyd) then
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
					connects_to = tconn,
					connect_sides = tcosi,
					on_place = shapes.rotate_node,
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
					on_place = shapes.rotate_node,
				})
			end
			-- registering crafting
			if tcraf then
				local recipes = {}
				for j in ipairs(tcraf.recipe) do
					recipes[j] = recipes[j] or {}
					for k, indg in pairs(tcraf.recipe[j]) do
						recipes[j][k] = string.gsub(indg, "shapes:self", name)
						recipes[j][k] = string.gsub(recipes[j][k], "shapes:shape", mname..":shapes_"..sname)
					end
				end
				local amount = tcraf.amount or 1
				minetest.register_craft({
					output = mname..":shapes_"..sname.."_"..tname.." "..amount,
					recipe = recipes,
					replacements = tcraf.replacements,
				})
			end
		end
	end
end