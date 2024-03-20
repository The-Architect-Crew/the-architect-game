furniture.furnace_materials = {
	{"blocks:stone", "blocks:cobble"},
	{"blocks:desert_stone", "blocks:desert_cobble"},
	{"blocks:sandstone", "blocks:sandstone"},
	{"blocks:obsidian", "blocks:obsidian"},
    {"blocks:basalt", "blocks:basalt_cobble"},
	{"blocks:steelblock", "blocks:steel_ingot"},
	{"blocks:rustblock", "blocks:rust_ingot"}
}

for i=1,#furniture.furnace_materials do
    local material = furniture.furnace_materials[i][1]
    local crafting_material = furniture.furnace_materials[i][2]
	local sname = string.match(material, ':(.*)')

    workbench.register_furnace("furniture", material)

    minetest.register_craft({
        output = "furniture:furnace_" .. sname,
        recipe = {
            {crafting_material, crafting_material, crafting_material},
            {crafting_material, "", crafting_material},
            {crafting_material, crafting_material, crafting_material},
        }
    })
end

