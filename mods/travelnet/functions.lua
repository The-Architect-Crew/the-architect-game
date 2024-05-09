function travelnet.filter(input)
    input = string.gsub(input, ",", " ")
    input = string.gsub(input, ";", " ")
    input = string.gsub(input, ":", " ")
    return input
end

function travelnet.filter_table(table)
    for i=1,#table do
        table[i] = travelnet.filter(table[i])
    end
    return table
end

function travelnet.register_network(name, creator)
    local latest_id = travelnet.storage:get_int("latest_network_id")
    if latest_id == 0 then latest_id = 1 end
    local accessible_network_ids = travelnet.storage:get_string(creator .. "_network_index")
    local owned_network_ids = travelnet.storage:get_string(creator .. "_owned_network_index")
    local appended_networks = latest_id

    if accessible_network_ids ~= "" then
        for _,netid in ipairs(accessible_network_ids:split(",")) do
            local network_name = travelnet.get_network_name(netid)
            local network_owner = travelnet.get_network_owner(netid)
            if (network_name == name) and (network_owner == creator) then
                return false
            end
        end
        appended_networks = "," .. latest_id
    end

    travelnet.storage:set_string("network_" .. latest_id, creator .. ":" .. name .. "," .. creator)
    travelnet.storage:set_string(creator .. "_owned_network_index", owned_network_ids .. appended_networks)
    travelnet.storage:set_string(creator .. "_network_index", accessible_network_ids .. appended_networks)
    travelnet.storage:set_int("latest_network_id", latest_id + 1)
    return latest_id
end

function travelnet.add_network_users(netid, users)
    local network_users = travelnet.get_network_users(netid)
    local network_name = travelnet.get_network_name(netid)

    for i=1,#users do
        if minetest.player_exists(users[i]) then
            local add = true
            for j=1,#network_users do
                if users[i] == network_users[j] then
                    add = false
                end
            end
            if add then
                table.insert_all(network_users, {users[i]})
                minetest.chat_send_player(users[i], travelnet.chat_message("note", "You have been granted access to the travelnet network " ..
                                            minetest.colorize(travelnet.network_color, network_name) .. "."))

                local user_networks = travelnet.storage:get_string(users[i] .. "_network_index")
                if user_networks == "" then
                    user_networks = netid
                else
                    user_networks = user_networks .. "," .. netid
                end
                travelnet.storage:set_string(users[i] .. "_network_index", user_networks)
            end
        end
    end

    travelnet.set_network_users(netid, network_users)
end

function travelnet.remove_network_users(netid, users)
    local network_users = travelnet.get_network_users(netid)
    local network_name = travelnet.get_network_name(netid)
    local owner = travelnet.get_network_owner(netid)
    local network_stations = travelnet.get_network_stations(netid)
    local resulting_users = {}

    for i=1,#network_users do
        local add = true
        for j=1,#users do
            if minetest.player_exists(users[j]) and (users[j] ~= owner) then
                if users[j] == network_users[i] then
                    add = false
                    for k=1,#network_stations do
                        if travelnet.get_station_owner(network_stations[k], netid) == users[j] then
                            travelnet.delete_station(network_stations[k], netid)
                        end
                    end
                    local user_networks = travelnet.storage:get_string(users[j] .. "_network_index")
                    local resulting_netids = {}
                    for _,accessible_netid in ipairs(user_networks:split(",")) do
                        if tonumber(accessible_netid) ~= tonumber(netid) then
                            table.insert_all(resulting_netids, {accessible_netid})
                        end
                    end
                    travelnet.storage:set_string(users[j] .. "_network_index", table.concat(resulting_netids, ","))
                    minetest.chat_send_player(users[j], travelnet.chat_message("note", "You have been revoked access from the TravelNet network " ..
                                                minetest.colorize(travelnet.network_color, network_name) ..
                                                ", all your stations on this network have been disconnected and reset."))
                end
            end
        end
        if add then
            table.insert_all(resulting_users, {network_users[i]})
        end
    end

    travelnet.set_network_users(netid, resulting_users)
end

function travelnet.change_network_owner(netid, new_owner)
    if minetest.player_exists(new_owner) then
        local owner = travelnet.get_network_owner(netid)
        local owned_networks = travelnet.storage:get_string(owner .. "_owned_network_index"):split(",")
        local new_owned_networks = {}
        for i=1,#owned_networks do
            if owned_networks[i] ~= netid then
                table.insert_all(new_owned_networks, {owned_networks[i]})
            end
        end
        travelnet.storage:set_string(owner .. "_owned_network_index", table.concat(new_owned_networks, ","))

        travelnet.add_network_users(netid, {new_owner})
        travelnet.set_network_owner(netid, new_owner)
    end
end

function travelnet.register_station(pos, name, owner, netid)
    local latest_id = travelnet.storage:get_int("latest_network_" .. netid .. "_id")
    if latest_id == 0 then latest_id = 1 end
    local selected_id = latest_id .. ":" .. netid
    local owned_station_ids = travelnet.storage:get_string(owner .. "_station_index")
    local network_stations = travelnet.get_network_stations(netid)

    for i=1,latest_id do
        if travelnet.storage:get_string("station_" .. i .. ":" .. netid) == "deleted" then
            selected_id = i .. ":" .. netid
            break
        end
    end

    local appended_station = selected_id

    if owned_station_ids ~= "" then
        for _,indid in ipairs(owned_station_ids:split(",")) do
            local owned_station_id = indid:split(":")[1]
            local owned_station_netid = indid:split(":")[2]
            local station_name = travelnet.get_station_name(owned_station_id, owned_station_netid)
            local station_owner = travelnet.get_station_owner(owned_station_id, owned_station_netid)
            if (station_name == name) and (station_owner == owner) then
                return false
            end
        end
        appended_station = "," .. appended_station
    end

    travelnet.storage:set_string("station_" .. selected_id, name .. "," .. owner)
    travelnet.storage:set_string("pos_" .. selected_id, minetest.pos_to_string(pos))

    if network_stations then
        network_stations = table.concat(table.insert_all(network_stations, {latest_id}), ",")
    else
        network_stations = latest_id
    end

    travelnet.storage:set_string("network_" .. netid .. "_stations", network_stations)

    travelnet.storage:set_string(owner .. "_station_index", owned_station_ids .. appended_station)

    if tonumber(selected_id:split(":")[1]) == latest_id then
        travelnet.storage:set_int("latest_network_" .. netid .. "_id", latest_id + 1)
    end

    return selected_id:split(":")[1]
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

    for _,network_statid in ipairs(travelnet.storage:get_string("network_" .. netid .. "_stations"):split(",")) do
        if tonumber(network_statid) ~= tonumber(statid) then
            table.insert_all(new_netindex, {network_statid})
        end
    end

    local station_meta = minetest.get_meta(minetest.string_to_pos(travelnet.storage:get_string("pos_" .. statid .. ":" .. netid)))
    station_meta:set_string("owner", owner)
    station_meta:set_string("selected_tab", "travel")
    station_meta:set_int("attached_network", 0)
    station_meta:set_int("editing_network", 0)
    station_meta:set_int("created_station", 0)
    station_meta:set_int("station_id", 0)
    station_meta:set_int("station_netid", 0)

    travelnet.storage:set_string(owner .. "_station_index", table.concat(new_index, ","))
    travelnet.storage:set_string("network_" .. netid .. "_stations", table.concat(new_netindex, ","))
    travelnet.storage:set_string("station_" .. statid .. ":" .. netid, "deleted")
    travelnet.storage:set_string("pos_" .. statid .. ":" .. netid, "deleted")
end

function travelnet.update_infotext(pos)
    local meta = minetest.get_meta(pos)
    local statid = meta:get_int("station_id")
    local netid = meta:get_int("station_netid")
    local station_name = travelnet.get_station_name(statid, netid)
    local network_name = travelnet.get_network_name(netid)

    locks.init_infotext(pos, "TravelNet station " .. station_name ..
                            "\non network " .. network_name)
end

function travelnet.dump_player_data(invoker, playername)
    if minetest.player_exists(playername) then
        local owned_networks = travelnet.get_owned_network_ids(playername)
        local owned_network_names = travelnet.get_owned_network_names(playername)
        local available_networks = travelnet.get_available_network_ids(playername)
        local available_network_names = travelnet.get_available_network_names(playername)

        minetest.chat_send_player(invoker, "Owned Network data for " .. playername .. ":")
        for i=1,#owned_networks do
            minetest.chat_send_player(invoker, owned_networks[i] .. " " .. owned_network_names[i])
        end

        minetest.chat_send_player(invoker, "Available Network data for " .. playername .. ":")
        for i=1,#available_networks do
            minetest.chat_send_player(invoker, available_networks[i] .. " " .. available_network_names[i])
        end

        local owned_statids = travelnet.storage:get_string(playername .. "_station_index"):split(",")

        minetest.chat_send_player(invoker, "Station data for " .. playername .. ":")

        for i=1,#owned_statids do
            local owned_station_id = owned_statids[i]:split(":")[1]
            local owned_station_network_id = owned_statids[i]:split(":")[2]
            minetest.chat_send_player(invoker, owned_station_id .. " " .. travelnet.get_station_name(owned_station_id, owned_station_network_id) ..
                                    "\non network " .. owned_station_network_id .. " " .. travelnet.get_network_name(owned_station_network_id))
        end
    end
end