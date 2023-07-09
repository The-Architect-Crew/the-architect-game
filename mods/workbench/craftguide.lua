local winv_exists = minetest.global_exists("winv")
if not winv_exists then
    return
end

local max_item_per_page = 36 -- items per page
local max_item_per_row = 6 -- items per row
local craftguide_list = {} -- valid crafts list
local craftguide_list_all = {} -- all possible items
local craftguide_names_list = {} -- valid crafts names
local craftguide_desc_list = {} -- valid crafts descriptions
local craftguide_tooltip_list = {} -- valid crafts descriptions
local craftguide_usage_list = {} -- usages list
local craftguide_data = {} -- various player specific form data
local craftguide_groups = {} -- manually defined groups
local craftguide_groups_auto = {} -- automatically generated groups
local craftguide_nonempty_modnames = {}

function workbench:register_craftguide_group(groupname, def)
    craftguide_groups[groupname] = {
        redirect = def.redirect, -- item to redirect
        description = def.description, -- description of group
    }
end

local path = minetest.get_modpath("workbench")
dofile(path.."/craftguide_groups.lua")

local function craftguide_init(player)
    local playername = player:get_player_name()
    local player_meta = player:get_meta()

    local save_data = {}
    if player_meta:get_string("workbench:craftguide") ~= "" then
        print("[workbench] data loaded for "..playername)
        save_data = minetest.deserialize(player_meta:get_string("workbench:craftguide"))
    end

    craftguide_data[playername] = {
        active = false, -- whether form is active
        item = "", -- selected item
        form_list = nil, -- cached recipe list
        fav_list = save_data.fav_list or {}, -- favourite list
        -- craft history
        history = nil, -- item history
        item_view = 0, -- viewing
        -- pages
        curr_page = 1,
        max_page = 1,
        curr_recipe = 1, -- current recipe page
        max_recipe = 1, -- max recipe page
        -- usage
        show_usage = nil,
        curr_usage = 1,
        max_usage = 1,
        -- content filter
        content = minetest.registered_items,
        content_name = "all",
        content_old = nil,
        -- search filter
        filter_search = "",
        filter_search_old = nil,
        -- mod filter
        filter_mod = save_data.filter_mod or {},
        filter_mod_show = nil,
        filter_mod_old = {},
        filter_mod_scroll = 0,
        -- adv filter
        filter_adv_show = nil,
        filter_adv_all = save_data.filter_adv_all or nil,
        filter_adv_shapes = save_data.filter_adv_shapes or nil,
    }
end

-- generate item tooltip
local function generate_item_tooltip(itemname)
    if not itemname or itemname == "" then
        return ""
    end
    local desc = itemname
    local desc_from_table = craftguide_desc_list[itemname]
    if desc_from_table then
        desc = desc_from_table
        return "tooltip[workbench_craftguide_item_"..itemname..";"..desc.."]"
    end
    if winv.is_group(itemname) and desc == itemname then -- group tooltip
        local groupstring = itemname:gsub(",", "") -- remove all commas to prevent invalid fieldname
        local groupname = string.match(itemname, ':(.*)')
        desc = ccore.comment("Any "..groupname, itemname)
        return "tooltip[workbench_craftguide_item_"..groupstring..";"..minetest.formspec_escape(desc).."]"
    end
    -- unknown tooltip + prints warning
    desc = ccore.comment("Unknown", itemname)
    print("[workbench] warning: unknown item found: "..itemname)
    return "tooltip[workbench_craftguide_item_"..itemname..";"..desc.."]"
end

-- generate right crafting header
local function craftguide_header_form(player)
    local playername = player:get_player_name()
    if not craftguide_data[playername] or craftguide_data[playername].item == "" then
        return ""
    end

    local ret_form = ""
    if craftguide_data[playername].item and craftguide_data[playername].item ~= "" then
        local itemname = craftguide_data[playername].item
        local itemdesc = minetest.registered_items[itemname].short_description or minetest.registered_items[itemname].description
        itemdesc = itemdesc:gsub("\n.*", "") -- First line of description only
        ret_form =
            "item_image_button[0.25,-0.9;0.8,0.8;"..itemname..";workbench_craftguide_header_"..itemname..";]".. -- item icon
            (craftguide_tooltip_list[itemname] or generate_item_tooltip(itemname)).. -- item tooltip
            "style_type[label;font_size=20;font=bold]"..
            "label[1.2,-0.7;"..itemdesc.."]".. -- item description (item name)
            "style_type[label;font_size=13;font=normal]"..
            "label[1.2,-0.3;"..itemname.."]" -- item technical name
    end
    return ret_form
end

-- convert workbench recipe data to formspec
local function workbench_recipe_to_form(recipe_data, output_data)
    local ret_form = ""
    -- apply dynamic input scale
    local item_scale = 1
    local item_width = 1.25
    local max_width = math.max(recipe_data.width, recipe_data.height)
    if max_width > 5 then
        item_width = (6.25 / max_width)
        item_scale = item_width - 0.25
    end

    -- create input item form
    for i = 1, recipe_data.height do
        for j = 1, recipe_data.width do
            local recipe_item = recipe_data.input[i][j]
            local recipe_itemname = ItemStack(recipe_item):get_name()
            local recipe_itemcount = ItemStack(recipe_item):get_count()
            if winv.is_group(recipe_itemname) then -- group label
                local groupname = recipe_itemname
                local groupstring = groupname:gsub(",", "") -- remove all commas to prevent invalid fieldname
                if craftguide_groups[groupname] then
                    recipe_itemname = craftguide_groups[groupname].redirect
                    recipe_item = recipe_itemname.." "..recipe_itemcount
                    ret_form = ret_form..
                        "item_image_button["..( 0.875 + ((j - 1) * item_width) )..","..( 0.875 + ((i - 1) * item_width) )..
                            ";"..item_scale..","..item_scale..";"..recipe_item..";workbench_craftguide_item_"..groupstring..";(G)]"..
                        "tooltip[workbench_craftguide_item_"..groupstring..";"..craftguide_groups[groupname].description.."]"
                else
                    recipe_itemname = winv.find_first_in_group(groupname)
                    recipe_item = recipe_itemname.." "..recipe_itemcount
                    craftguide_groups_auto[groupname] = groupstring
                    ret_form = ret_form..
                        "item_image_button["..( 0.875 + ((j - 1) * item_width) )..","..( 0.875 + ((i - 1) * item_width) )..
                            ";"..item_scale..","..item_scale..";"..recipe_item..";workbench_craftguide_item_"..groupstring..";(G)]"..
                        generate_item_tooltip(groupname)
                end
            else
                ret_form = ret_form..
                    "item_image_button["..( 0.875 + ((j - 1) * item_width) )..","..( 0.875 + ((i - 1) * item_width) )..
                        ";"..item_scale..","..item_scale..";"..recipe_item..";workbench_craftguide_item_"..recipe_itemname..";]"..
                        (craftguide_tooltip_list[recipe_itemname] or generate_item_tooltip(recipe_itemname))
            end
        end
    end

    -- output item(s) form
    local output_items = (workbench_crafts.output[output_data.ctype][recipe_data.id][output_data.output_index].items)
    local output_amt = #output_items
    -- apply dynamic output scale
    local output_item_scale = 1
    local output_item_width = 1.25
    if output_amt > 4 then
        output_item_width = (5 / output_amt)
        output_item_scale = output_item_width - 0.25
    end
    for index2, output_item in pairs(output_items) do
        local output_itemname = output_item:get_name()
        local output_itemstring = output_item:get_name().." "..output_item:get_count()
        ret_form = ret_form..
            "item_image_button["..1.4375 + ((index2 - 1) * output_item_width)..",7.75;"..output_item_scale..","..output_item_scale..";"..output_itemstring..";workbench_craftguide_item_"..output_itemname..";]"..
            (craftguide_tooltip_list[output_itemname] or generate_item_tooltip(output_itemname))
    end

    -- output arrow (crafting type)
    local crafting_arrow = "gui_arrow.png^[transformFYR90"
    if workbench_crafts.data[output_data.ctype].icon then
        crafting_arrow = workbench_crafts.data[output_data.ctype].icon
    end

    local crafting_desc = output_data.ctype
    if workbench_crafts.data[output_data.ctype].description then
        crafting_desc = workbench_crafts.data[output_data.ctype].description
    end

    ret_form = ret_form..
        "style[workbench_craftguide_ctype;border=false]"..
        "image_button[0.25,7.75;1,1;"..crafting_arrow..";workbench_craftguide_ctype;]"..
        "tooltip[workbench_craftguide_ctype;"..crafting_desc.."]"

    return ret_form
end

-- convert minetest recipe data to formspec
local function mt_recipe_to_form(recipe_data)
    local ret_form = ""
    local width = recipe_data.width
    if recipe_data.method == "cooking" then -- if cooking, hardset width to 1 (prevent faulty widths)
        width = 1
    end
    local recipe_amt = #recipe_data.items
    if width == 0 then -- shapeless recipe
        width = 3
    end
    local height = math.ceil(recipe_amt / width)
    if height < 5 then
        height = 5 -- hacky method -- to figure out better way to find height
    end
    -- apply dynamic input scale
    local item_scale = 1
    local item_width = 1.25
    local max_width = math.max(width, height)
    if max_width > 5 then
        item_width = (6.25 / max_width)
        item_scale = item_width - 0.25
    end

    -- create item form
    for i = 1, height do -- height
        for j = 1, width do -- width
            local recipe_index = ((i - 1) * width) + j
            local recipe_item = recipe_data.items[recipe_index]
            if recipe_item then
                local recipe_itemname = ItemStack(recipe_item):get_name()
                if recipe_itemname then
                    local recipe_itemcount = ItemStack(recipe_item):get_count()
                    if winv.is_group(recipe_itemname) then -- group label
                        local groupname = recipe_itemname
                        local groupstring = groupname:gsub(",", "") -- remove all commas to prevent invalid fieldname
                        if craftguide_groups[groupname] then
                            recipe_itemname = craftguide_groups[groupname].redirect
                            recipe_item = recipe_itemname.." "..recipe_itemcount
                            ret_form = ret_form..
                                "item_image_button["..( 0.875 + ((j - 1) * item_width) )..","..( 0.875 + ((i - 1) * item_width) )..
                                    ";"..item_scale..","..item_scale..";"..recipe_item..";workbench_craftguide_item_"..groupstring..";(G)]"..
                                "tooltip[workbench_craftguide_item_"..groupstring..";"..craftguide_groups[groupname].description.."]"
                        else
                            recipe_itemname = winv.find_first_in_group(groupname)
                            recipe_item = recipe_itemname.." "..recipe_itemcount
                            craftguide_groups_auto[groupname] = groupstring
                            ret_form = ret_form..
                                "item_image_button["..( 0.875 + ((j - 1) * item_width) )..","..( 0.875 + ((i - 1) * item_width) )..
                                    ";"..item_scale..","..item_scale..";"..recipe_item..";workbench_craftguide_item_"..groupstring..";(G)]"..
                                generate_item_tooltip(groupname)
                        end
                    else
                        ret_form = ret_form..
                            "item_image_button["..( 0.875 + ((j - 1) * item_width) )..","..( 0.875 + ((i - 1) * item_width) )..
                                ";"..item_scale..","..item_scale..";"..recipe_item..";workbench_craftguide_item_"..recipe_itemname..";]"..
                                (craftguide_tooltip_list[recipe_itemname] or generate_item_tooltip(recipe_itemname))
                    end
                end
            end
        end
    end

    -- output item
    local output_item = recipe_data.output
    local output_itemname = ItemStack(output_item):get_name()

    local crafting_arrow = "gui_arrow.png^[transformFYR90"
    local crafting_desc = recipe_data.method
    if recipe_data.method == "normal" or recipe_data.method == "cooking" then
        crafting_arrow = workbench_crafts.data[recipe_data.method].icon
        crafting_desc = workbench_crafts.data[recipe_data.method].description
    end

    ret_form = ret_form..
        "item_image_button[1.4375,7.75;1,1;"..output_item..";workbench_craftguide_item_"..output_itemname..";]"..
        (craftguide_tooltip_list[output_itemname] or generate_item_tooltip(output_itemname))..
        -- craft type
        "style[workbench_craftguide_ctype;border=false]"..
        "image_button[0.25,7.75;1,1;"..crafting_arrow..";workbench_craftguide_ctype;]"..
        "tooltip[workbench_craftguide_ctype;"..crafting_desc.."]"
    return ret_form
end

-- handle all workbench recipes
local function handle_workbench_recipes(playername, item, srecipe_count)
    local ret_form = ""
    local recipe_count = srecipe_count
    local output_data = workbench_crafts.output_by_name[item] -- workbench crafting
    if output_data then
        for index, value in pairs(output_data) do
            local input_data = workbench_crafts.input[value.ctype][value.input_index]
            if input_data then
                if (recipe_count + index) == craftguide_data[playername].curr_recipe then
                    ret_form = ret_form.. workbench_recipe_to_form(input_data, value)
                end
            end
        end
        recipe_count = recipe_count + #output_data
    end
    return recipe_count, ret_form
end

-- handle all minetest recipes
local function handle_mt_recipes(playername, item, srecipe_count)
    local ret_form = ""
    local recipe_count = srecipe_count
    local mt_output_data = minetest.get_all_craft_recipes(item)
    if mt_output_data then
        for index, value in pairs(mt_output_data) do
            --recipe_count = recipe_count + 1
            if (recipe_count + index) == craftguide_data[playername].curr_recipe then
                ret_form = ret_form.. mt_recipe_to_form(value)
            end
        end
        recipe_count = recipe_count + #mt_output_data
    end
    return recipe_count, ret_form
end

-- generate recipe form (right side)
local function craftguide_recipe_form(player)
    local playername = player:get_player_name()
    if not craftguide_data[playername] or craftguide_data[playername].item == "" then
        return ""
    end

    local item = craftguide_data[playername].item
    local fav_button = ""

    if craftguide_list[item] then -- allow favoriting only if valid craft
        fav_button = "image_button[7.85,0.2;0.5,0.5;winv_icon_star.png;workbench_craftguide_fav;]"

        if item ~= "" then
            if craftguide_data[playername].fav_list[item] then
                fav_button = "image_button[7.85,0.2;0.5,0.5;winv_icon_star.png^[colorize:#565656;workbench_craftguide_fav;]"
            end
        end
    end

    if fav_button ~= "" then
        fav_button = fav_button..
            "tooltip[workbench_craftguide_fav;Add to favourites]"
    end

    local undo_button = "image_button[7.85,0.9;0.5,0.5;winv_icon_return.png;workbench_craftguide_undo;]"
    local redo_button = "image_button[7.85,1.6;0.5,0.5;winv_icon_return.png^[transformFX;workbench_craftguide_redo;]"

    if not craftguide_data[playername].history then
        undo_button = "image_button[7.85,0.9;0.5,0.5;winv_icon_return.png^[colorize:#565656;workbench_craftguide_undo;]"
        redo_button = "image_button[7.85,1.6;0.5,0.5;winv_icon_return.png^[transformFX^[colorize:#565656;workbench_craftguide_redo;]"
    else
        if craftguide_data[playername].item_view == #craftguide_data[playername].history then
            redo_button = "image_button[7.85,1.6;0.5,0.5;winv_icon_return.png^[transformFX^[colorize:#565656;workbench_craftguide_redo;]"
        end
        if craftguide_data[playername].item_view <= 1 then
            undo_button = "image_button[7.85,0.9;0.5,0.5;winv_icon_return.png^[colorize:#565656;workbench_craftguide_undo;]"
        end
    end
    local usage_button = ""
    if craftguide_usage_list[item] then
        usage_button =      "button[7.85,2.3;0.5,0.5;workbench_craftguide_usage;U]"..
                            "tooltip[workbench_craftguide_usage;Show usages]"
        if craftguide_data[playername].show_usage then
            usage_button =  "button[7.85,2.3;0.5,0.5;workbench_craftguide_usage;R]"..
                            "tooltip[workbench_craftguide_usage;Show recipes]"
        end
    end

    -- background
    local ret_form =
        "image[0,0;7.75,9;winv_bg.png]"..
        "style[workbench_current_item;border=false]"..
        craftguide_header_form(player)..
        "box[0.25,0.25;7.275,7.275;#00000070]"..
        -- buttons (0.6 width)
        "style[workbench_craftguide_fav;border=false]"..
        fav_button..
        "style[workbench_craftguide_undo;border=false]"..
        undo_button..
        "tooltip[workbench_craftguide_undo;Undo to last recipe]"..
        "style[workbench_craftguide_redo;border=false]"..
        redo_button..
        "tooltip[workbench_craftguide_redo;Redo to next recipe]"..
        usage_button

    if craftguide_data[playername].show_usage then
        -- show usage
        if craftguide_usage_list[item] then
            local usage_count = 0
            for output_itemname, value in pairs(craftguide_usage_list[item]) do
                for ctype, value2 in pairs(value) do
                    usage_count = usage_count + 1
                    if usage_count == craftguide_data[playername].curr_usage then
                        if value2.utype == "mt" then
                            ret_form = ret_form.. mt_recipe_to_form(value2.data)
                        elseif value2.utype == "workbench" then
                            ret_form = ret_form.. workbench_recipe_to_form(value2.data, value2.odata)
                        end
                    end
                end
            end

            craftguide_data[playername].max_usage = usage_count
            ret_form = ret_form..
                "label[0.25,9.25;Usage " .. minetest.colorize("#FFFF00", tostring(craftguide_data[playername].curr_usage)) .. " / " .. tostring(usage_count) .. "]"
            if usage_count > 1 then -- show arrows (recipe page)
                ret_form = ret_form..
                    "image_button[6.5,7.83;0.5,0.8;winv_cicon_miniarrow.png^[transformFX;workbench_craftguide_usage_prev;;;false;]"..
                    "image_button[7,7.85;0.5,0.8;winv_cicon_miniarrow.png;workbench_craftguide_usage_next;;;false;]"
            end
        end
    else
        -- show recipes
        local output_data = workbench_crafts.output_by_name[item] -- workbench crafting
        local mt_output_data = minetest.get_all_craft_recipes(item) -- mt crafting
        local total_count
        if output_data and mt_output_data then
            total_count = #output_data + #mt_output_data
        else
            if output_data then
                total_count = #output_data
            else
                total_count = #mt_output_data
            end
        end
        if craftguide_data[playername].curr_recipe == 0 then
            craftguide_data[playername].curr_recipe = total_count
        end

        local recipe_count = 0
        local op_form
        local reverse_order = nil

        -- manual handling to change some recipe ordering...
        if item:find("variations:") and not item:find("_support_") then
            reverse_order = true
        end

        if reverse_order then
            recipe_count, op_form = handle_mt_recipes(playername, item, recipe_count)
            ret_form = ret_form.. op_form
        end

        recipe_count, op_form = handle_workbench_recipes(playername, item, recipe_count)
        ret_form = ret_form.. op_form

        if not reverse_order then
            recipe_count, op_form = handle_mt_recipes(playername, item, recipe_count)
            ret_form = ret_form.. op_form
        end

        -- handle common header displays (recipe page)
        craftguide_data[playername].max_recipe = recipe_count
        ret_form = ret_form..
            "label[0.25,9.25;Recipe " .. minetest.colorize("#FFFF00", tostring(recipe_count - craftguide_data[playername].curr_recipe) + 1) .. " / " .. tostring(recipe_count) .. "]" -- reverse page count (ensure older recipes are shown first)
        if recipe_count == 0 then -- no recipe found
            ret_form = ret_form..
                "style[workbench_craftguide_no_recipe;border=false]"..
                "image_button[0.25,7.75;1,1;gui_cross_big.png;workbench_craftguide_no_recipe;]"..
                "label[0.5, 0.5;No recipe found!]"..
                "tooltip[workbench_craftguide_no_recipe;No recipe found!]"
        end
        if recipe_count > 1 then -- show arrows (recipe page)
            ret_form = ret_form..
                "image_button[6.5,7.83;0.5,0.8;winv_cicon_miniarrow.png^[transformFX;workbench_craftguide_recipe_prev;;;false;]"..
                "image_button[7,7.85;0.5,0.8;winv_cicon_miniarrow.png;workbench_craftguide_recipe_next;;;false;]"
        end
    end

    return ret_form
end

-- get mod filter status of specified mod
local function get_modfilter_status(modname, playername)
	local data = craftguide_data[playername]
	if not data.filter_mod or not next(data.filter_mod) then
		return true
	end
	for i, modfname in pairs(data.filter_mod) do
		if modfname == modname then
			return false
		end
	end
	return true
end

-- generate mod filter list
local function modfilter_list(playername)
	local modlist = ""
	local modnames = craftguide_nonempty_modnames
	for i, modname in ipairs(modnames) do
		modlist = modlist.."checkbox[0.1,"..((i - 1) * 0.4 + 0.25)..";workbench_craftguide_modfilter_mod_"..modname..";"..modname..";"..tostring(get_modfilter_status(modname, playername)).."]"
	end
	return modlist
end

-- check if item matches mod filter
-- mod filter contains mods that should be filtered out
local function mod_match(itemname, filter_mod)
	if not filter_mod or not next(filter_mod) then
		return true
	end
	for i, modname in pairs(filter_mod) do
		if winv.mod_match(itemname, modname) then
			return nil
		end
	end
	return true
end

-- check if item matches advanced filter(s)
local function advfilter_check(playername, def)
    if craftguide_data[playername].filter_adv_shapes then
        if (def.groups.shapes == 0 or not def.groups.shapes) and (def.groups.shapes_mesh == 0 or not def.groups.shapes_mesh) then
            return true
        end
    else
        return true
    end
end

-- check if item matches search filter, returns closest to search filter
local NO_MATCH = 999
local function match(itemname, filter_search)
	if filter_search == "" then
		return 0
	end
	if itemname:lower():find(filter_search, 1, true) then
		return #itemname - #filter_search
	end
	return NO_MATCH
end

-- returns translated description of first line
local function description(def, lang_code)
	local desc = def.description
	if lang_code then
		desc = minetest.get_translated_string(lang_code, desc)
	end
	return desc:gsub("\n.*", "") -- First line only
end

-- generate item listing (left side)
local function construct_itemlist_form(player)
    local playername = player:get_player_name()
    if craftguide_data[playername].form_list then
        return
    else
        craftguide_data[playername].form_list = {}
    end

    -- get player language
    local lang
	local player_info = minetest.get_player_information(playername)
	if player_info and player_info.lang_code ~= "" then
		lang = player_info.lang_code
	end

    -- create a list according to filters
    local filter_search = craftguide_data[playername].filter_search
    local filtered_list = {}
	local order = {}

    local search_list = craftguide_list
    if winv.is_group(filter_search) or craftguide_data[playername].filter_adv_all then
        search_list = craftguide_list_all
    end
    for itemname, def in pairs(search_list) do
        if craftguide_data[playername].content[itemname] then -- content filter
            if mod_match(itemname, craftguide_data[playername].filter_mod) then
                if winv.is_group(filter_search) then
                    if winv.group_match(filter_search, itemname) then
                        filtered_list[#filtered_list+1] = itemname
                        order[itemname] = string.format("%02d", 1) .. itemname
                    end
                else
                    local m = match(description(def), filter_search)
                    if m > 0 then
                        m = math.min(m, match(description(def, lang), filter_search))
                    end
                    if m > 0 then
                        m = math.min(m, match(itemname, filter_search))
                    end

                    if m < NO_MATCH then
                        if advfilter_check(playername, def) then
                            filtered_list[#filtered_list+1] = itemname
                            -- Sort by match value first so closer matches appear earlier
                            order[itemname] = string.format("%02d", m) .. itemname
                        end
                    end
                end
            end
        end
    end

    -- sort list according to filter match
    table.sort(filtered_list, function(a, b) return order[a] < order[b] end)

    -- construct form with filtered, sorted list
    local count = 0
    for index, itemname in ipairs(filtered_list) do
        count = count + 1
        local curr_page = math.ceil(count / max_item_per_page)
        if not craftguide_data[playername].form_list[curr_page] then
            craftguide_data[playername].form_list[curr_page] = ""
        end
        -- item counters
        local item_count_in_page = count % max_item_per_page
        if item_count_in_page == 0 then
            item_count_in_page = max_item_per_page
        end
        local curr_row = math.ceil(item_count_in_page / max_item_per_row)

        local item_count_in_row = count % max_item_per_row
        if item_count_in_row == 0 then
            item_count_in_row = max_item_per_row
        end

        -- construct form
        craftguide_data[playername].form_list[curr_page] = craftguide_data[playername].form_list[curr_page]..
            "item_image_button["..( 0.25 + ((item_count_in_row - 1) * 1.25))..","..( 0.25 + ((curr_row - 1) * 1.25))..
                ";1,1;"..itemname..";workbench_craftguide_item_"..itemname..";]"..
                (craftguide_tooltip_list[itemname] or generate_item_tooltip(itemname))
    end

    if not craftguide_data[playername].form_list[1] then -- ensure first page is always constructed
        craftguide_data[playername].form_list[1] = "label[0.25,0.4;Nothing found...]"
    end
    craftguide_data[playername].max_page = math.ceil(count / max_item_per_page)
end

-- check if item is craftable (by mt crafting or workbench crafting)
local function is_craftable(itemname)
    if minetest.get_craft_recipe(itemname) and minetest.get_craft_recipe(itemname).items or workbench_crafts.output_by_name[itemname] then
        return true
    end
end

workbench:register_crafttype("drops", {
	description = ccore.comment("Drops", "Digging by chance"),
    icon = "workbench_crafticon_drops.png"
})

-- cache all craft items
minetest.register_on_mods_loaded(function()
    local start_time = os.clock()
    print("[workbench] caching craftguide items...")
    -- get non empty mods
    craftguide_nonempty_modnames = winv.get_nonempty_modnames()
    -- generate drop crafts, and cache item descriptions and tooltips
    for itemname, def in pairs(minetest.registered_items) do
        -- handle drops
        local drops = def.drop
        if drops then
            if def.groups.not_in_creative_inventory ~= 1 then
                if type(drops) == "string" then
                    local drop_itemstack = ItemStack(drops)
                    local drop_itemname = drop_itemstack:get_name()
                    local drop_item = minetest.registered_items[drop_itemname]
                    if drop_itemname ~= itemname and drop_item.groups.not_in_creative_inventory ~= 1 then
                        workbench:register_craft({
                            type = "drops",
                            input = {
                                {itemname}
                            },
                            output = {
                                {drops}
                            }
                        })
                    end
                elseif drops.items then
                    for index, data in pairs(drops.items) do
                        local drop_itemstack = ItemStack(data.items[index])
                        local drop_itemname = drop_itemstack:get_name()
                        local drop_item = minetest.registered_items[drop_itemname]
                        if drop_itemname ~= itemname and drop_item.groups.not_in_creative_inventory ~= 1 then
                            workbench:register_craft({
                                type = "drops",
                                input = {
                                    {itemname}
                                },
                                output = {
                                    {data.items[1]}
                                }
                            })
                        end
                    end
                else
                    print("[workbench] warning: faulty drop for: "..itemname)
                end
            end
        end

        -- handle craft guide list
        if def.description and def.description ~= "" and def.groups.not_in_craft_guide ~= 1 and itemname:find(":") then --and def.groups.not_in_creative_inventory ~= 1 then
            if is_craftable(itemname) then
                craftguide_list[itemname] = def -- cache all craftable items definitions
                craftguide_desc_list[itemname] = ccore.comment(def.description, itemname) -- cache new description (postfix with itemname)
            else
                craftguide_desc_list[itemname] = ccore.comment(def.description, itemname..minetest.colorize("red", "\nUncraftable")) -- uncraftable description
            end
            craftguide_list_all[itemname] = def -- cache all valid items definitions
            craftguide_tooltip_list[itemname] = generate_item_tooltip(itemname)
        end
    end

    for itemname, def in pairs(craftguide_list_all) do
        -- cache all valid names
        craftguide_names_list[#craftguide_names_list+1] = itemname
    end

    -- handle usage
    for itemname, def in pairs(craftguide_list) do
        local mt_craftlist = minetest.get_all_craft_recipes(itemname)
        if mt_craftlist then
            for index, value in pairs(mt_craftlist) do
                for index2, used_itemstring in pairs(value.items) do
                    if used_itemstring ~= "" then
                        local used_itemname = ItemStack(used_itemstring):get_name()
                        if not craftguide_usage_list[used_itemname] then
                            craftguide_usage_list[used_itemname] = {}
                        end
                        if not craftguide_usage_list[used_itemname][value.method] then
                            craftguide_usage_list[used_itemname][value.method] = {}
                        end
                        craftguide_usage_list[used_itemname][value.method][itemname] = {}
                        local udata = craftguide_usage_list[used_itemname][value.method][itemname]
                        udata.data = value
                        udata.utype = "mt"
                    end
                end
            end
        end

        local workbench_craftlist = workbench_crafts.output_by_name[itemname]
        if workbench_craftlist then
            for index, value in pairs(workbench_craftlist) do
                local input_data = workbench_crafts.input[value.ctype][value.input_index]
                if input_data then
                    for index2, used_itemstack in pairs(input_data.items) do
                        if used_itemstack.name ~= "" then
                            local used_itemname = used_itemstack.name
                            if not craftguide_usage_list[used_itemname] then
                                craftguide_usage_list[used_itemname] = {}
                            end
                            if not craftguide_usage_list[used_itemname][value.ctype] then
                                craftguide_usage_list[used_itemname][value.ctype] = {}
                            end
                            craftguide_usage_list[used_itemname][value.ctype][itemname] = {}
                            local udata = craftguide_usage_list[used_itemname][value.ctype][itemname]
                            udata.data = input_data
                            udata.odata = value
                            udata.utype = "workbench"
                        end
                    end
                end
            end
        end
    end

    print("[workbench] craftguide items cached! took "..os.clock() - start_time.."s")
end)

-- craftguide formspec
local function craftguide_form(player)
    local playername = player:get_player_name()
    if not craftguide_data[playername] then -- ensure data initalized
        craftguide_init(player)
    end
    local cgdata = craftguide_data[playername]

    if not cgdata.form_list then -- reconstruct item list if empty
        construct_itemlist_form(player)
    end

    -- mod filter handling
    local modfilter_form = ""
    if cgdata.filter_mod_show then
        local modf_length = #craftguide_nonempty_modnames
        local modf_scroll = ""
        local modf_bg = 0
        if modf_length > 12 then
            modf_scroll =
                "scrollbaroptions[max="..((modf_length - 12) * 4.1)..";thumbsize=15]"..
                "scrollbar[3.625,4.4;0.3,4.2;vertical;workbench_craftguide_modfilter_scroll;"..(cgdata.filter_mod_scroll).."]"
            modf_bg = modf_length - 12
        end
        modfilter_form =
            "box[0,3.85;4,4.9;#49494AE6]"..
            "image_button[0,3.85;4,4.9;gui_invis.png;workbench_craftguide_modfilter_bg;;true;false;]"..
            "button[-0.6,6.55;0.5,0.5;workbench_craftguide_modfilter_reset;R]"..
            "image_button[-0.6,7.15;0.5,0.5;gui_cross.png;workbench_craftguide_modfilter_clear;]"..
            modf_scroll..
            "image_button[3.5,3.85;0.5,0.5;gui_cross_light.png;workbench_craftguide_modfilter_remove;;true;false;]"..
            "scroll_container[0,3.85;3.6,4.9;workbench_craftguide_modfilter_scroll;vertical;0.1]"..
                "style_type[checkbox;noclip=false]"..
                "image_button[0,0;3.6,"..(4.9 + modf_bg * 0.4)..";gui_invis.png;workbench_craftguide_modfilter_bg;;false;false;]"..
                modfilter_list(playername)..
            "scroll_container_end[]"
    end

    -- advanced filter handling
    local advfilter_form = ""
    if cgdata.filter_adv_show then
        local tt_shapes = ccore.comment("Hide all shapes", "Current status: Shown")
        local tc_shapes = "white"
        local tt_all = ccore.comment("Show all items (including uncraftables)", "Current status: Hidden")
        local tc_all = "grey"
        if cgdata.filter_adv_shapes then
            tt_shapes = ccore.comment("Hide all shapes", "Current status: Hidden")
            tc_shapes = "grey"
        end
        if cgdata.filter_adv_all then
            tt_all = ccore.comment("Show all items (including uncraftables)", "Current status: Shown")
            tc_all = "white"
        end
        advfilter_form =
        "button[-0.6,6.55;0.5,0.5;workbench_craftguide_advfilter_shapes;"..minetest.colorize(tc_shapes, "S").."]"..
        "tooltip[workbench_craftguide_advfilter_shapes;"..tt_shapes.."]"..
        "button[-0.6,7.15;0.5,0.5;workbench_craftguide_advfilter_all;"..minetest.colorize(tc_all, "A").."]"..
        "tooltip[workbench_craftguide_advfilter_all;"..tt_all.."]"
    end

    -- content handling
    local craftguide_content_all = "image_button[-0.9,0.25;0.8,0.8;winv_cicon_all.png;workbench_craftguide_content_all;;true;false;]"
    local craftguide_content_block = "image_button[-0.9,1.15;0.8,0.8;winv_cicon_block.png;workbench_craftguide_content_block;;true;false;]"
    local craftguide_content_tool = "image_button[-0.9,2.05;0.8,0.8;winv_cicon_tool.png;workbench_craftguide_content_tool;;true;false;]"
    local craftguide_content_craftitem = "image_button[-0.9,2.95;0.8,0.8;winv_cicon_craftitem.png;workbench_craftguide_content_craftitem;;true;false;]"
    local craftguide_content_fav = "image_button[-0.9,4.75;0.8,0.8;winv_cicon_star.png;workbench_craftguide_content_fav;;true;false;]"
    local darken = "^[colorize:#00000055"
    if cgdata.content_name then
        local content_name = cgdata.content_name
        if content_name == "all" then
            craftguide_content_all = "image_button[-0.9,0.25;0.8,0.8;winv_cicon_all.png"..darken..";workbench_craftguide_content_all;;true;false;]"
        elseif content_name == "block" then
            craftguide_content_block = "image_button[-0.9,1.15;0.8,0.8;winv_cicon_block.png"..darken..";workbench_craftguide_content_block;;true;false;]"
        elseif content_name == "tool" then
            craftguide_content_tool = "image_button[-0.9,2.05;0.8,0.8;winv_cicon_tool.png"..darken..";workbench_craftguide_content_tool;;true;false;]"
        elseif content_name == "craftitem" then
            craftguide_content_craftitem = "image_button[-0.9,2.95;0.8,0.8;winv_cicon_craftitem.png"..darken..";workbench_craftguide_content_craftitem;;true;false;]"
        elseif content_name == "favourite" then
            craftguide_content_fav = "image_button[-0.9,4.75;0.8,0.8;winv_cicon_star.png"..darken..";workbench_craftguide_content_fav;;true;false;]"
        end
    end

    local formspec =
        "formspec_version[4]"..
        "size[17.75, 9]"..
        "bgcolor[#00000099;true;#00000099]"..
        "style_type[*;noclip=true;font_size=13]"..
        "style[workbench_craftguide_exit;border=false]"..
        "image_button[0.1,-0.6;0.5,0.5;winv_icon_player.png;workbench_craftguide_exit;]"..
        "tooltip[workbench_craftguide_exit;Return to main inventory]"..
        "container[0,0]"..
            --left_form (1.25 per grid)
            "image[0,0;7.75,9;winv_bg.png]"..
            -- search icons
			"field[0.25,7.75;5.25,1;workbench_craftguide_filter;;"..cgdata.filter_search.."]"..
			"field_close_on_enter[workbench_craftguide_filter;false]"..
			"image_button[5.75,7.75;0.5,0.5;gui_pointer.png;workbench_craftguide_search;]"..
			"image_button[5.75,8.25;0.5,0.5;gui_cross.png;workbench_craftguide_clear;]"..
            -- content icons
            craftguide_content_all..
			"tooltip[workbench_craftguide_content_all;Show all]"..
			craftguide_content_block..
			"tooltip[workbench_craftguide_content_block;Show blocks only]"..
			craftguide_content_tool..
			"tooltip[workbench_craftguide_content_tool;Show tools only]"..
			craftguide_content_craftitem..
			"tooltip[workbench_craftguide_content_craftitem;Show craft items only]"..
            craftguide_content_fav..
            "tooltip[workbench_craftguide_content_fav;Show favourites only]"..
            -- item list
            "style_type[item_image_button;border=false]"..
            cgdata.form_list[cgdata.curr_page]..
            -- arrows
			"image_button[6.5,7.83;0.5,0.8;winv_cicon_miniarrow.png^[transformFX;workbench_craftguide_prev;;;false;]"..
			"image_button[7,7.85;0.5,0.8;winv_cicon_miniarrow.png;workbench_craftguide_next;;;false;]"..
            "label[0.25,9.25;Page " .. minetest.colorize("#FFFF00", tostring(cgdata.curr_page)) .. " / " .. tostring(cgdata.max_page) .. "]"..
            -- mod filter
			"image_button[-0.9,3.85;0.8,0.8;winv_cicon_filter.png;workbench_craftguide_modfilter;;true;false;]"..
			"tooltip[workbench_craftguide_modfilter;Filter by mods]"..
            modfilter_form.. -- mod filter popup
            -- advanced filter
            "image_button[-0.9,5.65;0.8,0.8;winv_cicon_settings.png;workbench_craftguide_advfilter;;true;false;]"..
			"tooltip[workbench_craftguide_advfilter;Advanced filters]"..
            advfilter_form.. -- adv filter popup
        "container_end[]"..
        "container[10,0]"..
            --right_form (show recipe)
            craftguide_recipe_form(player)..
        "container_end[]"
    return formspec
end

winv:register_inventory("craftguide", {
    button = {
        texture = "winv_icon_craftguide.png",
        tooltip = "Craft Guide",
    },
    hide_in_node = true,
    button_function = function(player)
        local playername = player:get_player_name()
        if not craftguide_data[playername] then
            craftguide_init(player)
        end
        craftguide_data[playername].active = true
        player:set_inventory_formspec(craftguide_form(player))
    end,
})

local function reset_craftguide(playername)
    craftguide_data[playername].curr_page = 1
    craftguide_data[playername].max_page = 1
    craftguide_data[playername].form_list = nil
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
    local playername = player:get_player_name()
    if not craftguide_data[playername] then -- ensure init data
        craftguide_init(player)
    end

    local cgdata = craftguide_data[playername]
    if not (cgdata.active) then -- ensure form is active
        return
    end

    -- content filter
    if fields.workbench_craftguide_content_all then
        cgdata.content = minetest.registered_items
        cgdata.content_name = "all"
        reset_craftguide(playername)
    elseif fields.workbench_craftguide_content_block then
        cgdata.content = minetest.registered_nodes
        cgdata.content_name = "block"
        reset_craftguide(playername)
    elseif fields.workbench_craftguide_content_tool then
        cgdata.content = minetest.registered_tools
        cgdata.content_name = "tool"
        reset_craftguide(playername)
    elseif fields.workbench_craftguide_content_craftitem then
        cgdata.content = minetest.registered_craftitems
        cgdata.content_name = "craftitem"
        reset_craftguide(playername)
    end

    -- mod filter
    if fields.workbench_craftguide_modfilter then -- toggle
        if cgdata.filter_mod_show then
            cgdata.filter_mod_show = nil
        else
            cgdata.filter_mod_show = true
            cgdata.filter_adv_show = nil
        end
    elseif fields.workbench_craftguide_modfilter_remove then
        cgdata.filter_mod_show = nil
    end

    if cgdata.filter_mod_show then
        local modnames = craftguide_nonempty_modnames
        for i, modname in ipairs(modnames) do
            local mfield = fields["workbench_craftguide_modfilter_mod_"..modname]
            if mfield then
                if mfield == "false" then
                    cgdata.filter_mod[#cgdata.filter_mod+1] = modname
                elseif mfield == "true" then
                    for j, modfname in pairs(cgdata.filter_mod) do
                        if modfname == modname then
                            cgdata.filter_mod[j] = nil
                        end
                    end
                end
                reset_craftguide(playername)
            end
        end
        if fields.workbench_craftguide_modfilter_reset then
            cgdata.filter_mod = {}
            reset_craftguide(playername)
        elseif fields.workbench_craftguide_modfilter_clear then
            cgdata.filter_mod = {}
            for i, modname in ipairs(modnames) do
                cgdata.filter_mod[#cgdata.filter_mod+1] = modname
            end
            reset_craftguide(playername)
        end
    end

    -- adv filter
    if fields.workbench_craftguide_advfilter then
        if cgdata.filter_adv_show then
            cgdata.filter_adv_show = nil
        else
            cgdata.filter_adv_show = true
            cgdata.filter_mod_show = nil
        end
    end

    if cgdata.filter_adv_show then
        if fields.workbench_craftguide_advfilter_all then
            reset_craftguide(playername)
            if cgdata.filter_adv_all then
                cgdata.filter_adv_all = nil
            else
                cgdata.filter_adv_all = true
            end
        elseif fields.workbench_craftguide_advfilter_shapes then
            reset_craftguide(playername)
            if cgdata.filter_adv_shapes then
                cgdata.filter_adv_shapes = nil
            else
                cgdata.filter_adv_shapes = true
            end
        end
    end

    -- search filter
    if fields.workbench_craftguide_clear then
        cgdata.filter_search_old = cgdata.filter
        cgdata.filter_search = ""
        reset_craftguide(playername)
    end

    if fields.workbench_craftguide_search or fields.key_enter_field == "workbench_craftguide_filter" then
        local new_filter = fields.workbench_craftguide_filter:lower()
        if new_filter ~= cgdata.filter_search then -- prevent unnecessary reconstruction
            cgdata.filter_search_old = cgdata.filter
            cgdata.filter_search = new_filter
            reset_craftguide(playername)
        end
    end

    -- favourites handling
    if fields.workbench_craftguide_fav then
        local itemname = cgdata.item
        if itemname and itemname ~= "" then
            if not cgdata.fav_list[itemname] then
                cgdata.fav_list[itemname] = true
            else
                cgdata.fav_list[itemname] = nil
            end

            if cgdata.content_name == "favourite" then
                reset_craftguide(playername)
            end
        end
    end

    if fields.workbench_craftguide_content_fav then
        cgdata.content = cgdata.fav_list
        cgdata.content_name = "favourite"
        reset_craftguide(playername)
    end

    -- change pages
    if fields.workbench_craftguide_prev then -- previous page
        if cgdata.curr_page <= 1 then
            cgdata.curr_page = cgdata.max_page
        else
            cgdata.curr_page = cgdata.curr_page - 1
        end
    elseif fields.workbench_craftguide_next then -- next page
        if cgdata.curr_page >= cgdata.max_page then
            cgdata.curr_page = 1
        else
            cgdata.curr_page = cgdata.curr_page + 1
        end
    end

    if cgdata.item and cgdata.item ~= "" then
        -- change recipes
        if cgdata.max_recipe > 1 then
            if fields.workbench_craftguide_recipe_next then -- previous recipe
                if cgdata.curr_recipe <= 1 then
                    cgdata.curr_recipe = cgdata.max_recipe
                else
                    cgdata.curr_recipe = cgdata.curr_recipe - 1
                end
            elseif fields.workbench_craftguide_recipe_prev then -- next recipe
                if cgdata.curr_recipe >= cgdata.max_recipe then
                    cgdata.curr_recipe = 1
                else
                    cgdata.curr_recipe = cgdata.curr_recipe + 1
                end
            end
        end

        -- change usages
        if cgdata.max_usage > 1 then
            if fields.workbench_craftguide_usage_next then
                if cgdata.curr_usage >= cgdata.max_usage then
                    cgdata.curr_usage = 1
                else
                    cgdata.curr_usage = cgdata.curr_usage + 1
                end
            elseif fields.workbench_craftguide_usage_prev then
                if cgdata.curr_usage <= 1 then
                    cgdata.curr_usage = cgdata.max_usage
                else
                    cgdata.curr_usage = cgdata.curr_usage - 1
                end
            end
        end
    end

    -- undo / redo recipe view
    if cgdata.history then
        if fields.workbench_craftguide_undo then
            if cgdata.item_view > 1 then
                cgdata.item_view = cgdata.item_view - 1

                cgdata.item = cgdata.history[cgdata.item_view]
                cgdata.curr_recipe = 0 -- reset page
            end
        elseif fields.workbench_craftguide_redo then
            if cgdata.item_view < #cgdata.history then
                cgdata.item_view = cgdata.item_view + 1

                cgdata.item = cgdata.history[cgdata.item_view]
                cgdata.curr_recipe = 0 -- reset page
            end
        end
    end

    -- item redirect
    for index, itemname in ipairs(craftguide_names_list) do
        if (fields["workbench_craftguide_item_"..itemname]) then
            if craftguide_list[itemname] then -- only show if craftable
                -- add to history
                if not cgdata.history then
                    cgdata.history = {}
                    cgdata.item_view = 0
                end
                if cgdata.item ~= itemname then -- only add if different item
                    cgdata.history[#cgdata.history+1] = itemname
                    cgdata.item_view = #cgdata.history
                end
                -- set item
                cgdata.item = itemname
                cgdata.curr_recipe = 0 -- reset page
                cgdata.curr_usage = 1 -- reset page
                cgdata.show_usage = nil
            end
        end
    end

    -- group redirect
    -- manually defined groups
    for groupname, def in pairs(craftguide_groups) do
        local groupstring = groupname:gsub(",", "") -- remove all commas to prevent invalid fieldname
        if (fields["workbench_craftguide_item_"..groupstring]) then
            --cgdata.item = def.redirect
            --cgdata.curr_recipe = 1 -- reset page
            cgdata.filter_search = groupname
            cgdata.content = minetest.registered_items
            cgdata.content_name = "all"
            reset_craftguide(playername)
        end
    end

    -- automatically generated groups
    for groupname, groupstring in pairs(craftguide_groups_auto) do
        if (fields["workbench_craftguide_item_"..groupstring]) then
            cgdata.filter_search = groupname
            cgdata.content = minetest.registered_items
            cgdata.content_name = "all"
            reset_craftguide(playername)
        end
    end

    -- usage
    if fields.workbench_craftguide_usage then
        if cgdata.show_usage then
            cgdata.show_usage = nil
        else
            cgdata.show_usage = true
        end
    end

    -- quitting
    if fields.workbench_craftguide_exit or fields.quit then
        cgdata.active = false
        winv.refresh(player) -- switch back to normal inventory
    end

    -- scroll and refresh
    if fields.workbench_craftguide_modfilter_scroll then
        local scrolldis = minetest.explode_scrollbar_event(fields.workbench_craftguide_modfilter_scroll)
        if cgdata.filter_mod_scroll ~= scrolldis.value then
            cgdata.filter_mod_scroll = scrolldis.value
        else -- if scroll doesn't match and event detected, means its from a different field
            player:set_inventory_formspec(craftguide_form(player))
            return -- prevents double update
        end
    end

    -- refresh and updates formspec (if not quitting and no scroll event)
    if not fields.quit and not fields.workbench_craftguide_exit and not fields.workbench_craftguide_modfilter_scroll then
        player:set_inventory_formspec(craftguide_form(player))
    end
end)

-- handling data saving
local function save_craftguide_data(player)
    if player then
        local playername = player:get_player_name()
        if craftguide_data and craftguide_data[playername] then
            local player_meta = player:get_meta()
            local cgdata = craftguide_data[playername]
            local save_data = {}
            save_data.fav_list = cgdata.fav_list
            save_data.filter_mod = cgdata.filter_mod
            save_data.filter_adv_all = cgdata.filter_adv_all
            save_data.filter_adv_shapes = cgdata.filter_adv_shapes
            player_meta:set_string("workbench:craftguide", minetest.serialize(save_data))
            craftguide_data[playername] = nil -- remove data
            print("[workbench] data saved for "..playername)
        end
    end
end

minetest.register_on_leaveplayer(function(player)
    save_craftguide_data(player)
end)

minetest.register_on_shutdown(function()
    for _, player in pairs(minetest.get_connected_players()) do
		save_craftguide_data(player)
    end
end)