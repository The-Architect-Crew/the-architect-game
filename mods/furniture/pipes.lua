local S = default.get_translator

furniture.small_pipe = {
    fixed           =   {{-2/16, -1/16, -1/16, 2/16, 1/16, 1/16}, {-1/16, -2/16, -1/16, 1/16, 2/16, 1/16}, {-1/16, -1/16, -2/16, 1/16, 1/16, 2/16}},
    connect_bottom  =   {{-2/16, -8/16, -1/16,  2/16, 0/16, 1/16}, {-1/16, -8/16, -2/16,  1/16, 0/16, 2/16},
                        {-3/16, -1/16, -2/16,  3/16, 0/16, 2/16}, {-2/16, -1/16, -3/16,  2/16, 0/16, 3/16}, {-2/16, -1/16, -2/16,  2/16, 0/16, 2/16}},
    connect_top     =   {{-2/16, 0/16, -1/16,  2/16, 8/16, 1/16}, {-1/16, 0/16, -2/16,  1/16, 8/16, 2/16},
                        {-3/16, 0/16, -2/16,  3/16, 1/16, 2/16}, {-2/16, 0/16, -3/16,  2/16, 1/16, 3/16}, {-2/16, 0/16, -2/16,  2/16, 1/16, 2/16}},
    connect_back    =   {{-2/16, -1/16, 0/16,  2/16, 1/16, 8/16}, {-1/16, -2/16, 0/16,  1/16, 2/16, 8/16},
                        {-3/16, -2/16, 0/16,  3/16, 2/16, 1/16}, {-2/16, -3/16, 0/16,  2/16, 3/16, 1/16}, {-2/16, -2/16, 0/16,  2/16, 2/16, 1/16}},
    connect_front   =   {{-2/16, -1/16, -8/16,  2/16, 1/16, 0/16}, {-1/16, -2/16, -8/16,  1/16, 2/16, 0/16},
                        {-3/16, -2/16, -1/16,  3/16, 2/16, 0/16}, {-2/16, -3/16, -1/16,  2/16, 3/16, 0/16}, {-2/16, -2/16, -1/16,  2/16, 2/16, 0/16}},
    connect_right   =   {{0/16, -1/16, -2/16,  8/16, 1/16, 2/16}, {0/16, -2/16, -1/16,  8/16, 2/16, 1/16},
                        {0/16, -2/16, -3/16,  1/16, 2/16, 3/16}, {0/16, -3/16, -2/16,  1/16, 3/16, 2/16}, {0/16, -2/16, -2/16,  1/16, 2/16, 2/16}},
    connect_left    =   {{-8/16, -1/16, -2/16,  0/16, 1/16, 2/16}, {-8/16, -2/16, -1/16,  0/16, 2/16, 1/16},
                        {-1/16, -2/16, -3/16,  0/16, 2/16, 3/16}, {-1/16, -3/16, -2/16,  0/16, 3/16, 2/16}, {-1/16, -2/16, -2/16,  0/16, 2/16, 2/16}},
}

furniture.small_pipe_clean = {
    fixed           =   {{-2/16, -1/16, -1/16, 2/16, 1/16, 1/16}, {-1/16, -2/16, -1/16, 1/16, 2/16, 1/16}, {-1/16, -1/16, -2/16, 1/16, 1/16, 2/16}},
    connect_bottom  =   {{-2/16, -8/16, -1/16,  2/16, 0/16, 1/16}, {-1/16, -8/16, -2/16,  1/16, 0/16, 2/16}},
    connect_top     =   {{-2/16, 0/16, -1/16,  2/16, 8/16, 1/16}, {-1/16, 0/16, -2/16,  1/16, 8/16, 2/16}},
    connect_back    =   {{-2/16, -1/16, 0/16,  2/16, 1/16, 8/16}, {-1/16, -2/16, 0/16,  1/16, 2/16, 8/16}},
    connect_front   =   {{-2/16, -1/16, -8/16,  2/16, 1/16, 0/16}, {-1/16, -2/16, -8/16,  1/16, 2/16, 0/16}},
    connect_right   =   {{0/16, -1/16, -2/16,  8/16, 1/16, 2/16}, {0/16, -2/16, -1/16,  8/16, 2/16, 1/16}},
    connect_left    =   {{-8/16, -1/16, -2/16,  0/16, 1/16, 2/16}, {-8/16, -2/16, -1/16,  0/16, 2/16, 1/16}},
}

furniture.big_pipe = {
    fixed           =   {{-4/16, -4/16, -4/16, 4/16, 4/16, 4/16}, {-3/16, -3/16, -5/16, 3/16, 3/16, 5/16}, {-3/16, -5/16, -3/16, 3/16, 5/16, 3/16}, {-5/16, -3/16, -3/16, 5/16, 3/16, 3/16}},
    connect_bottom  =   {{-6/16, -8/16, -3/16,  6/16, 0/16, 3/16}, {-3/16, -8/16, -6/16,  3/16, 0/16, 6/16}, {-5/16, -8/16, -4/16,  5/16, 0/16, 4/16}, {-4/16, -8/16, -5/16,  4/16, 0/16, 5/16},
                        {-7/16, -2/16, -4/16,  7/16, 0/16, 4/16}, {-4/16, -2/16, -7/16,  4/16, 0/16, 7/16}, {-6/16, -2/16, -5/16,  6/16, 0/16, 5/16}, {-5/16, -2/16, -6/16,  5/16, 0/16, 6/16}},
    connect_top     =   {{-6/16, 0/16, -3/16,  6/16, 8/16, 3/16}, {-3/16, 0/16, -6/16,  3/16, 8/16, 6/16}, {-5/16, 0/16, -4/16,  5/16, 8/16, 4/16}, {-4/16, 0/16, -5/16,  4/16, 8/16, 5/16},
                        {-7/16, 0/16, -4/16,  7/16, 2/16, 4/16}, {-4/16, 0/16, -7/16,  4/16, 2/16, 7/16}, {-6/16, 0/16, -5/16,  6/16, 2/16, 5/16}, {-5/16, 0/16, -6/16,  5/16, 2/16, 6/16}},
    connect_back    =   {{-6/16, -3/16, 0/16,  6/16, 3/16, 8/16}, {-3/16, -6/16, 0/16,  3/16, 6/16, 8/16}, {-5/16, -4/16, 0/16,  5/16, 4/16, 8/16}, {-4/16, -5/16, 0/16,  4/16, 5/16, 8/16},
                        {-7/16, -4/16, 0/16,  7/16, 4/16, 2/16}, {-4/16, -7/16, 0/16,  4/16, 7/16, 2/16}, {-6/16, -5/16, 0/16,  6/16, 5/16, 2/16}, {-5/16, -6/16, 0/16,  5/16, 6/16, 2/16}},
    connect_front   =   {{-6/16, -3/16, -8/16,  6/16, 3/16, 0/16}, {-3/16, -6/16, -8/16,  3/16, 6/16, 0/16}, {-5/16, -4/16, -8/16,  5/16, 4/16, 0/16}, {-4/16, -5/16, -8/16,  4/16, 5/16, 0/16},
                        {-7/16, -4/16, -2/16,  7/16, 4/16, 0/16}, {-4/16, -7/16, -2/16,  4/16, 7/16, 0/16}, {-6/16, -5/16, -2/16,  6/16, 5/16, 0/16}, {-5/16, -6/16, -2/16,  5/16, 6/16, 0/16}},
    connect_right   =   {{0/16, -3/16, -6/16,  8/16, 3/16, 6/16}, {0/16, -6/16, -3/16,  8/16, 6/16, 3/16}, {0/16, -4/16, -5/16,  8/16, 4/16, 5/16}, {0/16, -5/16, -4/16,  8/16, 5/16, 4/16},
                        {0/16, -4/16, -7/16,  2/16, 4/16, 7/16}, {0/16, -7/16, -4/16,  2/16, 7/16, 4/16}, {0/16, -5/16, -6/16,  2/16, 5/16, 6/16}, {0/16, -6/16, -5/16,  2/16, 6/16, 5/16}},
    connect_left    =   {{-8/16, -3/16, -6/16,  0/16, 3/16, 6/16}, {-8/16, -6/16, -3/16,  0/16, 6/16, 3/16}, {-8/16, -4/16, -5/16,  0/16, 4/16, 5/16}, {-8/16, -5/16, -4/16,  0/16, 5/16, 4/16},
                        {-2/16, -4/16, -7/16,  0/16, 4/16, 7/16}, {-2/16, -7/16, -4/16,  0/16, 7/16, 4/16}, {-2/16, -5/16, -6/16,  0/16, 5/16, 6/16}, {-2/16, -6/16, -5/16,  0/16, 6/16, 5/16}},
}

furniture.big_pipe_clean = {
    fixed           =   {{-4/16, -4/16, -4/16, 4/16, 4/16, 4/16}, {-3/16, -3/16, -5/16, 3/16, 3/16, 5/16}, {-3/16, -5/16, -3/16, 3/16, 5/16, 3/16}, {-5/16, -3/16, -3/16, 5/16, 3/16, 3/16}},
    connect_bottom  =   {{-6/16, -8/16, -3/16,  6/16, 0/16, 3/16}, {-3/16, -8/16, -6/16,  3/16, 0/16, 6/16}, {-5/16, -8/16, -4/16,  5/16, 0/16, 4/16}, {-4/16, -8/16, -5/16,  4/16, 0/16, 5/16}},
    connect_top     =   {{-6/16, 0/16, -3/16,  6/16, 8/16, 3/16}, {-3/16, 0/16, -6/16,  3/16, 8/16, 6/16}, {-5/16, 0/16, -4/16,  5/16, 8/16, 4/16}, {-4/16, 0/16, -5/16,  4/16, 8/16, 5/16}},
    connect_back    =   {{-6/16, -3/16, 0/16,  6/16, 3/16, 8/16}, {-3/16, -6/16, 0/16,  3/16, 6/16, 8/16}, {-5/16, -4/16, 0/16,  5/16, 4/16, 8/16}, {-4/16, -5/16, 0/16,  4/16, 5/16, 8/16}},
    connect_front   =   {{-6/16, -3/16, -8/16,  6/16, 3/16, 0/16}, {-3/16, -6/16, -8/16,  3/16, 6/16, 0/16}, {-5/16, -4/16, -8/16,  5/16, 4/16, 0/16}, {-4/16, -5/16, -8/16,  4/16, 5/16, 0/16}},
    connect_right   =   {{0/16, -3/16, -6/16,  8/16, 3/16, 6/16}, {0/16, -6/16, -3/16,  8/16, 6/16, 3/16}, {0/16, -4/16, -5/16,  8/16, 4/16, 5/16}, {0/16, -5/16, -4/16,  8/16, 5/16, 4/16}},
    connect_left    =   {{-8/16, -3/16, -6/16,  0/16, 3/16, 6/16}, {-8/16, -6/16, -3/16,  0/16, 6/16, 3/16}, {-8/16, -4/16, -5/16,  0/16, 4/16, 5/16}, {-8/16, -5/16, -4/16,  0/16, 5/16, 4/16}},
}

furniture.register_pipes = function(base_node)

    local base_definition = minetest.registered_nodes[base_node]
    local base_description = base_definition.description
    local base_groups = base_definition.groups
    local base_sounds = base_definition.sounds
    local sname = string.match(base_node, ':(.*)')

    minetest.register_node("furniture:pipe_" .. sname, {
    description = S(base_description .. " Pipe"),
	tiles = {"furniture_pipe_" .. sname .. ".png"},
    paramtype = "light",
    drawtype = "nodebox",
    node_box = {
        type = "connected",
        fixed = furniture.small_pipe.fixed,
        connect_top = furniture.small_pipe.connect_top,
        connect_bottom = furniture.small_pipe.connect_bottom,
        connect_front = furniture.small_pipe.connect_front,
        connect_back = furniture.small_pipe.connect_back,
        connect_left = furniture.small_pipe.connect_left,
        connect_right = furniture.small_pipe.connect_right,
    },
    sunlight_propagates = true,
    connects_to = {"group:pipes_connect"},
    groups = base_groups,
    sounds = base_sounds
    })

    minetest.register_node("furniture:pipe_" .. sname .. "_vertical", {
        description = S(base_description .. " Vertical Pipe"),
        tiles = {"furniture_pipe_" .. sname .. ".png"},
        paramtype = "light",
        drawtype = "nodebox",
        node_box = {
            type = "connected",
            fixed = furniture.small_pipe.fixed,
            connect_top = furniture.small_pipe.connect_top,
            connect_bottom = furniture.small_pipe.connect_bottom,
        },
        sunlight_propagates = true,
        connects_to = {"group:pipes_connect"},
        groups = base_groups,
        sounds = base_sounds
        })

    minetest.register_node("furniture:pipe_" .. sname .. "_horizontal", {
        description = S(base_description .. " Horizontal Pipe"),
        tiles = {"furniture_pipe_" .. sname .. ".png"},
        paramtype = "light",
        drawtype = "nodebox",
        node_box = {
            type = "connected",
            fixed = furniture.small_pipe.fixed,
            connect_front = furniture.small_pipe.connect_front,
            connect_back = furniture.small_pipe.connect_back,
            connect_left = furniture.small_pipe.connect_left,
            connect_right = furniture.small_pipe.connect_right,
        },
        sunlight_propagates = true,
        connects_to = {"group:pipes_connect"},
        groups = base_groups,
        sounds = base_sounds
    })

    minetest.register_node("furniture:seamless_pipe_" .. sname, {
        description = S(base_description .. " Seamless Pipe"),
        tiles = {"furniture_pipe_" .. sname .. ".png"},
        paramtype = "light",
        drawtype = "nodebox",
        node_box = {
            type = "connected",
            fixed = furniture.small_pipe_clean.fixed,
            connect_top = furniture.small_pipe_clean.connect_top,
            connect_bottom = furniture.small_pipe_clean.connect_bottom,
            connect_front = furniture.small_pipe_clean.connect_front,
            connect_back = furniture.small_pipe_clean.connect_back,
            connect_left = furniture.small_pipe_clean.connect_left,
            connect_right = furniture.small_pipe_clean.connect_right,
        },
        sunlight_propagates = true,
        connects_to = {"group:pipes_connect"},
        groups = base_groups,
        sounds = base_sounds
        })

    minetest.register_node("furniture:seamless_pipe_" .. sname .. "_vertical", {
        description = S(base_description .. " Seamless Vertical Pipe"),
        tiles = {"furniture_pipe_" .. sname .. ".png"},
        paramtype = "light",
        drawtype = "nodebox",
        node_box = {
            type = "connected",
            fixed = furniture.small_pipe_clean.fixed,
            connect_top = furniture.small_pipe_clean.connect_top,
            connect_bottom = furniture.small_pipe_clean.connect_bottom,
        },
        sunlight_propagates = true,
        connects_to = {"group:pipes_connect"},
        groups = base_groups,
        sounds = base_sounds
        })

    minetest.register_node("furniture:seamless_pipe_" .. sname .. "_horizontal", {
        description = S(base_description .. " Seamless Horizontal Pipe"),
        tiles = {"furniture_pipe_" .. sname .. ".png"},
        paramtype = "light",
        drawtype = "nodebox",
        node_box = {
            type = "connected",
            fixed = furniture.small_pipe_clean.fixed,
            connect_front = furniture.small_pipe_clean.connect_front,
            connect_back = furniture.small_pipe_clean.connect_back,
            connect_left = furniture.small_pipe_clean.connect_left,
            connect_right = furniture.small_pipe_clean.connect_right,
        },
        sunlight_propagates = true,
        connects_to = {"group:pipes_connect"},
        groups = base_groups,
        sounds = base_sounds
    })

    -- Big pipes

    minetest.register_node("furniture:big_pipe_" .. sname, {
        description = S(base_description .. " Big Pipe"),
        tiles = {"furniture_pipe_" .. sname .. ".png"},
        paramtype = "light",
        drawtype = "nodebox",
        node_box = {
            type = "connected",
            fixed = furniture.big_pipe.fixed,
            connect_top = furniture.big_pipe.connect_top,
            connect_bottom = furniture.big_pipe.connect_bottom,
            connect_front = furniture.big_pipe.connect_front,
            connect_back = furniture.big_pipe.connect_back,
            connect_left = furniture.big_pipe.connect_left,
            connect_right = furniture.big_pipe.connect_right,
        },
        sunlight_propagates = true,
        connects_to = {"group:pipes_connect"},
        groups = base_groups,
        sounds = base_sounds
        })

    minetest.register_node("furniture:big_pipe_" .. sname .. "_vertical", {
        description = S(base_description .. " Big Vertical Pipe"),
        tiles = {"furniture_pipe_" .. sname .. ".png"},
        paramtype = "light",
        drawtype = "nodebox",
        node_box = {
            type = "connected",
            fixed = furniture.big_pipe.fixed,
            connect_top = furniture.big_pipe.connect_top,
            connect_bottom = furniture.big_pipe.connect_bottom,
        },
        sunlight_propagates = true,
        connects_to = {"group:pipes_connect"},
        groups = base_groups,
        sounds = base_sounds
        })

    minetest.register_node("furniture:big_pipe_" .. sname .. "_horizontal", {
        description = S(base_description .. " Big Horizontal Pipe"),
        tiles = {"furniture_pipe_" .. sname .. ".png"},
        paramtype = "light",
        drawtype = "nodebox",
        node_box = {
            type = "connected",
            fixed = furniture.big_pipe.fixed,
            connect_front = furniture.big_pipe.connect_front,
            connect_back = furniture.big_pipe.connect_back,
            connect_left = furniture.big_pipe.connect_left,
            connect_right = furniture.big_pipe.connect_right,
        },
        sunlight_propagates = true,
        connects_to = {"group:pipes_connect"},
        groups = base_groups,
        sounds = base_sounds
    })

    minetest.register_node("furniture:seamless_big_pipe_" .. sname, {
        description = S(base_description .. " Big Seamless Pipe"),
        tiles = {"furniture_pipe_" .. sname .. ".png"},
        paramtype = "light",
        drawtype = "nodebox",
        node_box = {
            type = "connected",
            fixed = furniture.big_pipe_clean.fixed,
            connect_top = furniture.big_pipe_clean.connect_top,
            connect_bottom = furniture.big_pipe_clean.connect_bottom,
            connect_front = furniture.big_pipe_clean.connect_front,
            connect_back = furniture.big_pipe_clean.connect_back,
            connect_left = furniture.big_pipe_clean.connect_left,
            connect_right = furniture.big_pipe_clean.connect_right,
        },
        sunlight_propagates = true,
        connects_to = {"group:pipes_connect"},
        groups = base_groups,
        sounds = base_sounds
        })

    minetest.register_node("furniture:seamless_big_pipe_" .. sname .. "_vertical", {
        description = S(base_description .. " Big Seamless Vertical Pipe"),
        tiles = {"furniture_pipe_" .. sname .. ".png"},
        paramtype = "light",
        drawtype = "nodebox",
        node_box = {
            type = "connected",
            fixed = furniture.big_pipe_clean.fixed,
            connect_top = furniture.big_pipe_clean.connect_top,
            connect_bottom = furniture.big_pipe_clean.connect_bottom,
        },
        sunlight_propagates = true,
        connects_to = {"group:pipes_connect"},
        groups = base_groups,
        sounds = base_sounds
        })
  
    minetest.register_node("furniture:seamless_big_pipe_" .. sname .. "_horizontal", {
        description = S(base_description .. " Big Seamless Horizontal Pipe"),
        tiles = {"furniture_pipe_" .. sname .. ".png"},
        paramtype = "light",
        drawtype = "nodebox",
        node_box = {
            type = "connected",
            fixed = furniture.big_pipe_clean.fixed,
            connect_front = furniture.big_pipe_clean.connect_front,
            connect_back = furniture.big_pipe_clean.connect_back,
            connect_left = furniture.big_pipe_clean.connect_left,
            connect_right = furniture.big_pipe_clean.connect_right,
        },
        sunlight_propagates = true,
        connects_to = {"group:pipes_connect"},
        groups = base_groups,
        sounds = base_sounds
    })

end

furniture.register_pipes("blocks:copperblock")
furniture.register_pipes("blocks:steelblock")
furniture.register_pipes("blocks:rustblock")
