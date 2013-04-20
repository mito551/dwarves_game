--tuned/translated by ibanez
local players = {}
local player_positions = {}
local last_wielded = {}

function round(num) 
	return math.floor(num + 0.5) 
end

minetest.register_on_joinplayer(function(player)
	local player_name = player:get_player_name()
	table.insert(players, player_name)
	last_wielded[player_name] = player:get_wielded_item():get_name()
	local pos = player:getpos()
	local rounded_pos = {x=round(pos.x),y=round(pos.y)+1,z=round(pos.z)}
	local wielded_item = check_for_torch(player)
	if wielded_item ~= "default:torch" and wielded_item ~= "walking_light:pick_mese" then
		-- Neuberechnung des Lichts erzwingen
		-- Reset the old light value to default
		minetest.env:add_node(rounded_pos,{type="node",name="air"})
	end
	player_positions[player_name] = {}
	player_positions[player_name]["x"] = rounded_pos.x;
	player_positions[player_name]["y"] = rounded_pos.y;
	player_positions[player_name]["z"] = rounded_pos.z;
end)

minetest.register_on_leaveplayer(function(player)
	local player_name = player:get_player_name()
	for i,v in ipairs(players) do
		if v == player_name then 
			table.remove(players, i)
			last_wielded[player_name] = nil
			-- Neuberechnung des Lichts erzwingen
			-- Reset the old light value to default
			local pos = player:getpos()
			local rounded_pos = {x=round(pos.x),y=round(pos.y)+1,z=round(pos.z)}
			minetest.env:add_node(rounded_pos,{type="node",name="air"})
			player_positions[player_name]["x"] = nil
			player_positions[player_name]["y"] = nil
			player_positions[player_name]["z"] = nil
			player_positions[player_name]["m"] = nil
			player_positions[player_name] = nil
		end
	end
end)

minetest.register_globalstep(function(dtime)
	for i,player_name in ipairs(players) do
		local player = minetest.env:get_player_by_name(player_name)
		local wielded_item = player:get_wielded_item():get_name()
		if wielded_item == "default:torch" or wielded_item == "walking_light:pick_mese" then
			-- Fackel ist in der Hand
			-- Check if the player wields a torch
			local pos = player:getpos()
			local rounded_pos = {x=round(pos.x),y=round(pos.y)+1,z=round(pos.z)}
			if (last_wielded[player_name] ~= "default:torch" and last_wielded[player_name] ~= "walking_light:pick_mese") or (player_positions[player_name]["x"] ~= rounded_pos.x or player_positions[player_name]["y"] ~= rounded_pos.y or player_positions[player_name]["z"] ~= rounded_pos.z) then
				-- Fackel gerade in die Hand genommen oder zu neuem Node bewegt
				-- Check what the node is
				local is_air  = minetest.env:get_node_or_nil(rounded_pos)
				if is_air == nil or (is_air ~= nil and (is_air.name == "air" or is_air.name == "walking_light:light")) then
					-- Wenn an aktueller Position "air" ist, Fackellicht setzen
					-- If the current position is air, light it up!
					minetest.env:add_node(rounded_pos,{type="node",name="walking_light:light"})
				end
				if (player_positions[player_name]["x"] ~= rounded_pos.x or player_positions[player_name]["y"] ~= rounded_pos.y or player_positions[player_name]["z"] ~= rounded_pos.z) then
					-- wenn Position geander, dann altes Licht loschen
					-- when position changes, then deleting the original light
					local old_pos = {x=player_positions[player_name]["x"], y=player_positions[player_name]["y"], z=player_positions[player_name]["z"]}
					-- Neuberechnung des Lichts erzwingen
					-- Reset the old light value to default
					local is_light = minetest.env:get_node_or_nil(old_pos)
					if is_light ~= nil and is_light.name == "walking_light:light" then
						minetest.env:add_node(old_pos,{type="node",name="air"})
					end
				end
				-- gemerkte Position ist nun die gerundete neue Position
				-- Players position for light is now the new position
				player_positions[player_name]["x"] = rounded_pos.x
				player_positions[player_name]["y"] = rounded_pos.y
				player_positions[player_name]["z"] = rounded_pos.z
			end

			last_wielded[player_name] = wielded_item;
		elseif last_wielded[player_name] == "default:torch" or last_wielded[player_name] == "walking_light:pick_mese" then
			-- Fackel nicht in der Hand, aber beim letzten Durchgang war die Fackel noch in der Hand
			-- Check if where the player is wielding his torch is already lit up
			local pos = player:getpos()
			local rounded_pos = {x=round(pos.x),y=round(pos.y)+1,z=round(pos.z)}
			repeat
				local is_light  = minetest.env:get_node_or_nil(rounded_pos)
				if is_light ~= nil and is_light.name == "walking_light:light" then
					-- Erzwinge Neuberechnung des Lichts
					-- Reset the old light value to default
					minetest.env:add_node(rounded_pos,{type="node",name="air"})
				end
			until minetest.env:get_node_or_nil(rounded_pos) ~= "walking_light:light"
			local old_pos = {x=player_positions[player_name]["x"], y=player_positions[player_name]["y"], z=player_positions[player_name]["z"]}
			repeat
				is_light  = minetest.env:get_node_or_nil(old_pos)
				if is_light ~= nil and is_light.name == "walking_light:light" then
					-- Erzwinge Neuberechnung des Lichts
					-- Reset the old light value to default
					minetest.env:add_node(old_pos,{type="node",name="air"})
				end
			until minetest.env:get_node_or_nil(old_pos) ~= "walking_light:light"
			last_wielded[player_name] = wielded_item
		end
	end
end)

minetest.register_node("walking_light:light", {
	drawtype = "glasslike",
	tile_images = {"walking_light.png"},
	inventory_image = minetest.inventorycube("walking_light.png"),
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	light_propagates = true,
	sunlight_propagates = true,
	light_source = 13,
	selection_box = {
        type = "fixed",
        fixed = {0, 0, 0, 0, 0, 0},
    },
})
minetest.register_tool("walking_light:pick_mese", {
	description = "Mese Pickaxe with light",
	inventory_image = "walking_light_mesepick.png",
	wield_image = "default_tool_mesepick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			cracky={times={[1]=2.0, [2]=1.0, [3]=0.5}, uses=20, maxlevel=3},
			crumbly={times={[1]=2.0, [2]=1.0, [3]=0.5}, uses=20, maxlevel=3},
			snappy={times={[1]=2.0, [2]=1.0, [3]=0.5}, uses=20, maxlevel=3}
		}
	},
})

minetest.register_craft({
	output = 'walking_light:pick_mese',
	recipe = {
		{'default:torch'},
		{'default:pick_mese'},
	}
})

--Thanks, RBA!
function check_for_torch (player)
if player==nil then return false end
local inv = player:get_inventory()
local hotbar=inv:get_list("main")
for index=1,8,1 do
    if hotbar[index]:get_name() == "default:torch" then
        return "default:torch"
    end
end
return false
end    