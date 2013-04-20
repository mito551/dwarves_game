local player_ges = 0
local player_in_bed = 0

minetest.register_node("papyrus_bed:bed_bottom", {
	description = "Papyrus bed",
	drawtype = "nodebox",
	tiles = {"papyrus_bed_bottom_above.png", "papyrus_bed_bottom_below.png", "papyrus_bed_bottom_side_right.png", "papyrus_bed_bottom_side_left.png", "papyrus_bed_brackets.png", "papyrus_bed_bottom_bottom.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
		-- bedspread
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

	on_construct = function(pos)
		local node = minetest.env:get_node(pos)
		local param2 = node.param2
		if param2 == 0 then
			node.name = "papyrus_bed:bed_top"
			pos.z = pos.z+1
			minetest.env:set_node(pos, node)
		elseif param2 == 1 then
			node.name = "papyrus_bed:bed_top"
			pos.x = pos.x+1
			minetest.env:set_node(pos, node)
		elseif param2 == 2 then
			node.name = "papyrus_bed:bed_top"
			pos.z = pos.z-1
			minetest.env:set_node(pos, node)
		elseif param2 == 3 then
			node.name = "papyrus_bed:bed_top"
			pos.x = pos.x-1
			minetest.env:set_node(pos, node)
		end
	end,

	on_destruct = function(pos)
		local node = minetest.env:get_node(pos)
		local param2 = node.param2
		if param2 == 0 then
			pos.z = pos.z+1
			minetest.env:remove_node(pos)
		elseif param2 == 1 then
			pos.x = pos.x+1
			minetest.env:remove_node(pos)
		elseif param2 == 2 then
			pos.z = pos.z-1
			minetest.env:remove_node(pos)
		elseif param2 == 3 then
			pos.x = pos.x-1
			minetest.env:remove_node(pos)
		end
	end,

	on_rightclick = function(pos, node, puncher)
		if not puncher:is_player() then
			return
		end
		if puncher:get_wielded_item():get_name() == "" then
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
			if puncher:get_player_name() == meta:get_string("player") then
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
				puncher:setpos(pos)
				meta:set_string("player", "")
				player_in_bed = player_in_bed-1
			elseif meta:get_string("player") == "" then
				pos.y = pos.y-0.5
				puncher:setpos(pos)
				meta:set_string("player", puncher:get_player_name())
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

minetest.register_on_joinplayer(function(pl)
	player_ges = player_ges+1
end)

minetest.register_on_leaveplayer(function(pl)
	player_ges = player_ges-1
end)

local timer = 0
local wait = false
minetest.register_globalstep(function(dtime)
	if timer<10 then
		timer = timer+dtime
	end
	timer = 0
	
	if player_ges == player_in_bed and player_ges ~= 0 then
		if minetest.env:get_timeofday() < 0.2 or minetest.env:get_timeofday() > 0.805 then
			if not wait then
			-- sound playback
				minetest.sound_play("papyrus_bed_snoring",{"papyrus_bed:bed", gain = 0.9, max_hear_distance = 10,})
			-- text message
				minetest.chat_send_all("Good night!")

				minetest.after(2, function()
					minetest.env:set_timeofday(0.23)
					wait = false
				end)
				wait = true
			end
		end
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

beds_player_spawns = {}
local file = io.open(minetest.get_worldpath().."/beds_player_spawns", "r")
if file then
	beds_player_spawns = minetest.deserialize(file:read("*all"))
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
				minetest.chat_send_all("Good night!!!")
				minetest.after(2, function()
					minetest.env:set_timeofday(0.23)
					wait = false
				end)
				wait = true
				for _,player in ipairs(minetest.get_connected_players()) do
					beds_player_spawns[player:get_player_name()] = player:getpos()
				end
				local file = io.open(minetest.get_worldpath().."/beds_player_spawns", "w")
				if file then
					file:write(minetest.serialize(beds_player_spawns))
					file:close()
				end
			end
		end
	end
end)

minetest.register_on_respawnplayer(function(player)
	local name = player:get_player_name()
	if beds_player_spawns[name] then
		player:setpos(beds_player_spawns[name])
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