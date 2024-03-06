function protection.get_grid_block(pos)
    local block_center = {
        x = protection.snap_to_increment(pos.x, protection.grid_xz),
        y = protection.snap_to_increment(pos.y, protection.grid_y),
        z = protection.snap_to_increment(pos.z, protection.grid_xz),
    }
    local pos1 = {
        x = block_center.x - (protection.grid_xz / 2),
        y = block_center.y - (protection.grid_y / 2),
        z = block_center.z - (protection.grid_xz / 2)
    }
    local pos2 = {
        x = block_center.x + (protection.grid_xz / 2),
        y = block_center.y + (protection.grid_y / 2),
        z = block_center.z + (protection.grid_xz / 2)
    }
    local block_data = {
        pos1 = pos1,
        pos2 = pos2,
        center = block_center
    }
    return block_data
end

function protection.snap_to_increment(value, increment)
    return math.floor((value) / increment + 0.5) * increment
end

function protection.pos_to_string(pos)
    return pos.x .. "," .. pos.y .. "," .. pos.z
end

function protection.pos_compare(pos1, pos2)
    local compx = pos1.x == pos2.x
    local compy = pos1.y == pos2.y
    local compz = pos1.z == pos2.z
    if compx and compy and compz then
        return true
    else
        return false
    end
end

function protection.calculate_surface(pos1, pos2)
    local length_x = math.abs(pos1.x - pos2.x) + 1
    local length_z = math.abs(pos1.z - pos2.z) + 1
    return length_x * length_z
end
function protection.calculate_volume(pos1, pos2)
    local length_x = math.abs(pos1.x - pos2.x) + 1
    local length_y = math.abs(pos1.y - pos2.y) + 1
    local length_z = math.abs(pos1.z - pos2.z) + 1
    return length_x * length_z * length_y
end
function protection.calculate_cost(pos1, pos2)
    local volume = protection.calculate_volume(pos1, pos2)
    return volume * protection.mese_cost / 100
end

function protection.find_block_area(pos, name)
    local areas_at_pos = areas:getAreasAtPos(pos)
    local block_data = protection.get_grid_block(pos)
    local area_data = {name = "Undefined", owner = "Unprotected", id = "undefined"}
    for id,area in pairs(areas_at_pos) do
        if protection.area_compare_pos(area, block_data) then
            if name ~= nil then
                if areas.areas[id].owner == name then
                    area_data = {name = area.name, owner = area.owner, id = id}
                    return area_data
                else
                    return area_data
                end
            else
                area_data = {name = area.name, owner = area.owner, id = id}
                return area_data
            end
        end
    end
    return area_data
end

function protection.find_owned_area(pos, name)
    local areas_at_pos = areas:getAreasAtPos(pos)
    local area_data = {name = "Undefined", owner = "Unprotected", id = "undefined"}
    for id,area in pairs(areas_at_pos) do
        if areas.areas[id].owner == name then
            area_data = {name = area.name, owner = area.owner, id = id}
            return area_data
        end
    end
    return area_data
end

function protection.count_lost_mese(player)
    local playername = player:get_player_name()
    local inv = minetest.get_inventory({type="player", name=playername})
    local mese_count = {crystals = 0, blocks = 0}
    local main_list = inv:get_list("main")
    for _,itemstack in ipairs(main_list) do
        if itemstack:get_name() == "blocks:lost_mese_crystal" then
            mese_count.crystals = mese_count.crystals + itemstack:get_count()
        elseif itemstack:get_name() == "blocks:lost_mese" then
            mese_count.blocks = mese_count.blocks + itemstack:get_count()
        end
    end
    return mese_count
end

function protection.subtract_mese(mese_count, amount)
    local inv_amount = mese_count.crystals + mese_count.blocks * 9
    if inv_amount < amount then
        return false
    else
        local subtract_amount = {blocks = 0, crystals = 0, add = 0}
        while amount > 0 do
            if amount > 9 then
                if mese_count.blocks > 0 then
                    mese_count.blocks = mese_count.blocks - 1
                    subtract_amount.blocks = subtract_amount.blocks + 1
                else
                    mese_count.crystals = mese_count.crystals - 9
                    subtract_amount.crystals = subtract_amount.crystals + 9
                end
                amount = amount - 9
            elseif mese_count.crystals < amount then
                subtract_amount.add = 9 - amount
                subtract_amount.blocks = subtract_amount.blocks + 1
                amount = 0
            elseif amount < 9 then
                mese_count.crystals = mese_count.crystals - amount
                subtract_amount.crystals = subtract_amount.crystals + amount
                amount = 0
            end
        end
        return subtract_amount
    end
end

function protection.take_mese(player, amount)
    amount = math.ceil(amount)
    local mese_count = protection.count_lost_mese(player)
    local subtract_amount = protection.subtract_mese(mese_count, amount)
    if subtract_amount ~= false then
        local playername = player:get_player_name()
        local inv = minetest.get_inventory({type="player", name=playername})
        inv:remove_item("main", "blocks:lost_mese_crystal " .. subtract_amount.crystals)
        inv:add_item("main", "blocks:lost_mese_crystal " .. subtract_amount.add) -- For breaking down blocks into crystals
        inv:remove_item("main", "blocks:lost_mese " .. subtract_amount.blocks)
    else
        return false
    end
end

-- Test
minetest.register_craftitem("protection:test", {
    description = "testttt",
    inventory_image = "blocks_book.png",
   on_use = function(itemstack, user, pointed_thing)
        local mese_count = protection.count_lost_mese(user)
        minetest.chat_send_player(user:get_player_name(), "Lost mese crystals: " .. mese_count.crystals .. " Lost mese blocks: " .. mese_count.blocks)
   end,
})