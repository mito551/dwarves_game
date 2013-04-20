-- init.lua
--
-- workbench minetest mod, by darkrose
-- Copyright (C) Lisa Milne 2012 <lisa@ltmnet.com>
--
-- updated by cornernote
-- Copyright (C) Brett O'Donnell 2012 <cornernote@gmail.com>
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU Lesser General Public License as
-- published by the Free Software Foundation, either version 2.1 of the
-- License, or (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful, but
-- WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
-- Lesser General Public License for more details.
--
-- You should have received a copy of the GNU Lesser General Public
-- License along with this program.  If not, see
-- <http://www.gnu.org/licenses/>


-- set inventory_craft_small=1 in minetest.conf to limit inventory craft to 2x2
--[[if minetest.setting_getbool("inventory_craft_small")
	and not minetest.setting_getbool("creative_mode")
	and not minetest.get_modpath("inventory_plus") then
		minetest.register_on_joinplayer(function(player)
			player:get_inventory():set_width("craft", 2)
			player:get_inventory():set_size("craft", 2*2)
			player:set_inventory_formspec("size[8,7.5]"
				.."list[current_player;main;0,3.5;8,4;]"
				.."list[current_player;craft;3,0.5;2,2;]"
				.."list[current_player;craftpreview;6,1;1,1;]")
		end)
else
	minetest.register_on_joinplayer(function(player)
		player:get_inventory():set_width("craft", 3)
		player:get_inventory():set_size("craft", 3*3)
	end)
end--]]

-- expose api
workbench = {}

-- on_construct
workbench.on_construct = function(pos)
	local width = minetest.get_item_group(minetest.env:get_node(pos).name, "craft_width")
	local meta = minetest.env:get_meta(pos)
	local inv = meta:get_inventory()
	inv:set_size("craftresult", 1)
	inv:set_size("table", width*width)
	inv:set_width("craft", width)
	meta:set_string("formspec", "size[8,"..(width+4.5).."]"
		.."list[current_name;craftresult;6,2;1,1;]"
		.."list[current_player;main;0,"..(width+0.5)..";8,4;]"
		.."list[current_name;table;0,0;"..width..","..width..";]")
	meta:set_string("infotext", width.."x"..width.." WorkBench")
	meta:set_int("width", width)
end

-- can_dig
workbench.can_dig = function(pos,player)
	local meta = minetest.env:get_meta(pos);
	local inv = meta:get_inventory()
	if inv:is_empty("table") and inv:is_empty("craftresult") then
		return true
	end
	return false
end

-- allow_metadata_inventory_move
workbench.allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
	if to_list == "craftresult" then
		return 0
	end
	if to_list == "table" then
		workbench.update_inventory(pos, true, true)
	end
	return count
end

-- allow_metadata_inventory_put
workbench.allow_metadata_inventory_put = function(pos, listname, index, stack, player)
	if listname == "craftresult" then
		return 0
	end
	return stack:get_count()
end

-- allow_metadata_inventory_take
workbench.allow_metadata_inventory_take = function(pos, listname, index, stack, player)
	return stack:get_count()
end

-- on_metadata_inventory_move
workbench.on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
	if to_list == "table" then
		workbench.update_inventory(pos)
	end
end

-- on_metadata_inventory_put
workbench.on_metadata_inventory_put = function(pos, listname, index, stack, player)
	if listname == "table" then
		workbench.update_inventory(pos)
	end
end

-- on_metadata_inventory_take
workbench.on_metadata_inventory_take = function(pos, listname, index, count, player)
	if listname == "table" then
		workbench.update_inventory(pos)
	elseif listname == "craftresult" then
		workbench.update_inventory(pos, true)
	end
end

-- update_inventory
workbench.update_inventory = function(pos,update_table,skip_update_craft)
	local meta = minetest.env:get_meta(pos)
	local inv = meta:get_inventory()
	local width = meta:get_int("width")
	local tablelist = inv:get_list("table")
	local crafted = nil
	local table_dec = nil

	-- update table
	if update_table then
		-- get craft result
		if tablelist then
			_, table_dec = minetest.get_craft_result({method = "normal", width = width, items = tablelist})
		end
		-- update table
		if table_dec then
			inv:set_list("table", table_dec.items)
		else
			inv:set_list("table", nil)
		end
		tablelist = table_dec.items
	end	

	-- update craft result
	if not skip_update_craft then
		-- get craft result
		if tablelist then
			crafted = minetest.get_craft_result({method = "normal", width = width, items = tablelist})
		end
		-- update craft result
		if crafted then
			inv:set_stack("craftresult", 1, crafted.item)
		else
			inv:set_stack("craftresult", 1, nil)
		end
	end
	
end

-- register
workbench.register = function(width, recipe)
	minetest.register_node("workbench:"..width.."x"..width, {
		description = "WorkBench "..width.."x"..width,
		tile_images = {"workbench_"..width.."x"..width.."_top.png","workbench_"..width.."x"..width.."_bottom.png","workbench_"..width.."x"..width.."_side.png"},
		paramtype2 = "facedir",
		groups = {cracky=2,craft_width=width,oddly_breakable_by_hand=1},
		legacy_facedir_simple = true,
		sounds = default.node_sound_wood_defaults(),
		on_construct = workbench.on_construct,
		can_dig = workbench.can_dig,
		allow_metadata_inventory_move = workbench.allow_metadata_inventory_move,
		allow_metadata_inventory_put = workbench.allow_metadata_inventory_put,
		allow_metadata_inventory_take = workbench.allow_metadata_inventory_take,
		on_metadata_inventory_move = workbench.on_metadata_inventory_move,
		on_metadata_inventory_put = workbench.on_metadata_inventory_put,
		on_metadata_inventory_take = workbench.on_metadata_inventory_take,
	})
	minetest.register_craft({
		output = "workbench:"..width.."x"..width,
		recipe = recipe,
	})
end

-- register workbenches
workbench.register(3, {
	{"group:wood","group:wood"},
	{"group:wood","group:wood"},
})
workbench.register(4, {
	{"default:stone","default:stone","default:stone"},
	{"group:wood","group:wood","group:wood"},
	{"group:wood","group:wood","group:wood"},
})
workbench.register(5, {
	{"default:steel_ingot","default:steel_ingot","default:steel_ingot","default:steel_ingot"},
	{"group:wood","group:wood","group:wood","group:wood"},
	{"group:wood","group:wood","group:wood","group:wood"},
	{"group:wood","group:wood","group:wood","group:wood"},
})

-- register test crafts
minetest.register_craft({
	output = '"default:mese"',
	recipe = {
		{'"dwarves:adamantium_conc"','"dwarves:adamantium_conc"','"dwarves:adamantium_conc"','"dwarves:adamantium_conc"','"dwarves:adamantium_conc"'},
		{'"dwarves:adamantium_conc"','"dwarves:adamantium_conc"','"dwarves:adamantium_conc"','"dwarves:adamantium_conc"','"dwarves:adamantium_conc"'},
		{'"dwarves:adamantium_conc"','"dwarves:adamantium_conc"','"dwarves:adamantium_conc"','"dwarves:adamantium_conc"','"dwarves:adamantium_conc"'},
		{'"dwarves:adamantium_conc"','"dwarves:adamantium_conc"','"dwarves:adamantium_conc"','"dwarves:adamantium_conc"','"dwarves:adamantium_conc"'},
		{'"dwarves:adamantium_conc"','"dwarves:adamantium_conc"','"dwarves:adamantium_conc"','"dwarves:adamantium_conc"','"dwarves:adamantium_conc"'},
	}
})

minetest.register_craft({
	output = '"dwarves:adamantium_conc"',
	recipe = {
		{'"dwarves:adamantium"','"dwarves:adamantium"','"dwarves:adamantium"','"dwarves:adamantium"','"dwarves:adamantium"'},
		{'"dwarves:adamantium"','"dwarves:adamantium"','"dwarves:adamantium"','"dwarves:adamantium"','"dwarves:adamantium"'},
		{'"dwarves:adamantium"','"dwarves:adamantium"','"dwarves:durin_axe"','"dwarves:adamantium"','"dwarves:adamantium"'},
		{'"dwarves:adamantium"','"dwarves:adamantium"','"dwarves:adamantium"','"dwarves:adamantium"','"dwarves:adamantium"'},
		{'"dwarves:adamantium"','"dwarves:adamantium"','"dwarves:adamantium"','"dwarves:adamantium"','"dwarves:adamantium"'},
	}
})


minetest.register_craft({
    type = "shapeless",
    output = 'default:mese',
    recipe = {
        "default:lava_source",
        "default:lava_source",
        "default:lava_source",
        "default:water_source",
        "default:water_source",
        "default:water_source",
        "default:water_source",
        "default:water_source",
        "default:water_source",
        "default:water_source",
    },
})

minetest.register_craft({
	output = '"dwarves:durin_axe"',
	recipe = {
		{'','','dwarves:adamantium','',''},
		{'','dwarves:adamantium','dwarves:adamantium','dwarves:adamantium','dwarves:adamantium'},
		{'','dwarves:adamantium','dwarves:ebony_ingot','dwarves:sapphire',''},
		{'','','default:stick','default:paper',''},
		{'','dwarves:ruby','default:stick','dwarves:ruby',''},
	}
})

-- inventory_plus
if minetest.get_modpath("inventory_plus") then

	-- get_formspec
	local get_formspec = function(player,page)
		if page=="workbench" then
			return "size[8,7.5]"
				.."list[current_player;main;0,3.5;8,4;]"
				.."button[0,0;2,0.5;main;Back]"
				.."button[2,0;2,0.5;workbench_craft;Craft]"
				.."label[1.6,1.5;3x3]"
				.."label[3.6,1.5;4x4]"
				.."label[5.6,1.5;5x5]"
				.."list[detached:"..player:get_player_name().."_workbench;workbench3;1.5,2;1,1;]"
				.."list[detached:"..player:get_player_name().."_workbench;workbench4;3.5,2;1,1;]"
				.."list[detached:"..player:get_player_name().."_workbench;workbench5;5.5,2;1,1;]"
		end
		-- craft page
		if page=="workbench_craft" then
			local width = 2
			local inv = player:get_inventory()
			if not inv:get_stack("workbench5", 1):is_empty() then
				width = 5
			elseif not inv:get_stack("workbench4", 1):is_empty() then
				width = 4
			elseif not inv:get_stack("workbench3", 1):is_empty() then
				width = 3
			end
			player:get_inventory():set_width("craft", width)
			player:get_inventory():set_size("craft", width*width)
			return "size[8,"..(width+5.5).."]"
				.."button[0,0;2,0.5;main;Back]"
				.."button[2,0;2,0.5;workbench;Workbench]"
				.."list[current_player;craftpreview;6,"..math.floor(width/2+1)..";1,1;]"
				.."list[current_player;craft;"..(6-width)..",1;"..width..","..width..";]"
				.."list[current_player;main;0,"..(width+1.5)..";8,4;]"
		end
	end

	-- register_on_player_receive_fields
	minetest.register_on_player_receive_fields(function(player, formname, fields)
		if fields.workbench then
			inventory_plus.set_inventory_formspec(player, get_formspec(player,"workbench"))
			return
		end
		if fields.workbench_craft then
			inventory_plus.set_inventory_formspec(player, get_formspec(player,"workbench_craft"))
			return
		end
	end)

	-- register_on_joinplayer
	minetest.register_on_joinplayer(function(player)

		inventory_plus.register_button(player,"workbench_craft","Craft")
		inventory_plus.register_button(player,"workbench","Workbench")
		inventory_plus.buttons[player:get_player_name()]["craft"] = nil
		
		local player_inv = player:get_inventory()
		local workbench_inv = minetest.create_detached_inventory(player:get_player_name().."_workbench",{
			on_put = function(inv, listname, index, stack, player)
				player:get_inventory():set_stack(listname, index, stack)
			end,
			on_take = function(inv, listname, index, stack, player)
				player:get_inventory():set_stack(listname, index, nil)
			end,
			allow_put = function(inv, listname, index, stack, player)
				local width = stack:get_definition().groups.craft_width
				if width then
					if listname=="workbench3" and width==3 then
						return 1
					end
					if listname=="workbench4" and width==4 and not inv:get_stack("workbench3",1):is_empty() then
						return 1
					end
					if listname=="workbench5" and width==5 and not inv:get_stack("workbench4",1):is_empty() and  not inv:get_stack("workbench3",1):is_empty() then
						return 1
					end
				end
				return 0
			end,
			allow_take = function(inv, listname, index, stack, player)
				if listname=="workbench3" and inv:get_stack("workbench4",1):is_empty() and inv:get_stack("workbench5",1):is_empty() then
					return 1
				end
				if listname=="workbench4" and inv:get_stack("workbench5",1):is_empty() then
					return 1
				end
				if listname=="workbench5" then
					return 1
				end
				return 0
			end,
			allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
				return 0
			end,
		})
		for i=3,5 do
			local workbench = "workbench"..i
			player_inv:set_size(workbench, 1)
			workbench_inv:set_size(workbench, 1)
			workbench_inv:set_stack(workbench,1,player_inv:get_stack(workbench,1))
		end
		
		minetest.after(2,function()
			inventory_plus.set_inventory_formspec(player,get_formspec(player, "workbench_craft"))
		end)
		
	end)
end
