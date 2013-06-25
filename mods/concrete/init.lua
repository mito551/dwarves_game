minetest.register_node("concrete:concrete_source", {
	description = "Concrete Source",
	inventory_image = minetest.inventorycube("concrete_wet.png"),
		tiles = {
			{name="concrete_flowing.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.0}}
		},
		special_tiles = {
		{name="concrete_wet.png", backface_culling=false},
	},
	drawtype = "liquid",
	alpha = 250,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	liquidtype = "source",
	liquid_alternative_flowing = "concrete:concrete_flowing",
	liquid_alternative_source = "concrete:concrete_source",
	liquid_viscosity = 7,
	liquid_renewable = true,
	post_effect_color = {a=250, r=50, g=50, b=50},
	groups = {liquid=3, puts_out_fire=1},
})



minetest.register_node("concrete:concrete_flowing", {
	description = "Flowing Concrete",
	inventory_image = minetest.inventorycube("concrete_wet.png"),
	drawtype = "flowingliquid",
	tiles = {"concrete_wet.png"},
	special_tiles = {
		{
			image="concrete_flowing.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.8}
		},
		{
			image="concrete_flowing.png",
			backface_culling=true,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.8}
		},
	},
	alpha = 250,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	liquidtype = "flowing",
	liquid_alternative_flowing = "concrete:concrete_flowing",
	liquid_alternative_source = "concrete:concrete_source",
	liquid_viscosity = 7,
	liquid_renewable = true,
	post_effect_color = {a=250, r=50, g=50, b=50},
	groups = {liquid=3, puts_out_fire=1},
})

minetest.register_node("concrete:concrete_drying", {
	description = "Drying Concrete",
	tiles = {"concrete_wet.png"},
	is_ground_content = true,
	groups = {snappy=7,choppy=7,oddly_breakable_by_hand=7,cracky=7},
})

minetest.register_abm({
	nodenames = {"concrete:concrete_flowing", "concrete:concrete_source"},
	interval = 300,
	chance = 2,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.env:set_node(pos, {name = "concrete:concrete_drying"})
	end,
})


minetest.register_abm({
	nodenames = {"concrete:concrete_flowing", "concrete:concrete_source"},
	neighbors = {"concrete:concrete_drying"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.env:set_node(pos, {name = "concrete:concrete_drying"})
	end,
})


minetest.register_abm({
	nodenames = {"concrete:concrete_drying"},
	interval = 300,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
			if minetest.env:find_node_near(pos, 4, "default:steelblock") then
				minetest.env:set_node(pos, {name = "concrete:reinforced_concrete"})
			else
				minetest.env:set_node(pos, {name = "concrete:concrete"})
			end
	end,
})

minetest.register_node("concrete:concrete", {
	description = "Concrete",
	tiles = {"concrete_concrete.png"},
	is_ground_content = true,
	groups = {cracky=2},
})

minetest.register_node("concrete:reinforced_concrete", {
	description = "Reinforced Concerte",
	tiles = {"concrete_concrete.png"},
	is_ground_content = true,
	groups = {cracky=1},
})

minetest.register_node("concrete:lime", {
	description = "Lime",
	tiles = {"concrete_lime.png"},
	groups = {snappy=7,choppy=7,oddly_breakable_by_hand=7,cracky=7},
})

minetest.register_craftitem("concrete:cement", {
	description = "Cement",
	inventory_image = "concrete_cement.png",
})

minetest.register_craft({
	type = "shapeless",
	output = "concrete:concrete_source",
	recipe = {"concrete:cement", "bucket:bucket_water", "default:gravel"},
	replacements = {
		{"bucket:bucket_water", "bucket:bucket_empty"}
	}
})


minetest.register_craft({
    type = "shapeless",
    output = 'default:gravel 2',
    recipe = {
        "default:desert_sand",
        "default:cobble",
    },
})

minetest.register_craft({
	type = "cooking",
	output = "concrete:lime",
	recipe = "default:desert_stone",
})

minetest.register_craft({
	type = "cooking",
	output = "concrete:cement",
	recipe = "concrete:lime",
})
