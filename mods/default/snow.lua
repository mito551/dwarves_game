---
---AFTERPARTY SNOW ---
---

minetest.register_node("default:needles", {
	description = "Pine Needles",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"snow_needles.png"},
	paramtype = "light",
	groups = {snappy=6, leafdecay=3, flammable=2},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get xmas tree with 1/50 chance
				items = {'default:xmas_tree'},
				rarity = 50,
			},
			{
				-- player will get sapling with 1/20 chance
				items = {'default:sapling_pine'},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {'default:needles'},
			}
		}
	},
	--Remove snow above leaves after decay.
	after_destruct = function(pos, node, digger)
		pos.y = pos.y + 1
		local nodename = minetest.get_node(pos).name
		if nodename == "default:snow" then
			minetest.remove_node(pos)
		end
	end,
	sounds = default.node_sound_leaves_defaults(),
})

--Decorated Pine leaves.
minetest.register_node("default:needles_decorated", {
	description = "Decorated Pine Needles",
	drawtype = "allfaces_optional",
	tiles = {"snow_needles_decorated.png"},
	paramtype = "light",
	groups = {snappy=6, leafdecay=3, flammable=2},
		drop = {
		max_items = 1,
		items = {
			{
				-- player will get xmas tree with 1/20 chance
				items = {'default:xmas_tree'},
				rarity = 50,
			},
			{
				-- player will get sapling with 1/20 chance
				items = {'default:sapling_pine'},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {'default:needles_decorated'},
			}
		}
	},
	--Remove snow above leaves after decay.
	after_destruct = function(pos, node, digger)
		pos.y = pos.y + 1
		local nodename = minetest.get_node(pos).name
		if nodename == "default:snow" then
			minetest.remove_node(pos)
		end
	end,
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("default:xmas_tree", {
	description = "Christmas Tree",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"snow_xmas_tree.png"},
	inventory_image = "snow_xmas_tree.png",
	wield_image = "snow_xmas_tree.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=7,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("default:sapling_pine", {
	description = "Pine Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"snow_sapling_pine.png"},
	inventory_image = "snow_sapling_pine.png",
	wield_image = "snow_sapling_pine.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=7,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("default:star", {
	description = "Star",
	drawtype = "torchlike",
	tiles = {"snow_star.png"},
	inventory_image = "snow_star.png",
	wield_image = "snow_star.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=7,dig_immediate=3},
	sounds = default.node_sound_defaults(),
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:needles",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:sapling_pine",
	burntime = 10,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:needles_decorated",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:xmas_tree",
	burntime = 10,
})



--Snowballs
-------------
snowball_GRAVITY=9
snowball_VELOCITY=19

--Shoot snowball.
local snow_shoot_snowball=function (item, player, pointed_thing)
	local playerpos=player:getpos()
	local obj=minetest.add_entity({x=playerpos.x,y=playerpos.y+1.5,z=playerpos.z}, "default:snowball_entity")
	local dir=player:get_look_dir()
	obj:setvelocity({x=dir.x*snowball_VELOCITY, y=dir.y*snowball_VELOCITY, z=dir.z*snowball_VELOCITY})
	obj:setacceleration({x=dir.x*-3, y=-snowball_GRAVITY, z=dir.z*-3})
	item:take_item()
	return item
end

--The snowball Entity
snow_snowball_ENTITY={
	physical = false,
	timer=0,
	textures = {"snow_snowball.png"},
	lastpos={},
	collisionbox = {0,0,0,0,0,0},
}

--Snowball_entity.on_step()--> called when snowball is moving.
snow_snowball_ENTITY.on_step = function(self, dtime)
	self.timer=self.timer+dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	--Become item when hitting a node.
	if self.lastpos.x~=nil then --If there is no lastpos for some reason.
		if node.name ~= "air" then
			minetest.place_node(self.lastpos,{name="default:snow"})
			self.object:remove()
		end
	end
	self.lastpos={x=pos.x, y=pos.y, z=pos.z} -- Set lastpos-->Node will be added at last pos outside the node
end

minetest.register_entity("default:snowball_entity", snow_snowball_ENTITY)

--Snowball.
minetest.register_craftitem("default:snowball", {
	description = "Snowball",
	inventory_image = "snow_snowball.png",
	on_use = snow_shoot_snowball,
})

--Snow.
minetest.register_node("default:snow", {
	description = "Snow",
	tiles = {"snow_snow.png"},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = "light",
	param2 = nil,
	--param2 is reserved for what vegetation is hiding inside.
	--mapgen defines the vegetation.
	--1 = Moss
	groups = {crumbly=3,melts=3},
	buildable_to = true,
	drop = 'default:snowball',
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.35, 0.5}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.35, 0.5}
		},
	},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_snow_footstep", gain=0.45},
	}),
	--Update dirt node underneath default.
	after_destruct = function(pos, node, digger)
		if node.param2 == 1 then
			local n = minetest.get_node(pos).name
			if  n == "air" or n == "default:water_flowing" or n == "default:water_source" then
				minetest.add_node(pos,{name="default:moss",param2=1})
			end
		end
		pos.y = pos.y - 1
		local nodename = minetest.get_node(pos).name
		if nodename == "default:dirt_with_snow" then
			minetest.add_node(pos,{name="default:dirt_with_grass"})
		end
	end,
	on_construct = function(pos, newnode)
		pos.y = pos.y - 1
		local nodename = minetest.get_node(pos).name
		if nodename == "default:dirt_with_grass" then
			minetest.remove_node(pos)
			minetest.add_node(pos,{name="default:dirt_with_snow"})
		elseif nodename == "air" then
			pos.y = pos.y + 1
			minetest.remove_node(pos)
		end
	end,
})

--Snow with dirt.
minetest.register_node("default:dirt_with_snow", {
	description = "Dirt with Snow",
	tiles = {"snow_snow.png", "default_dirt.png", "default_dirt.png^snow_snow_side.png"},
	is_ground_content = true,
	groups = {crumbly=6},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_snow_footstep", gain=0.4},
	}),
	--Place snow above this node when placed.
	after_place_node = function(pos, newnode)
		pos.y = pos.y + 1
		local nodename = minetest.get_node(pos).name
		if nodename == "air" then
			minetest.add_node(pos,{name="default:snow"})
		end
	end,
})

--Gets rid of snow when the node underneath is dug.
local unsnowify = function(pos, node, digger)
	if node.name == "default:dry_shrub" then
		pos.y = pos.y - 1
		local nodename = minetest.get_node(pos).name
		if nodename == "default:dirt_with_snow" then
			minetest.add_node(pos,{name="default:dirt_with_grass"})
		end
		pos.y = pos.y + 1
	end
	pos.y = pos.y + 1
	local nodename = minetest.get_node(pos).name
	if nodename == "default:snow" then
		minetest.remove_node(pos)
		local obj=minetest.add_entity({x=pos.x,y=pos.y,z=pos.z}, "default:snowball_entity")
		obj:setacceleration({x=0, y=-snowball_GRAVITY, z=0})
	end
end

minetest.register_on_dignode(unsnowify)

--Snow block.
minetest.register_node("default:snow_block", {
	description = "Snow",
	tiles = {"snow_snow.png"},
	--param2 is reserved for what vegetation is hiding inside.
	--mapgen defines the vegetation.
	--1 = Moss
	--2 = Papyrus
	--3 = Dry shrub
	is_ground_content = true,
	groups = {crumbly=6,melts=2,falling_node=1},
	drop = 'default:snow_block',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
	--Update dirt node underneath default.
	after_destruct = function(pos, node, digger)
		if node.param2 == 1 then
			local n = minetest.get_node(pos).name
			if  n == "air" or n == "default:water_flowing" or n == "default:water_source" then
				minetest.add_node(pos,{name="default:moss",param2=1})
			end
		elseif node.param2 == 2 then
			local n = minetest.get_node(pos).name
			if  n == "air" or n == "default:water_flowing" or n == "default:water_source" then
				minetest.add_node(pos,{name="default:papyrus"})
				pos.y = pos.y + 1 
				local n =  minetest.get_node(pos)
				if n.name == "default:snow_block" and n.param2 == 2 then
					minetest.remove_node(pos)
					pos.y = pos.y - 1 
					minetest.add_node(pos,{name="default:snow_block",param2=2})
				end
			end
		elseif node.param2 == 3 then
			local n = minetest.get_node(pos).name
			if  n == "air" or n == "default:water_flowing" or n == "default:water_source" then
				minetest.add_node(pos,{name="default:dry_shrub"})
			end
		end
	end,
})

--Snow brick.
minetest.register_node("default:snow_brick", {
	description = "Snow Brick",
	tiles = {"snow_snow_brick.png"},
	is_ground_content = true,
	groups = {crumbly=5,melts=2},
	drop = 'default:snow_brick',
	sounds = default.node_sound_dirt_defaults(),
})

--Ice.
minetest.register_node("default:ice", {
	description = "Ice",
	tiles = {"snow_ice.png"},
	is_ground_content = true,
	use_texture_alpha = true,
	drawtype = "glasslike",
	groups = {snappy=5,cracky=5,melts=1},
	drop = 'default:ice',
	paramtype = "light",
	sunlight_propagates = true,
	sounds = default.node_sound_glass_defaults(),
})

--Moss.
minetest.register_node("default:moss", {
	description = "Moss",
	tiles = {"snow_moss.png"},
	drawtype = "signlike",
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	selection_box = {
		type = "wallmounted",
	},
	is_ground_content = true,
	groups = {crumbly=7, flammable=2, attached_node=1},
})

minetest.register_craft({
    output = 'default:snow_block',
    recipe = {
        {'default:snowball', 'default:snowball'},
        {'default:snowball', 'default:snowball'},
    },
})

minetest.register_craft({
    output = 'default:snow_brick',
    recipe = {
        {'default:snow_block', 'default:snow_block'},
        {'default:snow_block', 'default:snow_block'},
    },
})

local function stop_slip(player, time)
	minetest.after(time, function()
		player:set_physics_override(1, 1, 1)
	end)
end

local SLIPPERY_ICE = true  --experimental and default disabled

--ice (slippery)
if SLIPPERY_ICE then --experimental
minetest.register_abm({
	nodenames = {"default:ice"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		for _,object in ipairs(minetest.get_objects_inside_radius(pos, 0.9)) do
			if object:is_player() then
				--minetest.sound_play("dplus_hurt", {pos = pos, gain = 0.5, max_hear_distance = 10})
				object:set_physics_override(0.8, 1, 1)--(speed, jump, gravity)
				local po = object:getpos()
				local dir = object:get_look_dir()
				local tab = object:get_player_control()
					if tab["right"] or tab["left"] or tab["down"] or tab["up"] then
						--object:setpos({x=po.x+math.ceil(dir.x)*i,y=po.y, z=po.z+math.ceil(dir.z)*i}, true)
						object:moveto({x=po.x+math.ceil(dir.x)*0.03,y=po.y, z=po.z+math.ceil(dir.z)*0.03}, true)
			end
				stop_slip(object, 1)
			end
		end
	end})
end

--remove dirt_with_snow (when snow digged)
minetest.register_on_dignode(function(pos, oldnode, digger)
	if oldnode.name == "default:snow" then
		pos.y = pos.y-1
		if minetest.get_node(pos).name == "default:dirt_with_snow" then
			minetest.set_node(pos, {name="default:dirt_with_grass"})
		end
	end
end)


--Melting
--Any node part of the group melting will melt when near warm nodes such as lava, fire, torches, etc.
--The amount of water that replaces the node is defined by the number on the group:
--1: one water_source
--2: four water_flowings
--3: one water_flowing
minetest.register_abm({
    nodenames = {"group:melts"},
    neighbors = {"group:igniter","default:torch","default:furnace_active","group:hot"},
    interval = 2,
    chance = 2,
    action = function(pos, node, active_object_count, active_object_count_wider)
		local intensity = minetest.get_item_group(node.name,"melts")
		if intensity == 1 then
			minetest.add_node(pos,{name="default:water_source"})
		elseif intensity == 2 then
			local check_place = function(pos,node)
				if minetest.get_node(pos).name == "air" then
					minetest.place_node(pos,node)
				end
			end
			minetest.add_node(pos,{name="default:water_flowing"})
			check_place({x=pos.x+1,y=pos.y,z=pos.z},{name="default:water_flowing"})
			check_place({x=pos.x-1,y=pos.y,z=pos.z},{name="default:water_flowing"})
			check_place({x=pos.x,y=pos.y+1,z=pos.z},{name="default:water_flowing"})
			check_place({x=pos.x,y=pos.y-1,z=pos.z},{name="default:water_flowing"})
		elseif intensity == 3 then
			minetest.add_node(pos,{name="default:water_flowing"})
		end
		nodeupdate(pos)
    end,
})

--Freezing
--Water freezes when in contact with default.
minetest.register_abm({
    nodenames = {"default:water_source"},
    neighbors = {"default:snow", "default:snow_block"},
    interval = 20,
    chance = 4,
    action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.add_node(pos,{name="default:ice"})
    end,
})

--Spread moss to cobble.
minetest.register_abm({
    nodenames = {"default:cobble"},
    neighbors = {"default:moss"},
    interval = 20,
    chance = 6,
    action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.add_node(pos,{name="default:mossycobble"})
    end,
})

--Grow saplings
minetest.register_abm({
    nodenames = {"default:sapling_pine"},
    interval = 10,
    chance = 50,
    action = function(pos, node, active_object_count, active_object_count_wider)
		default.make_pine(pos,false)
    end,
})

--Grow saplings
minetest.register_abm({
    nodenames = {"default:xmas_tree"},
    interval = 10,
    chance = 50,
    action = function(pos, node, active_object_count, active_object_count_wider)
		default.make_pine(pos,false,true)
    end,
})

if default.enable_snowfall then

	--Snowing
	snow_fall=function (pos)
		local obj=minetest.add_entity(pos, "default:fall_entity")
		obj:setvelocity({x=0, y=-1, z=0})
	end

	-- The snowfall Entity
	snow_fall_ENTITY={
		physical = true,
		timer=0,
		textures = {"snow_snowfall.png"},
		lastpos={},
		collisionbox = {0,0,0,0,0,0},
	}


	-- snowfall_entity.on_step()--> called when snow is falling
	snow_fall_ENTITY.on_step = function(self, dtime)
		self.timer=self.timer+dtime
		local pos = self.object:getpos()
		local node = minetest.get_node(pos)

		if self.lastpos and self.object:getvelocity().y == 0 then
			if minetest.get_node({x=self.lastpos.x,z=self.lastpos.z,y=self.lastpos.y}).name == "default:moss" then
				minetest.add_node({x=self.lastpos.x,z=self.lastpos.z,y=self.lastpos.y},{name="default:snow",param2=1})
				self.object:remove()
				return
			end
			minetest.place_node(self.lastpos,{name="default:snow"})
			self.object:remove()
		end
		
		if self.timer > 120 then
			self.object:remove()
		end

		self.lastpos={x=pos.x, y=pos.y, z=pos.z} -- Set lastpos-->Node will be added at last pos outside the node
	end

	minetest.register_entity("default:fall_entity", snow_fall_ENTITY)

	--Regenerate Snow
	minetest.register_abm({
		nodenames = {"default:dirt_with_grass", "default:desert_sand", "default:moss"},
		interval = 50,
		chance = 150,
		action = function(pos, node, active_object_count, active_object_count_wider)
			--Check we are in the right biome
			local env = minetest.env
			local perlin1 = env:get_perlin(112,3, 0.5, 150)
			local test = perlin1:get2d({x=pos.x, y=pos.z})
			local in_biome = false
			local smooth = default.smooth
			if smooth and (test > 0.73 or (test > 0.43 and math.random(0,29) > (0.73 - test) * 100 )) then
				in_biome = true
			elseif not smooth and test > 0.53 then
				in_biome = true
			end
			if in_biome then
				--Check if block is under cover
				local ground_y = nil
				for y=15,0,-1 do
					if env:get_node({x=pos.x,y=y+pos.y,z=pos.z}).name ~= "air" then
						ground_y = pos.y+y
						break
					end
				end
				if ground_y then
					local n = env:get_node({x=pos.x,y=ground_y,z=pos.z})
					if (n.name ~= "default:snow" and n.name ~= "default:snow_block" and n.name ~= "default:ice" and n.name ~= "default:water_source" and n.name ~= "default:papyrus") then
						local obj = minetest.get_objects_inside_radius({x=pos.x,y=ground_y+20,z=pos.z}, 15)
						for i,v in pairs(obj) do
							e = v:get_luaentity()
							if e ~= nil and e.name == "default:fall_entity" then 
								return
							end
						end
						snow_fall({x=pos.x,y=ground_y+15,z=pos.z})
						if default.debug then
							print("snowfall at x"..pos.x.." y"..pos.z)
						end
					end
				end
			end
		end
	})
end

minetest.register_alias("snow:snow", "default:snow")
minetest.register_alias("snow:ice", "default:ice")
minetest.register_alias("default:moss", "dwarves:moss")
minetest.register_alias("snow:dirt_with_snow", "default:dirt_with_snow")
minetest.register_alias("snow:snow_block", "default:snow_block")
minetest.register_alias("snow:snowball", "default:snowball")
minetest.register_alias("snow:needles", "default:needles")
minetest.register_alias("snow:snow_brick", "default:snow_brick")

