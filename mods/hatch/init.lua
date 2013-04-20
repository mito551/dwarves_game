----trapdoor----

local me
local meta
local state = 0

local function update_door(pos, node) 
	minetest.env:set_node(pos, node)
end

local function punch(pos)
	meta = minetest.env:get_meta(pos)
	state = meta:get_int("state")
	me = minetest.env:get_node(pos)
	local tmp_node
	local tmp_node2
	oben = {x=pos.x, y=pos.y+1, z=pos.z}
		if state == 1 then
			state = 0
			minetest.sound_play("door_close", {pos = pos, gain = 0.3, max_hear_distance = 10})
			tmp_node = {name="hatch:trapdoor", param1=me.param1, param2=me.param2}
		else
			state = 1
			minetest.sound_play("door_open", {pos = pos, gain = 0.3, max_hear_distance = 10})
			tmp_node = {name="hatch:trapdoor_open", param1=me.param1, param2=me.param2}
		end
		update_door(pos, tmp_node)
		meta:set_int("state", state)
end


minetest.register_node("hatch:trapdoor", {
	description = "Trapdoor",
	inventory_image = "door_trapdoor.png",
	drawtype = "nodebox",
	tiles = {"door_trapdoor.png", "door_trapdoor.png",  "default_wood.png",  "default_wood.png", "default_wood.png", "default_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=2,door=1},
	sounds = default.node_sound_wood_defaults(),
	drop = "hatch:trapdoor",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	on_creation = function(pos)
		state = 0
	end,
	on_rightclick = function(pos, node, clicker)
		punch(pos)
	end,
})


minetest.register_node("hatch:trapdoor_open", {
	drawtype = "nodebox",
	tiles = {"default_wood.png", "default_wood.png",  "default_wood.png",  "default_wood.png", "door_trapdoor.png", "door_trapdoor.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	pointable = true,
	stack_max = 0,
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=2,door=1},
	sounds = default.node_sound_wood_defaults(),
	drop = "hatch:trapdoor",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0.4, 0.5, 0.5, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0.4, 0.5, 0.5, 0.5}
	},
	on_rightclick = function(pos, node, clicker)
		punch(pos)
	end,
})




minetest.register_craft({
	output = 'hatch:trapdoor 2',
	recipe = {
		{'group:wood', 'default:stick', 'group:wood'},
		{'group:wood', 'default:stick', 'group:wood'},
		{'', '', ''},
	}
})