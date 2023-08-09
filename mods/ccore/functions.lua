-- swap nodes
function ccore.swap_node(pos, name)
	local node = minetest.get_node(pos)
	if node.name == name then
		return
	end
	node.name = name
	minetest.swap_node(pos, node)
end

-- Scan groups for forbidden groups
function ccore.scan_forbidden_groups(array1, array2)
    local result = false
    for i=1,#array1 do
        for j=1,#array2 do
            if array1[i] == array2[j] then
                result = true
            end
        end
    end
    return result
end

-- int to time string
function ccore.get_time(int)
	if not tonumber(int) then
		return nil
	end
	if int > 59 then
		if int > 3600 then
			local ihr = math.floor(int / 3600)
			local imin = math.floor((int % 3600) / 60)
			local isec = int % 60
			if isec > 0 then
				return ihr.." hr "..imin.." min "..isec.." sec"
			else
				if imin > 0 then
					return ihr.." hr "..imin.." min"
				else
					return ihr.. "hr"
				end
			end
		else -- minutes and seconds
			local imin = math.floor(int / 60)
			local isec = int % 60
			if isec > 0 then
				return imin.." min "..isec.." sec"
			else
				return imin.." min"
			end
		end
	else -- seconds only
		return int.." sec"
	end
end

-- dig directionally
function ccore.dig_dir(pos, nodes, dir, digger)
	local np = {x = pos.x, y = pos.y + dir, z = pos.z}
	local nn = minetest.get_node(np)
	for i=1,#nodes do
		if nn.name == nodes[i] then
			if digger == nil then
				minetest.remove_node(np)
			else
				minetest.node_dig(np, nn, digger)
			end
		end
	end
end

-- description commenting
function ccore.comment(desc, comment, color)
	if color then
		return desc.."\n"..minetest.colorize(color, comment)
	else
		return desc.."\n"..minetest.colorize("grey", comment)
	end
end

local station_comment_list = {}
function ccore.station_comment(name, desc)
	if station_comment_list[name] then
		station_comment_list[name] = station_comment_list[name]..", "..desc
	else
		station_comment_list[name] = desc
	end
end

minetest.register_on_mods_loaded(function()
    for name in pairs(station_comment_list) do
        minetest.override_item(name, {
			description = ccore.comment(minetest.registered_nodes[name].description, station_comment_list[name], "green"),
		})
    end
end)

-- round number to a select decimal point
function ccore.round(num, decpoint)
	return tonumber(string.format("%."..decpoint.."f", num))
end
-- remove comment from description
function ccore.strip_newlines(string)
	return string.match(string, '(.*)\n') or string
end

ccore.not_inherited = {"wood", "stone", "fire_biome", "azure", "sand", "stick"}

ccore.groups_copy = function(table)
    local copy = {}
    for table_key, table_value in pairs(table) do
		local inherit = true
		for i=1,#ccore.not_inherited do
			if table_key == ccore.not_inherited[i] then
				inherit = false
			end
		end
		-- Cleaner implemntation for the "craft_" naming convention of crafting groups
		if string.match(table_key, '(.*)_') == "craft" then
			inherit = false
		end
		if (inherit) then
			copy[table_key] = table_value
		end
    end
    return copy
end