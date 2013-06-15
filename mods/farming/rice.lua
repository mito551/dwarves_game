minetest.register_craftitem("farming:rice_seed", {
	description = "Rice",
	inventory_image = "farming_rice_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		local pointed = minetest.env:get_node(pointed_thing.under)
		local above = minetest.env:get_node(pointed_thing.above)
		for _,farming_soil in ipairs(farming_soil) do
			if above.name == "air" and pointed.name == farming_soil then
				above.name = "farming:rice_1"
				minetest.env:set_node(pointed_thing.above, above)
				itemstack:take_item(1)
				return itemstack
			end
		end
	end
})

minetest.register_node("farming:rice_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_rice_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+4/16, 0.5}
		},
	},
	groups = {snappy=6, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:rice_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_rice_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+7/16, 0.5}
		},
	},
	groups = {snappy=6, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:rice_3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_rice_3.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+13/16, 0.5}
		},
	},
	groups = {snappy=6, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:rice", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"farming_rice.png"},
	drop = {
		max_items = 4,
		items = {
			{ items = {'farming:rice_seed'} },
			{ items = {'farming:rice_seed'} },
			{ items = {'farming:rice_seed'}, rarity = 2},
			{ items = {'farming:rice_seed'}, rarity = 5},
		}
	},
	groups = {snappy=6, flammable=2, not_in_creative_inventory=1, sickle=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_abm({
	nodenames = {"farming:rice_1", "farming:rice_2", "farming:rice_3"},
	interval = 61,
	chance = 15,
	action = function(pos, node)
		pos.y = pos.y-1
		if minetest.env:get_node(pos).name ~= "farming:soil_wet" then
			return
		end
		pos.y = pos.y+1
		if minetest.env:get_node_light(pos) < 8 then
			return
		end
		if node.name == "farming:rice_1" then
			node.name = "farming:rice_2"
			minetest.env:set_node(pos, node)
		elseif node.name == "farming:rice_2" then
			node.name = "farming:rice_3"
			minetest.env:set_node(pos, node)
		elseif node.name == "farming:rice_3" then
			node.name = "farming:rice"
			minetest.env:set_node(pos, node)
		end
	end
})

minetest.register_craft({
	output = 'farming:onigiri',
	recipe = {
		{'', 'farming:rice_seed', ''},
		{'farming:rice_seed', '', 'farming:rice_seed'},
	}
})

--[[minetest.register_craft({
	output = 'farming:rice_pudding',
	recipe = {
		{"farming:rice_seed"},
		{"dwarves:water_boiled"},
	},
	replacements = {{"dwarves:water_boiled", "bucket:bucket_empty"}},
})

minetest.register_craftitem("farming:rice_pudding", {
	description = "Rice Pudding",
	inventory_image = "farming_rice_pudidng.png",
	stack_max = 99,
	on_use = minetest.item_eat(8)
})--]]

minetest.register_craftitem("farming:onigiri", {
	description = "Onigiri",
	inventory_image = "farming_onigiri.png",
	stack_max = 99,
	on_use = minetest.item_eat(3)
})