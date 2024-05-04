function travelnet.register_network(name, creator)
    local latest_id = travelnet.storage:get_int("latest_network_id")
    if latest_id == 0 then latest_id = 1 end
    local owned_network_ids = travelnet.storage:get_string(creator .. "_network_index")
    local appended_networks = latest_id

    if owned_network_ids ~= "" then
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
    travelnet.storage:set_int("latest_network_id", latest_id + 1)
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
    if latest_id == 0 then latest_id = 1 end
    local selected_id = latest_id
    local owned_station_ids = travelnet.storage:get_string(owner .. "_station_index")
    local network_stations = travelnet.get_network_stations(netid)

    for i=1,latest_id do
        if travelnet.storage:get_string("station_" .. i) == "deleted" then
            selected_id = i
            break
        end
    end

    local appended_station = selected_id

    if owned_station_ids ~= "" then
        for _,statid in ipairs(owned_station_ids:split(",")) do

            local station_name = travelnet.get_station_name(statid, netid)
            local station_owner = travelnet.get_station_owner(statid, netid)
            if (station_name == name) and (station_owner == owner) then
                return false
            end
        end
        appended_station = "," .. appended_station
    end

    travelnet.storage:set_string("station_" .. selected_id .. ":" .. netid, name .. "," .. owner)
    travelnet.storage:set_string("pos_" .. selected_id .. ":" .. netid, minetest.pos_to_string(pos))

    if network_stations then
        network_stations = table.concat(table.insert_all(network_stations, {latest_id}), ",")
    else
        network_stations = latest_id
    end

    travelnet.storage:set_string("network_" .. netid .. "_stations", network_stations)

    travelnet.storage:set_string(owner .. "_station_index", owned_station_ids .. appended_station)

    if selected_id == latest_id then
        travelnet.storage:set_int("latest_network_" .. netid .. "_id", latest_id + 1)
    end

    return selected_id
end

function travelnet.delete_station(statid, netid)

    local new_index = {}
    local new_netindex = {}
    local owner = travelnet.get_station_owner(statid, netid)

    for _,indid in ipairs(travelnet.storage:get_string(owner .. "_station_index"):split(",")) do
        if indid ~= statid .. ":" .. netid then
            table.insert_all(new_index, {indid})
        end
    end

    for _,indid in ipairs(travelnet.storage:get_string("network_" .. netid .. "_stations"):split(",")) do
        if tonumber(indid) ~= tonumber(statid) then
            table.insert_all(new_netindex, {indid})
        end
    end

    travelnet.storage:set_string(owner .. "_station_index", table.concat(new_index, ","))
    travelnet.storage:set_string("network_" .. netid .. "_stations", table.concat(new_netindex, ","))
    travelnet.storage:set_string("station_" .. statid .. ":" .. netid, "deleted")
    travelnet.storage:set_string("pos_" .. statid .. ":" .. netid, "deleted")
end

function travelnet.update_infotext(pos)
    local meta = minetest.get_meta(pos)
    local statid = meta:get_int("station_id")
    local netid = meta:get_int("station_netid")
    local owner = travelnet.get_station_owner(statid, netid)
    local station_name = travelnet.get_station_name(statid, netid)
    local network_name = travelnet.get_network_name(netid)

    locks.init_infotext(pos, "TravelNet station " .. station_name ..
                            "\nowned by " .. owner ..
                            "\non network " .. network_name)
end