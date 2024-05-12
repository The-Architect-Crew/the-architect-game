blocks = {}

local path = minetest.get_modpath("blocks")
-- Alias
dofile(path.."/alias_old.lua")
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
-- Misc
dofile(path.."/mapgen.lua")

blocks.loot = {
    loot_level1 = {},
    loot_level2 = {},
    loot_level3 = {},
    loot_level4 = {},
    loot_level5 = {},
    loot_level6 = {},
    loot_level7 = {},
    loot_level8 = {}
}

minetest.register_on_mods_loaded(function()
    for name, definition in pairs(minetest.registered_items) do
        if definition.groups.loot and not string.find(name, "shapes_") then
            table.insert_all(blocks.loot["loot_level" .. definition.groups.loot], {name})
        end
    end
end)

function blocks.roll_loot(falloff, level)
    if level == nil then level = 1 end
    local itemstack
    if (math.random() < falloff) and (level < 8) then
        itemstack = blocks.roll_loot(falloff, level + 1)
    else
        local cat_size = #blocks.loot["loot_level" .. level]
        if cat_size == 0 then
            level = level - 1
            cat_size = #blocks.loot["loot_level" .. level]
        end
        local amount = math.random(1, math.max(1, 10-2*level))
        local random_id = math.random(1, cat_size)
        itemstack = blocks.loot["loot_level" .. level][random_id] .. " " .. amount
    end
    return itemstack
end