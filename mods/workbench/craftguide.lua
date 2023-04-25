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
local craftguide_data = {} -- various player specific form data
local craftguide_groups = {}
local craftguide_groups_auto = {}

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
    craftguide_data[playername] = {
        active = false,
        item = "",
        item_recipe_curr = 1,
        item_recipe_max = 1,
        form_list = nil,

        curr_page = 1,
        max_page = 1,

        filter = "",
        old_filter = nil,

        content = minetest.registered_items,
        content_name = "all",
        old_content = nil,

        mod_filter = {},
		show_mod_filter = nil,
		old_mod_filter = {},
		mod_filter_scroll = 0,
    }
end

local function is_group(itemname)
    if itemname:find("group:", 1, true) then
        local groupstring = string.match(itemname, ':(.*)')
        if groupstring and groupstring ~= "" then
            return true
        end
    end
end

local function group_match(groupname, itemname)
    local group_list = {}
    local groupstring = string.match(groupname, ':(.*)')
    for group in string.gmatch(groupstring, '([^,]+)') do
        table.insert(group_list, group)
    end

    -- check item fulfill all groups
    for i = 1, #group_list do
        if minetest.get_item_group(itemname, group_list[i]) == 0 then
            return nil
        end
    end
    return true
end

local function find_first_in_group(groupname)
    for itemname, def in pairs(minetest.registered_items) do
        if def.groups.not_in_creative_inventory ~= 1 and def.groups.not_in_craftguide ~= 1 then
            if group_match(groupname, itemname) then
                return itemname
            end
        end
    end
    return groupname
end

local function generate_item_tooltip(itemname)
    local desc = itemname
    -- TODO handle group description
    local desc_from_table = craftguide_desc_list[itemname]
    if desc_from_table then
        desc = desc_from_table
    end
    return "tooltip[workbench_craftguide_item_"..itemname..";"..desc.."]"
end

local function craftguide_display_form(player)
    local playername = player:get_player_name()
    if not craftguide_data[playername] or craftguide_data[playername].item == "" then
        return ""
    end

    local ret_form = ""
    if craftguide_data[playername].item and craftguide_data[playername].item ~= "" then
        local itemname = craftguide_data[playername].item
        local itemdesc = minetest.registered_items[itemname].short_description or minetest.registered_items[itemname].description
        itemdesc = itemdesc:gsub("\n.*", "") -- First line only
        ret_form =
            "item_image_button[0.25,-0.9;0.8,0.8;"..itemname..";workbench_craftguide_display_"..itemname..";]"..
            generate_item_tooltip(itemname)..
            "style_type[label;font_size=20;font=bold]"..
            "label[1.2,-0.7;"..itemdesc.."]"..
            "style_type[label;font_size=13;font=normal]"..
            "label[1.2,-0.3;"..itemname.."]"
    end
    return ret_form
end

-- recipe form (right side)
local function craftguide_recipe_form(player)
    local playername = player:get_player_name()
    if not craftguide_data[playername] or craftguide_data[playername].item == "" then
        return ""
    end

    local ret_form =
        "image[0,0;7.75,9;winv_bg.png]"..
        "style[workbench_current_item;border=false]"..
        craftguide_display_form(player)..
        "box[0.25,0.25;7.275,7.275;#00000070]"..
        -- arrows
        "image_button[6.5,7.83;0.5,0.8;winv_cicon_miniarrow.png^[transformFX;workbench_craftguide_recipe_prev;;;false;]"..
        "image_button[7,7.85;0.5,0.8;winv_cicon_miniarrow.png;workbench_craftguide_recipe_next;;;false;]"

    local item = craftguide_data[playername].item
    local output_data = workbench_crafts.output_by_name[item]
    local recipe_count = 0
    if output_data then -- workbench crafting
        for index, value in pairs(output_data) do
            local input_data = workbench_crafts.input[value.ctype][value.input_index]
            if input_data then
                recipe_count = recipe_count + 1

                if recipe_count == craftguide_data[playername].item_recipe_curr then
                    -- apply dynamic input scale
                    local item_scale = 1
                    local item_width = 1.25
                    local max_width = math.max(input_data.width, input_data.height)
                    if max_width > 5 then
                        item_width = (6.25 / max_width)
                        item_scale = item_width - 0.25
                    end

                    -- create input item form
                    for i = 1, input_data.height do
                        for j = 1, input_data.width do
                            local recipe_item = input_data.input[i][j]
                            local recipe_itemname = ItemStack(recipe_item):get_name()
                            local recipe_itemcount = ItemStack(recipe_item):get_count()
                            if is_group(recipe_itemname) then -- group label
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
                                    recipe_itemname = find_first_in_group(groupname)
                                    recipe_item = recipe_itemname.." "..recipe_itemcount
                                    craftguide_groups_auto[groupname] = groupstring
                                    ret_form = ret_form..
                                        "item_image_button["..( 0.875 + ((j - 1) * item_width) )..","..( 0.875 + ((i - 1) * item_width) )..
                                            ";"..item_scale..","..item_scale..";"..recipe_item..";workbench_craftguide_item_"..groupstring..";(G)]"..
                                        "tooltip[workbench_craftguide_item_"..groupstring..";"..minetest.formspec_escape(groupname).."]"
                                end
                            else
                                ret_form = ret_form..
                                    "item_image_button["..( 0.875 + ((j - 1) * item_width) )..","..( 0.875 + ((i - 1) * item_width) )..
                                        ";"..item_scale..","..item_scale..";"..recipe_item..";workbench_craftguide_item_"..recipe_itemname..";]"..
                                    generate_item_tooltip(recipe_itemname)
                            end
                        end
                    end

                    -- output item(s) form
                    local output_items = (workbench_crafts.output[value.ctype][input_data.id][value.output_index].items)
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
                            generate_item_tooltip(output_itemname)
                    end

                    -- output arrow (crafting type)
                    local crafting_arrow = "gui_arrow.png^[transformFYR90"
                    if workbench_crafts.data[value.ctype].icon then
                        crafting_arrow = workbench_crafts.data[value.ctype].icon
                    end

                    local crafting_desc = value.ctype
                    if workbench_crafts.data[value.ctype].description then
                        crafting_desc = workbench_crafts.data[value.ctype].description
                    end

                    ret_form = ret_form..
                        "style[workbench_craftguide_ctype;border=false]"..
                        "image_button[0.25,7.75;1,1;"..crafting_arrow..";workbench_craftguide_ctype;]"..
                        "tooltip[workbench_craftguide_ctype;"..crafting_desc.."]"
                end
            end
        end
    end

    local mt_output_data = minetest.get_all_craft_recipes(item)
    if mt_output_data then -- mt crafting api
        for index, value in pairs(mt_output_data) do
            recipe_count = recipe_count + 1
            if recipe_count == craftguide_data[playername].item_recipe_curr then
                -- determine size (width & height) of recipe
                local width = value.width
                local recipe_amt = #value.items
                if width == 0 then -- shapeless recipe
                    width = 3
                end
                local height = math.ceil(recipe_amt / width)
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
                        local recipe_item = value.items[recipe_index]
                        if recipe_item then
                            local recipe_itemname = ItemStack(recipe_item):get_name()
                            if recipe_itemname then
                                local recipe_itemcount = ItemStack(recipe_item):get_count()
                                if is_group(recipe_itemname) then -- group label
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
                                        recipe_itemname = find_first_in_group(groupname)
                                        recipe_item = recipe_itemname.." "..recipe_itemcount
                                        craftguide_groups_auto[groupname] = groupstring
                                        ret_form = ret_form..
                                            "item_image_button["..( 0.875 + ((j - 1) * item_width) )..","..( 0.875 + ((i - 1) * item_width) )..
                                                ";"..item_scale..","..item_scale..";"..recipe_item..";workbench_craftguide_item_"..groupstring..";(G)]"..
                                            "tooltip[workbench_craftguide_item_"..groupstring..";"..minetest.formspec_escape(groupname).."]"
                                    end
                                else
                                    ret_form = ret_form..
                                        "item_image_button["..( 0.875 + ((j - 1) * item_width) )..","..( 0.875 + ((i - 1) * item_width) )..
                                            ";"..item_scale..","..item_scale..";"..recipe_item..";workbench_craftguide_item_"..recipe_itemname..";]"..
                                        generate_item_tooltip(recipe_itemname)
                                end
                            end
                        end
                    end
                end

                -- output item
                local output_item = value.output
                local output_itemname = ItemStack(output_item):get_name()

                local crafting_arrow = "gui_arrow.png^[transformFYR90"
                if value.method == "normal" then
                    crafting_arrow = workbench_crafts.data["normal"].icon
                elseif value.method == "cooking" then
                    crafting_arrow = workbench_crafts.data["cooking"].icon
                end

                local crafting_desc = value.method
                if value.method == "normal" then
                    crafting_desc = workbench_crafts.data["normal"].description
                elseif value.method == "cooking" then
                    crafting_desc = workbench_crafts.data["cooking"].description
                end

                ret_form = ret_form..
                    "item_image_button[1.4375,7.75;1,1;"..output_item..";workbench_craftguide_item_"..output_itemname..";]"..
                    generate_item_tooltip(output_itemname)..
                    -- craft type
                    "style[workbench_craftguide_ctype;border=false]"..
                    "image_button[0.25,7.75;1,1;"..crafting_arrow..";workbench_craftguide_ctype;]"..
                    "tooltip[workbench_craftguide_ctype;"..crafting_desc.."]"
            end
        end
    end
    craftguide_data[playername].item_recipe_max = recipe_count
    ret_form = ret_form..
        "label[0.25,9.25;Recipe " .. minetest.colorize("#FFFF00", tostring(craftguide_data[playername].item_recipe_curr)) .. " / " .. tostring(recipe_count) .. "]"
    if recipe_count == 0 then
        ret_form = ret_form..
            "style[workbench_craftguide_no_recipe;border=false]"..
            "image_button[0.25,7.75;1,1;gui_cross_big.png;workbench_craftguide_no_recipe;]"..
            "tooltip[workbench_craftguide_no_recipe;No recipe found!]"
    end
    return ret_form
end

local function get_modfilter_status(modname, playername)
	local inv = craftguide_data[playername]
	if not inv.mod_filter or not next(inv.mod_filter) then
		return true
	end
	for i, modfname in pairs(inv.mod_filter) do
		if modfname == modname then
			return false
		end
	end
	return true
end

local function modfilter_list(playername)
	local modlist = ""
	local modnames = minetest.get_modnames()
	for i, modname in ipairs(modnames) do
		modlist = modlist.."checkbox[0.1,"..((i - 1) * 0.4 + 0.25)..";workbench_craftguide_modfilter_mod_"..modname..";"..modname..";"..tostring(get_modfilter_status(modname, playername)).."]"
	end
	return modlist
end

local function mod_match(s, mod_filter)
	if not mod_filter or not next(mod_filter) then
		return true
	end
	for i, modname in pairs(mod_filter) do
		if s:lower():find(modname..":", 1, true) then
			return nil
		end
	end
	return true
end

local NO_MATCH = 999
local function match(s, filter)
	if filter == "" then
		return 0
	end
	if s:lower():find(filter, 1, true) then
		return #s - #filter
	end
	return NO_MATCH
end

local function description(def, lang_code)
	local s = def.description
	if lang_code then
		s = minetest.get_translated_string(lang_code, s)
	end
	return s:gsub("\n.*", "") -- First line only
end

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
    local filter = craftguide_data[playername].filter
    local filtered_list = {}
	local order = {}

    local search_list = craftguide_list
    if is_group(filter) then
        search_list = craftguide_list_all
    end
    for itemname, def in pairs(search_list) do
        if craftguide_data[playername].content[itemname] then -- content filter
            local mf = mod_match(itemname, craftguide_data[playername].mod_filter)
            if mf then
                if is_group(filter) then
                    if group_match(filter, itemname) then
                        filtered_list[#filtered_list+1] = itemname
                        order[itemname] = string.format("%02d", 1) .. itemname
                    end
                else
                    local m = match(description(def), filter)
                    if m > 0 then
                        m = math.min(m, match(description(def, lang), filter))
                    end
                    if m > 0 then
                        m = math.min(m, match(itemname, filter))
                    end

                    if m < NO_MATCH then
                        filtered_list[#filtered_list+1] = itemname
                        -- Sort by match value first so closer matches appear earlier
                        order[itemname] = string.format("%02d", m) .. itemname
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
                generate_item_tooltip(itemname)
    end

    if not craftguide_data[playername].form_list[1] then -- ensure first page is always constructed
        craftguide_data[playername].form_list[1] = "label[0.25,0.4;Nothing found...]"
    end
    craftguide_data[playername].max_page = math.ceil(count / max_item_per_page)
end

local function is_craftable(itemname)
    if minetest.get_craft_recipe(itemname) and minetest.get_craft_recipe(itemname).items or workbench_crafts.output_by_name[itemname] then
        return true
    end
end

-- cache all craft items
local start_time
minetest.register_on_mods_loaded(function()
    start_time = os.clock()
    print("[workbench] caching craftguide items...")
    for itemname, def in pairs(minetest.registered_items) do
        if def.description and def.description ~= "" and def.groups.not_in_craftguide ~= 1 then --and def.groups.not_in_creative_inventory ~= 1 then
            if is_craftable(itemname) then
                craftguide_list[itemname] = def
            end
            craftguide_list_all[itemname] = def
            craftguide_desc_list[itemname] = ccore.comment(def.description, itemname)
        end
    end

    for key, def in pairs(craftguide_list_all) do
        craftguide_names_list[#craftguide_names_list+1] = key
    end
    print("[workbench] craftguide items cached! took "..os.clock() - start_time.."s")
end)

-- craftguide formspec
local function craftguide_form(player)
    local playername = player:get_player_name()
    if not craftguide_data[playername] then -- ensure data initalized
        craftguide_init(player)
    end

    if not craftguide_data[playername].form_list then -- reconstruct item list
        construct_itemlist_form(player)
    end

    local modfilter_form  = ""
    if craftguide_data[playername].show_mod_filter then
        local modf_length = #minetest.get_modnames()
        local modf_scroll = ""
        local modf_bg = 0
        if modf_length > 12 then
            modf_scroll =
                "scrollbaroptions[max="..((modf_length - 12) * 4.1)..";thumbsize=15]"..
                "scrollbar[3.625,4.4;0.3,4.2;vertical;workbench_craftguide_modfilter_scroll;"..(craftguide_data[playername].mod_filter_scroll).."]"
            modf_bg = modf_length - 12
        end
        modfilter_form =
            "box[0,3.85;4,4.9;#49494AE6]"..
            "image_button[0,3.85;4,4.9;gui_invis.png;workbench_craftguide_modfilter_bg;;true;false;]"..
            "button[-0.6,4.75;0.5,0.5;workbench_craftguide_modfilter_reset;R]"..
            "image_button[-0.6,5.35;0.5,0.5;gui_cross.png;workbench_craftguide_modfilter_clear;]"..
            modf_scroll..
            "image_button[3.5,3.85;0.5,0.5;gui_cross_light.png;workbench_craftguide_modfilter_remove;;true;false;]"..
            "scroll_container[0,3.85;3.6,4.9;workbench_craftguide_modfilter_scroll;vertical;0.1]"..
                "style_type[checkbox;noclip=false]"..
                "image_button[0,0;3.6,"..(4.9 + modf_bg * 0.4)..";gui_invis.png;workbench_craftguide_modfilter_bg;;false;false;]"..
                modfilter_list(playername)..
            "scroll_container_end[]"
    end

    local craftguide_filter_all = "image_button[-0.9,0.25;0.8,0.8;winv_cicon_all.png;workbench_craftguide_filter_all;;true;false;]"
    local craftguide_filter_block = "image_button[-0.9,1.15;0.8,0.8;winv_cicon_block.png;workbench_craftguide_filter_block;;true;false;]"
    local craftguide_filter_tool = "image_button[-0.9,2.05;0.8,0.8;winv_cicon_tool.png;workbench_craftguide_filter_tool;;true;false;]"
    local craftguide_filter_craftitem = "image_button[-0.9,2.95;0.8,0.8;winv_cicon_craftitem.png;workbench_craftguide_filter_craftitem;;true;false;]"
    local darken = "^[colorize:#00000055"
    if craftguide_data[playername].content_name then
        local icname = craftguide_data[playername].content_name
        if icname == "all" then
            craftguide_filter_all = "image_button[-0.9,0.25;0.8,0.8;winv_cicon_all.png"..darken..";workbench_craftguide_filter_all;;true;false;]"
        elseif icname == "block" then
            craftguide_filter_block = "image_button[-0.9,1.15;0.8,0.8;winv_cicon_block.png"..darken..";workbench_craftguide_filter_block;;true;false;]"
        elseif icname == "tool" then
            craftguide_filter_tool = "image_button[-0.9,2.05;0.8,0.8;winv_cicon_tool.png"..darken..";workbench_craftguide_filter_tool;;true;false;]"
        elseif icname == "craftitem" then
            craftguide_filter_craftitem = "image_button[-0.9,2.95;0.8,0.8;winv_cicon_craftitem.png"..darken..";workbench_craftguide_filter_craftitem;;true;false;]"
        end
    end

    local form =
        "formspec_version[4]"..
        "size[17.75, 9]"..
        "style_type[*;noclip=true;font_size=13]"..
        "bgcolor[#00000000;neither]"..
        "style[workbench_craftguide_exit;border=false]"..
        "image_button[0.1,-0.6;0.5,0.5;winv_icon_return.png;workbench_craftguide_exit;]"..
        "tooltip[workbench_craftguide_exit;Return to main inventory]"..
        "container[0,0]"..
            --left_form..
            --1.25 per grid
            "image[0,0;7.75,9;winv_bg.png]"..
            -- LIST
            -- search icons
			"field[0.25,7.75;5.25,1;workbench_craftguide_filter;;"..craftguide_data[playername].filter.."]"..
			"field_close_on_enter[workbench_craftguide_filter;false]"..
			"image_button[5.75,7.75;0.5,0.5;gui_pointer.png;workbench_craftguide_search;]"..
			"image_button[5.75,8.25;0.5,0.5;gui_cross.png;workbench_craftguide_clear;]"..

            -- filter icons
            craftguide_filter_all..
			"tooltip[workbench_craftguide_filter_all;Show all]"..
			craftguide_filter_block..
			"tooltip[workbench_craftguide_filter_block;Show blocks only]"..
			craftguide_filter_tool..
			"tooltip[workbench_craftguide_filter_tool;Show tools only]"..
			craftguide_filter_craftitem..
			"tooltip[workbench_craftguide_filter_craftitem;Show craft items only]"..

            -- item list
            "style_type[item_image_button;border=false]"..
            craftguide_data[playername].form_list[craftguide_data[playername].curr_page]..

            -- arrows
			"image_button[6.5,7.83;0.5,0.8;winv_cicon_miniarrow.png^[transformFX;workbench_craftguide_prev;;;false;]"..
			"image_button[7,7.85;0.5,0.8;winv_cicon_miniarrow.png;workbench_craftguide_next;;;false;]"..
            "label[0.25,9.25;Page " .. minetest.colorize("#FFFF00", tostring(craftguide_data[playername].curr_page)) .. " / " .. tostring(craftguide_data[playername].max_page) .. "]"..

            -- modfilter icons
			"image_button[-0.9,3.85;0.8,0.8;winv_cicon_filter.png;workbench_craftguide_modfilter;;true;false;]"..
			"tooltip[workbench_craftguide_modfilter;Filter by mods]"..
            modfilter_form..
        "container_end[]"..
        "container[10,0]"..
            --right_form..
            craftguide_recipe_form(player)..
        "container_end[]"

    return form
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

minetest.register_on_player_receive_fields(function(player, formname, fields)
    local playername = player:get_player_name()
    if not craftguide_data[playername] then
        craftguide_init(player)
    end

    local cgdata = craftguide_data[playername]
    if not (cgdata.active) then
        return
    end

    -- content filter
    if fields.workbench_craftguide_filter_all then
        cgdata.content = minetest.registered_items
        cgdata.content_name = "all"
        cgdata.curr_page = 1
        cgdata.max_page = 1
        cgdata.form_list = nil
    elseif fields.workbench_craftguide_filter_block then
        cgdata.content = minetest.registered_nodes
        cgdata.content_name = "block"
        cgdata.curr_page = 1
        cgdata.max_page = 1
        cgdata.form_list = nil
    elseif fields.workbench_craftguide_filter_tool then
        cgdata.content = minetest.registered_tools
        cgdata.content_name = "tool"
        cgdata.curr_page = 1
        cgdata.max_page = 1
        cgdata.form_list = nil
    elseif fields.workbench_craftguide_filter_craftitem then
        cgdata.content = minetest.registered_craftitems
        cgdata.content_name = "craftitem"
        cgdata.curr_page = 1
        cgdata.max_page = 1
        cgdata.form_list = nil
    end

    -- mod filter
    if fields.workbench_craftguide_modfilter then
        if cgdata.show_mod_filter then
            cgdata.show_mod_filter = nil
        else
            cgdata.show_mod_filter = true
        end
    elseif fields.workbench_craftguide_modfilter_remove then
        cgdata.show_mod_filter = nil
    end

    if cgdata.show_mod_filter then
        local modnames = minetest.get_modnames()
        for i, modname in ipairs(modnames) do
            local mfield = fields["workbench_craftguide_modfilter_mod_"..modname]
            if mfield then
                if mfield == "false" then
                    cgdata.mod_filter[#cgdata.mod_filter+1] = modname
                elseif mfield == "true" then
                    for j, modfname in pairs(cgdata.mod_filter) do
                        if modfname == modname then
                            cgdata.mod_filter[j] = nil
                        end
                    end
                end
                cgdata.curr_page = 1
                cgdata.form_list = nil
            end
        end
        if fields.workbench_craftguide_modfilter_reset then
            cgdata.mod_filter = {}
            cgdata.curr_page = 1
            cgdata.form_list = nil
        elseif fields.workbench_craftguide_modfilter_clear then
            cgdata.mod_filter = {}
            for i, modname in ipairs(modnames) do
                cgdata.mod_filter[#cgdata.mod_filter+1] = modname
            end
            cgdata.curr_page = 1
            cgdata.form_list = nil
        end

        if fields.workbench_craftguide_modfilter_scroll then
			local scrolldis = minetest.explode_scrollbar_event(fields.workbench_craftguide_modfilter_scroll)
			cgdata.mod_filter_scroll = scrolldis.value
		end
    end

    -- search filter
    if fields.workbench_craftguide_search or fields.key_enter_field == "workbench_craftguide_filter" or fields.workbench_craftguide_clear then
        cgdata.old_filter = cgdata.filter
        if fields.workbench_craftguide_clear then
            cgdata.curr_page = 1
            cgdata.filter = ""
        else
            cgdata.filter = fields.workbench_craftguide_filter:lower()
        end

        if cgdata.filter ~= cgdata.old_filter then -- prevent unnecessary reconstruction
            -- reset filter and list
            cgdata.curr_page = 1
            cgdata.max_page = 1
            cgdata.form_list = nil
        end
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

    -- change recipes
    if cgdata.item and cgdata.item ~= "" then
        if cgdata.item_recipe_max > 1 then
            if fields.workbench_craftguide_recipe_prev then -- previous recipe
                if cgdata.item_recipe_curr <= 1 then
                    cgdata.item_recipe_curr = cgdata.item_recipe_max
                else
                    cgdata.item_recipe_curr = cgdata.item_recipe_curr - 1
                end
            elseif fields.workbench_craftguide_recipe_next then -- next recipe
                if cgdata.item_recipe_curr >= cgdata.item_recipe_max then
                    cgdata.item_recipe_curr = 1
                else
                    cgdata.item_recipe_curr = cgdata.item_recipe_curr + 1
                end
            end
        end
    end

    for index, itemname in ipairs(craftguide_names_list) do
        if (fields["workbench_craftguide_item_"..itemname]) then
            cgdata.item = itemname
            cgdata.item_recipe_curr = 1 -- reset page
        end
    end

    for groupname, def in pairs(craftguide_groups) do
        local groupstring = groupname:gsub(",", "") -- remove all commas to prevent invalid fieldname
        if (fields["workbench_craftguide_item_"..groupstring]) then
            --cgdata.item = def.redirect
            --cgdata.item_recipe_curr = 1 -- reset page
            cgdata.filter = groupname
            cgdata.content = minetest.registered_items
            cgdata.content_name = "all"
            cgdata.curr_page = 1
            cgdata.form_list = nil
        end
    end

    for groupname, groupstring in pairs(craftguide_groups_auto) do
        if (fields["workbench_craftguide_item_"..groupstring]) then
            cgdata.filter = groupname
            cgdata.content = minetest.registered_items
            cgdata.content_name = "all"
            cgdata.curr_page = 1
            cgdata.form_list = nil
        end
    end

    -- quitting
    if fields.workbench_craftguide_exit or fields.quit then
        cgdata.active = false
        winv.refresh(player) -- switch back to normal inventory
    end

    -- refresh and updates formspec (if not quitting)
    if not fields.quit and not fields.workbench_craftguide_exit then
        player:set_inventory_formspec(craftguide_form(player))
    end
end)