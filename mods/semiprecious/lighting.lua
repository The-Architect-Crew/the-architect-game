minetest.register_node("semiprecious:lantern_garnet", {
    description = "Garnet Lantern",
    tiles = {"semiprecious_garnet_block.png^arabesque_mosaic_frame.png"},
    paramtype = "light",
    light_source = 13,
    groups = {cracky=3, oddly_breakable_by_hand = 1},
    sounds = default.node_sound_glass_defaults()
})

minetest.register_node("semiprecious:lantern_amethyst", {
    description = "Amethyst Lantern",
    tiles = {"semiprecious_amethyst_block.png^arabesque_mosaic_frame.png"},
    paramtype = "light",
    light_source = 13,
    groups = {cracky = 3, oddly_breakable_by_hand = 1},
    sounds = default.node_sound_glass_defaults()
})


--lighting crafts move to crafting.lua
minetest.register_craft({
    output = "semiprecious:lantern_garnet 8",
    recipe = {
      {"default:steel_ingot", "semiprecious:garnet_block", "default:steel_ingot"},
      {"semiprecious:garnet_block", "default:torch", "semiprecious:garnet_block"},
      {"default:steel_ingot", "semiprecious:garnet_block", "default:steel_ingot"}
    }
})

minetest.register_craft({
    output = "semiprecious:lantern_amethyst 8",
    recipe = {
      {"default:steel_ingot", "semiprecious:amethyst_block", "default:steel_ingot"},
      {"semiprecious:amethyst_block", "default:torch", "semiprecious:amethyst_block"},
      {"default:steel_ingot", "semiprecious:amethyst_block", "default:steel_ingot"}
    }
})
