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