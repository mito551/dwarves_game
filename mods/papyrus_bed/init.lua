local player_in_bed = 0
local guy
local hand
local old_yaw = 0

local function get_dir(pos)
	local btop = "papyrus_bed:bed_top"
	if minetest.env:get_node({x=pos.x+1,y=pos.y,z=pos.z}).name == btop then
		return 7.9
	elseif minetest.env:get_node({x=pos.x-1,y=pos.y,z=pos.z}).name == btop then
		return 4.75
	elseif minetest.env:get_node({x=pos.x,y=pos.y,z=pos.z+1}).name == btop then
		return 3.15
	elseif minetest.env:get_node({x=pos.x,y=pos.y,z=pos.z-1}).name == btop then
		return 6.28
	end
end

function plock(start, max, tick, player, yaw)
	if start+tick < max then
		player:set_look_pitch(-1.2)
		player:set_look_yaw(yaw)
		minetest.after(tick, plock, start+tick, max, tick, player, yaw) 
	else
		player:set_look_pitch(0)
		if old_yaw ~= 0 then minetest.after(0.1+tick, function() player:set_look_yaw(old_yaw) end) end
	end
end

function exit(pos)
	local npos = minetest.env:find_node_near(pos, 1, "papyrus_bed:bed_bottom")
	if npos ~= nil then pos = npos end
	if minetest.env:get_node({x=pos.x+1,y=pos.y,z=pos.z}).name == "air" then
		return {x=pos.x+1,y=pos.y,z=pos.z}
	elseif minetest.env:get_node({x=pos.x-1,y=pos.y,z=pos.z}).name == "air" then
		return {x=pos.x-1,y=pos.y,z=pos.z}
	elseif minetest.env:get_node({x=pos.x,y=pos.y,z=pos.z+1}).name == "air" then
		return {x=pos.x,y=pos.y,z=pos.z+1}
	elseif minetest.env:get_node({x=pos.x,y=pos.y,z=pos.z-1}).name == "air" then
		return {x=pos.x,y=pos.y,z=pos.z-1}
	else 
		return {x=pos.x,y=pos.y,z=pos.z}
	end
end

minetest.register_node("papyrus_bed:bed_bottom", {
	description = "Bed",
	inventory_image = "papyrus_bed_bed.png",
	wield_image = "papyrus_bed_bed.png",
	wield_scale = {x=0.8,y=2.5,z=1.3},
	drawtype = "nodebox",
	tiles = {"papyrus_bed_bottom_above.png", "papyrus_bed_bottom_below.png", "papyrus_bed_bottom_side_right.png", "papyrus_bed_bottom_side_left.png", "papyrus_bed_brackets.png", "papyrus_bed_bottom_bottom.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	stack_max = 1,
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
		-- papyrus_bedpread
					{-0.5, 0.3125, -0.5, 0.5, 0.4375, 0.5},
		-- frame and mattress
					{-0.5, -0.3125, -0.5, 0.5, 0.3125, 0.5},
		-- brackets
					{-0.5, -0.5, -0.5, -0.3125, -0.3125, -0.3125},
					{0.3125, -0.5, -0.5, 0.5, -0.3125, -0.3125},
				}
	},
	selection_box = {
		type = "fixed",
		fixed = {
					{-0.5, -0.5, -0.5, 0.5, 0.5, 1.5},
				}
	},
	
	after_place_node = function(pos, placer, itemstack)
		local node = minetest.env:get_node(pos)
		local param2 = node.param2
		local npos = {x=pos.x, y=pos.y, z=pos.z}
		if param2 == 0 then
			npos.z = npos.z+1
		elseif param2 == 1 then
			npos.x = npos.x+1
		elseif param2 == 2 then
			npos.z = npos.z-1
		elseif param2 == 3 then
			npos.x = npos.x-1
		end
		if minetest.registered_nodes[minetest.env:get_node(npos).name].buildable_to == true and minetest.env:get_node({x=npos.x, y=npos.y-1, z=npos.z}).name ~= "air" then
			minetest.env:set_node(npos, {name="papyrus_bed:bed_top", param2 = param2})
		else
			minetest.env:dig_node(pos)
			return true
		end
	end,	
	
	on_destruct = function(pos)
		pos = minetest.env:find_node_near(pos, 1, "papyrus_bed:bed_top")
		if pos ~= nil then minetest.env:remove_node(pos) end
	end,
	
	 on_rightclick = function(pos, node, clicker, itemstack)
		if not clicker:is_player() then
			return
		end

		if minetest.env:get_timeofday() > 0.2 and minetest.env:get_timeofday() < 0.805 then
			minetest.chat_send_all("You can only sleep at night")
			return
		else			
			clicker:set_physics_override(0,0,0)
			old_yaw = clicker:get_look_yaw()
			guy = clicker
			clicker:set_look_yaw(get_dir(pos))
			minetest.chat_send_all("Good night")
			plock(0,2,0.1,clicker, get_dir(pos))
		end

		if not clicker:get_player_control().sneak then
			local meta = minetest.env:get_meta(pos)
			local param2 = node.param2
			if param2 == 0 then
				pos.z = pos.z+1
			elseif param2 == 1 then
				pos.x = pos.x+1
			elseif param2 == 2 then
				pos.z = pos.z-1
			elseif param2 == 3 then
				pos.x = pos.x-1
			end
			if clicker:get_player_name() == meta:get_string("player") then
				if param2 == 0 then
					pos.x = pos.x-1
				elseif param2 == 1 then
					pos.z = pos.z+1
				elseif param2 == 2 then
					pos.x = pos.x+1
				elseif param2 == 3 then
					pos.z = pos.z-1
				end
				pos.y = pos.y-0.5
				clicker:setpos(pos)
				meta:set_string("player", "")
				player_in_bed = player_in_bed-1
			elseif meta:get_string("player") == "" then
				pos.y = pos.y-0.5
				clicker:setpos(pos)
				meta:set_string("player", clicker:get_player_name())
				player_in_bed = player_in_bed+1
			end
		end
	end
})

minetest.register_node("papyrus_bed:bed_top", {
	drawtype = "nodebox",
	tiles = {"papyrus_bed_top_above.png", "papyrus_bed_top_below.png", "papyrus_bed_top_side_right.png", "papyrus_bed_top_side_left.png", "papyrus_bed_top_top.png", "papyrus_bed_brackets.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
		-- headboard
					{-0.5, 0.3125, 0.4375, 0.5, 0.5, 0.5},
		-- pillow
					{-0.34375, 0.3125, 0.0, 0.34375, 0.375, 0.375},
		-- bedspread
					{-0.5, 0.3125, -0.5, 0.5, 0.4375, 0.0},
		-- frame and mattress
					{-0.5, -0.3125, -0.5, 0.5, 0.3125, 0.5},
		-- brackets
					{-0.5, -0.5, 0.3125, -0.3125, -0.3125, 0.5},
					{0.3125, -0.5, 0.3125, 0.5, -0.3125, 0.5},
				}
	},
	selection_box = {
		type = "fixed",
		fixed = {
					{0, 0, 0, 0, 0, 0},
				}
	},
})

minetest.register_alias("papyrus_bed:bed", "papyrus_bed:bed_bottom")

minetest.register_craft({
	output = "papyrus_bed:bed",
	recipe = {
		{"default:paper", "default:papyrus", "default:papyrus", },
		{"default:wood", "default:wood", "default:wood", },
		{"default:stick", "", "default:stick", }
	}
})

papyrus_bed_player_spawns = {}
local file = io.open(minetest.get_worldpath().."/papyrus_bed_player_spawns", "r")
if file then
	papyrus_bed_player_spawns = minetest.deserialize(file:read("*all"))
	file:close()
end

local timer = 0
local wait = false
minetest.register_globalstep(function(dtime)
	if timer<2 then
		timer = timer+dtime
		return
	end
	timer = 0
	
	local players = #minetest.get_connected_players()
	if players == player_in_bed and players ~= 0 then
		if minetest.env:get_timeofday() < 0.2 or minetest.env:get_timeofday() > 0.805 then
			if not wait then
				minetest.after(2, function()
					minetest.env:set_timeofday(0.23)
					wait = false
					guy:set_physics_override(1,1,1)
					guy:setpos(exit(guy:getpos()))
					
				end)
				wait = true
				for _,player in ipairs(minetest.get_connected_players()) do
					papyrus_bed_player_spawns[player:get_player_name()] = player:getpos()
				end
				local file = io.open(minetest.get_worldpath().."/papyrus_bed_player_spawns", "w")
				if file then
					file:write(minetest.serialize(papyrus_bed_player_spawns))
					file:close()
				end
			end
		end
	end
end)

minetest.register_on_respawnplayer(function(player)
	local name = player:get_player_name()
	if papyrus_bed_player_spawns[name] then
		player:setpos(papyrus_bed_player_spawns[name])
		return true
	end
end)

minetest.register_abm({
	nodenames = {"papyrus_bed:bed_bottom"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		local meta = minetest.env:get_meta(pos)
		if meta:get_string("player") ~= "" then
			local param2 = node.param2
			if param2 == 0 then
				pos.z = pos.z+1
			elseif param2 == 1 then
				pos.x = pos.x+1
			elseif param2 == 2 then
				pos.z = pos.z-1
			elseif param2 == 3 then
				pos.x = pos.x-1
			end
			local player = minetest.env:get_player_by_name(meta:get_string("player"))
			if player == nil then
				meta:set_string("player", "")
				player_in_bed = player_in_bed-1
				return
			end
			local player_pos = player:getpos()
			player_pos.x = math.floor(0.5+player_pos.x)
			player_pos.y = math.floor(0.5+player_pos.y)
			player_pos.z = math.floor(0.5+player_pos.z)
			if pos.x ~= player_pos.x or pos.y ~= player_pos.y or pos.z ~= player_pos.z then
				meta:set_string("player", "")
				player_in_bed = player_in_bed-1
				return
			end
		end
	end
})

if minetest.setting_get("log_mods") then
	minetest.log("action", "papyrus_bed loaded")
end
