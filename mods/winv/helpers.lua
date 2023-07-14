-- check if itemname is groupname (prefix with group:)
-- returns true if is a groupname, else nil
function winv.is_group(itemname)
    if itemname:find("group:", 1, true) then
        local groupstring = string.match(itemname, ':(.*)')
        if groupstring and groupstring ~= "" then
            return true
        end
    end
end

-- check if item is in given group (group:groupname)
-- return true if is in group, else nil
function winv.group_match(groupname, itemname)
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

-- find the first item in specified group
-- if found, return itemname
-- if none found, return groupname
function winv.find_first_in_group(groupname)
    for itemname, def in pairs(minetest.registered_items) do
        if def.groups.not_in_creative_inventory ~= 1 and def.groups.not_in_craftguide ~= 1 then
            if winv.group_match(groupname, itemname) then
                return itemname
            end
        end
    end
    return groupname
end

-- check if item is from specified mod (modname)
function winv.mod_match(itemname, modname)
    local item_modname = string.match(itemname, '(.*):')
    if item_modname == modname then
        return true
    end
end

-- gets a list of modnames, that actually contain nodes/items
-- returns said list, results should be cached if used multiple times
-- (expensive check that runs through entire itemlist for matches)
-- exclude_creative is a bool that excludes items from not_in_creative_inventory from the check
function winv.get_nonempty_modnames(exclude_creative)
    local modnames = minetest.get_modnames()
    local ret_modnames = {}
    local nonempty_modnames = {}
    for itemname, def in pairs(minetest.registered_items) do
        if (exclude_creative and not winv.group_match("group:not_in_creative_inventory", itemname)) or
            (exclude_creative ~= true) then
            local modname = string.match(itemname, '(.*):')
            if modname and not nonempty_modnames[modname] then
                nonempty_modnames[modname] = true
            end
        end
    end

    for i, modname in ipairs(modnames) do
		if nonempty_modnames[modname] then
            ret_modnames[#ret_modnames + 1] = modname
        end
	end
    return ret_modnames
end

-- checks if item is in invalid mod (mod dpoesn't exists)
-- situation will occur in cases of alias
-- whereby the mod doesn't actually exists
-- returns true if item is in invalid mod
function winv.in_invalid_mod(itemname)
    local modnames = minetest.get_modnames()
    local item_modname = string.match(itemname, '(.*):')
    for i, modname in ipairs(modnames) do
        if item_modname == modname then
            return nil
        end
    end
    return true
end