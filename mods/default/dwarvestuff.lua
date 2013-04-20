minetest.register_tool("default:pick_iron", {
	description = "Iron Pickaxe",
	inventory_image = "default_tool_ironpick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})

minetest.register_tool("default:axe_iron", {
	description = "Iron Axe",
	inventory_image = "default_tool_ironaxe.png",
	tool_capabilities = {

		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=3.00, [2]=1.60, [3]=1.00}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=4},		
	},
})

minetest.register_tool("default:sword_iron", {
	description = "Iron Sword",
	inventory_image = "default_tool_ironsword.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=1.90, [2]=0.90, [3]=0.30}, uses=40, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	}
})

minetest.register_tool("default:shovel_iron", {
	description = "Iron Shovel",
	inventory_image = "default_tool_ironshovel.png",
	wield_image = "default_tool_ironshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.10, [2]=0.50, [3]=0.30}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	}
})


minetest.register_craft({
	output = 'torch:torch 4',
	recipe = {
		{'default:coal_lump'},
		{'default:stick'},
	}
})

minetest.register_craft({
	output = 'default:pick_iron',
	recipe = {
		{'default:iron_ingot', 'default:iron_ingot', 'default:iron_ingot'},
		{'', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:shovel_iron',
	recipe = {
		{'default:iron_ingot'},
		{'default:stick'},
		{'default:stick'},
	}
})

minetest.register_craft({
	output = 'default:axe_iron',
	recipe = {
		{'default:iron_ingot', 'default:iron_ingot'},
		{'default:iron_ingot', 'default:stick'},
		{'', 'default:stick'},
	}
})

minetest.register_craft({
	output = 'default:sword_iron',
	recipe = {
		{'default:iron_ingot'},
		{'default:iron_ingot'},
		{'default:stick'},
	}
})


minetest.register_craft({
	output = 'default:ironblock',
	recipe = {
		{'default:iron_ingot', 'default:iron_ingot', 'default:iron_ingot'},
		{'default:iron_ingot', 'default:iron_ingot', 'default:iron_ingot'},
		{'default:iron_ingot', 'default:iron_ingot', 'default:iron_ingot'},
	}
})

minetest.register_craft({
	output = 'default:iron_ingot 9',
	recipe = {
		{'default:ironblock'},
	}
})

minetest.register_craftitem("default:iron_ingot", {
	description = "Iron Ingot",
	inventory_image = "default_steel_ingot.png",
})

minetest.register_craftitem("default:torch", {
	description = "Hand Torch",
	inventory_image = "default_torch.png",
})

minetest.register_abm({
	nodenames = {'default:tree'},
	interval = 3600000,
	chance = 10,
	action = function(pos, node, active_object_count, active_object_count_wider)
		for i=0, 3 do
			for j=0,3 do
				for k=0,3 do
					if minetest.env:get_node({x=pos.x+i-1, y=pos.y+j-1, z=pos.z+k-1}).name == "air" then
						minetest.env:add_node({x=pos.x+i-1, y=pos.y+j-1, z=pos.z+k-1}, {name="default:apple"})
						return
					end
				end
			end
		end
	end,
})

minetest.register_node("default:rail", {
	description = "Rail",
	drawtype = "raillike",
	tiles = {"default_rail.png", "default_rail_curved.png", "default_rail_t_junction.png", "default_rail_crossing.png"},
	inventory_image = "default_rail.png",
	wield_image = "default_rail.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	selection_box = {
		type = "fixed",
                -- but how to specify the dimensions for curved and sideways rails?
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {bendy=2,snappy=1,dig_immediate=2,rail=1,attached_node=1},
		after_place_node = function(pos, placer, itemstack)
		if not mesecon then
			minetest.env:get_meta(pos):set_string("cart_acceleration", "0.5")
		end
	end,
	
	mesecons = {
		effector = {
			action_on = function(pos, node)
				minetest.env:get_meta(pos):set_string("cart_acceleration", "0.5")
			end,
			
			action_off = function(pos, node)
				minetest.env:get_meta(pos):set_string("cart_acceleration", "0")
			end,
		},
	},
})

