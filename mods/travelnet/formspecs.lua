
function tavelnet.travelnet_formspec(pos, player)
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
        local available_networks = travelnet.get_available_network_ids(playername)
        local selected_network_dropid
        for i=1,#available_networks do
            if available_networks[i] == selected_netid then
                selected_network_dropid = i
            end
        end
        settings_tab = table.concat({
            "dropdown[0.25,0.25;5.0,0.5;selected_network;" .. table.concat(travelnet.get_available_network_names(playername), ",") .. ";" .. selected_network_dropid .. ";true]",
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

function tavelnet.attach_network_formspec(pos, player)
	local spos = pos.x..","..pos.y..","..pos.z
	local meta = minetest.get_meta(pos)
	local winv_listring = ""
    local playername = player:get_player_name()
    local right_inv = winv.get_inventory(player, "right")
    local network_dropdown = ""
    local create_network = ""
    local available_networks = travelnet.get_available_network_ids(playername)
    if available_networks[1] ~= nil then
        local selected_network_dropid = 0
        for i=1,#available_networks do
            if available_networks[i] == selected_netid then
                selected_network_dropid = i
            end
        end
        local available_network_names = travelnet.get_available_network_names(playername)
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

function tavelnet.create_station_formspec(pos, player)
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

function tavelnet.travelnet_show_formspec(pos, player)
	local playername = player:get_player_name()
	minetest.show_formspec(playername, "furniture:travelnet", travelnet.travelnet_formspec(pos, player))
end

function tavelnet.travelnet_show_attach_network_formspec(pos, player)
	local playername = player:get_player_name()
	minetest.show_formspec(playername, "furniture:travelnet_attach_network", travelnet.attach_network_formspec(pos, player))
end

function tavelnet.travelnet_show_create_station_formspec(pos, player)
	local playername = player:get_player_name()
	minetest.show_formspec(playername, "furniture:travelnet_create_station", travelnet.create_station_formspec(pos, player))
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "furniture:travelnet" or not player then
		return
	end
	local playername = player:get_player_name()
	local pos = travelnet[playername]
	local meta = minetest.get_meta(pos)

	if not locks.can_access(pos, player) then
		return 0
	end

	if locks.fields(pos, player, fields, "furniture_travelnet", "TravelNet") then
		travelnet.travelnet_show_formspec(pos, player)
	end

	if not fields.quit then
		winv.node_receive_fields(player, formname, fields)
		if winv.node_refresh(player) then
			travelnet.travelnet_show_formspec(pos, player)
		end
	end
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "furniture:travelnet_attach_network" or not player then
		return
	end
	local playername = player:get_player_name()
	local pos = travelnet[playername]
	local meta = minetest.get_meta(pos)

	if not locks.can_access(pos, player) then
		return 0
	end

	if locks.fields(pos, player, fields, "furniture_travelnet", "TravelNet") then
		travelnet.travelnet_show_formspec(pos, player)
	end

    if fields.key_enter_field == "create_network" then
        if fields.create_network ~= "" then
            travelnet.register_network(fields.create_network, playername)
            travelnet.travelnet_show_attach_network_formspec(pos, player)
        end
    end

    local netnames = travelnet.get_available_network_names(playername)
    if #netnames > 0 then
        for dropid=1,#netnames do
            if fields.dropdown == dropid then
                local netid = netnames[dropid]
                meta:set_int("selected_netid", netid)
                meta:set_int("attached_network", 1)
                travelnet.travelnet_show_create_station_formspec(pos, player)
            end
        end
    end

	if not fields.quit then
		winv.node_receive_fields(player, formname, fields)
		if winv.node_refresh(player) then
			travelnet.travelnet_show_attach_network_formspec(pos, player)
		end
	end
end)