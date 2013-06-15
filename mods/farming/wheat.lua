minetest.register_craftitem("farming:wheat_seed", {
	description = "Wheat",
	inventory_image = "farming_wheat_harvested.png",
	on_place = function(itemstack, placer, pointed_thing)
		local pointed = minetest.env:get_node(pointed_thing.under)
		local above = minetest.env:get_node(pointed_thing.above)
		for _,farming_soil in ipairs(farming_soil) do
			if above.name == "air" and pointed.name == farming_soil then
				above.name = "farming:wheat_1"
				minetest.env:set_node(pointed_thing.above, above)
				itemstack:take_item(1)
				return itemstack
			end
		end
	end
})

minetest.register_node("farming:wheat_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_wheat_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+4/16, 0.5}
		},
	},
	groups = {snappy=6, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:wheat_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_wheat_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+7/16, 0.5}
		},
	},
	groups = {snappy=6, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:wheat_3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_wheat_3.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+13/16, 0.5}
		},
	},
	groups = {snappy=6, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:wheat", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"farming_wheat.png"},
	drop = {
		max_items = 4,
		items = {
			{ items = {'farming:wheat_seed'} },
			{ items = {'farming:wheat_seed'} },
			{ items = {'farming:wheat_seed'}, rarity = 2},
			{ items = {'farming:wheat_seed'}, rarity = 5},
		}
	},
	groups = {snappy=6, flammable=2, not_in_creative_inventory=1, sickle=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_abm({
	nodenames = {"farming:wheat_1", "farming:wheat_2", "farming:wheat_3"},
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
		if node.name == "farming:wheat_1" then
			node.name = "farming:wheat_2"
			minetest.env:set_node(pos, node)
		elseif node.name == "farming:wheat_2" then
			node.name = "farming:wheat_3"
			minetest.env:set_node(pos, node)
		elseif node.name == "farming:wheat_3" then
			node.name = "farming:wheat"
			minetest.env:set_node(pos, node)
		end
	end
})

minetest.register_craft({
	output = "farming:flour",
	recipe = {
		{"farming:wheat_seed", }
	}
})

minetest.register_craftitem("farming:flour", {
	description = "Flour",
	inventory_image = "farming_flour.png",
})

minetest.register_craft({
	output = "farming:dough",
	type = "shapeless",
	recipe = {"farming:flour", "farming:flour", "farming:flour", "farming:flour", "bucket:bucket_water"},
	replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}}
})

minetest.register_craftitem("farming:dough", {
	description = "Dough",
	inventory_image = "farming_cake_mix.png",
})

minetest.register_craft({
	type = "cooking",
	output = "farming:bread",
	recipe = "farming:dough",
	cooktime = 10
})

minetest.register_craftitem("farming:bread", {
	description = "Bread",
	inventory_image = "farming_bread.png",
	stack_max = 99,
	on_use = minetest.item_eat(10)
})

minetest.register_alias("farming:corn_seed", "farming:wheat_seed")
minetest.register_alias("farming:corn_1", "farming:wheat_1")
minetest.register_alias("farming:corn_2", "farming:wheat_2")
minetest.register_alias("farming:corn_3", "farming:wheat_3")
minetest.register_alias("farming:corn", "farming:wheat")
minetest.register_alias("farming:corn_harvested", "farming:wheat_seed")

-- ========= FUEL =========
minetest.register_craft({
	type = "fuel",
	recipe = "farming:wheat_seed",
	burntime = 1
})