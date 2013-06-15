minetest.register_craftitem("farming:cotton_seed", {
	description = "Cotton Seeds",
	inventory_image = "farming_cotton_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		local pointed = minetest.env:get_node(pointed_thing.under)
		local above = minetest.env:get_node(pointed_thing.above)
		for _,farming_soil in ipairs(farming_soil) do
			if above.name == "air" and pointed.name == farming_soil then
				above.name = "farming:cotton_1"
				minetest.env:set_node(pointed_thing.above, above)
				itemstack:take_item(1)
				return itemstack
			end
		end
	end
})

minetest.register_node("farming:cotton_1", {
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_cotton_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+6/16, 0.5}
		},
	},
	groups = {snappy=6, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:cotton_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = {
		max_items = 3,
		items = {
			{ items = {'farming:cotton_seed'} },
			{ items = {'farming:cotton_seed'} },
			{ items = {'farming:cotton_seed'}, rarity = 3 },
			{ items = {'farming:cotton_seed'}, rarity = 5 }
		}
	},
	tiles = {"farming_cotton_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+12/16, 0.5}
		},
	},
	groups = {snappy=6, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:cotton", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"farming_cotton.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'flowers:cotton'} },
			{ items = {'flowers:cotton'}, rarity = 2 },
			{ items = {'flowers:cotton'}, rarity = 5 }
		}
	},
	after_dig_node = function(pos)
		minetest.env:add_node(pos, {name="farming:cotton_2"})	
	end,
	groups = {snappy=6, flammable=2, not_in_creative_inventory=1, sickle=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_abm({
	nodenames = {"farming:cotton_1", "farming:cotton_2"},
	interval = 97,
	chance = 42,
	action = function(pos, node)
		pos.y = pos.y-1
		if minetest.env:get_node(pos).name ~= "farming:soil_wet" then
			return
		end
		pos.y = pos.y+1
		if minetest.env:get_node_light(pos) < 8 then
			return
		end
		if node.name == "farming:cotton_1" then
			node.name = "farming:cotton_2"
			minetest.env:set_node(pos, node)
		elseif node.name == "farming:cotton_2" then
			node.name = "farming:cotton"
			minetest.env:set_node(pos, node)
		end
	end
})

-- the cotton of VanessaEs "flowers"
if ( minetest.get_modpath("farming") ) ~= nil then
minetest.register_craftitem(":flowers:cotton", {
    description = "Cotton",
    image = "flowers_cotton.png",
})
end

minetest.register_craftitem("farming:string", {
	description = "String",
	inventory_image = "farming_string.png",
})

minetest.register_craft({
	output = "wool:white",
	recipe = {
			{"flowers:cotton", "flowers:cotton", "flowers:cotton"},
			{"flowers:cotton", "flowers:cotton", "flowers:cotton"},
			{"flowers:cotton", "flowers:cotton", "flowers:cotton"}
			}
})

minetest.register_craft({
	output = "wool:white",
	recipe = {
			{"farming:string", "farming:string"},
			{"farming:string", "farming:string"},
			}
})

minetest.register_craft({
	output = "farming:string 4",
	recipe = {{"wool:white"}}
})

-- ========= FUEL =========
minetest.register_craft({
	type = "fuel",
	recipe = "farming:string",
	burntime = 1
})
