-- Quest items and recipes that make up the moonlight quest

minetest.register_craftitem("quests:moonlight_inactive", {
	description = ccore.comment("Moonlight Husk", "Requires activation"),
	inventory_image = "quests_moonlight_inactive.png",
})
minetest.register_craftitem("quests:moonlight_head", {
	description = ccore.comment("Moonlight Head", "Weirdly, it doesn't seem to glow anymore..."),
	inventory_image = "quests_moonlight_head.png",
})
minetest.register_craftitem("quests:moonlight_binding", {
	description = ccore.comment("Moonlight Binding", "Forged from hardened gold and equipped with a few alien trinkets"),
	inventory_image = "quests_moonlight_binding_filled.png",
})
minetest.register_craftitem("quests:moonlight_binding_base", {
	description = ccore.comment("Moonlight Binding Base", "A perfect fit for some peculiar mechanisms"),
	inventory_image = "quests_moonlight_binding_base.png",
})
minetest.register_craftitem("quests:moonlight_handle", {
	description = ccore.comment("Moonlight Handle Module", "Contains the balancing mechanisms"),
	inventory_image = "quests_moonlight_handle.png",
})
minetest.register_craftitem("quests:moonstone_focus_bound", {
	description = ccore.comment("Bound Moonstone Focus", "The most advanced moonlight focusing device"),
	inventory_image = "quests_moonstone_focus_bound.png",
})
minetest.register_craftitem("quests:moonstone_focus", {
	description = ccore.comment("Moonstone Focus", "The lens have self-formed"),
	inventory_image = "quests_moonstone_focus.png",
})
minetest.register_craftitem("quests:obsidian_heart_broken", {
	description = ccore.comment("Broken Obsidian Heart", "Somehow still pretty much in one piece"),
	inventory_image = "quests_obsidian_heart_broken.png",
})
minetest.register_craftitem("quests:obsidian_heart", {
	description = ccore.comment("Obsidian Heart", "A faint beating is heard from the inside"),
	inventory_image = "quests_obsidian_heart.png",
})
minetest.register_craftitem("quests:melted_moonstone", {
	description = ccore.comment("Melted Moonstone", "Whats up with the screaming?"),
	inventory_image = "quests_melted_moonstone.png",
})
minetest.register_craftitem("quests:moonstone_essence", {
	description = ccore.comment("Moonstone Essence", "It is crying, loudly"),
	inventory_image = "quests_moonstone_essence.png",
})
minetest.register_craftitem("quests:inverted_moonstone_essence", {
	description = ccore.comment("Inverted Moonstone Essence", "It is producing a constant ear-shattering scream"),
	inventory_image = "quests_inverted_moonstone_essence.png",
})
minetest.register_craftitem("quests:inverted_moonstone_crystal", {
	description = ccore.comment("Inverted Moonstone Crystal", "Its very presence is unbearable.\nIt also feels very, very wrong"),
	inventory_image = "quests_inverted_moonstone_crystal.png",
})
minetest.register_craftitem("quests:moonstone_binding", {
	description = ccore.comment("Moonstone Binding", "Weightless"),
	inventory_image = "quests_moonstone_binding.png",
})
minetest.register_craftitem("quests:polished_moonstone_fragments", {
	description = ccore.comment("Polished Moonstone Fragments", "Shiny"),
	inventory_image = "quests_polished_moonstone_fragments.png",
})
minetest.register_craftitem("quests:polished_moonstone_crystal", {
	description = ccore.comment("Polished Moonstone Crystal", "Reflects everything but moonlight"),
	inventory_image = "quests_polished_moonstone_crystal.png",
})
minetest.register_craftitem("quests:hardened_moonstone", {
	description = ccore.comment("Hardened Moonstone", "The lattice is forming"),
	inventory_image = "quests_hardened_moonstone.png",
})
minetest.register_craftitem("quests:unbreakable_moonstone", {
	description = ccore.comment("Unbreakable Moonstone", "Unbreakable, but mese can probably erode it"),
	inventory_image = "quests_unbreakable_moonstone.png",
})
minetest.register_craftitem("quests:hardened_gold_lump", {
	description = ccore.comment("Hardened Gold Lump", "An alloy made according to the ancient recipe"),
	inventory_image = "quests_hardened_gold_lump.png",
})
minetest.register_craftitem("quests:hardened_gold_ingot", {
	description = ccore.comment("Hardened Gold Ingot", "Very hard, seems to vibrate"),
	inventory_image = "quests_hardened_gold_ingot.png",
})

-- Crafting

minetest.register_craft({
	output = "quests:moonlight_inactive",
	recipe = {
		{"quests:moonlight_head"},
        {"quests:moonlight_binding"},
	}
})
minetest.register_craft({
	output = "quests:moonlight_binding",
	recipe = {
		{"quests:hardened_gold_ingot", "quests:moonstone_focus_bound", "quests:hardened_gold_ingot"},
        {"", "quests:moonlight_binding_base", ""},
        {"quests:hardened_gold_ingot", "quests:moonlight_handle", "quests:hardened_gold_ingot"},
	}
})
minetest.register_craft({
	output = "quests:moonlight_binding_base",
	recipe = {
		{"quests:hardened_gold_ingot", "quests:hardened_gold_ingot", "quests:hardened_gold_ingot"},
        {"", "quests:hardened_gold_ingot", ""},
        {"", "quests:hardened_gold_ingot", ""},
	}
})
minetest.register_craft({
	output = "quests:moonlight_head",
	recipe = {
        {"quests:melted_moonstone", "quests:melted_moonstone", "quests:melted_moonstone"},
		{"quests:unbreakable_moonstone", "quests:unbreakable_moonstone", "quests:unbreakable_moonstone"},
        {"quests:melted_moonstone", "quests:melted_moonstone", "quests:melted_moonstone"},
	}
})
minetest.register_craft({
	output = "quests:moonlight_handle",
	recipe = {
		{"quests:hardened_gold_ingot", "quests:polished_moonstone_crystal", "quests:hardened_gold_ingot"},
        {"quests:hardened_gold_ingot", "blocks:moonstone_powder", "quests:hardened_gold_ingot"},
        {"quests:hardened_gold_ingot", "quests:polished_moonstone_crystal", "quests:hardened_gold_ingot"},
	}
})
minetest.register_craft({
	output = "quests:moonstone_focus_bound",
	recipe = {
		{"quests:hardened_gold_ingot", "blocks:moonstone_powder", "quests:hardened_gold_ingot"},
        {"quests:hardened_gold_ingot", "quests:moonstone_focus", "quests:hardened_gold_ingot"},
        {"quests:hardened_gold_ingot", "blocks:moonstone_powder", "quests:hardened_gold_ingot"},
	}
})
minetest.register_craft({
	output = "quests:moonstone_focus",
	recipe = {
		{"quests:polished_moonstone_crystal", "quests:inverted_moonstone_crystal", "quests:polished_moonstone_crystal"},
        {"blocks:moonstone_powder", "quests:obsidian_heart_broken", "blocks:moonstone_powder"},
        {"quests:polished_moonstone_crystal", "quests:inverted_moonstone_crystal", "quests:polished_moonstone_crystal"},
	}
})
minetest.register_craft({
	output = "quests:obsidian_heart",
	recipe = {
		{"blocks:obsidian", "blocks:obsidian", "blocks:obsidian"},
        {"blocks:obsidian", "bucket_lava", "blocks:obsidian"},
        {"blocks:obsidian", "blocks:obsidian", "blocks:obsidian"},
	}
})
minetest.register_craft({
	output = "quests:polished_moonstone_crystal",
	recipe = {
		{"quests:polished_moonstone_fragments", "quests:polished_moonstone_fragments", "quests:polished_moonstone_fragments"},
	}
})
minetest.register_craft({
	output = "quests:polished_moonstone_fragments",
	recipe = {
		{"blocks:moonstone_crystal", "blocks:moonstone_powder", "blocks:moonstone_crystal"},
        {"blocks:moonstone_powder", "blocks:moonstone_powder", "blocks:moonstone_powder"},
        {"blocks:moonstone_crystal", "blocks:moonstone_powder", "blocks:moonstone_crystal"},
	}
})
minetest.register_craft({
	output = "quests:inverted_moonstone_essence",
	recipe = {
		{"blocks:mese_crystal_fragment", "", "blocks:mese_crystal_fragment"},
        {"", "quests:moonstone_essence", ""},
        {"blocks:mese_crystal_fragment", "", "blocks:mese_crystal_fragment"},
	}
})
minetest.register_craft({
	output = "quests:inverted_moonstone_crystal",
	recipe = {
		{"blocks:mese_crystal", "quests:inverted_moonstone_essence", "blocks:mese_crystal"},
        {"quests:inverted_moonstone_essence", "quests:inverted_moonstone_essence", "quests:inverted_moonstone_essence"},
        {"blocks:mese_crystal", "quests:inverted_moonstone_essence", "blocks:mese_crystal"},
	}
})
minetest.register_craft({
	output = "quests:moonstone_binding 2",
	recipe = {
		{"blocks:silver_ingot", "blocks:tin_ingot", "blocks:silver_ingot"},
        {"blocks:tin_ingot", "blocks:silver_ingot", "blocks:tin_ingot"},
	}
})
minetest.register_craft({
	output = "quests:hardened_moonstone",
	recipe = {
		{"", "quests:moonstone_binding", ""},
        {"quests:inverted_moonstone_crystal", "blocks:moonstone", "quests:inverted_moonstone_crystal"},
        {"", "quests:moonstone_binding", ""},
	}
})
minetest.register_craft({
	output = "quests:hardened_gold_lump",
	recipe = {
		{"blocks:silver_ingot", "blocks:mithril_ingot", "blocks:silver_ingot"},
        {"blocks:mithril_ingot", "blocks:gold_ingot", "blocks:mithril_ingot"},
        {"blocks:mithril_ingot", "blocks:mithril_ingot", "blocks:mithril_ingot"},
	}
})

-- Cooking

minetest.register_craft({
	type = "cooking",
	output = "quests:obsidian_heart_broken",
	recipe = "quests:obsidian_heart",
    cooktime = 12,
})
minetest.register_craft({
	type = "cooking",
	output = "quests:melted_moonstone",
	recipe = "blocks:moonstone_crystal",
    cooktime = 2,
})
minetest.register_craft({
	type = "cooking",
	output = "quests:moonstone_essence",
	recipe = "quests:melted_moonstone",
    cooktime = 6,
})
minetest.register_craft({
	type = "cooking",
	output = "quests:unbreakable_moonstone",
	recipe = "quests:hardened_moonstone",
    cooktime = 24,
})
minetest.register_craft({
	type = "cooking",
	output = "quests:hardened_gold_ingot",
	recipe = "quests:hardened_gold_lump",
    cooktime = 12,
})
minetest.register_craft({
	type = "cooking",
	output = "tools:moonlight",
	recipe = "quests:moonlight_inactive",
    cooktime = 1,
})
