wb_lock = {}
-- return true if workbench is locked
function wb_lock.is_locked(pos)
	local meta = minetest.get_meta(pos)
	if meta:get_string("lock") == "locked" then
		return true
	end
end

-- return true if player is not owner
function wb_lock.noaccess(pos, player)
	local meta = minetest.get_meta(pos)
	if player then
		local playername = player:get_player_name()
		if meta:get_string("owner") ~= playername then
			return true
		end
	end
end

-- return true if workbench is locked & player is not owner (player can't access)
function wb_lock.check(pos, player)
	if wb_lock.is_locked(pos) then
		if wb_lock.noaccess(pos, player) then
			workbench.send(player, "Workbench is locked!")
			return true
		end
	end
end

-- "locked" value is from meta:get_string("lock")
function wb_lock.formspec(locked)
	if locked == "locked" then
		return ""..
			"image_button[0.4,4.15;1.05,1.05;workbench_lock.png;workbench_unlock;;;false;workbench_lock.png]" ..
			"tooltip[workbench_unlock;Unlock workbench (Allow other players to access) \nCurrently locked]"
	elseif locked == "unlocked" then
		return "" ..
			"image_button[0.4,4.15;1.05,1.05;workbench_unlock.png;workbench_lock;;;false;workbench_unlock.png]" ..
			"tooltip[workbench_lock;Lock workbench (Disallow other players to access) \nCurrently unlocked]"
	end
end