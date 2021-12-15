locks = {}
locks.dinfo = {}
locks.dinfo["lock"] = {"Only the owner & shared can access & dig", "Locked"}
locks.dinfo["unlock"] = {"Everyone can access & dig", "Public Access"}
locks.dinfo["mail"] = {"Everyone can add items, but only owner & shared can access & dig", "Mailbox"}
locks.dinfo["protect"] = {"If protected: The owner & shared & protection owner(s) can access & dig \nIf not protected: Everyone can access & dig", "Protected Access"}

-- returns description
function locks.desc(type, level, disable_shared)
	local desc = locks.dinfo[type][level]
	if disable_shared then
		local desc2 = desc:gsub(" & shared", "")
		return desc2
	else
		return desc
	end
end

-- returns current order, next order
function locks.icons(fieldname, lock, order, disable_shared, add_desc)
	if not add_desc then
		adesc = ""
	else
		adesc = " \n"..add_desc
	end
	for index, row in pairs(order) do
		if row == lock then
			local indexplus = index + 1
			if indexplus > #order then
				indexplus = 1
			else
				indexplus = index + 1
			end
			local cicon, nicon = order[index], order[indexplus]
			return "gui_"..cicon..".png;"..fieldname.."_"..nicon..";;true;false;]"..
				"tooltip["..fieldname.."_"..nicon..";Current status: "..cicon.." \n"..locks.desc(cicon, 1, disable_shared).." \nPress to change to: "..nicon..""..adesc.."]"
		end
	end
end

-- check whether valid access
-- returns true if able to access protected area + has edit rights
-- return <value> if has edit rights but not access protected area
-- return "mail" if has mail rights
function locks.can_access(pos, player)
	local meta = minetest.get_meta(pos)
	local playername = player:get_player_name()
	local owner = meta:get_string("owner")
	local lock = meta:get_string("lock")
	local shared = meta:get_string("shared")
	-- protection bypass
	if minetest.check_player_privs(player, "protection_bypass") then
		return true
	end
	-- no owner
	if owner == "" then
		if minetest.is_protected(pos, playername) then
			return "noone"
		else
			return true
		end
	end
	-- owner
	if playername == owner then
		if minetest.is_protected(pos, playername) then
			return "owner"
		else
			return true
		end
	end
	-- shared
	local sharedstring = " "..shared.." "
	if sharedstring:find(" "..playername.." ") then
		if minetest.is_protected(pos, playername) then
			return "shared"
		else
			return true
		end
	end
	-- public
	if lock == "unlock" then
		if minetest.is_protected(pos, playername) then
			return "public"
		else
			return true
		end
	end
	-- protect
	if lock == "protect" then
		if not minetest.is_protected(pos, playername) then
			return "protect"
		end
	end
	-- mail
	if lock == "mail" then
		return "mail"
	end
end