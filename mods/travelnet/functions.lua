
function travelnet.register_network(name, creator)
    local latest_id = travelnet.storage:get_int("latest_network_id")
    local owned_network_ids = travelnet.storage:get_string(creator .. "_network_index")
    local appended_networks = latest_id

    if owned_network_ids ~= 0 then
        for _,netid in ipairs(owned_network_ids:split(",")) do
            local network_name = travelnet.get_network_name(netid)
            local network_owner = travelnet.get_network_owner(netid)
            if (network_name == name) and (network_owner == creator) then
                return false
            end
        end
        appended_networks = "," .. latest_id
    end

    travelnet.storage:set_string("network_" .. latest_id, creator .. ":" .. name .. "," .. creator)
    travelnet.storage:set_string(creator .. "_network_index", owned_network_ids .. appended_networks)
    travelnet.storage:set_int("latest_id", latest_id + 1)
    return latest_id
end

function travelnet.share_network(netid, users)
    local network_users = travelnet.get_network_users(netid)

    for i=1,#users do
        for j=1,#network_users do
            if users[i] == network_users[j] then
                break
            end
            table.insert_all(network_users, {users[i]})
        end
    end

    travelnet.set_network_users(netid, network_users)
end

function travelnet.register_station(pos, name, owner, netid)
    local latest_id = travelnet.storage:get_int("latest_network_" .. netid .. "_id")
    local selected_id = latest_id
    local owned_station_ids = travelnet.storage:get_string(owner .. "_station_index")

    for i=0,latest_id do
        if travelnet.storage:get_string("station_" .. i) == "deleted" then
            selected_id = i
            break
        end
    end

    local appended_station = selected_id

    if owned_station_ids ~= 0 then
        for _,statid in ipairs(owned_station_ids:split(",")) do
            -- statid in the format of station_id:network_id
            local station_name = travelnet.get_station_name(statid .. ":" .. netid)
            local station_owner = travelnet.get_station_owner(statid .. ":" .. netid)
            if (station_name == name) and (station_owner == owner) then
                return false
            end
        end
        appended_station = "," .. appended_station
    end

    travelnet.storage:set_string("station_" .. selected_id .. ":" .. netid, name .. "," .. owner)
    travelnet.storage:set_string("pos_" .. selected_id .. ":" .. netid, minetest.pos_to_string(pos))

    travelnet.storage:set_string(owner .. "_station_index", owned_station_ids .. appended_station)

    if selected_id == latest_id then
        travelnet.storage:set_int("latest_network_" .. netid .. "_id", latest_id + 1)
    end

    return selected_id
end

function travelnet.delete_station(statid, netid)

    local new_index = {}
    local owner = travelnet.get_station_owner(statid .. ":" .. netid)

    for _,indid in ipairs(travelnet.storage:get_string(owner .. "_station_index"):split(",")) do
        if indid ~= statid .. ":" .. netid then
            table.insert_all(new_index, {indid})
        end
    end

    travelnet.storage:set_string(owner .. "_station_index", table.concat(new_index, ","))
    travelnet.storage:set_string("station_" .. statid .. ":" .. netid, "deleted")
    travelnet.storage:set_string("pos_" .. statid .. ":" .. netid, "deleted")
end