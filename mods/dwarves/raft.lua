--(C) darkrose

local players = {}
local times = {}

minetest.register_node("dwarves:wooden_raft", {
	description = "Wooden Raft",
	tile_images = {"default_wood.png"},
	is_ground_content = true,
	visual_scale = 1.5,
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("infotext","Wooden Raft")
	end,
	on_punch = function(pos,node,player)
		local name = player:get_player_name()
		local meta = minetest.env:get_meta(pos);
		if meta:get_string("player") == "" then
			players[name] = player;
			player:setpos({x=pos.x,y=pos.y+1,z=pos.z});
			meta:set_string("player",name)
			times[name] = 0
		end
	end,
	after_place_node = function(pos,player)
		local w = minetest.env:find_node_near(pos,1,{"default:water_source","default:water_source"})
		if not w then
			return
		end
		print("raft at "..minetest.pos_to_string(pos).." moving to "..minetest.pos_to_string(w))
		local i = minetest.env:get_node(pos)
		minetest.env:add_node(w,i)
		minetest.env:remove_node(pos)
	end,
})

minetest.register_craft({
	output = "dwarves:wooden_raft",
	recipe = {
		{'default:wood', 'default:wood',''},
		{'default:wood', 'default:wood', 'default:wood'},
		{'default:wood', 'default:wood',''},
	}
})

minetest.register_abm({
	nodenames = {"dwarves:wooden_raft"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.env:get_meta(pos);
		local name = meta:get_string("player")
		if name == "" then
			return
		end
		local player = players[name]
		if not player then
			return
		end
		
		local pp = player:getpos()
		if math.floor(pp.x) > math.ceil(pos.x) or math.floor(pp.z) > math.ceil(pos.z) or math.ceil(pp.x) < math.floor(pos.x) or math.ceil(pp.z) < math.floor(pos.z) then
			meta:set_string("player","")
			return
		end

		local tm = os.time()
		if times[name] == tm then
			return
		end
		times[name] = tm
		local meta0 = meta:to_table()
		local dir = player:get_look_dir()
		local np = {x=pos.x+dir.x,y=pos.y,z=pos.z+dir.z}
		if dir.x > 0.5 then
			np.x = pos.x+2
		end
		if dir.z > 0.5 then
			np.z = pos.z+2
		end
		if dir.x < -0.5 then
			np.x = pos.x-2
		end
		if dir.z < -0.5 then
			np.z = pos.z-2
		end
		local nn = minetest.env:get_node(np)
		local na = minetest.env:get_node({x=pos.x,y=pos.y+1,z=pos.z})
		if na and ( na.name == "default:water_source" or na.name == "default:water_flowing" ) then
			na = minetest.env:get_node({x=pos.x,y=pos.y-1,z=pos.z})
			meta:set_string("player","")
			if na and ( na.name == "default:water_source" or na.name == "default:water_flowing" ) then
				minetest.env:remove_node(pos)
				minetest.env:add_node({x=pos.x,y=pos.y-1,z=pos.z},node)
				meta = minetest.env:get_meta({x=pos.x,y=pos.y-1,z=pos.z})
				meta:from_table(meta0)
			end
			return
		elseif not nn or ( nn.name ~= "default:water_source" and nn.name ~= "default:water_flowing" ) then
			if dir.x > 0.5 then
				np.x = pos.x+1
			end
			if dir.z > 0.5 then
				np.z = pos.z+1
			end
			if dir.x < -0.5 then
				np.x = pos.x-1
			end
			if dir.z < -0.5 then
				np.z = pos.z-1
			end
			nn = minetest.env:get_node(np)
			if not nn or ( nn.name ~= "default:water_source" and nn.name ~= "default:water_flowing" ) then
				return
			end
		end
		minetest.env:add_node(pos,nn)
		minetest.env:add_node(np,node)
		meta = minetest.env:get_meta(np)
		meta:from_table(meta0)
		np.y = np.y+0.5
		player:setpos(np);
	end
})
