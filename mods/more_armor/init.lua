-- Regisiter Head Armor

minetest.register_tool("more_armor:helmet_mithril", {
	description = "Mithril Helmet",
	inventory_image = "more_armor_inv_helmet_mithril.png",
	groups = {armor_head=15, armor_heal=15, armor_use=50},
	wear = 0,
})

minetest.register_craft({
	output = "more_armor:helmet_mithril",
	recipe = {
		{"moreores:mithril_ingot", "moreores:mithril_ingot", "moreores:mithril_ingot"},
		{"moreores:mithril_ingot", "", "moreores:mithril_ingot"},
		{"", "", ""},
	},
})

-- Regisiter Torso Armor

minetest.register_tool("more_armor:chestplate_mithril", {
	description = "Mithril Chestplate",
	inventory_image = "more_armor_inv_chestplate_mithril.png",
	groups = {armor_torso=25, armor_heal=15, armor_use=50},
	wear = 0,
})

minetest.register_craft({
	output = "more_armor:chestplate_mithril",
	recipe = {
		{"moreores:mithril_ingot", "", "moreores:mithril_ingot"},
		{"moreores:mithril_ingot", "moreores:mithril_ingot", "moreores:mithril_ingot"},
		{"moreores:mithril_ingot", "moreores:mithril_ingot", "moreores:mithril_ingot"},
	},
})

-- Regisiter Leg Armor

minetest.register_tool("more_armor:leggings_mithril", {
	description = "Mithril Leggings",
	inventory_image = "more_armor_inv_leggings_mithril.png",
	groups = {armor_legs=20, armor_heal=15, armor_use=50},
	wear = 0,
})

minetest.register_craft({
	output = "more_armor:leggings_mithril",
	recipe = {
		{"moreores:mithril_ingot", "moreores:mithril_ingot", "moreores:mithril_ingot"},
		{"moreores:mithril_ingot", "", "moreores:mithril_ingot"},
		{"moreores:mithril_ingot", "", "moreores:mithril_ingot"},
	},
})

-- Regisiter Shields

minetest.register_tool("more_armor:shield_mithril", {
	description = "Mithril Shield",
	inventory_image = "more_armor_inv_shield_mithril.png",
	groups = {armor_shield=25, armor_heal=15, armor_use=50},
	wear = 0,
})

minetest.register_craft({
	output = "more_armor:shield_mithril",
	recipe = {
		{"moreores:mithril_ingot", "moreores:mithril_ingot", "moreores:mithril_ingot"},
		{"moreores:mithril_ingot", "moreores:mithril_ingot", "moreores:mithril_ingot"},
		{"", "moreores:mithril_ingot", ""},
	},
})

minetest.register_alias("moreores:mithril_ingot", "dwarves:mithril_ingot")

