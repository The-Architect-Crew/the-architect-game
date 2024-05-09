minetest.register_craftitem("travelnet:core_uplink", {
	description = "Travelnet Uplink Core",
	inventory_image = "travelnet_uplink.png",
})

minetest.register_craft({
    output = "travelnet:core_uplink",
    recipe = {
        {"", "blocks:steelblock", ""},
        {"furniture:gear", "blocks:mese", "furniture:gear"},
        {"", "furniture:gear", ""},
    }
})

for i=1,#travelnet.materials do
    local material = travelnet.materials[i]
    local secondary_material = false
    if type(material) == "table" then
        secondary_material = material[2]
        material = material[1]
    end
    local sname = string.match(material, ':(.*)')
    if secondary_material then
        secondary_material = string.match(secondary_material, ':(.*)')
    else
        secondary_material = "steelblock"
    end

    minetest.register_craft({
        output = "travelnet:station_" .. sname,
        recipe = {
            {"blocks:" .. sname, "blocks:" .. secondary_material, "blocks:" .. sname},
            {"furniture:gear", "travelnet:core_uplink", "blocks:glass"},
            {"blocks:" .. sname, "blocks:" .. secondary_material, "blocks:" .. sname},
        }
    })
end