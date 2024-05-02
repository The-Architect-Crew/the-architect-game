
function travelnet.get_network_name(netid)
    return string.match(travelnet.storage:get_string("network_" .. netid), ':(.*)'):split(",")[1]
end

function travelnet.get_network_owner(netid)
    return string.match(travelnet.storage:get_string("network_" .. netid), ':(.*)'):split(",")[2]
end

function travelnet.get_network_users(netid)
    return string.match(travelnet.storage:get_string("network_" .. netid), '(.*):'):split(",")
end

function travelnet.get_station_name(statid)
    return travelnet.storage:get_string("station_" .. statid):split(",")[1]
end

function travelnet.get_station_owner(statid)
    return travelnet.storage:get_string("station_" .. statid):split(",")[2]
end

function travelnet.get_station_pos(statid)
    return minetest.string_to_pos(travelnet.storage:get_string("pos_" .. statid))
end

function travelnet.set_network_name(netid, name)
    local netusers = travelnet.get_network_users(netid)
    local netowner = travelnet.get_network_owner(netid)
    travelnet.storage:set_string("network_" .. netid, netusers .. ":" .. name .. "," .. netowner)
end

function travelnet.set_network_users(netid, users)
    users = table.concat(users, ",")
    local netname = travelnet.get_network_name(netid)
    local netowner = travelnet.get_network_owner(netid)
    travelnet.storage:set_string("network_" .. netid, users .. ":" .. netname .. "," .. netowner)
end

function travelnet.set_station_name(statid, name)
    local owner = travelnet.get_station_owner(statid)
    travelnet.storage.set_string("station_" .. statid, name .. "," .. owner)
end

function travelnet.set_station_pos(statid, pos)
    travelnet.storage.set_string("pos_" .. statid, minetest.pos_to_string(pos))
end

function travelnet.get_available_network_names(user)
    local user_networks = travelnet.storage:get_string(user .. "_network_index")
    local network_names = {}
    for _,netid in ipairs(user_networks:split(",")) do
        table.insert_all(network_names, {travelnet.get_network_name(netid)})
    end
    return network_names
end

function travelnet.get_available_network_ids(user)
    local user_networks = travelnet.storage:get_string(user .. "_network_index")
    return user_networks:split(",")
end