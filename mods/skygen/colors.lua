-- Day and Day Horizon are used as base colors for the biome
-- These two are then colorized by the Sun Tint and Moon Tint into Dawn and Night color variations respectively
-- This is done to reduce redundancy, as I found myself just colorizing like that when choosing the colors anyway
-- Dawn is generated using inverted colors, as horizon tends to be the darker color on the Day
-- Stars are colorized using the sun tint as well
-- Clouds are changed in three different functions already and colorizing them would be a bit more expensive due to the required transition functions

skygen.biome_names = {
    "cold_desert",
    "cold_desert_ocean",
    "desert",
    "desert_ocean",
    "taiga",
    "taiga_ocean",
    "snowy_grassland",
    "snowy_grassland_ocean",
    "grassland",
    "grassland_ocean",
    "grassland_dunes",
    "coniferous_forest",
    "coniferous_forest_dunes",
    "coniferous_forest_ocean",
    "deciduous_forest",
    "deciduous_forest_ocean",
    "deciduous_forest_shore",
    "rainforest",
    "rainforest_ocean",
    "rainforest_swamp",
    "icesheet",
    "icesheet_ocean",
    "tundra",
    "tundra_highland",
    "tundra_beach",
    "tundra_ocean",
    "sandstone_desert",
    "sandstone_desert_ocean",
    "savanna",
    "savanna_shore",
    "savanna_ocean",
    "chalk_grassland",
    "chalk_grassland_ocean",
    "underground",
    "hell"
}

skygen.biomes = {
    cold_desert = {
        name = "Cold Desert",
        colors = {
            {182, 232, 230}, -- Day
            {192, 189, 178}, -- Day Horizon
            {230, 230, 0}, -- Sun Tint
            {160, 199, 246}, -- Moon Tint
        }
    },
    cold_desert_under = {
        name = "Underground",
        colors = {
            {192, 192, 192}, -- Day
            {128, 128, 128}, -- Day Horizon
            {230, 230, 0}, -- Sun Tint
            {160, 199, 246}, -- Moon Tint
        }
    },
    cold_desert_ocean = {
        name = "Cold Desert",
        colors = {
            {210, 239, 254}, -- Day
            {204, 204, 204}, -- Day Horizon
            {230, 230, 0}, -- Sun Tint
            {160, 199, 246}, -- Moon Tint
        }
    },
    desert = {
        name = "Desert",
        colors = {
            {255, 255, 121}, -- Day
            {203, 158, 95}, -- Day Horizon
            {241, 99, 0}, -- Sun Tint
            {87, 61, 250}, -- Moon Tint
        }
    },
    desert_ocean = {
        name = "Desert",
        colors = {
            {253, 227, 60}, -- Day
            {186, 141, 87}, -- Day Horizon
            {241, 99, 0}, -- Sun Tint
            {87, 61, 250}, -- Moon Tint
        }
    },
    desert_under = {
        name = "Underground",
        colors = {
            {192, 192, 192}, -- Day
            {128, 128, 128}, -- Day Horizon
            {241, 99, 0}, -- Sun Tint
            {87, 61, 250}, -- Moon Tint
        }
    },
    taiga = {
        name = "Taiga",
        colors = {
            {160, 199, 246}, -- Day
            {88, 48, 125}, -- Day Horizon
            {200, 37, 127}, -- Sun Tint
            {0, 219, 219}, -- Moon Tint
        }
    },
    taiga_ocean = {
        name = "Taiga",
        colors = {
            {141, 224, 222}, -- Day
            {87, 61, 250}, -- Day Horizon
            {200, 37, 127}, -- Sun Tint
            {0, 219, 219}, -- Moon Tint
        }
    },
    taiga_under = {
        name = "Underground",
        colors = {
            {192, 192, 192}, -- Day
            {128, 128, 128}, -- Day Horizon
            {200, 37, 127}, -- Sun Tint
            {0, 219, 219}, -- Moon Tint
        }
    },
    snowy_grassland = {
        name = "Snowy Grassland",
        colors = {
            {192, 112, 172}, -- Day
            {180, 164, 204}, -- Day Horizon
            {214, 241, 254}, -- Sun Tint
            {87, 61, 250}, -- Moon Tint
        }
    },
    snowy_grassland_ocean = {
        name = "Snowy Grassland",
        colors = {
            {16, 98, 174}, -- Day
            {0, 182, 182}, -- Day Horizon
            {214, 241, 254}, -- Sun Tint
            {87, 61, 250}, -- Moon Tint
        }
    },
    snowy_grassland_under = {
        name = "Underground",
        colors = {
            {192, 192, 192}, -- Day
            {128, 128, 128}, -- Day Horizon
            {214, 241, 254}, -- Sun Tint
            {87, 61, 250}, -- Moon Tint
        }
    },
    grassland = {
        name = "Grassland",
        colors = {
            {160, 199, 246}, -- Day
            {39, 115, 185}, -- Day Horizon
            {222, 99, 0}, -- Sun Tint
            {18, 103, 182}, -- Moon Tint
        }
    },
    grassland_dunes = {
        name = "Grassland",
        colors = {
            {184, 221, 251}, -- Day
            {196, 193, 142}, -- Day Horizon
            {222, 99, 0}, -- Sun Tint
            {18, 103, 182}, -- Moon Tint
        }
    },
    grassland_ocean = {
        name = "Grassland",
        colors = {
            {141, 224, 222}, -- Day
            {160, 199, 246}, -- Day Horizon
            {222, 99, 0}, -- Sun Tint
            {18, 103, 182}, -- Moon Tint
        }
    },
    grassland_under = {
        name = "Underground",
        colors = {
            {192, 192, 192}, -- Day
            {128, 128, 128}, -- Day Horizon
            {222, 99, 0}, -- Sun Tint
            {18, 103, 182}, -- Moon Tint
        }
    },
    coniferous_forest = {
        name = "Coniferous Forest",
        colors = {
            {131, 156, 67}, -- Day
            {114, 139, 53}, -- Day Horizon
            {244, 178, 0}, -- Sun Tint
            {0, 149, 157}, -- Moon Tint
        }
    },
    coniferous_forest_dunes = {
        name = "Coniferous Forest",
        colors = {
            {194, 194, 194}, -- Day
            {114, 139, 53}, -- Day Horizon
            {244, 178, 0}, -- Sun Tint
            {0, 149, 157}, -- Moon Tint
        }
    },
    coniferous_forest_under = {
        name = "Underground",
        colors = {
            {192, 192, 192}, -- Day
            {128, 128, 128}, -- Day Horizon
            {244, 178, 0}, -- Sun Tint
            {0, 149, 157}, -- Moon Tint
        }
    },
    coniferous_forest_ocean = {
        name = "Coniferous Forest",
        colors = {
            {192, 189, 178}, -- Day
            {65, 107, 53}, -- Day Horizon
            {244, 178, 0}, -- Sun Tint
            {0, 149, 157}, -- Moon Tint
        }
    },
    deciduous_forest = {
        name = "Deciduous Forest",
        colors = {
            {214, 241, 254}, -- Day
            {62, 157, 185}, -- Day Horizon
            {233, 184, 9}, -- Sun Tint
            {39, 115, 185}, -- Moon Tint
        }
    },
    deciduous_forest_shore = {
        name = "Deciduous Forest",
        colors = {
            {192, 233, 254}, -- Day
            {202, 160, 97}, -- Day Horizon
            {233, 184, 9}, -- Sun Tint
            {39, 115, 185}, -- Moon Tint
        }
    },
    deciduous_forest_ocean = {
        name = "Deciduous Forest",
        colors = {
            {184, 221, 251}, -- Day
            {36, 151, 183}, -- Day Horizon
            {233, 184, 9}, -- Sun Tint
            {39, 115, 185}, -- Moon Tint
        }
    },
    deciduous_forest_under = {
        name = "Underground",
        colors = {
            {192, 192, 192}, -- Day
            {128, 128, 128}, -- Day Horizon
            {233, 184, 9}, -- Sun Tint
            {39, 115, 185}, -- Moon Tint
        }
    },
    rainforest = {
        name = "Rainforest",
        colors = {
            {89, 142, 40}, -- Day
            {33, 48, 23}, -- Day Horizon
            {243, 54, 0}, -- Sun Tint
            {184, 221, 251}, -- Moon Tint
        }
    },
    rainforest_swamp = {
        name = "Rainforest",
        colors = {
            {151, 141, 96}, -- Day
            {57, 82, 15}, -- Day Horizon
            {243, 54, 0}, -- Sun Tint
            {184, 221, 251}, -- Moon Tint
        }
    },
    rainforest_ocean = {
        name = "Rainforest",
        colors = {
            {164, 164, 164}, -- Day
            {57, 82, 15}, -- Day Horizon
            {243, 54, 0}, -- Sun Tint
            {184, 221, 251}, -- Moon Tint
        }
    },
    rainforest_under = {
        name = "Underground",
        colors = {
            {192, 192, 192}, -- Day
            {128, 128, 128}, -- Day Horizon
            {243, 54, 0}, -- Sun Tint
            {184, 221, 251}, -- Moon Tint
        }
    },
    icesheet = {
        name = "Icesheet",
        colors = {
            {0, 73, 73}, -- Day
            {0, 219, 219}, -- Day Horizon
            {222, 222, 222}, -- Sun Tint
            {87, 61, 250}, -- Moon Tint
        }
    },
    icesheet_ocean = {
        name = "Icesheet",
        colors = {
            {16, 94, 169}, -- Day
            {39, 152, 185}, -- Day Horizon
            {222, 222, 222}, -- Sun Tint
            {87, 61, 250}, -- Moon Tint
        }
    },
    icesheet_under = {
        name = "Underground",
        colors = {
            {192, 192, 192}, -- Day
            {128, 128, 128}, -- Day Horizon
            {222, 222, 222}, -- Sun Tint
            {87, 61, 250}, -- Moon Tint
        }
    },
    tundra_highland = {
        name = "Tundra",
        colors = {
            {0, 36, 36}, -- Day
            {17, 144, 180}, -- Day Horizon
            {204, 204, 0}, -- Sun Tint
            {88, 48, 125}, -- Moon Tint
        }
    },
    tundra = {
        name = "Tundra",
        colors = {
            {44, 59, 154}, -- Day
            {16, 135, 169}, -- Day Horizon
            {204, 204, 0}, -- Sun Tint
            {88, 48, 125}, -- Moon Tint
        }
    },
    tundra_beach = {
        name = "Tundra",
        colors = {
            {76, 76, 76}, -- Day
            {164, 164, 164}, -- Day Horizon
            {204, 204, 0}, -- Sun Tint
            {88, 48, 125}, -- Moon Tint
        }
    },
    tundra_ocean = {
        name = "Tundra",
        colors = {
            {44, 44, 44}, -- Day
            {16, 94, 169}, -- Day Horizon
            {204, 204, 0}, -- Sun Tint
            {88, 48, 125}, -- Moon Tint
        }
    },
    tundra_under = {
        name = "Underground",
        colors = {
            {192, 192, 192}, -- Day
            {128, 128, 128}, -- Day Horizon
            {204, 204, 0}, -- Sun Tint
            {88, 48, 125}, -- Moon Tint
        }
    },
    sandstone_desert = {
        name = "Sandstone Desert",
        colors = {
            {169, 209, 248}, -- Day
            {206, 201, 156}, -- Day Horizon
            {244, 190, 0}, -- Sun Tint
            {44, 59, 154}, -- Moon Tint
        }
    },
    sandstone_desert_ocean = {
        name = "Sandstone Desert",
        colors = {
            {61, 126, 186}, -- Day
            {191, 186, 129}, -- Day Horizon
            {244, 190, 0}, -- Sun Tint
            {44, 59, 154}, -- Moon Tint
        }
    },
    sandstone_desert_under = {
        name = "Underground",
        colors = {
            {192, 192, 192}, -- Day
            {128, 128, 128}, -- Day Horizon
            {244, 190, 0}, -- Sun Tint
            {44, 59, 154}, -- Moon Tint
        }
    },
    savanna = {
        name = "Savanna",
        colors = {
            {34, 112, 184}, -- Day
            {236, 190, 152}, -- Day Horizon
            {170, 24, 0}, -- Sun Tint
            {53, 29, 75}, -- Moon Tint
        }
    },
    savanna_shore = {
        name = "Savanna",
        colors = {
            {62, 157, 185}, -- Day
            {224, 134, 110}, -- Day Horizon
            {170, 24, 0}, -- Sun Tint
            {53, 29, 75}, -- Moon Tint
        }
    },
    savanna_ocean = {
        name = "Savanna",
        colors = {
            {34, 112, 184}, -- Day
            {238, 192, 0}, -- Day Horizon
            {170, 24, 0}, -- Sun Tint
            {53, 29, 75}, -- Moon Tint
        }
    },
    savanna_under = {
        name = "Underground",
        colors = {
            {192, 192, 192}, -- Day
            {128, 128, 128}, -- Day Horizon
            {170, 24, 0}, -- Sun Tint
            {53, 29, 75}, -- Moon Tint
        }
    },
    chalk_grassland = {
        name = "Chalk Grassland",
        colors = {
            {48, 48, 48}, -- Day
            {75, 74, 70}, -- Day Horizon
            {79, 63, 28}, -- Sun Tint
            {51, 53, 81}, -- Moon Tint
        }
    },
    chalk_grassland_ocean = {
        name = "Chalk Grassland",
        colors = {
            {50, 50, 50}, -- Day
            {13, 44, 72}, -- Day Horizon
            {79, 63, 28}, -- Sun Tint
            {51, 53, 81}, -- Moon Tint
        }
    },
    underground = {
        name = "Underground",
        colors = {
            {240, 240, 240}, -- Day
            {192, 192, 192}, -- Day Horizon
            {230, 230, 230}, -- Sun Tint
            {160, 160, 160}, -- Moon Tint
            {0, 0, 0}, -- Indoors
        }
    },
    hell = {
        name = "Hell",
        colors = {
            {93, 13, 0}, -- Day
            {38, 9, 0}, -- Day Horizon
            {93, 13, 0}, -- Sun Tint
            {27, 9, 0}, -- Moon Tint
            {71, 8, 0}, -- Indoors
        }
    },
}