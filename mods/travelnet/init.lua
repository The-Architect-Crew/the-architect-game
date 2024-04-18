travelnet = {}

travelnet.storage = minetest.get_mod_storage()

local path = minetest.get_modpath("travelnet")

dofile(path .."/database.lua")
dofile(path .."/formspecs.lua")
dofile(path .."/functions.lua")
dofile(path .."/register.lua")