furniture = {}

local path = minetest.get_modpath("furniture")

workbench:register_crafttype("furniture", {
	description = ccore.comment("Furniture Making", "Use a furniture assembler"),
	icon = "crafticon_furniture.png",
})

furniture.craftstation_materials = {
    "blocks:wood",
    "blocks:stone",
    "blocks:sandstone",
    "blocks:obsidian",
    "blocks:basalt",
    "blocks:concrete",
    {"blocks:marble", "blocks:goldblock"},
    {"blocks:rustblock", "blocks:rustblock"}
}

-- Helper functions
furniture.table_contains = function(term, table)
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

furniture.table_copy = function(table)
    local copy = {}
    for table_key, table_value in pairs(table) do
        copy[table_key] = table_value
    end
    return copy
end

furniture.dictionary_append = function(table, input_table)
    for intable_key, intable_value in pairs(input_table) do
        table[intable_key] = intable_value
    end
end

furniture.table_append = function(table, input_table)
    local table_len = #table
    for i=1,table_len do
        table[table_len + i] = input_table[i]
    end
end

-- Model and Collection definitions
dofile(path .."/content/base.lua")
dofile(path .."/content/bathroom.lua")
dofile(path .."/content/kitchen.lua")
dofile(path .."/content/medieval.lua")
dofile(path .."/content/steampunk.lua")

-- These are furniture in the sense that they're models
dofile(path.."/assembler.lua")
dofile(path.."/brickmaker.lua")
dofile(path.."/engraver.lua")
dofile(path.."/tablesaw.lua")
dofile(path .."/furnace.lua")

-- Anything that contains crafting registrations has to go after craftstations
dofile(path.."/steampunk.lua")

-- And these are furniture since players can't get the stuff otherwise
dofile(path.."/craftitems.lua")
dofile(path.."/crafts.lua")

-- Furniture registration
function furniture.register(base_node, limit, materials, texture)
    for i=1, #furniture.types do
        local fdef = furniture.types[i]
        if furniture.table_contains(fdef.name, limit) then
            furniture.assemble_node(base_node, i, materials, texture)
            furniture.register_crafting(base_node, i, materials, false)
            if fdef.generate_locked then
                furniture.register_crafting(base_node, i, materials, true)
            end
        end
    end
end

function furniture.assemble_node(base_node, tablep, materials, texture)
    local fdef = furniture.types[tablep]
    local base_definition = minetest.registered_nodes[base_node]
    local sname = string.match(base_node, ':(.*)')
    local modname = string.match(base_node, '(.*):')
    local esname = modname .. "_" .. sname -- For avoiding name conflicts in the sound tables
    local furniture_name = "furniture:" .. modname .. "_" .. fdef.name .. "_" .. sname -- To avoid potential conflicts in mod support
    if modname == "blocks" then
        furniture_name = "furniture:" .. fdef.name .. "_" .. sname
        esname = sname
    end
    local furniture_description =  base_definition.description .. " " .. fdef.description
    local furniture_mesh = (fdef.base or fdef.name) .. ".obj"
    local tiles = {texture or base_definition.tiles[1]}
    local sunlight
    if (fdef.sunlight_propagates) then
        sunlight = fdef.sunlight_propagates
    else
        sunlight = true
    end
    local sounds = base_definition.sounds
    local collision_box = {type = "fixed", fixed = fdef.box}
    local groups = ccore.groups_copy(base_definition.groups)
    if fdef.groups then
        furniture.dictionary_append(groups, fdef.groups)
    end
    local activate_sound
    local gain
    if fdef.activate_sound then
        if type(fdef.activate_sound[esname]) == "table" then
            activate_sound = fdef.activate_sound[esname][1] or fdef.activate_sound.default[1]
            gain = fdef.activate_sound[esname][2] or fdef.activate_sound.default[2]
        else
            activate_sound = fdef.activate_sound[esname] or fdef.activate_sound.default
            gain = 0.06
        end
    end
    local deactivate_sound
    local gain_active
    if fdef.deactivate_sound then
        if type(fdef.deactivate_sound[esname]) == "table" then
            deactivate_sound = fdef.deactivate_sound[esname][1] or fdef.deactivate_sound.default[1]
            gain_active = fdef.deactivate_sound[esname][2] or fdef.deactivate_sound.default[2]
        else
            deactivate_sound = fdef.deactivate_sound[esname] or fdef.deactivate_sound.default
            gain_active = 0.13
        end
    end

    -- Active versions
    local furniture_mesh_active = (fdef.base or fdef.name) .. "_activated.obj"
    local tiles_active = furniture.table_copy(tiles)
    local collision_box_active = {type = "fixed", fixed = fdef.box_activated}
    local groups_active = ccore.groups_copy(groups)
    groups_active.not_in_creative_inventory = 1
    if fdef.groups_active then
        furniture.dictionary_append(groups_active, fdef.groups_active)
    end
    local sunlight_active
    if (fdef.sunlight_propagates_active) then
        sunlight_active = fdef.sunlight_propagates_active
    else
        sunlight_active = true
    end

    -- Textures
    local alpha = "blend"
    if (type(fdef.special_textures) == "table") then
        for i=1, #fdef.special_textures do
            tiles[i+1] = fdef.special_textures[i]
        end
    elseif (type(fdef.special_textures) == "string") then
        tiles[2] = fdef.special_textures
    end

    if fdef.active then
        if (type(fdef.special_textures_active) == "table") then
            for i=1, #fdef.special_textures_active do
                tiles_active[i+1] = fdef.special_textures_active[i]
            end
        elseif (type(fdef.special_textures_active) == "string") then
            tiles_active[2] = fdef.special_textures_active
        end
    end

    -- Declare function storage
    local on_rightclick
    local on_rightclick_active

    local after_place_node_locked
    local on_rightclick_locked
    local on_rightclick_active_locked
    local can_dig_locked = false

    if fdef.generate_locked then
        after_place_node_locked = function(pos, placer)
            local meta = minetest.get_meta(pos)
            local playername = placer:get_player_name()
            meta:set_string("owner", playername)
            meta:set_string("infotext", "Locked " .. furniture_description .. "\nOwned by " .. playername .. ".")
        end
        on_rightclick_locked = function(pos, node, player)
            local meta = minetest.get_meta(pos)
            local owner = meta:get_string("owner")
            local playername = player:get_player_name()
            if playername == owner then
                minetest.swap_node(pos, {name = furniture_name .. "_activated_locked", param2 = node.param2})
                minetest.sound_play(activate_sound, {pos = pos, gain = gain, max_hear_distance = 10}, true)
            end
        end
        on_rightclick_active_locked = function(pos, node, player)
            local meta = minetest.get_meta(pos)
            local owner = meta:get_string("owner")
            local playername = player:get_player_name()
            if playername == owner then
                minetest.swap_node(pos, {name = furniture_name .. "_locked", param2 = node.param2})
                minetest.sound_play(deactivate_sound, {pos = pos, gain = gain_active, max_hear_distance = 10}, true)
            end
        end
    end

    if fdef.active then
        on_rightclick = function(pos, node)
            minetest.swap_node(pos, {name = furniture_name .. "_activated", param2 = node.param2})
            minetest.sound_play(activate_sound, {pos = pos, gain = gain, max_hear_distance = 10}, true)
        end
        on_rightclick_active = function(pos, node)
            minetest.swap_node(pos, {name = furniture_name, param2 = node.param2})
            minetest.sound_play(deactivate_sound, {pos = pos, gain = gain_active, max_hear_distance = 10}, true)
        end
    end

    -- Assemble node(s)

    if (fdef.storage) then
       crates:register_storage(furniture_name, {
            description = furniture_description,
            columns = fdef.storage,
            tiles = tiles,
            sorting = true,
            portable = fdef.portable,
            --dyeable = fdef.dyeable, -- Don't think it'll work cause of the texturing approach
            --dyemod = dfef.dyemod, -- Don't think it'll work cause of the texturing approach
            colorlabel = fdef.colorlabel,
            lock_order = {"lock", "protect", "public", "mail"},
            groups = groups,
            drawtype = 'mesh',
            mesh = furniture_mesh,
            collision_box = collision_box,
            selection_box = collision_box,
            use_texture_alpha = fdef.alpha or alpha,
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = sunlight,
            sounds = sounds,
            light_source = fdef.light_source or base_definition.light_source,
            visual_scale = fdef.visual_scale or base_definition.visual_scale,
            post_effect_color = fdef.post_effect_color or base_definition.post_effect_color,
            walkable = fdef.walkable or base_definition.walkable,
            pointable = fdef.pointable or base_definition.pointable,
            diggable = fdef.diggable or base_definition.diggable,
            climbable = fdef.climbable or base_definition.climbable,
            move_resistance = fdef.move_resistance or base_definition.move_resistance,
            buildable_to = fdef.buildable_to or base_definition.buildable_to,
            floodable = fdef.floodable or base_definition.floodable,
            drowning = fdef.drowning or base_definition.drowning,
            damage_per_second = fdef.damage_per_second or base_definition.damage_per_second,
        })
    else
        minetest.register_node(furniture_name, {
            description = furniture_description,
            tiles = tiles,
            groups = groups,
            drawtype = 'mesh',
            mesh = furniture_mesh,
            collision_box = collision_box,
            selection_box = collision_box,
            use_texture_alpha = fdef.alpha or alpha,
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = sunlight,
            sounds = sounds,
            on_rightclick = on_rightclick,
            light_source = fdef.light_source or base_definition.light_source,
            visual_scale = fdef.visual_scale or base_definition.visual_scale,
            post_effect_color = fdef.post_effect_color or base_definition.post_effect_color,
            walkable = fdef.walkable or base_definition.walkable,
            pointable = fdef.pointable or base_definition.pointable,
            diggable = fdef.diggable or base_definition.diggable,
            climbable = fdef.climbable or base_definition.climbable,
            move_resistance = fdef.move_resistance or base_definition.move_resistance,
            buildable_to = fdef.buildable_to or base_definition.buildable_to,
            floodable = fdef.floodable or base_definition.floodable,
            drowning = fdef.drowning or base_definition.drowning,
            damage_per_second = fdef.damage_per_second or base_definition.damage_per_second
        })
        if fdef.active then
            minetest.register_node(furniture_name .. "_activated", {
                description = furniture_description,
                tiles = tiles_active,
                groups = groups_active,
                drawtype = 'mesh',
                mesh = furniture_mesh_active,
                collision_box = collision_box_active,
                selection_box = collision_box_active,
                use_texture_alpha = fdef.alpha_active or alpha,
                paramtype = "light",
                paramtype2 = "facedir",
                sunlight_propagates = sunlight_active,
                sounds = sounds,
                drop = furniture_name,
                on_rightclick = on_rightclick_active,
                light_source = fdef.light_source_active or base_definition.light_source,
                visual_scale = fdef.visual_scale_active or base_definition.visual_scale,
                post_effect_color = fdef.post_effect_color_active or base_definition.post_effect_color,
                walkable = fdef.walkable_active or base_definition.walkable,
                pointable = fdef.pointable_active or base_definition.pointable,
                diggable = fdef.diggable_active or base_definition.diggable,
                climbable = fdef.climbable_active or base_definition.climbable,
                move_resistance = fdef.move_resistance_active or base_definition.move_resistance,
                buildable_to = fdef.buildable_to_active or base_definition.buildable_to,
                floodable = fdef.floodable_active or base_definition.floodable,
                drowning = fdef.drowning_active or base_definition.drowning,
                damage_per_second = fdef.damage_per_second_active or base_definition.damage_per_second
            })
        end
        if fdef.generate_locked then
            minetest.register_node(furniture_name .. "_locked", {
                description = "Locked " .. furniture_description,
                tiles = tiles,
                groups = groups,
                drawtype = 'mesh',
                mesh = furniture_mesh,
                collision_box = collision_box,
                selection_box = collision_box,
                use_texture_alpha = fdef.alpha or alpha,
                paramtype = "light",
                paramtype2 = "facedir",
                sunlight_propagates = sunlight,
                sounds = sounds,
                after_place_node = after_place_node_locked,
                on_rightclick = on_rightclick_locked,
                light_source = fdef.light_source or base_definition.light_source,
                visual_scale = fdef.visual_scale or base_definition.visual_scale,
                post_effect_color = fdef.post_effect_color or base_definition.post_effect_color,
                walkable = fdef.walkable or base_definition.walkable,
                pointable = fdef.pointable or base_definition.pointable,
                diggable = fdef.diggable or base_definition.diggable,
                climbable = fdef.climbable or base_definition.climbable,
                move_resistance = fdef.move_resistance or base_definition.move_resistance,
                buildable_to = fdef.buildable_to or base_definition.buildable_to,
                floodable = fdef.floodable or base_definition.floodable,
                drowning = fdef.drowning or base_definition.drowning,
                damage_per_second = fdef.damage_per_second or base_definition.damage_per_second
            })
            minetest.register_node(furniture_name .. "_activated_locked", {
                description = "Locked " .. furniture_description,
                tiles = tiles_active,
                groups = groups_active,
                drawtype = 'mesh',
                mesh = furniture_mesh_active,
                collision_box = collision_box_active,
                selection_box = collision_box_active,
                use_texture_alpha = fdef.alpha_active or alpha,
                paramtype = "light",
                paramtype2 = "facedir",
                sunlight_propagates = sunlight_active,
                sounds = sounds,
                drop = furniture_name,
                after_place_node = after_place_node_locked,
                on_rightclick = on_rightclick_active_locked,
                can_dig = can_dig_locked,
                light_source = fdef.light_source_active or base_definition.light_source,
                visual_scale = fdef.visual_scale_active or base_definition.visual_scale,
                post_effect_color = fdef.post_effect_color_active or base_definition.post_effect_color,
                walkable = fdef.walkable_active or base_definition.walkable,
                pointable = fdef.pointable_active or base_definition.pointable,
                diggable = fdef.diggable_active or base_definition.diggable,
                climbable = fdef.climbable_active or base_definition.climbable,
                move_resistance = fdef.move_resistance_active or base_definition.move_resistance,
                buildable_to = fdef.buildable_to_active or base_definition.buildable_to,
                floodable = fdef.floodable_active or base_definition.floodable,
                drowning = fdef.drowning_active or base_definition.drowning,
                damage_per_second = fdef.damage_per_second_active or base_definition.damage_per_second
            })
        end
    end
end

-- Furniture crafting

function furniture.register_crafting(base_node, i, materials_in, locked)
    local materials = furniture.table_copy(materials_in)
    local fdef = furniture.types[i]
    local sname = string.match(base_node, ':(.*)')
    local modname = string.match(base_node, '(.*):')
    local furniture_name = "furniture:" .. modname .. "_" .. fdef.name .. "_" .. sname
    if modname == "blocks" then
        furniture_name = "furniture:" .. fdef.name .. "_" .. sname
    end
    if locked and (not minetest.global_exists("blocks")) then
        workbench:register_craft({
            type = "furniture",
            output = {
                {furniture_name .. "_locked"}
            },
            input = {
                {"furniture:lock", furniture_name},
            },
        })
    else
        if (type(fdef.special_materials) == "table") then -- Append special material(s) to the end
            for j=1,#fdef.special_materials do
                materials[#materials+j] = fdef.special_materials[j]
            end
        elseif (type(fdef.special_materials) == "string") then
            materials[#materials+1] = fdef.special_materials
        end
        materials[0] = ""
        if fdef.crafting then
            local recipe = {{}, {}, {}, {}, {}}
            for rw=1,5 do
                for cl=1,5 do
                    recipe[rw][cl] = materials[fdef.crafting[rw][cl]] or ""
                end
            end
            workbench:register_craft({
                type = "furniture",
                output = {
                    {furniture_name}
                },
                input = recipe,
            })
        end
    end
end
-- Locking

if not minetest.global_exists("blocks") then
    -- Craftitems
    minetest.register_craftitem("furniture:lock", {
        description = "Locking Mechanism",
        inventory_image = "furniture_lock.png",
    })
    -- Crafting
    minetest.register_craft({
        output = "furniture:lock",
        recipe = {
            {"", "default:steel_ingot", ""},
            {"default:steel_ingot", "", "default:steel_ingot"},
            {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
        }
    })
end

furniture.register("blocks:wood", furniture.woodlike_set, {"blocks:wood", "blocks:stick"}, "variations_wood.png^[sheet:3x3:1,0")
furniture.register("blocks:acacia_wood", furniture.woodlike_set, {"blocks:acacia_wood", "blocks:stick"}, "variations_acacia_wood.png^[sheet:3x3:1,0")
furniture.register("blocks:aspen_wood", furniture.woodlike_set, {"blocks:aspen_wood", "blocks:stick"}, "variations_aspen_wood.png^[sheet:3x3:1,0")
furniture.register("blocks:junglewood", furniture.woodlike_set, {"blocks:junglewood", "blocks:stick"}, "variations_junglewood.png^[sheet:3x3:1,0")
furniture.register("blocks:azure_wood", furniture.woodlike_set, {"blocks:azure_wood", "blocks:stick"}, "variations_azure_wood.png^[sheet:3x3:1,0")
furniture.register("blocks:pine_wood", furniture.woodlike_set, {"blocks:pine_wood", "blocks:stick"}, "variations_pine_wood.png^[sheet:3x3:1,0")
furniture.register("blocks:cherry_wood", furniture.woodlike_set, {"blocks:cherry_wood", "blocks:stick"}, "variations_cherry_wood.png^[sheet:3x3:1,0")
furniture.register("blocks:steelblock", furniture.woodlike_set, {"blocks:steelblock", "blocks:steel_ingot"}, "variations_steelblock.png^[sheet:3x3:1,0")
furniture.register("blocks:rustblock", furniture.woodlike_set, {"blocks:rustblock", "blocks:rust_ingot"}, "furniture_rustblock_clean.png") -- Fix crafting later

furniture.register("blocks:stone", furniture.stonelike_set, {"blocks:stone", "blocks:shapes_stone_slab"}, "variations_stone.png^[sheet:3x3:1,0")
furniture.register("blocks:desert_stone", furniture.stonelike_set, {"blocks:desert_stone", "blocks:shapes_desert_stone_slab"}, "variations_desert_stone.png^[sheet:3x3:1,0")
furniture.register("blocks:basalt", furniture.stonelike_set, {"blocks:basalt", "blocks:shapes_basalt_slab"}, "variations_basalt.png^[sheet:3x3:1,0")
furniture.register("blocks:sandstone", furniture.stonelike_set, {"blocks:sandstone", "blocks:shapes_sandstone_slab"}, "variations_sandstone.png^[sheet:3x3:1,0")
furniture.register("blocks:marble", furniture.stonelike_set, {"blocks:marble", "blocks:shapes_marble_slab"}, "variations_marble.png^[sheet:3x3:1,0")

furniture.register("blocks:amber", furniture.stonelike_set, {"blocks:amber", "blocks:shapes_amber_slab"}, "variations_amber.png^[sheet:3x3:1,0")

furniture.register("blocks:glass", furniture.glasslike_set, {"blocks:glass", "blocks:sand"}, "blocks_glass.png")
furniture.register("blocks:obsidian_glass", furniture.glasslike_set, {"blocks:obsidian_glass", "blocks:obsidian_shard"}, "blocks_obsidian_glass.png")
furniture.register("blocks:amethyst", furniture.glasslike_set, {"blocks:amethyst", "blocks:amethyst_crystal"}, "variations_amethyst.png^[sheet:3x3:1,0")
furniture.register("blocks:garnet", furniture.glasslike_set, {"blocks:garnet", "blocks:garnet_crystal"}, "variations_garnet.png^[sheet:3x3:1,0")

furniture.register("blocks:steelblock", furniture.steampunk_set, {"blocks:steelblock", "blocks:steel_ingot"}, "variations_steelblock.png^[sheet:3x3:1,0")
furniture.register("blocks:rustblock", furniture.steampunk_set, {"blocks:rustblock", "blocks:rust_ingot"}, "variations_rustblock.png^[sheet:3x3:1,0")

furniture.register("blocks:steelblock", furniture.house_appliances, {"blocks:steelblock", "blocks:steel_ingot"}, "variations_steelblock.png^[sheet:3x3:1,0")
furniture.register("blocks:steelblock", furniture.bathroom_set, {"blocks:steelblock", "blocks:steel_ingot"}, "variations_steelblock.png^[sheet:3x3:1,0")

furniture.register("blocks:steelblock", furniture.medieval_lighting, {"blocks:steelblock", "blocks:steel_ingot"}, "variations_steelblock.png^[sheet:3x3:1,0")
furniture.register("blocks:rustblock", furniture.medieval_lighting, {"blocks:rustblock", "blocks:rust_ingot"}, "variations_rustblock.png^[sheet:3x3:1,0")