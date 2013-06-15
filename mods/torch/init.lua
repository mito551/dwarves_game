--the flame entity
minetest.register_entity("torch:flame", {
    physical = true,
	visual_size = {x=0.35, y=0.35},
	collisionbox = {0,00,0,0,0,0},
    visual = "sprite",
	textures = {"flame.png"},
    on_step = function(self, dtime)
        self.timer = self.timer + dtime
        if self.timer > 2 then
            self.object:remove()
        end
    end,
    timer = 0,
})

TORCHNAMES = {
	"torch:torch",
}

CHECKSIZE = 40

SMOKE = {
    physical = true,
    collisionbox = {0.1,0.1,0.1,0.1,0.1,0.1},
    visual = "sprite",
    textures = {"smoke.png"},
    on_step = function(self, dtime)
        self.object:setacceleration({x=0.1+math.random()*0.1, y=0.4+math.random()*0.3, z=0.1+math.random()*0.1})
        self.timer = self.timer + dtime
        if self.timer > 1 then
            self.object:remove()
        end
    end,
    timer = 0,
}

minetest.register_entity("torch:smoke", SMOKE)

local smokestep = 0
local liststep = 0
local torchlist = {}

function particles_spawn_smoke(dtime)
	smokestep = smokestep + 1
	if smokestep == 10 then
		smokestep = -2
		for i in ipairs(torchlist) do
			local tpos = torchlist[i]
			if minetest.env:get_node(tpos).param2 == 0 then
			minetest.env:add_entity({x=tpos.x + math.random()*0.2,y=tpos.y-0.25 + math.random()*0.2,z=tpos.z + math.random()*0.2}, "torch:smoke")
				end
				if minetest.env:get_node(tpos).param2 == 1 then
					minetest.env:add_entity({x=tpos.x + math.random()*0.2,y=tpos.y+0.3 + math.random()*0.2,z=tpos.z + math.random()*0.2}, "torch:smoke")
				end
				if minetest.env:get_node(tpos).param2 == 2 then
					minetest.env:add_entity({x=tpos.x+0.43 + math.random()*0.2,y=tpos.y+0.4 + math.random()*0.2,z=tpos.z + math.random()*0.2}, "torch:smoke")
				end
				if minetest.env:get_node(tpos).param2 == 3 then
					minetest.env:add_entity({x=tpos.x-0.43 + math.random()*0.2,y=tpos.y+0.4 + math.random()*0.2,z=tpos.z + math.random()*0.2}, "torch:smoke")
				end
				if minetest.env:get_node(tpos).param2 == 4 then
					minetest.env:add_entity({x=tpos.x + math.random()*0.2,y=tpos.y+0.4 + math.random()*0.2,z=tpos.z+0.43 + math.random()*0.2}, "torch:smoke")
				end
				if minetest.env:get_node(tpos).param2 == 5 then
					minetest.env:add_entity({x=tpos.x + math.random()*0.2,y=tpos.y+0.4 + math.random()*0.2,z=tpos.z-0.43 + math.random()*0.2}, "torch:smoke")
				end
		end
	end
end

function update_torchlist()
	liststep = liststep + 1
	if liststep == 50 then
		liststep = 0
		torchlist = {}
		local players = minetest.get_connected_players()
		for i in ipairs(players) do
			local playerpos = players[i]:getpos()
			local torches = minetest.env:find_nodes_in_area(
						{x=playerpos.x-CHECKSIZE, y=playerpos.y-CHECKSIZE, z=playerpos.z-CHECKSIZE},
						{x=playerpos.x+CHECKSIZE, y=playerpos.y+CHECKSIZE, z=playerpos.z+CHECKSIZE},
						TORCHNAMES)
			torchinlist=false
			for j in ipairs(torches) do
				for k in ipairs(torchlist) do
					if dump(torchlist[k]) == dump(torches[j]) then torchinlist=true end
				end
				if not torchinlist then table.insert(torchlist, torches[j]) end
			end
		end
	end
end

--minetest.register_globalstep(particles_spawn_smoke)
--minetest.register_globalstep(update_torchlist)


-- register flame abm
minetest.register_abm({
	nodenames = {"torch:torch"},
	interval = 1,
	chance = 2,
	action = function(pos)
		if minetest.env:get_node(pos).param2 == 0 then
			minetest.env:add_entity({x=pos.x + math.random()*0.0879,y=pos.y-0.25 + math.random()*0.0879,z=pos.z + math.random()*0.0879}, "torch:flame")
        end
		if minetest.env:get_node(pos).param2 == 1 then
			minetest.env:add_entity({x=pos.x + math.random()*0.0879,y=pos.y+0.3 + math.random()*0.0879,z=pos.z + math.random()*0.0879}, "torch:flame")
        end
		if minetest.env:get_node(pos).param2 == 2 then
			minetest.env:add_entity({x=pos.x+0.43 + math.random()*0.0879,y=pos.y+0.4 + math.random()*0.0879,z=pos.z + math.random()*0.0879}, "torch:flame")
        end
		if minetest.env:get_node(pos).param2 == 3 then
			minetest.env:add_entity({x=pos.x-0.43 + math.random()*0.0879,y=pos.y+0.4 + math.random()*0.0879,z=pos.z + math.random()*0.0879}, "torch:flame")
        end
		if minetest.env:get_node(pos).param2 == 4 then
			minetest.env:add_entity({x=pos.x + math.random()*0.0879,y=pos.y+0.4 + math.random()*0.0879,z=pos.z+0.43 + math.random()*0.0879}, "torch:flame")
        end
		if minetest.env:get_node(pos).param2 == 5 then
			minetest.env:add_entity({x=pos.x + math.random()*0.0879,y=pos.y+0.4 + math.random()*0.0879,z=pos.z-0.43 + math.random()*0.0879}, "torch:flame")
        end
	end,
})--]]


--crafty things
minetest.register_craft({
	output = 'torch:torch 4',
	recipe = {
		{'default:coal_lump'},
		{'default:stick'},
	}
})

--the actual torches
minetest.register_node("torch:torch", {
	description = "Torch",
	drawtype = "nodebox",
	inventory_image = "torch_wield.png",
	wield_image = "torch_wield.png",
	tiles = {"default_tree.png","default_wood.png","default_wood.png","default_wood.png","default_wood.png","default_wood.png"},
	paramtype = "light",
	paramtype2 = "wallmounted",
	legacy_wallmounted = true,
	sunlight_propagates = true,
	walkable = false,
	light_source = LIGHT_MAX,
	node_box = {
		type = "wallmounted",
		wall_bottom =  {-0.1,-0.5,-0.1, 0.1,0.2,0.1},
		wall_top =     {-0.1,0.5-0.6, -0.1, 0.1, 0.5, 0.1},
		wall_side =    {-0.5,-0.3,-0.1, -0.3, 0.3, 0.1},
	},
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, 0.2, 0.1},
		wall_side = {-0.5, -0.3, -0.1, -0.3, 0.3, 0.1},
	},
	groups = {tree=1,snappy=1,choppy=7,oddly_breakable_by_hand=6,attached_node=1},
})

--[[check if the torch is actually on a walkable node
minetest.register_abm(
        {nodenames = {"torch:torch"},
        interval = 1,
        chance = 1,
        action = function(pos)
		if minetest.env:get_node(pos).param2 == 0 and minetest.registered_nodes[minetest.env:get_node({x=pos.x,y=pos.y+1,z=pos.z}).name].walkable == false then
			minetest.env:remove_node(pos)
			minetest.env:add_item(pos, "torch:torch")
        end
		if minetest.env:get_node(pos).param2 == 1 and minetest.registered_nodes[minetest.env:get_node({x=pos.x,y=pos.y-1,z=pos.z}).name].walkable == false then
			minetest.env:remove_node(pos)
			minetest.env:add_item(pos, "torch:torch")
        end

		if minetest.env:get_node(pos).param2 == 2 and minetest.registered_nodes[minetest.env:get_node({x=pos.x+1,y=pos.y,z=pos.z}).name].walkable == false then
			minetest.env:remove_node(pos)
			minetest.env:add_item(pos, "torch:torch")
        end

		if minetest.env:get_node(pos).param2 == 3 and minetest.registered_nodes[minetest.env:get_node({x=pos.x-1,y=pos.y,z=pos.z}).name].walkable == false then
			minetest.env:remove_node(pos)
			minetest.env:add_item(pos, "torch:torch")
        end
		if minetest.env:get_node(pos).param2 == 4 and minetest.registered_nodes[minetest.env:get_node({x=pos.x,y=pos.y,z=pos.z+1}).name].walkable == false then
			minetest.env:remove_node(pos)
			minetest.env:add_item(pos, "torch:torch")
        end
		if minetest.env:get_node(pos).param2 == 5 and minetest.registered_nodes[minetest.env:get_node({x=pos.x,y=pos.y,z=pos.z-1}).name].walkable == false then
			minetest.env:remove_node(pos)
			minetest.env:add_item(pos, "torch:torch")
        end
	end,
})--]]