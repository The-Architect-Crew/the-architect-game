locks = {}
locks.dinfo = {}
locks.dinfo["lock"] = {"Only the owner & shared can access & dig", "Locked", "Locked"}
locks.dinfo["unlock"] = {"Everyone can access & dig", "Unlocked", "Unlocked"}
locks.dinfo["public"] = {"Everyone can access \nOnly owner & shared can dig", "Public Access", "Public Access"}
locks.dinfo["mail"] = {"Everyone can add items \nOnly owner & shared can access & dig", "Mailbox", "Mailbox"}
locks.dinfo["protect"] = {"Protected Area: All protection owner(s) can access but only owner & shared can dig \nUnprotected Area: Everyone can access but only owner & shared can dig", "Protected Access", "Protected"}

-- returns description
function locks.desc(locktype, level, enabled_shared)
	local desc = locks.dinfo[locktype][level]
	if enabled_shared then
		return desc
	else
		local desc2 = desc:gsub(" & shared", "")
		return desc2
	end
end

local function get_desc(add_desc)
	if not add_desc then
		return ""
	else
		return " \n"..add_desc
	end
end

-- returns current order, next order
function locks.icons(pos, fieldprefix, lockorder, enabled_shared, add_desc)
	local meta = minetest.get_meta(pos)
	local locktype = meta:get_string("lock")
	for index, row in pairs(lockorder) do
		if row == locktype then
			local indexplus = index + 1
			if indexplus > #lockorder then
				indexplus = 1
			else
				indexplus = index + 1
			end
			local cicon, nicon = lockorder[index], lockorder[indexplus]
			return
				"gui_"..cicon..".png;"..fieldprefix.."_"..nicon..";;true;false;gui_"..cicon..".png^[colorize:black:80]"..
				"tooltip["..fieldprefix.."_"..nicon..";Current mode: "..locks.desc(cicon, 3).." \n"..locks.desc(cicon, 1, enabled_shared).." \nPress to change to: "..locks.desc(nicon, 3)..""..get_desc(add_desc).."]"
		end
	end
end

-- check whether valid access
-- returns true if able to access protected area + has access + dig rights
-- return <value> if has access rights but not access protected area / dig rights
function locks.can_access(pos, player)
	local meta = minetest.get_meta(pos)
	local playername = player:get_player_name()
	local owner = meta:get_string("owner")
	local locktype = meta:get_string("lock")
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
	if locktype == "public" then
		return "public"
	end
	-- unlocked
	if locktype == "unlock" then
		if minetest.is_protected(pos, playername) then
			return "unlock"
		else
			return true
		end
	end
	-- protect
	if locktype == "protect" then
		if not minetest.is_protected(pos, playername) then
			return "protect"
		end
	end
	-- mail
	if locktype == "mail" then
		return "mail"
	end
end

function locks.fields(pos, player, fields, fieldprefix, desc, infoadd)
	local playername = player:get_player_name()
	local meta = minetest.get_meta(pos)
	local owner = meta:get_string("owner")
	if playername == owner then
		for locktype in pairs(locks.dinfo) do
			if fields[fieldprefix.."_"..locktype] then
				meta:set_string("lock", locktype)
				meta:set_string("infotext", locks.desc(locktype , 2).." "..desc.." (Owned by "..owner..") "..get_desc(infoadd))
				return locktype
			end
		end
	end
end

function locks.init_infotext(pos, desc, infoadd)
	local meta = minetest.get_meta(pos)
	local locktype = meta:get_string("lock")
	local owner = meta:get_string("owner")
	local ownerdesc
	if owner == "" then
		ownerdesc = "(Unowned)"
	else
		ownerdesc = "(Owned by "..owner..")"
	end
	meta:set_string("infotext", locks.desc(locktype , 2).." "..desc.." "..ownerdesc.." "..get_desc(infoadd))
end