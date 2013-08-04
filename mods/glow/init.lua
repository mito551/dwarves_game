minetest.register_node("glow:stone_with_worms", {
	description = "Glow Worms in Stone",
	tiles = { "default_stone.png^worms.png" },
	is_ground_content = true,
	groups = { cracky=4 },
	drop = "glow:stone_with_worms",
	paramtype = "light",
	light_source = 4,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "glow:stone_with_worms",
	wherein        = "default:stone",
	clust_scarcity = 800,
	clust_num_ores = 4,
	clust_size     = 8,
	height_min     = -100,
	height_max     = 20,
})

minetest.register_node("glow:shrooms", {
	description = "Glow Shrooms",
	drawtype = "plantlike",
	tiles = { "shrooms.png" },
	inventory_image = "shrooms.png",
	wield_image = "shrooms.png",
	drop = 'glow:shrooms',
	groups = { snappy=7, flammable=2, flower=1, flora=1, attached_node=1 },
	sunlight_propagates = true,
	walkable = false,
	pointable = true,
	diggable = true,
	climbable = false,
	buildable_to = true,
	paramtype = "light",
	light_source = 3,
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.4, -0.5, -0.4, 0.4, 0.0, 0.4 },
	},
})

minetest.register_node("glow:fireflies", {
	description = "Fireflies",
	drawtype = "glasslike",
	tiles = {
		{
			name = "fireflies.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2,
			},
		},
	},
	alpha = 100,
	paramtype = "light",
	light_source = 4,
	walkable = false,
	pointable = false,
	diggable = false,
	climbable = false,
	buildable_to = true,
})

minetest.register_on_generated(function(minp, maxp, seed)
	local tree_nodes = minetest.find_nodes_in_area(minp, maxp, "default:tree")
	for key, pos in pairs(tree_nodes) do
		local bpos = { x=pos.x, y=pos.y-1, z=pos.z }
		if minetest.get_node(bpos).name ~= "default:tree" then
			local prob = math.random()
			if prob <= 0.2 then
				for nx = -1, 1, 2 do
					for ny = -1, 1, 2 do
						for nz = -1, 1, 2 do
							local tpos = { x=bpos.x+nx, y=bpos.y+ny, z=bpos.z+nz }
							if minetest.get_node(tpos).name == "default:dirt_with_grass" then
								local ppos = { x=tpos.x, y=tpos.y+1, z=tpos.z }
								minetest.add_node(ppos, { name = "glow:shrooms" })
							end
						end
					end
				end
			end
		end
	end
end)

minetest.register_abm({
	nodenames = {"air"},
	neighbors = {
		"default:grass_1",
		"default:grass_2",
		"default:grass_3",
		"default:grass_4",
		"default:grass_5",
	},
	interval = 15,
	chance = 600,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.get_timeofday() > 0.74 or minetest.get_timeofday() < 0.22 then
			--local water_nodes = minetest.find_nodes_in_area(minp, maxp, "group:water")
			--if #water_nodes > 0 then
			if minetest.find_node_near(pos, 3, "glow:fireflies") == nil then
				minetest.set_node(pos, {name = "glow:fireflies"})
			end
		end
	end,
})

minetest.register_abm({
	nodenames = {"glow:fireflies"},
	interval = 1.0,
	chance = 2,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.remove_node(pos)
	end,
})
