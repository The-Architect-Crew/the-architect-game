protection.protection_color = "#a0cf2c"
protection.area_color = "#2ca4cf"
protection.name_color = "#ffff00"
protection.price_color = "#a89f6b"

local protection_stations = {
    marker = "Portable Marker",
    protector = "Protector Station",
    manager = "Area Manager"
}

local message_types = {
    success = minetest.colorize("#00ff00", "[Success]"),
    error = minetest.colorize("#ff0000", "[Error]"),
    note = minetest.colorize("#888888", "[Note]"),
    warning = minetest.colorize("#ffdd00", "[Warning]"),
}

function protection.chat_message(station, message_type, message, hint)
    if hint == nil then
        hint = ""
    end
    return "<" .. minetest.colorize(protection.protection_color, protection_stations[station]) .. "> " ..
            message_types[message_type] .. " " .. message .. " " .. minetest.colorize("#888888", hint)
end