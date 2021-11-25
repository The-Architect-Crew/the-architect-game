minetest.register_craft({
        output = "semiprecious:turquoise_tile 9",
        recipe ={
            {"semiprecious:turquoise_block", "semiprecious:turquoise_block", "semiprecious:turquoise_block"},
            {"semiprecious:turquoise_block", "semiprecious:turquoise_block", "semiprecious:turquoise_block"},
            {"semiprecious:turquoise_block", "semiprecious:turquoise_block", "semiprecious:turquoise_block"}
        }
})

minetest.register_craft({
        output = "semiprecious:lapis_lazuli_tile 9",
        recipe ={
            {"semiprecious:lapis_lazuli_block", "semiprecious:lapis_lazuli_block", "semiprecious:lapis_lazuli_block"},
            {"semiprecious:lapis_lazuli_block", "semiprecious:lapis_lazuli_block", "semiprecious:lapis_lazuli_block"},
            {"semiprecious:lapis_lazuli_block", "semiprecious:lapis_lazuli_block", "semiprecious:lapis_lazuli_block"}
        }
})

minetest.register_craft({
        output = "semiprecious:malachite_tile 9",
        recipe  = {
            {"semiprecious:malachite_block", "semiprecious:malachite_block", "semiprecious:malachite_block"},
            {"semiprecious:malachite_block", "semiprecious:malachite_block", "semiprecious:malachite_block"},
            {"semiprecious:malachite_block", "semiprecious:malachite_block", "semiprecious:malachite_block"}
        }
})

minetest.register_craft({
        output = "semiprecious:garnet_block",
        recipe = {
            {"semiprecious:garnet", "semiprecious:garnet", "semiprecious:garnet"},
            {"semiprecious:garnet", "semiprecious:garnet", "semiprecious:garnet"},
            {"semiprecious:garnet", "semiprecious:garnet", "semiprecious:garnet"}
        }
})

minetest.register_craft({
        output = "semiprecious:garnet 9",
        type = "shapeless",
        recipe = {"semiprecious:garnet_block"}
})

minetest.register_craft({
        output = "semiprecious:garnet_tile 9",
        recipe = {
            {"semiprecious:garnet_block", "semiprecious:garnet_block", "semiprecious:garnet_block"},
            {"semiprecious:garnet_block", "semiprecious:garnet_block", "semiprecious:garnet_block"},
            {"semiprecious:garnet_block", "semiprecious:garnet_block", "semiprecious:garnet_block"}
        }
})

minetest.register_craft({
        output = "semiprecious:amethyst_block",
        recipe = {
            {"semiprecious:amethyst", "semiprecious:amethyst", "semiprecious:amethyst"},
            {"semiprecious:amethyst", "semiprecious:amethyst", "semiprecious:amethyst"},
            {"semiprecious:amethyst", "semiprecious:amethyst", "semiprecious:amethyst"}
        }
})

minetest.register_craft({
        output = "semiprecious:amethyst 9",
        type = "shapeless",
        recipe = {"semiprecious:amethyst_block"}
})

minetest.register_craft({
        output = "semiprecious:amethyst_tile 9",
        recipe = {
            {"semiprecious:amethyst_block", "semiprecious:amethyst_block", "semiprecious:amethyst_block"},
            {"semiprecious:amethyst_block", "semiprecious:amethyst_block", "semiprecious:amethyst_block"},
            {"semiprecious:amethyst_block", "semiprecious:amethyst_block", "semiprecious:amethyst_block"}
        }
})
--craft dyes from semiprecious stones

minetest.register_craft({
        output = "dye:cyan 8",
        type = "shapeless",
        recipe = {"semiprecious:turquoise_block"}
})

minetest.register_craft({
        output = "dye:blue 8",
        type = "shapeless",
        recipe = {"semiprecious:lapis_lazuli_block"}
})

minetest.register_craft({
        output = "dye:dark_green 8",
        type = "shapeless",
        recipe = {"semiprecious:malachite_block"}
})

minetest.register_craft({
        output = "dye:red 8",
        type = "shapeless",
        recipe = {"semiprecious:garnet"}
})

minetest.register_craft({
        output = "dye:violet 8",
        type = "shapeless",
        recipe = {"semiprecious:amethyst"}
})
