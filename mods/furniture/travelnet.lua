furniture.travelnet = {}

local function travelnet_formspec(pos, player)
	local spos = pos.x..","..pos.y..","..pos.z
	local meta = minetest.get_meta(pos)
	local winv_listring = ""
    local playername = player:get_player_name()
    local right_inv = winv.get_inventory(player, "right")
    local tab_switches = ""
    local selected_tab = meta:get_string("selected_tab")
    local selected_netid = meta:get_int("selected_network_id")
    if selected_netid == nil then
        selected_tab = "first"
    end
    if playername == meta:get_string("owner") then
        tab_switches = table.concat({
            "style[" .. selected_tab .. ";bgcolor=#AAAAAA]",
            "image_button[6.5,0.25;1.0,1.0;blocks_book.png^[hsl:0:-100:0;info;]",
            "tooltip[info;Travel]",
            "image_button[6.5,1.5;1.0,1.0;gui_cube.png;edit;]",
            "tooltip[edit;Edit Station]"
        }, "")
    else
        selected_tab = "travel"
    end
    local settings_tab = ""
    if selected_tab == "settings" then
        local available_networks = get_available_network_ids(playername)
        local selected_network_dropid
        for i=1,#available_networks do
            if available_networks[i] == selected_netid then
                selected_network_dropid = i
            end
        end
        settings_tab = table.concat({
            "dropdown[0.25,0.25;5.0,0.5;selected_network;" .. table.concat(get_available_network_names(playername), ",") .. ";" .. selected_network_dropid .. ";true]",
        }, "")
    end
    local travel_tab = ""
    local first_tab = ""
    if right_inv == "player" then
        winv_listring =
            "listring[current_player;main]"..
            "listring[nodemeta:"..spos..";input]"..
            "listring[current_player;main]"..
            "listring[nodemeta:"..spos..";output]"
    elseif right_inv == "crafting" then
        winv_listring =
            "listring[nodemeta:"..spos..";input]"..
            "listring[detached:winv_craft_"..playername..";input]"..
            "listring[nodemeta:"..spos..";input]"..
            "listring[nodemeta:"..spos..";output]"..
            "listring[detached:winv_craft_"..playername..";input]"..
            "listring[detached:winv_craft_"..playername..";output]"
    elseif right_inv == "craftguide" then
        winv_listring =
            "listring[detached:winv_creative_"..playername..";main]"..
            "listring[nodemeta:"..spos..";input]"..
            "listring[detached:trash;main]"..
            "listring[nodemeta:"..spos..";output]"..
            "listring[detached:trash;main]"
    end
    local tab = ""
    if selected_tab == "travel" then
        tab = travel_tab
    elseif selected_tab == "settings" then
        tab = settings_tab
    elseif selected_tab == "first" then
        tab = first_tab
    end
	local winv_formspec = {
		"image[0,0;7.75,10.25;winv_bg.png]",
        tab_switches,
        tab,
		winv_listring,
		"style_type[image;noclip=true]",
		"image[-1.4,8.8;1.4,1.4;gui_tab.png]",
		"image_button[-1.1,8.95;1.05,1.05;"..locks.icons(pos, "furniture_travelnet", {"lock", "protect", "public"}).."]"
	}
	return winv.init_inventory(player, table.concat(winv_formspec, ""))
end

local function attach_network_formspec(pos, player)
	local spos = pos.x..","..pos.y..","..pos.z
	local meta = minetest.get_meta(pos)
	local winv_listring = ""
    local playername = player:get_player_name()
    local right_inv = winv.get_inventory(player, "right")
    local network_dropdown = ""
    local create_network = ""
    local available_networks = get_available_network_ids(playername)
    if available_networks[1] ~= nil then
        local selected_network_dropid = 0
        for i=1,#available_networks do
            if available_networks[i] == selected_netid then
                selected_network_dropid = i
            end
        end
        local available_network_names = get_available_network_names(playername)
        local network_names
        if #available_network_names > 1 then
            network_names = table.concat(available_network_names, ",")
        else
            network_names = available_network_names[1]
        end
        network_dropdown = table.concat({
            "dropdown[0.25,0.25;5.0,0.5;selected_network;" .. network_names .. ";" .. selected_network_dropid .. ";true]",
        }, "")
    else
        create_network = "field[0.25,1.5;5.0,0.5;create_network;Create Network;New Network]" ..
        "field_close_on_enter[create_network;false]"
    end
    if right_inv == "player" then
        winv_listring =
            "listring[current_player;main]"..
            "listring[nodemeta:"..spos..";input]"..
            "listring[current_player;main]"..
            "listring[nodemeta:"..spos..";output]"
    elseif right_inv == "crafting" then
        winv_listring =
            "listring[nodemeta:"..spos..";input]"..
            "listring[detached:winv_craft_"..playername..";input]"..
            "listring[nodemeta:"..spos..";input]"..
            "listring[nodemeta:"..spos..";output]"..
            "listring[detached:winv_craft_"..playername..";input]"..
            "listring[detached:winv_craft_"..playername..";output]"
    elseif right_inv == "craftguide" then
        winv_listring =
            "listring[detached:winv_creative_"..playername..";main]"..
            "listring[nodemeta:"..spos..";input]"..
            "listring[detached:trash;main]"..
            "listring[nodemeta:"..spos..";output]"..
            "listring[detached:trash;main]"
    end
	local winv_formspec = {
		"image[0,0;7.75,10.25;winv_bg.png]",
        network_dropdown,
        create_network,
		winv_listring,
		"style_type[image;noclip=true]",
		"image[-1.4,8.8;1.4,1.4;gui_tab.png]",
		"image_button[-1.1,8.95;1.05,1.05;"..locks.icons(pos, "furniture_travelnet", {"lock", "protect", "public"}).."]"
	}
	return winv.init_inventory(player, table.concat(winv_formspec, ""))
end

local function create_station_formspec(pos, player)
	local spos = pos.x..","..pos.y..","..pos.z
	local meta = minetest.get_meta(pos)
	local winv_listring = ""
    local playername = player:get_player_name()
    local right_inv = winv.get_inventory(player, "right")
    if right_inv == "player" then
        winv_listring =
            "listring[current_player;main]"..
            "listring[nodemeta:"..spos..";input]"..
            "listring[current_player;main]"..
            "listring[nodemeta:"..spos..";output]"
    elseif right_inv == "crafting" then
        winv_listring =
            "listring[nodemeta:"..spos..";input]"..
            "listring[detached:winv_craft_"..playername..";input]"..
            "listring[nodemeta:"..spos..";input]"..
            "listring[nodemeta:"..spos..";output]"..
            "listring[detached:winv_craft_"..playername..";input]"..
            "listring[detached:winv_craft_"..playername..";output]"
    elseif right_inv == "craftguide" then
        winv_listring =
            "listring[detached:winv_creative_"..playername..";main]"..
            "listring[nodemeta:"..spos..";input]"..
            "listring[detached:trash;main]"..
            "listring[nodemeta:"..spos..";output]"..
            "listring[detached:trash;main]"
    end
	local winv_formspec = {
		"image[0,0;7.75,10.25;winv_bg.png]",
		winv_listring,
		"style_type[image;noclip=true]",
		"image[-1.4,8.8;1.4,1.4;gui_tab.png]",
		"image_button[-1.1,8.95;1.05,1.05;"..locks.icons(pos, "furniture_travelnet", {"lock", "protect", "public"}).."]"
	}
	return winv.init_inventory(player, table.concat(winv_formspec, ""))
end

local function travelnet_show_formspec(pos, player)
	local playername = player:get_player_name()
	minetest.show_formspec(playername, "furniture:travelnet", travelnet_formspec(pos, player))
end

local function travelnet_show_attach_network_formspec(pos, player)
	local playername = player:get_player_name()
	minetest.show_formspec(playername, "furniture:travelnet_attach_network", attach_network_formspec(pos, player))
end

local function travelnet_show_create_station_formspec(pos, player)
	local playername = player:get_player_name()
	minetest.show_formspec(playername, "furniture:travelnet_create_station", create_station_formspec(pos, player))
end

local function travelnet_on_construct(pos)
	local meta = minetest.get_meta(pos)
	meta:set_string("lock", "lock")
	meta:set_string("owner", "")
    meta:set_string("editors", "")
	locks.init_infotext(pos, "TravelNet")
end

local function travelnet_after_place_node(pos, placer, itemstack, pointed_thing)
	local meta = minetest.get_meta(pos)
	local playername = placer:get_player_name()
	meta:set_string("owner", playername)
    meta:set_string("editors", playername)
    meta:set_int("attached_network", 0)
    meta:set_int("created_station", 0)
	locks.init_infotext(pos, "TravelNet")
end

local function get_network_name(netid)
    return string.match(furniture.storage:get_string("network_" .. netid), ':(.*)'):split(",")[1]
end

local function get_network_owner(netid)
    return string.match(furniture.storage:get_string("network_" .. netid), ':(.*)'):split(",")[2]
end

local function get_network_users(netid)
    return string.match(furniture.storage:get_string("network_" .. netid), '(.*):'):split(",")
end

local function get_station_name(statid)
    return string.match(furniture.storage:get_string("station_" .. statid), ':(.*)'):split(",")[1]
end

local function get_station_owner(statid)
    return string.match(furniture.storage:get_string("station_" .. statid), ':(.*)'):split(",")[2]
end

local function get_station_pos(statid)
    return minetest.string_to_pos(furniture.storage:get_string("pos_" .. statid))
end

local function set_network_name(netid, name)
    local netusers = get_network_users(netid)
    local netowner = get_network_owner(netid)
    furniture.storage:set_string("network_" .. netid, netusers .. ":" .. name .. "," .. netowner)
end

local function set_network_users(netid, users)
    users = table.concat(users, ",")
    local netname = get_network_name(netid)
    local netowner = get_network_owner(netid)
    furniture.storage:set_string("network_" .. netid, users .. ":" .. netname .. "," .. netowner)
end

local function set_station_name(statid, name)
    local owner = get_station_owner(statid)
    furniture.storage.set_string("station_" .. statid, name .. "," .. owner)
end

local function set_station_pos(statid, pos)
    furniture.storage.set_string("pos_" .. statid, minetest.pos_to_string(pos))
end

function get_available_network_names(user)
    local user_networks = furniture.storage:get_string(user .. "_network_index")
    local network_names = {}
    for _,netid in ipairs(user_networks:split(",")) do
        table.insert_all(network_names, {get_network_name(netid)})
    end
    return network_names
end

function get_available_network_ids(user)
    local user_networks = furniture.storage:get_string(user .. "_network_index")
    return user_networks:split(",")
end

local function register_network(name, creator)
    local latest_id = furniture.storage:get_int("latest_network_id")
    local owned_network_ids = furniture.storage:get_string(creator .. "_network_index")
    local appended_networks = latest_id

    if owned_network_ids ~= "" then
        for _,netid in ipairs(owned_network_ids:split(",")) do
            local network_name = get_network_name(netid)
            local network_owner = get_network_owner(netid)
            if (network_name == name) and (network_owner == creator) then
                return false
            end
        end
        appended_networks = "," .. latest_id
    end

    furniture.storage:set_string("network_" .. latest_id, creator .. ":" .. name .. "," .. creator)
    furniture.storage:set_string(creator .. "_network_index", owned_network_ids .. appended_networks)
    furniture.storage:set_int("latest_id", latest_id + 1)
    return true
end

local function share_network(netid, users)
    local network_users = netid:get_network_users()

    for i=1,#users do
        for j=1,#network_users do
            if users[i] == network_users[j] then
                break
            end
            table.insert_all(network_users, {users[i]})
        end
    end

    netid:set_network_users(network_users)
end

local function register_station(pos, name, owner, netid)
    local latest_id = furniture.storage:get_int("latest_network_" .. netid .. "_id")
    local selected_id = latest_id
    local owned_station_ids = furniture.storage:get_string(owner .. "_station_index")

    for i=0,latest_id do
        if furniture.storage:get_string("station_" .. i) == "deleted" then
            selected_id = i
            break
        end
    end

    local appended_station = selected_id

    if owned_station_ids ~= "" then
        for _,statid in ipairs(owned_station_ids:split(",")) do
            -- statid in the format of station_id:network_id
            local station_name = statid:get_station_name()
            local station_owner = statid:get_station_owner()
            if (station_name == name) and (station_owner == owner) then
                return false
            end
        end
        appended_station = "," .. appended_station
    end

    furniture.storage.set_string("station_" .. selected_id .. ":" .. netid, name .. "," .. owner)
    furniture.storage.set_string("pos_" .. selected_id .. ":" .. netid, minetest.pos_to_string(pos))

    furniture.storage:set_string(owner .. "_station_index", owned_station_ids .. appended_station)

    if selected_id == latest_id then
        furniture.storage:set_int("latest_network_" .. netid .. "_id", latest_id + 1)
    end
end

local function delete_station(statid, netid)
    furniture.storage.set_string("station_" .. statid .. ":" .. netid, "deleted")
    furniture.storage.set_string("pos_" .. statid .. ":" .. netid, "deleted")

    local new_index = {}

    for _,indid in ipairs(furniture.storage:get_string(owner .. "_station_index"):split(",")) do
        if indid ~= statid .. ":" .. netid then
            table.insert_all(new_index, {indid})
        end
    end

    furniture.storage:set_string(owner .. "_station_index", table.concat(new_index, ","))
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "furniture:travelnet" or not player then
		return
	end
	local playername = player:get_player_name()
	local pos = furniture.travelnet[playername]
	local meta = minetest.get_meta(pos)

	if not locks.can_access(pos, player) then
		return 0
	end

	if locks.fields(pos, player, fields, "furniture_travelnet", "TravelNet") then
		travelnet_show_formspec(pos, player)
	end

	if not fields.quit then
		winv.node_receive_fields(player, formname, fields)
		if winv.node_refresh(player) then
			travelnet_show_formspec(pos, player)
		end
	end
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "furniture:travelnet_attach_network" or not player then
		return
	end
	local playername = player:get_player_name()
	local pos = furniture.travelnet[playername]
	local meta = minetest.get_meta(pos)

	if not locks.can_access(pos, player) then
		return 0
	end

	if locks.fields(pos, player, fields, "furniture_travelnet", "TravelNet") then
		travelnet_show_formspec(pos, player)
	end

    if fields.key_enter_field == "create_network" then
        if fields.create_network ~= "" then
            register_network(fields.create_network, playername)
            travelnet_show_attach_network_formspec(pos, player)
        end
    end

    local netnames = get_available_network_names(playername)
    if #netnames > 0 then
        for dropid=1,#netnames do
            if fields.dropdown == dropid then
                local netid = netnames[dropid]
                meta:set_int("selected_netid", netid)
                meta:set_int("attached_network", 1)
                travelnet_show_create_station_formspec(pos, player)
            end
        end
    end

	if not fields.quit then
		winv.node_receive_fields(player, formname, fields)
		if winv.node_refresh(player) then
			travelnet_show_attach_network_formspec(pos, player)
		end
	end
end)

minetest.register_node("furniture:travelnet", {
    description = "TravelNet",
    tiles = {"blocks_stone.png"},
    groups = {dig_immediate = 3},
    sounds = default.sounds_stone_defaults,
    on_construct = travelnet_on_construct,
    after_place_node = travelnet_after_place_node,
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local playername = clicker:get_player_name()
        local meta = minetest.get_meta(pos)

        if not meta or meta and meta:get_string("owner") == "" then
            travelnet_on_construct(pos)
            travelnet_after_place_node(pos, clicker, itemstack, pointed_thing)
        end

        if meta:get_int("attached_network") == 0 then
            if meta:get_string("owner") == playername then
                furniture.travelnet[playername] = pos
                travelnet_show_attach_network_formspec(pos, clicker)
            else
                minetest.chat_send_player(playername, "This TravelNet station has not yet been configured by the owner.")
                return itemstack
            end
        elseif meta:get_int("created_station") == 0 then
            if meta:get_string("owner") == playername then
                furniture.travelnet[playername] = pos
                travelnet_show_create_station_formspec(pos, clicker)
            else
                minetest.chat_send_player(playername, "This TravelNet station has not yet been configured by the owner.")
                return itemstack
            end
        elseif (meta:get_int("created_station") == 1) and (meta:get_int("attached_network") == 1) then
            if not locks.can_access(pos, clicker) then
                return itemstack
            end
            travelnet_show_formspec(pos, clicker)
            furniture.travelnet[playername] = pos
        end
    end,
})