travelnet = {}

travelnet.pos = {}
travelnet.storage = minetest.get_mod_storage()

travelnet.materials = {
    "blocks:wood",
    "blocks:sandstone",
    "blocks:copperblock",
    "blocks:steelblock",
    "blocks:stone",
    "blocks:obsidian",
    "blocks:basalt",
    {"blocks:marble", "blocks:goldblock"},
    {"blocks:mithrilblock", "blocks:mithrilblock"},
    {"blocks:rustblock", "blocks:rustblock"}
}

local path = minetest.get_modpath("travelnet")

dofile(path .."/database.lua")
dofile(path .."/messages.lua")
dofile(path .."/formspecs.lua")
dofile(path .."/functions.lua")
dofile(path .."/chatcommands.lua")
dofile(path .."/register.lua")
dofile(path .."/crafting.lua")