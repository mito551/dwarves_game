drowning = {}	-- Exported functions

local players_under_water = {}
local drowning_seconds = {}

local START_DROWNING_SECONDS = 32
local FACTOR_DROWNING_SECONDS = 2
local MIN_DROWNING_SECONDS = 1
local DROWNING_DAMAGE = 1

local timer = 0
if minetest.setting_getbool("enable_damage") == true then
minetest.register_globalstep(function(dtime)
	timer = timer + dtime
	if timer >= .5 then
		timer = timer - .5
	else
		return
	end
	for _,player in ipairs(minetest.get_connected_players()) do
			local player_name = player:get_player_name()
			if players_under_water[player_name] == nil then
				players_under_water[player_name] = {count=0}
			end
			if drowning_seconds[player_name] == nil then
				drowning_seconds[player_name] = START_DROWNING_SECONDS
			end
			-- Lua interpretes nil and 0 as true
			if PlayerNotInLiquid(player) == false then
				players_under_water[player_name].count = players_under_water[player_name].count + .5
				if players_under_water[player_name].count >= drowning_seconds[player_name] then
					if player:get_hp() > 0 then
						player:set_hp(player:get_hp() - DROWNING_DAMAGE)
						pos = player:getpos()
						pos.y=pos.y+1
						minetest.sound_play({name="drowning_gurp"}, {pos = pos, gain = 1.0, max_hear_distance = 16})
						players_under_water[player_name].count = players_under_water[player_name].count - drowning_seconds[player_name]
						drowning_seconds[player_name] = math.floor(drowning_seconds[player_name]/FACTOR_DROWNING_SECONDS)
						if drowning_seconds[player_name] < MIN_DROWNING_SECONDS then
							drowning_seconds[player_name] = MIN_DROWNING_SECONDS
						end
					else
						players_under_water[player_name] = {count=0}
						drowning_seconds[player_name] = START_DROWNING_SECONDS
					end
				end
			elseif players_under_water[player_name].count > 0 then
				pos = player:getpos()
				pos.y=pos.y+1
				minetest.sound_play({name="drowning_gasp"}, {pos = pos, gain = 1.0, max_hear_distance = 32})
				players_under_water[player_name] = {count=0}
				drowning_seconds[player_name] = START_DROWNING_SECONDS
			end
	end
end)
end

function PlayerNotInLiquid(player)
	local pos = player:getpos()
	pos.x = math.floor(pos.x+0.5)
	pos.y = math.floor(pos.y+2.0)
	pos.z = math.floor(pos.z+0.5)
	
	-- getting nodename at players head
	n_head = minetest.env:get_node(pos).name
	-- checking if node is liquid (0=not 2=lava 3=water) then player is underwater
	-- this includes flowing water and flowing lava
	if minetest.get_item_group(n_head, "liquid") ~= 0 then
		return false
	end
	return true
end

minetest.register_on_respawnplayer(function(player)
			local player_name = player:get_player_name()
			players_under_water[player_name] = {count=0}
			drowning_seconds[player_name] = START_DROWNING_SECONDS
end)