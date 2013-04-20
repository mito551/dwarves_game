minetest.register_craftitem("farming:pumpkin_seed", {
	description = "Pumpkin Seed",
	inventory_image = "farming_pumpkin_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		local pointed = minetest.env:get_node(pointed_thing.under)
		local above = minetest.env:get_node(pointed_thing.above)
		for _,farming_soil in ipairs(farming_soil) do
			if above.name == "air" and pointed.name == farming_soil then
				above.name = "farming:pumpkin_1"
				minetest.env:set_node(pointed_thing.above, above)
				itemstack:take_item(1)
				return itemstack
			end
		end
	end
})

minetest.register_node("farming:pumpkin_1", {
	paramtype = "light",
	drawtype = "nodebox",
	drop = "",
	tiles = {"farming_pumpkin_top.png", "farming_pumpkin_top.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png"},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.2, -0.5, -0.2, 0.2, -0.1, 0.2}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.2, -0.5, -0.2, 0.2, -0.1, 0.2}
		},
	},
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("farming:pumpkin_2", {
	paramtype = "light",
	drawtype = "nodebox",
	drop = "",
	tiles = {"farming_pumpkin_top.png", "farming_pumpkin_top.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png"},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.35, -0.5, -0.35, 0.35, 0.2, 0.35}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.35, -0.5, -0.35, 0.35, 0.2, 0.35}
		},
	},
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("farming:pumpkin", {
	description = "Pumpkin",
	paramtype2 = "facedir",
	tiles = {"farming_pumpkin_top.png", "farming_pumpkin_top.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png"},
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2},
	sounds = default.node_sound_wood_defaults(),
	
	on_punch = function(pos, node, puncher)
		local tool = puncher:get_wielded_item():get_name()
		if tool and tool == "default:sword_wood" or tool == "default:sword_stone" or tool == "default:sword_steel" then
			node.name = "farming:pumpkin_face"
			minetest.env:set_node(pos, node)
			puncher:get_inventory():add_item("main", ItemStack("farming:pumpkin_seed"))
			if math.random(1, 5) == 1 then
				puncher:get_inventory():add_item("main", ItemStack("farming:pumpkin_seed"))
			end
		end
	end
})

minetest.register_abm({
	nodenames = {"farming:pumpkin_1", "farming:pumpkin_2"},
	interval = 89,
	chance = 31,
	action = function(pos, node)
		pos.y = pos.y-1
		if minetest.env:get_node(pos).name ~= "farming:soil_wet" then
			return
		end
		pos.y = pos.y+1
		if minetest.env:get_node_light(pos) < 8 then
			return
		end
		if node.name == "farming:pumpkin_1" then
			node.name = "farming:pumpkin_2"
			minetest.env:set_node(pos, node)
		elseif node.name == "farming:pumpkin_2" then
			node.name = "farming:pumpkin"
			minetest.env:set_node(pos, node)
		end
	end
})

minetest.register_node("farming:pumpkin_face", {
	description = "Pumpkin",
	paramtype2 = "facedir",
	tiles = {"farming_pumpkin_top.png", "farming_pumpkin_top.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_face.png"},
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("farming:pumpkin_face_light", {
	description = "Pumpkin",
	paramtype2 = "facedir",
	light_source = LIGHT_MAX-2,
	tiles = {"farming_pumpkin_top.png", "farming_pumpkin_top.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_face_light.png"},
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:pumpkin_face_light",
	recipe = {"farming:pumpkin_face", "default:torch"}
})

-- ========= SCARECROW =========
local box1 = {
	{-1, -8, -1, 1, 8, 1},
}

local box2 = {
	{-1, -8, -1, 1, 8, 1},
	{-12, -8, -1, 12, -7, 1},
	{-5, -2, -5, 5, 8, 5}
}

for j,list in ipairs(box1) do
	for i,int in ipairs(list) do
		list[i] = int/16
	end
	box1[j] = list
end

for j,list in ipairs(box2) do
	for i,int in ipairs(list) do
		list[i] = int/16
	end
	box2[j] = list
end

minetest.register_node("farming:scarecrow", {
	description = "Scarecrow",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"farming_scarecrow_top.png", "farming_scarecrow_top.png", "farming_scarecrow_side.png", "farming_scarecrow_side.png", "farming_scarecrow_side.png", "farming_scarecrow_front.png"},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = box2
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-12/16, -1.5, -0.5, 12/16, 0.5, 0.5}
		}
	},
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2},
	
	after_place_node = function(pos, placer)
		local node = minetest.env:get_node(pos)
		local param2 = node.param2
		pos.y = pos.y+1
		if minetest.env:get_node(pos).name ~= "air" then
			pos.y = pos.y-1
			minetest.env:remove_node(pos)
			minetest.after(0.1, function(placer)
				local inv = placer:get_inventory()
				local index = placer:get_wield_index()
				inv:set_stack("main", index, ItemStack("farming:scarecrow"))
			end, placer)
			return
		end
		minetest.env:set_node(pos, node)
		pos.y = pos.y-1
		node.name = "farming:scarecrow_bottom"
		minetest.env:set_node(pos, node)
	end,
	
	after_destruct = function(pos, oldnode)
		pos.y = pos.y-1
		if minetest.env:get_node(pos).name == "farming:scarecrow_bottom" then
			minetest.env:remove_node(pos)
		end
	end
})

minetest.register_node("farming:scarecrow_bottom", {
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"default_wood.png"},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = box1
	},
	groups = {not_in_creative_inventory=1},
	selection_box = {
		type = "fixed",
		fixed = {
			{0, 0, 0, 0, 0, 0}
		}
	}
})

minetest.register_craft({
	output = 'farming:pumpkin_seed 2',
	recipe = {
		{"farming:pumpkin"},
	},
})

minetest.register_craft({
	output = "farming:scarecrow",
	recipe = {
		{"", "farming:pumpkin_face", "",},
		{"default:stick", "default:stick", "default:stick",},
		{"", "default:stick", "",}
	}
})

minetest.register_node("farming:scarecrow_light", {
	description = "Scarecrow",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = LIGHT_MAX-2,
	tiles = {"farming_scarecrow_top.png", "farming_scarecrow_top.png", "farming_scarecrow_side.png", "farming_scarecrow_side.png", "farming_scarecrow_side.png", "farming_scarecrow_front_light.png"},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = box2
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-12/16, -1.5, -0.5, 12/16, 0.5, 0.5}
		}
	},
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2},
	
	after_place_node = function(pos, placer)
		local node = minetest.env:get_node(pos)
		local param2 = node.param2
		pos.y = pos.y+1
		if minetest.env:get_node(pos).name ~= "air" then
			pos.y = pos.y-1
			minetest.env:remove_node(pos)
			minetest.after(0.1, function(placer)
				local inv = placer:get_inventory()
				local index = placer:get_wield_index()
				inv:set_stack("main", index, ItemStack("farming:scarecrow_light"))
			end, placer)
			return
		end
		minetest.env:set_node(pos, node)
		pos.y = pos.y-1
		node.name = "farming:scarecrow_bottom"
		minetest.env:set_node(pos, node)
	end,
	
	after_destruct = function(pos, oldnode)
		pos.y = pos.y-1
		if minetest.env:get_node(pos).name == "farming:scarecrow_bottom" then
			minetest.env:remove_node(pos)
		end
	end
})

minetest.register_craft({
	output = "farming:scarecrow_light",
	recipe = {
		{"", "farming:pumpkin_face_light", "",},
		{"default:stick", "default:stick", "default:stick",},
		{"", "default:stick", "",}
	}
})

-- ========= FUEL =========
minetest.register_craft({
	type = "fuel",
	recipe = "farming:pumpkin_seed",
	burntime = 1
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:pumpkin",
	burntime = 5
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:pumpkin_face",
	burntime = 5
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:pumpkin_face_light",
	burntime = 7
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:scarecrow",
	burntime = 5
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:scarecrow_light",
	burntime = 5
})
