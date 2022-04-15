workbench.fuels = {}
function workbench:register_fueltype(name)
	workbench.fuels[name] = {}
end

function workbench:register_fuel(def)
	def = def or {}
	local ftype = def.type or "normal"
	local ftime = def.time or 0
	local fcat = def.cat or "none"
	-- ensure fuel type is registered
	if workbench.fuels[ftype] == nil then
		return minetest.log("error",
			"[workbench] Error registering fuel - Invalid fuel type: "..
			"type: "..ftype..", category: "..fcat..", fuel: "..def.fuel
		)
	end
	-- ensure valid format
	if type(def.fuel) ~= "string" then
		return minetest.log("error",
			"[workbench] Error registering fuel - Invalid fuel format: "..
			"type: "..ftype..", category: "..fcat
		)
	end
	-- save data
	table.insert(workbench.fuels[ftype], {
		time = ftime, -- fueltime
		cat = def.cat, -- category
		fuel = def.fuel, -- fuel source
		--replacements = def.replacements or {}, -- TODO support replacements
	})
end

function workbench:get_fuel(ilist, ftype, cat)
	local ftype2 = ftype or "normal"
	local flist = workbench.fuels[ftype2]
	-- obtaining workbench fuel
	for i in pairs(flist) do
		if flist[i].cat == cat then
			for j in ipairs(ilist) do
				local fitem = ItemStack(flist[i].fuel) -- fuel item
				local citem = ilist[j] -- input item
				if fitem:get_name() == citem:get_name() then
					print("validfuel")
					local dfuel = citem:peek_item(citem:get_count() - fitem:get_count())
					return flist[i].time, {dfuel}
				end
			end
		end
	end
	-- obtaining minetest.register_craft fuel
	if ftype2 == "normal" then
		local output, dinput = minetest.get_craft_result({method = "fuel", width = 1, items = ilist})
		if output and output.item and output.time > 0 then
			return output.time, dinput.items
		end
	end
end