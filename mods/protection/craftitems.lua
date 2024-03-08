minetest.register_craftitem("protection:lost_mese_core", {
    description = ccore.comment("Lost Mese Core", "Radiating location data"),
    inventory_image = "protection_lost_mese_core.png"
})
minetest.register_craftitem("protection:lost_mese_flare", {
    description = ccore.comment("Lost Mese Flare", "Emits some kind of a signal"),
    inventory_image = "protection_lost_mese_flare.png"
})
minetest.register_craftitem("protection:map_display", {
    description = ccore.comment("Map Display", "Displays results of protection calculations"),
    inventory_image = "protection_map_display.png"
})