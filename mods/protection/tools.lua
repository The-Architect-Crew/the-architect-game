minetest.register_craftitem("protection:block_checker", {
    description = "Protection Block Checker \n (Checks Protection Blocks)",
    inventory_image = "blocks_book.png",
    on_use = function(itemstack, user, pointed_thing)
        local pos = pointed_thing.under
        local block_data = protection.get_grid_block(pos)
        if user:is_player() then
            local name = user:get_player_name()
            minetest.chat_send_player(name, "This node belongs to the block: " .. block_data.center.x .. " " .. block_data.center.y .. " " .. block_data.center.z .. ".")
            areas:setPos1(name, block_data.pos1)
            areas:setPos2(name, block_data.pos2)
        end
        return nil
    end
})