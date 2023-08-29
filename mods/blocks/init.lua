blocks = {}

local path = minetest.get_modpath("blocks")
-- Ground
dofile(path.."/dirt.lua")
dofile(path.."/snow.lua")
dofile(path.."/sand.lua")
-- Underground
dofile(path.."/liquid.lua")
dofile(path.."/stone.lua")
dofile(path.."/ore.lua")
dofile(path.."/underground.lua")
dofile(path.."/sfcave.lua")
dofile(path.."/stalagmites.lua")
-- Deco blocks
dofile(path.."/plank.lua")
dofile(path.."/glass.lua")
dofile(path.."/wool.lua")
dofile(path.."/brick.lua")
dofile(path.."/streets.lua")
dofile(path.."/fire.lua")
dofile(path.."/misc.lua")
-- Deco items
dofile(path.."/climbing.lua")
dofile(path.."/torch.lua")
dofile(path.."/lamp.lua")
dofile(path.."/book.lua")
dofile(path.."/vessel.lua")
dofile(path.."/bars.lua")
-- Signs
dofile(path.."/sign.lua")
dofile(path.."/itemframe.lua")
-- Shapes
dofile(path.."/shapes.lua")

blocks.forbidden_groups = {
    "not_in_creative_inventory",
    "not_in_craftguide",
}

blocks.random_items = {}
blocks.rare_items = {}
blocks.extra_rare_items = {
    "blocks:goldblock",
    "blocks:silverblock",
    "blocks:steelblock",
    "blocks:diamondblock",
    "blocks:mese",
    "blocks:tinblock",
    "blocks:copperblock",
    "blocks:copperblock_patinated",
    "tools:pick_mese",
    "tools:pick_diamond",
    "tools:axe_mese",
    "tools:axe_diamond",
    "tools:sword_mese",
    "tools:sword_diamond",
    "tools:shovel_mese",
    "tools:shovel_diamond",
}

blocks.blocked_mods = {"quests", "variations", "patterns", "flora"}
blocks.rare_mods = {"tools", "furniture"}

minetest.register_on_mods_loaded(function()
    for name, definition in pairs(minetest.registered_items) do
        if (not ccore.scan_forbidden_groups(definition.groups, blocks.forbidden_groups)) and (not ccore.belongs(blocks.blocked_mods, ccore.modname(name))) then
            if ccore.belongs(blocks.extra_rare_items, name) then
                break
            elseif ccore.belongs(blocks.rare_mods, ccore.modname(name)) then
                table.insert_all(blocks.rare_items, {name})
            else
                table.insert_all(blocks.random_items, {name})
            end
        end
    end
end)