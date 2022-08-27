winv:register_inventory("remote", {
	lists = {
		{"remote", 4 * 6},
	},
	button = {
		texture = "winv_icon_remote.png",
		tooltip = "Remote Access",
	},
	formspec_func = function(player)
		local playername = player:get_player_name()
		local formspec = {
			"image[0,0;7.75,7.75;winv_bg.png]",
			"button[0.25,0.25;6.35,0.7;<name>;Link by nearby nodes]",
			"button[6.8,0.25;0.7,0.7;<name>;?]",
			-- --
			"button[0.25,1.15;6.35,0.7;<name>;Link by coordinates]",
			"button[6.8,1.15;0.7,0.7;<name>;?]",
			-- --
			"style_type[textlist;font_size=12]",
			-- --
			"box[0.25,2.05;3.525,4.7;#00000069]",
			"textlist[0.25,2.05;3.525,4.7;<name>;Linked Nodes:,1. (123\\,32\\,435): Chest,2. (-12\\,32\\,23): Seeds,3. (-32\\,25\\,203): Valuables,4. (23\\,24\\,124): Chest2,5. (90\\,20\\,125): Chest3,6. (-34689\\, -34600\\, -34343): Chest4;1;true]", -- overall list
			"image_button[1.475,6.85;0.7,0.7;gui_cross_big.png;<name>;;false;false]",
			"image_button[2.375,6.85;0.7,0.7;gui_heart.png;<name>;;false;false]",
			"image_button[3.175,6.85;0.7,0.7;gui_enter.png;<name>;;false;false]",
			-- --
			"box[3.975,2.05;3.525,4.7;#00000069]",
			"textlist[3.975,2.05;3.525,4.7;<name>;Favourite:,3. (-32\\,25\\,203): Valuables,5. (90\\,20\\,125): Chest3;1;true]", -- favourite list
			"image_button[6.1,6.85;0.7,0.7;gui_heart_broken.png;<name>;;false;false]",
			"image_button[6.9,6.85;0.7,0.7;gui_enter.png;<name>;;false;false]",
			-- --
			"style_type[label;font_size=15;noclip=true]",
			"label[0.1,7.95; "..minetest.colorize("white", "Remote viewing: Valuables (-32\\,25\\,203)").."]",
		}
		return table.concat(formspec)
	end,
	on_player_receive_fields = function(player, formname, fields)
		if fields["winv_remote_left"] or fields["winv_remote_right"] then
			-- --
		end
	end,
})