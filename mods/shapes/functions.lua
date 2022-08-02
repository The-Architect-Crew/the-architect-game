--=== PANES FUCTIONALITY ===
-- Obtained from minetest-game/panes
-- https://github.com/minetest/minetest_game/tree/master/mods/xpanes
-- xyz & BlockMen & Auke Kok (MIT)
-- Various Minetest developers and contributors (MIT)
local function is_pane(pos, group)
	return minetest.get_item_group(minetest.get_node(pos).name, group) > 0
end

local function connects_dir(pos, name, dir, group)
	local aside = vector.add(pos, minetest.facedir_to_dir(dir))
	if is_pane(aside, group) then return true end

	local connects_to = minetest.registered_nodes[name].connects_to
	if not connects_to then return false end

	local list = minetest.find_nodes_in_area(aside, aside, connects_to)
	if #list > 0 then return true end
	return false
end

local function swap(pos, node, name, param2)
	if node.name == name and node.param2 == param2 then return end
	minetest.set_node(pos, {name = name, param2 = param2})
end

local function update_pane(pos, group)
	if not is_pane(pos, group) then return end
	local node = minetest.get_node(pos)
	local name = node.name
	if name:sub(-5) == "_flat" then
		name = name:sub(1, -6)
	end

	local any = node.param2
	local c = {}
	local count = 0
	for dir = 0, 3 do
		c[dir] = connects_dir(pos, name, dir, group)
		if c[dir] then
			any = dir
			count = count + 1
		end
	end

	if count == 0 then
		swap(pos, node, name .. "_flat", any)
	elseif count == 1 then
		swap(pos, node, name .. "_flat", (any + 1) % 4)
	elseif count == 2 then
		if (c[0] and c[2]) or (c[1] and c[3]) then
			swap(pos, node, name .. "_flat", (any + 1) % 4)
		else
			swap(pos, node, name, 0)
		end
	else
		swap(pos, node, name, 0)
	end
end

local pane_groups = {"pane", "panemc"}
for _,pane_group in pairs(pane_groups) do
	minetest.register_on_placenode(function(pos, node)
		if minetest.get_item_group(node, pane_group) then
			update_pane(pos, pane_group)
		end
		for i = 0, 3 do
			local dir = minetest.facedir_to_dir(i)
			update_pane(vector.add(pos, dir), pane_group)
		end
	end)

	minetest.register_on_dignode(function(pos)
		for i = 0, 3 do
			local dir = minetest.facedir_to_dir(i)
			update_pane(vector.add(pos, dir), pane_group)
		end
	end)
end