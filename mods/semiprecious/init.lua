--register nodes

minetest.register_craftitem("semiprecious:garnet", {
        description = "Garnet",
        inventory_image = "semiprecious_garnet.png"
})

minetest.register_node("semiprecious:stone_with_garnet", {
        description = "Stone with Garnet",
        tiles = {"default_stone.png^semiprecious_mineral_garnet.png"},
        is_ground_content = true,
        groups = {cracky = 2},
        drop = "semiprecious:garnet 2",
        sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("semiprecious:amethyst", {
        description = "Amethyst",
        inventory_image = "semiprecious_amethyst.png"
})

minetest.register_node("semiprecious:stone_with_amethyst", {
        description = "Stone with Amethyst",
        tiles = {"default_stone.png^semiprecious_mineral_amethyst.png"},
        is_ground_content = true,
        groups = {cracky = 2},
        drop = "semiprecious:amethyst 2",
        sounds = default.node_sound_stone_defaults(),
})

local semiprecious_nodes = {

        ["turquoise_tile"] = {
                description = "Turquoise Tile",
                tiles = {"semiprecious_turquoise_tile.png"},
                is_ground_content = false,
                groups = {cracky = 3},
                sounds = default.node_sound_stone_defaults(),
        },

        ["turquoise_block"] = {
                description = "Turquoise Block",
                tiles = {"semiprecious_turquoise_block.png"},
                is_ground_content = true,
                groups = {cracky = 2},
                sounds = default.node_sound_stone_defaults(),
        },

        ["lapis_lazuli_block"] = {
                description = "Lapis Lazuli Block",
                tiles = {"semiprecious_lapis_lazuli_block.png"},
                is_ground_content = true,
                groups = {cracky = 2},
                sounds = default.node_sound_stone_defaults(),
        },

        ["lapis_lazuli_tile"] = {
                description = "Lapis Lazuli Tile",
                tiles = {"semiprecious_lapis_lazuli_tile.png"},
                is_ground_content = false,
                groups = {cracky = 3},
                sounds = default.node_sound_stone_defaults(),
        },

        ["malachite_block"] = {
                description = "Malachite Block",
                tiles = {"semiprecious_malachite_block.png"},
                is_ground_content = true,
                groups = {cracky = 2},
                sounds = default.node_sound_stone_defaults(),
        },

        ["malachite_tile"] = {
                description = "Malachite Tile",
                tiles = {"semiprecious_malachite_tile.png"},
                is_ground_content = false,
                groups = {cracky = 3},
                sounds = default.node_sound_stone_defaults(),
        },

        ["garnet_block"] = {
                description = "Garnet Block",
                drawtype = "allfaces",
		tiles = {"semiprecious_garnet_block.png"},
                paramtype = "light",
                use_texture_alpha = true,
                is_ground_content = true,
                sunlight_propagates = true,
                groups = {cracky = 2},
                sounds = default.node_sound_stone_defaults(),
        },

        ["garnet_tile"] = {
                description = "Garnet Tile",
                drawtype = "allfaces",
		tiles = {"semiprecious_garnet_tile.png"},
                paramtype = "light",
                use_texture_alpha = true,
                is_ground_content = false,
                groups = {cracky = 3},
                sounds = default.node_sound_stone_defaults(),
        },

        ["amethyst_block"] = {
                description = "Amethyst Block",
		drawtype = "allfaces",
                tiles = {"semiprecious_amethyst_block.png"},
                paramtype = "light",
                use_texture_alpha = true,
                is_ground_content = true,
                sunlight_propagates = true,
                groups = {cracky = 2},
                sounds = default.node_sound_stone_defaults(),
        },

        ["amethyst_tile"] = {
                description = "Amethyst Tile",
		drawtype = "allfaces",
                tiles = {"semiprecious_amethyst_tile.png"},
                paramtype = "light",
                use_texture_alpha = true,
                is_ground_content = false,
                groups = {cracky = 3},
                sounds = default.node_sound_stone_defaults(),
        },

}

for name, definition in pairs(semiprecious_nodes) do
        minetest.register_node("semiprecious:"..name, definition)
end

minetest.register_node("semiprecious:turquoise_tile", {
        description = "Turquoise tile",
        tiles = {"semiprecious_turquoise_tile.png"},
        is_ground_content = false,
        groups = {cracky =3},
        sounds = default.node_sound_stone_defaults(),
})
dofile(minetest.get_modpath("semiprecious").."/lighting.lua")
dofile(minetest.get_modpath("semiprecious").."/mapgen.lua")
dofile(minetest.get_modpath("semiprecious").."/crafting.lua")

--stairsplus (moreblocks) support


if minetest.get_modpath("moreblocks") ~= nil then
        for name, definition in pairs(semiprecious_nodes) do
                stairsplus:register_all("stairs", name, "semiprecious:"..name, {
                        description = name,
                              tiles = {"semiprecious_"..name..".png"},
                              use_texture_alpha = true,
                              groups = {cracky = 3},
                              sounds = default.node_sound_stone_defaults()
        })
        end
elseif minetest.get_modpath("stairs") ~=nil then
        for name, definition in pairs(semiprecious_nodes) do

              stairs.register_stair_and_slab(
                      name,
                      "semiprecious:"..name,
                      {cracky = 3},
                      {"semiprecious_"..name..".png"},
                      name.."Stair",
                      name.."Stair",
                      default.node_sound_stone_defaults()
                      )
        end

end
