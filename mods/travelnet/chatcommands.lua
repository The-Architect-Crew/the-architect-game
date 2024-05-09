minetest.register_chatcommand("travelnet_data", {
    params = "<name>",
    description = "Print TravelNet station data for the player",
    privs = {server=true},
    func = function(name, param)
        if (param ~= "") and (param ~= nil) then
            travelnet.dump_player_data(name, param)
        end
    end
})