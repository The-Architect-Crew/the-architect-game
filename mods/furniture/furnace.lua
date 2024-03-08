furniture.furnace_materials = {
	"blocks:stone",
	"blocks:desert_stone",
	"blocks:sandstone",
	"blocks:obsidian",
    "blocks:basalt",
	"blocks:steelblock",
	"blocks:rustblock"
}

for i=1,#furniture.furnace_materials do
    local material = furniture.furnace_materials[i]
	local sname = string.match(material, ':(.*)')

    workbench.register_furnace("furniture", material)

    minetest.register_craft({
        output = "workbench:furnace_" .. sname,
        recipe = {
            {material, material, material},
            {material, "", material},
            {material, material, material},
        }
    })
end

