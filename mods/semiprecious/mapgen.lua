minetest.register_ore({
      ore_type = "sheet",
      ore = "semiprecious:turquoise_block",
      wherein = "default:stone",
      y_min = -31000,
      y_max = -128,
      noise_threshold = 0.7,
      noise_params = {
              offset = -0.16,
              scale = 1,
              spread = {x = 25, y = 25, z = 25},
              seed = 23,
              octaves = 3,
              persist = 0.70,
              },
      column_height_max = 6,
      column_height_min = 2
})


minetest.register_ore({
      ore_type = "sheet",
      ore = "semiprecious:lapis_lazuli_block",
      wherein = "default:stone",
      y_min = -31000,
      y_max = -256,
      noise_threshold = 0.7,
      noise_params = {
              offset = -0.16,
              scale = 1,
              spread = {x = 25, y = 25, z = 25},
              seed = 23,
              octaves = 3,
              persist = 0.70,
              },
      column_height_max = 6,
      column_height_min = 2
})

minetest.register_ore({
      ore_type = "sheet",
      ore = "semiprecious:malachite_block",
      wherein = "default:stone",
      y_min = -31000,
      y_max = -512,
      noise_threshold = 0.7,
      noise_params = {
              offset = -0.16,
              scale = 1,
              spread = {x = 25, y = 25, z = 25},
              seed = 23,
              octaves = 3,
              persist = 0.70,
              },
      column_height_max = 6,
      column_height_min = 2
})

minetest.register_ore({
        ore_type = "scatter",
        ore = "semiprecious:stone_with_garnet",
        wherein = "default:stone",
        clust_scarcity = 14 * 14 * 14,
        clust_num_ores = 3,
        clust_size = 2,
        y_min = -512,
        y_max = -128,

})

minetest.register_ore({
        ore_type = "scatter",
        ore = "semiprecious:stone_with_garnet",
        wherein = "default:stone",
        clust_scarcity = 12 * 12 * 12,
        clust_num_ores = 5,
        clust_size = 3,
        y_min = -31000,
        y_max = -512,
})

minetest.register_ore({
        ore_type = "scatter",
        ore = "semiprecious:garnet_block",
        wherein = "default:stone",
        clust_scarcity = 14 * 14 * 14,
        clust_num_ores = 3,
        clust_size = 2,
        y_min = -1023,
        y_max = -512,
})

minetest.register_ore({
        ore_type = "scatter",
        ore = "semiprecious:garnet_block",
        wherein = "default:stone",
        clust_scarcity = 12 * 12 * 12,
        clust_num_ores = 5,
        clust_size = 3,
        y_min = -31000,
        y_max = -1024,
})

minetest.register_ore({
        ore_type = "scatter",
        ore = "semiprecious:stone_with_amethyst",
        wherein = "default:stone",
        clust_scarcity = 15 * 15 * 15,
        clust_num_ores = 3,
        clust_size = 2,
        y_min = -255,
        y_max = -84,
})

minetest.register_ore({
        ore_type = "scatter",
        ore = "semiprecious:stone_with_amethyst",
        wherein = "default:stone",
        clust_scarcity = 13 * 13 * 13,
        clust_num_ores = 5,
        clust_size = 3,
        y_min = -31000,
        y_max = -256,
})

minetest.register_ore({
        ore_type = "scatter",
        ore = "semiprecious:amethyst_block",
        wherein = "default:stone",
        clust_scarcity = 15 * 15 * 15,
        clust_num_ores = 3,
        clust_size = 2,
        y_min = -1023,
        y_max = -512,
})

minetest.register_ore({
        ore_type = "scatter",
        ore = "semiprecious:amethyst_block",
        wherein = "default:stone",
        clust_scarcity = 13 * 13 * 13,
        clust_num_ores = 5,
        clust_size = 3,
        y_min = -31000,
        y_max = -1024,
})
