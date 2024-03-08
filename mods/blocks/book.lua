local S = default.get_translator

local esc = minetest.formspec_escape
local formspec_size = "size[8,8]"

local function formspec_core(tab)
	if tab == nil then tab = 1 else tab = tostring(tab) end
	return "tabheader[0,0;book_header;" ..
		esc(S("Write")) .. "," ..
		esc(S("Read")) .. ";" ..
		tab  ..  ";false;false]"
end

local function formspec_write(title, text)
	return "field[0.5,1;7.5,0;title;" .. esc(S("Title:")) .. ";" ..
			esc(title) .. "]" ..
		"textarea[0.5,1.5;7.5,7;text;" .. esc(S("Contents:")) .. ";" ..
			esc(text) .. "]" ..
		"button_exit[2.5,7.5;3,1;save;" .. esc(S("Save")) .. "]"
end

local function formspec_read(owner, title, string, text, page, page_max)
	return "label[0.5,0.5;" .. esc(S("by @1", owner)) .. "]" ..
		"tablecolumns[color;text]" ..
		"tableoptions[background=#00000000;highlight=#00000000;border=false]" ..
		"table[0.4,0;7,0.5;title;#FFFF00," .. esc(title) .. "]" ..
		"textarea[0.5,1.5;7.5,7;;" ..
			esc(string ~= "" and string or text) .. ";]" ..
		"button[2.4,7.6;0.8,0.8;book_prev;<]" ..
		"label[3.2,7.7;" .. esc(S("Page @1 of @2", page, page_max)) .. "]" ..
		"button[4.9,7.6;0.8,0.8;book_next;>]"
end

local function formspec_string(lpp, page, lines, string)
	for i = ((lpp * page) - lpp) + 1, lpp * page do
		if not lines[i] then break end
		string = string .. lines[i] .. "\n"
	end
	return string
end

local tab_number
local lpp = 14 -- Lines per book's page
local function book_on_use(itemstack, user)
	local player_name = user:get_player_name()
	local meta = itemstack:get_meta()
	local title, text, owner = "", "", player_name
	local page, page_max, lines, string = 1, 1, {}, ""

	-- Backwards compatibility
	local old_data = minetest.deserialize(itemstack:get_metadata())
	if old_data then
		meta:from_table({ fields = old_data })
	end

	local data = meta:to_table().fields

	if data.owner then
		title = data.title or ""
		text = data.text or ""
		owner = data.owner

		for str in (text .. "\n"):gmatch("([^\n]*)[\n]") do
			lines[#lines+1] = str
		end

		if data.page then
			page = data.page
			page_max = data.page_max
			string = formspec_string(lpp, page, lines, string)
		end
	end

	local formspec
	if title == "" and text == "" then
		formspec = formspec_write(title, text)
	elseif owner == player_name then
		local tab = tab_number or 1
		if tab == 2 then
			formspec = formspec_core(tab) ..
				formspec_read(owner, title, string, text, page, page_max)
		else
			formspec = formspec_core(tab) .. formspec_write(title, text)
		end
	else
		formspec = formspec_read(owner, title, string, text, page, page_max)
	end

	minetest.show_formspec(player_name, "blocks:book", formspec_size .. formspec)
	return itemstack
end

local max_text_size = 10000
local max_title_size = 80
local short_title_size = 35
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "blocks:book" then return end
	local player_name = player:get_player_name()
	local inv = player:get_inventory()
	local stack = player:get_wielded_item()
	local data = stack:get_meta():to_table().fields

	local title = data.title or ""
	local text = data.text or ""

	if fields.book_header ~= nil and data.owner == player_name then
		local contents
		local tab = tonumber(fields.book_header)
		if tab == 1 then
			contents = formspec_core(tab) ..
				formspec_write(title, text)
		elseif tab == 2 then
			local lines, string = {}, ""
			for str in (text .. "\n"):gmatch("([^\n]*)[\n]") do
				lines[#lines+1] = str
			end
			string = formspec_string(lpp, data.page, lines, string)
			contents = formspec_read(player_name, title, string,
				text, data.page, data.page_max)
		end
		tab_number = tab
		local formspec = formspec_size .. formspec_core(tab) .. contents
		minetest.show_formspec(player_name, "blocks:book", formspec)
		return
	end

	if fields.save and fields.title and fields.text then
		local new_stack
		if stack:get_name() ~= "blocks:book_written" then
			local count = stack:get_count()
			if count == 1 then
				stack:set_name("blocks:book_written")
			else
				stack:set_count(count - 1)
				new_stack = ItemStack("blocks:book_written")
			end
		end

		if data.owner ~= player_name and title ~= "" and text ~= "" then
			return
		end

		if not data then data = {} end
		data.title = fields.title:sub(1, max_title_size)
		data.owner = player:get_player_name()
		local short_title = data.title
		-- Don't bother triming the title if the trailing dots would make it longer
		if #short_title > short_title_size + 3 then
			short_title = short_title:sub(1, short_title_size) .. "..."
		end
		data.description = S("\"@1\" by @2", short_title, data.owner)
		data.text = fields.text:sub(1, max_text_size)
		data.text = data.text:gsub("\r\n", "\n"):gsub("\r", "\n")
		data.page = 1
		data.page_max = math.ceil((#data.text:gsub("[^\n]", "") + 1) / lpp)

		if new_stack then
			new_stack:get_meta():from_table({ fields = data })
			if inv:room_for_item("main", new_stack) then
				inv:add_item("main", new_stack)
			else
				minetest.add_item(player:get_pos(), new_stack)
			end
		else
			stack:get_meta():from_table({ fields = data })
		end

	elseif fields.book_next or fields.book_prev then
		if not data.page then
			return
		end

		data.page = tonumber(data.page)
		data.page_max = tonumber(data.page_max)

		if fields.book_next then
			data.page = data.page + 1
			if data.page > data.page_max then
				data.page = 1
			end
		else
			data.page = data.page - 1
			if data.page == 0 then
				data.page = data.page_max
			end
		end

		stack:get_meta():from_table({fields = data})
		stack = book_on_use(stack, player)
	end

	-- Update stack
	player:set_wielded_item(stack)
end)

minetest.register_craftitem("blocks:paper", {
	description = S("Paper"),
	inventory_image = "blocks_paper.png",
	groups = {flammable = 3},
})

minetest.register_craftitem("blocks:book", {
	description = S("Book"),
	inventory_image = "blocks_book.png",
	groups = {book = 1, flammable = 3},
	on_use = book_on_use,
})

minetest.register_craftitem("blocks:book_written", {
	description = S("Book with Text"),
	inventory_image = "blocks_book_written.png",
	groups = {book = 1, not_in_creative_inventory = 1, flammable = 3},
	stack_max = 1,
	on_use = book_on_use,
})

--
-- == CRAFTS
--

minetest.register_craft({
	output = "blocks:paper",
	recipe = {
		{"flora:papyrus", "flora:papyrus", "flora:papyrus"},
	}
})

default.register_craft_metadata_copy("blocks:book", "blocks:book_written")
minetest.register_craft({
	output = "blocks:book",
	recipe = {
		{"blocks:paper"},
		{"blocks:paper"},
		{"blocks:paper"},
	}
})

minetest.register_craft({
	output = "blocks:paper",
	recipe = {
		{"flora:papyrus", "flora:papyrus", "flora:papyrus"},
	}
})

minetest.register_craft({
	output = "blocks:bookshelf",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"blocks:book", "blocks:book", "blocks:book"},
		{"group:wood", "group:wood", "group:wood"},
	}
})