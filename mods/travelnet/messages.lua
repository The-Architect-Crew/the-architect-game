travelnet.travelnet_color = "#80aaff"
travelnet.network_color = "#ff4e39"
travelnet.name_color = "#ffff00"
travelnet.location_color = "#a0cf2c"
travelnet.price_color = "#a89f6b"
travelnet.true_color = "#00ff00"
travelnet.false_color = "#ff0000"
travelnet.dim_color = "#888888"
travelnet.warning_color = "#ffdd00"

local message_types = {
    success = minetest.colorize("#00ff00", "[Success]"),
    error = minetest.colorize("#ff0000", "[Error]"),
    note = minetest.colorize("#888888", "[Note]"),
    warning = minetest.colorize("#ffdd00", "[Warning]"),
}

function travelnet.chat_message(message_type, message, hint)
    if hint == nil then
        hint = ""
    end
    return "<" .. minetest.colorize(travelnet.travelnet_color, "TravelNet") .. "> " ..
            message_types[message_type] .. " " .. message .. " " .. minetest.colorize("#888888", hint)
end