minetest.register_chatcommand("station_data", {
    params = "<name>",
    description = "Print travelnet station data for the player",
    privs = {server=true},
    func = function(name, param)
        if (param ~= "") and (param ~= nil) then
            travelnet.dump_player_data(name, param)
        end
    end
})