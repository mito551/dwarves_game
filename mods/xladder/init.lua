minetest.register_node(":default:ladder", {
	description = "Ladder",
	drawtype = "nodebox",
	tiles = {"default_wood.png"},
	inventory_image = "default_ladder.png",
	wield_image = "default_ladder.png",
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	climbable = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0.5, 0.5, 0.5, 0.3},
	},
	node_box = {
		type = "fixed",
		fixed = {{-0.4, -0.5, 0.5, -0.32, 0.5, 0.37},
			 {0.45, -0.5, 0.5, 0.32, 0.5, 0.37},

			 {-0.32, -0.5+(1/4)-(1/8)-(1/16), 0.47, 0.32, -0.5+(1/4)-(1/8)+(1/16), 0.4},
			 {-0.32, -0.5+(2/4)-(1/8)-(1/16), 0.47, 0.32, -0.5+(2/4)-(1/8)+(1/16), 0.4},
			 {-0.32, -0.5+(3/4)-(1/8)-(1/16), 0.47, 0.32, -0.5+(3/4)-(1/8)+(1/16), 0.4},
			 {-0.32, -0.5+(4/4)-(1/8)-(1/16), 0.47, 0.32, -0.5+(4/4)-(1/8)+(1/16), 0.4},},
	},
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=3,flammable=2},
	sounds = default.node_sound_wood_defaults(),
})
