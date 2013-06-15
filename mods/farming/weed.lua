minetest.register_node("farming:weed", {
	description = "Weed",
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	drawtype = "plantlike",
	tiles = {"farming_weed.png"},
	inventory_image = "farming_weed.png",
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+4/16, 0.5}
		},
	},
	drop = {
		max_items = 1,
		items = {
			{ items = {'farming:wheat_seed'}, rarity = 13 },
			{ items = {'farming:cotton_seed'}, rarity = 21 },
			{ items = {'farming:tea_seed'}, rarity = 27 },
			{ items = {'farming:rice_seed'}, rarity = 13 },
			{ items = {'farming:pumpkin_seed'}, rarity = 34 },
			{ items = {'farming:lime_seed'}, rarity = 34 }
		}
	},
	groups = {snappy=6, flammable=2, sickle=1},
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_abm({
	nodenames = {"farming:soil_wet", "farming:soil"},
	interval = 50,
	chance = 10,
	action = function(pos, node)
		pos.y = pos.y+1
		if minetest.env:get_node(pos).name == "air" then
			node.name = "farming:weed"
			minetest.env:set_node(pos, node)
		end
	end
})

-- ========= FUEL =========
minetest.register_craft({
	type = "fuel",
	recipe = "farming:weed",
	burntime = 1
})