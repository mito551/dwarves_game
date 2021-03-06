minetest.register_node("farming:soil", {
	tiles = {"farming_soil.png", "default_dirt.png", "default_dirt.png", "default_dirt.png", "default_dirt.png", "default_dirt.png"},
	drop = "default:dirt",
	groups = {crumbly=3, not_in_creative_inventory=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})

minetest.register_node("farming:soil_wet", {
	tiles = {"farming_soil_wet.png", "farming_soil_wet_side.png", "farming_soil_wet_side.png", "farming_soil_wet_side.png", "farming_soil_wet_side.png", "farming_soil_wet_side.png"},
	drop = "default:dirt",
	groups = {crumbly=3, not_in_creative_inventory=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})

minetest.register_abm({
	nodenames = {"farming:soil"},
	interval = 15,
	chance = 3,
	action = function(pos, node)
		if minetest.env:find_node_near(pos, 4, {"default:water_source", "default:water_flowing"}) then
			node.name = "farming:soil_wet"
			minetest.env:set_node(pos, node)
		end
	end,
})