minetest.register_craftitem("farming:tea_seed", {
	description = "Tea Seed",
	inventory_image = "farming_tea_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		local pointed = minetest.env:get_node(pointed_thing.under)
		local above = minetest.env:get_node(pointed_thing.above)
		for _,farming_soil in ipairs(farming_soil) do
			if above.name == "air" and pointed.name == farming_soil then
				above.name = "farming:tea_1"
				minetest.env:set_node(pointed_thing.above, above)
				itemstack:take_item(1)
				return itemstack
			end
		end
	end
})

minetest.register_node("farming:tea_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_tea_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+4/16, 0.5}
		},
	},
	groups = {snappy=6, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:tea_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_tea_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+7/16, 0.5}
		},
	},
	groups = {snappy=6, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:tea_3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_tea_3.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+13/16, 0.5}
		},
	},
	groups = {snappy=6, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:tea", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"farming_tea_grown.png"},
	drop = {
		max_items = 4,
		items = {
			{ items = {'farming:tea_seed'} },
			{ items = {'farming:tea_leaves'} },
			{ items = {'farming:tea_seed'}, rarity = 2},
			{ items = {'farming:tea_seed'}, rarity = 5},
			{ items = {'farming:tea_leaves'}, rarity = 2},
			{ items = {'farming:tea_leaves'}, rarity = 5},
		}
	},
	after_dig_node = function(pos)
		minetest.env:add_node(pos, {name="farming:tea_2"})	
	end,
	groups = {snappy=6, flammable=2, not_in_creative_inventory=1, sickle=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_abm({
	nodenames = {"farming:tea_1", "farming:tea_2", "farming:tea_3"},
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
		if node.name == "farming:tea_1" then
			node.name = "farming:tea_2"
			minetest.env:set_node(pos, node)
		elseif node.name == "farming:tea_2" then
			node.name = "farming:tea_3"
			minetest.env:set_node(pos, node)
		elseif node.name == "farming:tea_3" then
			node.name = "farming:tea"
			minetest.env:set_node(pos, node)
		end
	end
})

minetest.register_craft({
	output = 'farming:teapot_3',
	recipe = {
		{"farming:tea_leaves"},
		{"dwarves:water_boiled"},
		{"farming:teapot"},
	},
	replacements = {{"dwarves:water_boiled", "bucket:bucket_empty"}},
})

minetest.register_craft({
	output = 'farming:tea_cup',
	recipe = {
		{"farming:teapot_3"},
		{"farming:cup"},
	},
	replacements = {{"farming:teapot_3", "farming:teapot_2"}},
})

minetest.register_craft({
	output = 'farming:tea_cup',
	recipe = {
		{"farming:teapot_2"},
		{"farming:cup"},
	},
	replacements = {{"farming:teapot_2", "farming:teapot_1"}},
})

minetest.register_craft({
	output = 'farming:tea_cup',
	recipe = {
		{"farming:teapot_1"},
		{"farming:cup"},
	},
	replacements = {{"farming:teapot_1", "farming:teapot"}},
})

minetest.register_craft({
	output = 'farming:teapot',
	recipe = {
		{"dwarves:castiron"},
		{"dwarves:castiron"},
	}
})

minetest.register_craft({
	output = 'farming:cup',
	recipe = {
		{'default:clay_lump', '', 'default:clay_lump'},	
		{'', 'default:clay_lump', ''},
	}
})

minetest.register_craftitem("farming:tea_leaves", {
	description = "Tea Leaves",
	inventory_image = "farming_tea_leaves.png",
})

minetest.register_craftitem("farming:tea_cup", {
	description = "Cup of Tea",
	inventory_image = "farming_tea.png",
	stack_max = 1,
	on_use = minetest.item_eat(6, "farming:cup")
})


minetest.register_craftitem("farming:cup", {
	description = "Cup",
	inventory_image = "farming_cup.png"
})
minetest.register_craftitem("farming:teapot_3", {
	description = "Teapot 3/3",
	inventory_image = "farming_teapot.png"
})
minetest.register_craftitem("farming:teapot_2", {
	description = "Teapot 2/3",
	inventory_image = "farming_teapot.png"
})
minetest.register_craftitem("farming:teapot_1", {
	description = "Teapot 1/3",
	inventory_image = "farming_teapot.png"
})
minetest.register_craftitem("farming:teapot", {
	description = "Empty Teapot",
	inventory_image = "farming_teapot.png"
})