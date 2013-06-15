minetest.register_craftitem("farming:lime_seed", {
	description = "Lime Seed",
	inventory_image = "farming_lime_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		local pointed = minetest.env:get_node(pointed_thing.under)
		local above = minetest.env:get_node(pointed_thing.above)
		for _,farming_soil in ipairs(farming_soil) do
			if above.name == "air" and pointed.name == farming_soil then
				above.name = "farming:lime_1"
				minetest.env:set_node(pointed_thing.above, above)
				itemstack:take_item(1)
				return itemstack
			end
		end
	end
})

minetest.register_node("farming:lime_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_lime_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+4/16, 0.5}
		},
	},
	groups = {snappy=6, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:lime_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_lime_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+7/16, 0.5}
		},
	},
	groups = {snappy=6, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:lime_3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_lime_3.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+13/16, 0.5}
		},
	},
	groups = {snappy=6, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:lime_grown", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"farming_lime_grown.png"},
	drop = {
		max_items = 4,
		items = {
			{ items = {'farming:lime_seed'} },
			{ items = {'farming:lime'} },
			{ items = {'farming:lime_seed'}, rarity = 5},
			{ items = {'farming:lime'}, rarity = 5},
		}
	},
	after_dig_node = function(pos)
		minetest.env:add_node(pos, {name="farming:lime_2"})	
	end,
	groups = {snappy=6, flammable=2, not_in_creative_inventory=1, sickle=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_abm({
	nodenames = {"farming:lime_1", "farming:lime_2", "farming:lime_3"},
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
		if node.name == "farming:lime_1" then
			node.name = "farming:lime_2"
			minetest.env:set_node(pos, node)
		elseif node.name == "farming:lime_2" then
			node.name = "farming:lime_3"
			minetest.env:set_node(pos, node)
		elseif node.name == "farming:lime_3" then
			node.name = "farming:lime_grown"
			minetest.env:set_node(pos, node)
		end
	end
})

minetest.register_craft({
    type = "shapeless",
    output = 'dwarves:tequila_with_lime',
    recipe = {
        "farming:lime_slice",
		"dwarves:tequila",
    },
})

minetest.register_craftitem("farming:lime_slice", {
	description = "Lime Slice",
	inventory_image = "farming_lime_slice.png",
})

minetest.register_node("farming:lime", {
	description = "Lime",
	drawtype = "plantlike",
	visual_scale = 0.8,
	tiles = {"farming_lime.png"},
	inventory_image = "farming_lime.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2}
	},
	drop = {
		max_items = 4,
		items = {
			{ items = {'farming:lime_slice'}},
			{ items = {'farming:lime_seed'}, rarity = 15},
			{ items = {'farming:lime_slice'}},
			{ items = {'farming:lime_slice'}},
			{ items = {'farming:lime_slice'}},
		}
	},
	groups = {dig_immediate=3,attached_node=1},
})