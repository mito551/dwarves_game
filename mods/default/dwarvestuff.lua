minetest.register_tool("default:pick_iron", {
	description = "Iron Pickaxe",
	inventory_image = "default_tool_ironpick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[4]=2.80, [5]=1.70, [6]=1.70, [7]=0.70}, uses=20},
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
			choppy={times={[4]=2.80, [5]=1.70, [6]=1.70, [7]=0.70}, uses=20},
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
			snappy={times={[4]=2.80, [5]=1.70, [6]=1.70, [7]=0.70}, uses=20},
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
			crumbly = {times={[4]=2.80, [5]=1.70, [6]=1.70, [7]=0.70}, uses=20},
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