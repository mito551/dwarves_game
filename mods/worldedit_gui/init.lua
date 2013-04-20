--[[

Home GUI for Minetest

Copyright (c) 2012 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-particles
License: GPLv3

]]--

-- local api
local worldedit_gui = {}

-- filename
worldedit_gui.filename = minetest.get_worldpath()..'/worldedit_gui'

-- list of inventories
worldedit_gui.inv = {}

-- get_formspec
worldedit_gui.get_formspec = function(player,page)
	local name = player:get_player_name();
	local player_inv = player:get_inventory()
	local pos1,pos2 = worldedit.pos1[name],worldedit.pos2[name]
	local formspec = ""
	
	-- worldedit_gui
	if page == "worldedit_gui" then
		formspec = formspec
			.."size[8,6.5]"
			.."button[0,0;2,0.5;main;Back]"

			.."button_exit[0,1;2,0.5;worldedit_gui_p_set;Set Pos]"
			.."button[2,1;2,0.5;worldedit_gui_pos1;Set Pos1]"
			.."button[4,1;2,0.5;worldedit_gui_pos2;Set Pos2]"
			.."button[6,1;2,0.5;worldedit_gui_reset;Reset Pos]"

			.."button[0,2;2,0.5;worldedit_gui_volume;Volume]"
			.."button_exit[2,2;2,0.5;worldedit_gui_mark;Markers]"
			.."button[4,2;2,0.5;worldedit_gui_set;Set]"
			.."button[6,2;2,0.5;worldedit_gui_replace;Replace]"

			.."button[0,3;2,0.5;worldedit_gui_cylinder;Cylinder]"
			.."button[2,3;2,0.5;worldedit_gui_hollow_cylinder;H-Cylinder]"
			.."button[4,3;2,0.5;worldedit_gui_spiral;Spiral]"

			.."button_exit[0,4;2,0.5;worldedit_gui_dig;Dig]"
			.."button[2,4;2,0.5;worldedit_gui_copy;Copy]"
			.."button[4,4;2,0.5;worldedit_gui_move;Move]"
			.."button[6,4;2,0.5;worldedit_gui_stack;Stack]"

			.."button[0,5;2,0.5;worldedit_gui_flip;Flip]"
			.."button[2,5;2,0.5;worldedit_gui_rotate;Rotate]"
			.."button[4,5;2,0.5;worldedit_gui_transpose;Transpose]"
			
			.."button[0,6;2,0.5;worldedit_gui_save;Save]"
			.."button[2,6;2,0.5;worldedit_gui_load;Load]"
			.."button[4,6;2,0.5;worldedit_gui_metasave;Meta Save]"
			.."button[6,6;2,0.5;worldedit_gui_metaload;Meta Load]"
			
		if pos1 ~= nil then
			formspec = formspec
				.."label[2,-0.2;Pos1: "..math.floor(pos1.x)..","..math.floor(pos1.y)..","..math.floor(pos1.z).."]"
		end
		if pos2 ~= nil then
			formspec = formspec
				.."label[2,0.2;Pos2: "..math.floor(pos2.x)..","..math.floor(pos2.y)..","..math.floor(pos2.z).."]"
		end
	end

	-- worldedit_gui_set
	if page == "worldedit_gui_set" then
		local node = player_inv:get_stack("worldedit_gui_set",1):get_name()
		formspec = formspec
			.."size[8,7.5]"
			.."button[0,0;2,0.5;main;Main]"
			.."button[2,0;2,0.5;worldedit_gui;World Edit]"
			.."list[current_player;main;0,3.5;8,4;]"

			.."list[detached:"..name.."_worldedit_gui;worldedit_gui_set;4,1;1,1;]"
			.."field[5.2,1.7;2,0.5;worldedit_gui_set_node;Use Node;]"
			.."button[6.7,1.4;1,0.5;worldedit_gui_set_node_save;Save]"

		if minetest.registered_nodes[node] then
			formspec = formspec.."label[4,1.8;Selected: "..node.."]"
		end
		if pos1 and pos2 then
			if minetest.registered_nodes[node] then
				formspec = formspec.."button_exit[2.5,2.5;3,0.5;worldedit_gui_set_go;Set Nodes Now]"
			else
				formspec = formspec.."button_exit[2.5,2.5;3,0.5;worldedit_gui_set_go;Set Air Now]"
			end
		else
			formspec = formspec.."label[2.5,2.5;No WorldEdit Region Selected]"
		end
	end

	-- worldedit_gui_replace
	if page == "worldedit_gui_replace" then
		local node_1 = player_inv:get_stack("worldedit_gui_replace",1):get_name()
		local node_2 = player_inv:get_stack("worldedit_gui_replace",2):get_name()
		formspec = formspec
			.."size[8,7.5]"
			.."button[0,0;2,0.5;main;Main]"
			.."button[2,0;2,0.5;worldedit_gui;World Edit]"
			.."list[current_player;main;0,3.5;8,4;]"

			.."list[detached:"..name.."_worldedit_gui;worldedit_gui_replace;0,1;1,1;0]"
			.."field[1.2,1.7;2,0.5;worldedit_gui_replace_node_1;Search Node;]"
			.."button[2.7,1.4;1,0.5;worldedit_gui_replace_node_1_save;Save]"

			.."list[detached:"..name.."_worldedit_gui;worldedit_gui_replace;4,1;1,1;1]"
			.."field[5.2,1.7;2,0.5;worldedit_gui_set_node;Replace Node;]"
			.."button[6.7,1.4;1,0.5;worldedit_gui_set_node_save;Save]"
			
		if minetest.registered_nodes[node_1] then
			formspec = formspec.."label[0,1.8;Selected: "..node_1.."]"
		end
		if minetest.registered_nodes[node_2] then
			formspec = formspec.."label[4,1.8;Selected: "..node_2.."]"
		end
		if pos1 and pos2 then
			if minetest.registered_nodes[node_2] and minetest.registered_nodes[node_1] then
				formspec = formspec.."button_exit[2.5,2.5;3,0.5;worldedit_gui_replace_go;Replace Nodes Now]"
			elseif minetest.registered_nodes[node_1] then
				formspec = formspec.."button_exit[2.5,2.5;3,0.5;worldedit_gui_replace_go;Replace With Air]"
			elseif minetest.registered_nodes[node_1] then
				formspec = formspec.."button_exit[2.5,2.5;3,0.5;worldedit_gui_replace_go;Replace Air With]"
			else
				formspec = formspec.."label[2.5,2.5;Missing Node]"
			end
		else
			formspec = formspec.."label[2.5,2.5;No WorldEdit Region Selected]"
		end
	end

	-- worldedit_gui_cylinder
	if page == "worldedit_gui_cylinder" then
		local node = player_inv:get_stack("worldedit_gui_cylinder",1):get_name()
		formspec = formspec
			.."size[8,7.5]"
			.."button[0,0;2,0.5;main;Main]"
			.."button[2,0;2,0.5;worldedit_gui;World Edit]"
			.."list[current_player;main;0,3.5;8,4;]"

			.."field[0.2,1.5;2,0.5;worldedit_gui_cylinder_length;Length;]"
			.."field[0.2,2.5;2,0.5;worldedit_gui_cylinder_radius;Radius;]"
			.."field[2.2,1.5;2,0.5;worldedit_gui_cylinder_axis;Axis (x/y/z);]"

			.."list[detached:"..name.."_worldedit_gui;worldedit_gui_cylinder;4,1;1,1;]"
			.."field[5.2,1.7;2,0.5;worldedit_gui_set_node;Use Node;]"
			.."button[6.7,1.4;1,0.5;worldedit_gui_set_node_save;Save]"
			
		if minetest.registered_nodes[node] then
			formspec = formspec.."label[4,1.8;Selected: "..node.."]"
		end
		if pos1 then
			if minetest.registered_nodes[node] then
				formspec = formspec.."button_exit[2.5,2.5;3,0.5;worldedit_gui_cylinder_go;Create Cylinder]"
			else
				formspec = formspec.."label[2.5,2.5;Missing Node]"
			end
		else
			formspec = formspec.."label[2.5,2.5;No WorldEdit Region Selected]"
		end
	end

	-- worldedit_gui_hollow_cylinder
	if page == "worldedit_gui_hollow_cylinder" then
		local node = player_inv:get_stack("worldedit_gui_hollow_cylinder",1):get_name()
		formspec = formspec
			.."size[8,7.5]"
			.."button[0,0;2,0.5;main;Main]"
			.."button[2,0;2,0.5;worldedit_gui;World Edit]"
			.."list[current_player;main;0,3.5;8,4;]"

			.."field[0.2,1.5;2,0.5;worldedit_gui_hollow_cylinder_length;Length;]"
			.."field[0.2,2.5;2,0.5;worldedit_gui_hollow_cylinder_radius;Radius;]"
			.."field[2.2,1.5;2,0.5;worldedit_gui_hollow_cylinder_axis;Axis (x/y/z);]"

			.."list[detached:"..name.."_worldedit_gui;worldedit_gui_hollow_cylinder;4,1;1,1;]"
			.."field[5.2,1.7;2,0.5;worldedit_gui_set_node;Use Node;]"
			.."button[6.7,1.4;1,0.5;worldedit_gui_set_node_save;Save]"
			
		if minetest.registered_nodes[node] then
			formspec = formspec.."label[4,1.8;Selected: "..node.."]"
		end
		if pos1 then
			if minetest.registered_nodes[node] then
				formspec = formspec.."button_exit[2.5,2.5;3,0.5;worldedit_gui_hollow_cylinder_go;Create Hollow Cylinder]"
			else
				formspec = formspec.."label[2.5,2.5;Missing Node]"
			end
		else
			formspec = formspec.."label[2.5,2.5;No WorldEdit Region Selected]"
		end
	end
	
	-- worldedit_gui_spiral
	if page == "worldedit_gui_spiral" then
		local node = player_inv:get_stack("worldedit_gui_spiral",1):get_name()
		formspec = formspec
			.."size[8,7.5]"
			.."button[0,0;2,0.5;main;Main]"
			.."button[2,0;2,0.5;worldedit_gui;World Edit]"
			.."list[current_player;main;0,3.5;8,4;]"

			.."field[0.2,1.5;2,0.5;worldedit_gui_spiral_size;Size;]"

			.."list[detached:"..name.."_worldedit_gui;worldedit_gui_spiral;4,1;1,1;]"
			.."field[5.2,1.7;2,0.5;worldedit_gui_set_node;Use Node;]"
			.."button[6.7,1.4;1,0.5;worldedit_gui_set_node_save;Save]"
			
		if minetest.registered_nodes[node] then
			formspec = formspec.."label[4,1.8;Selected: "..node.."]"
		end
		if pos1 then
			if minetest.registered_nodes[node] then
				formspec = formspec.."button_exit[2.5,2.5;3,0.5;worldedit_gui_spiral_go;Create Spiral]"
			else
				formspec = formspec.."label[2.5,2.5;Missing Node]"
			end
		else
			formspec = formspec.."label[2.5,2.5;No WorldEdit Region Selected]"
		end
	end

	-- worldedit_gui_copy
	if page == "worldedit_gui_copy" then
		formspec = formspec
			.."size[4,3.5]"
			.."button[0,0;2,0.5;main;Main]"
			.."button[2,0;2,0.5;worldedit_gui;World Edit]"
			.."field[0.2,1.5;2,0.5;worldedit_gui_copy_amount;Amount;]"
			.."field[0.2,2.5;2,0.5;worldedit_gui_copy_axis;Axis (x/y/z);]"
		if pos1 and pos2 then
			formspec = formspec.."button_exit[0,3;3,0.5;worldedit_gui_copy_go;Copy Region]"
		else
			formspec = formspec.."label[0,3;No WorldEdit Region Selected]"
		end
	end

	-- worldedit_gui_move
	if page == "worldedit_gui_move" then
		formspec = formspec
			.."size[4,3.5]"
			.."button[0,0;2,0.5;main;Main]"
			.."button[2,0;2,0.5;worldedit_gui;World Edit]"
			.."field[0.2,1.5;2,0.5;worldedit_gui_move_amount;Amount;]"
			.."field[0.2,2.5;2,0.5;worldedit_gui_move_axis;Axis (x/y/z);]"
		if pos1 and pos2 then
			formspec = formspec.."button_exit[0,3;3,0.5;worldedit_gui_move_go;Move Region]"
		else
			formspec = formspec.."label[0,3;No WorldEdit Region Selected]"
		end
	end

	-- worldedit_gui_stack
	if page == "worldedit_gui_stack" then
		formspec = formspec
			.."size[4,3.5]"
			.."button[0,0;2,0.5;main;Main]"
			.."button[2,0;2,0.5;worldedit_gui;World Edit]"
			.."field[0.2,1.5;2,0.5;worldedit_gui_stack_amount;Amount;]"
			.."field[0.2,2.5;2,0.5;worldedit_gui_stack_axis;Axis (x/y/z);]"
		if pos1 and pos2 then
			formspec = formspec.."button_exit[0,3;3,0.5;worldedit_gui_stack_go;Stack Region]"
		else
			formspec = formspec.."label[0,3;No WorldEdit Region Selected]"
		end
	end

	-- worldedit_gui_transpose
	if page == "worldedit_gui_transpose" then
		formspec = formspec
			.."size[4,3.5]"
			.."button[0,0;2,0.5;main;Main]"
			.."button[2,0;2,0.5;worldedit_gui;World Edit]"
			.."field[0.2,1.5;2,0.5;worldedit_gui_transpose_axis1;Axis 1 (x/y/z);]"
			.."field[0.2,2.5;2,0.5;worldedit_gui_transpose_axis2;Axis 2 (x/y/z);]"
		if pos1 and pos2 then
			formspec = formspec.."button_exit[0,3;3,0.5;worldedit_gui_transpose_go;Transpose Region]"
		else
			formspec = formspec.."label[0,3;No WorldEdit Region Selected]"
		end
	end

	-- worldedit_gui_flip
	if page == "worldedit_gui_flip" then
		formspec = formspec
			.."size[4,3.5]"
			.."button[0,0;2,0.5;main;Main]"
			.."button[2,0;2,0.5;worldedit_gui;World Edit]"
			.."field[0.2,1.5;2,0.5;worldedit_gui_flip_axis;Axis (x/y/z);]"
		if pos1 and pos2 then
			formspec = formspec.."button_exit[0,3;3,0.5;worldedit_gui_flip_go;Flip Region]"
		else
			formspec = formspec.."label[0,3;No WorldEdit Region Selected]"
		end
	end

	-- worldedit_gui_rotate
	if page == "worldedit_gui_rotate" then
		formspec = formspec
			.."size[4,3.5]"
			.."button[0,0;2,0.5;main;Main]"
			.."button[2,0;2,0.5;worldedit_gui;World Edit]"
			.."field[0.2,1.5;2,0.5;worldedit_gui_rotate_axis;Axis (x/y/z);]"
			.."field[1.2,1.5;2,0.5;worldedit_gui_rotate_angle;Angle (90/180/270);]"
		if pos1 and pos2 then
			formspec = formspec.."button_exit[0,3;3,0.5;worldedit_gui_rotate_go;Rotate Region]"
		else
			formspec = formspec.."label[0,3;No WorldEdit Region Selected]"
		end
	end

	-- worldedit_gui_save
	if page == "worldedit_gui_save" then
		formspec = formspec
			.."size[4,3.5]"
			.."button[0,0;2,0.5;main;Main]"
			.."button[2,0;2,0.5;worldedit_gui;World Edit]"
			.."field[0.2,1.5;2,0.5;worldedit_gui_save_name;Name;]"
		if pos1 and pos2 then
			formspec = formspec.."button_exit[0,3;3,0.5;worldedit_gui_save_go;Save Region]"
		else
			formspec = formspec.."label[0,3;No WorldEdit Region Selected]"
		end
	end

	-- worldedit_gui_load
	if page == "worldedit_gui_load" then
		formspec = formspec
			.."size[4,3.5]"
			.."button[0,0;2,0.5;main;Main]"
			.."button[2,0;2,0.5;worldedit_gui;World Edit]"
			.."field[0.2,1.5;2,0.5;worldedit_gui_load_name;Name;]"
		if pos1 then
			formspec = formspec.."button_exit[0,3;3,0.5;worldedit_gui_load_go;Load Region]"
		else
			formspec = formspec.."label[0,3;No WorldEdit Region Selected]"
		end
	end

	-- worldedit_gui_metasave
	if page == "worldedit_gui_metasave" then
		formspec = formspec
			.."size[4,3.5]"
			.."button[0,0;2,0.5;main;Main]"
			.."button[2,0;2,0.5;worldedit_gui;World Edit]"
			.."field[0.2,1.5;2,0.5;worldedit_gui_metasave_name;Name;]"
		if pos1 and pos2 then
			formspec = formspec.."button_exit[0,3;3,0.5;worldedit_gui_metasave_go;Meta Save Region]"
		else
			formspec = formspec.."label[0,3;No WorldEdit Region Selected]"
		end
	end

	-- worldedit_gui_metaload
	if page == "worldedit_gui_metaload" then
		formspec = formspec
			.."size[4,3.5]"
			.."button[0,0;2,0.5;main;Main]"
			.."button[2,0;2,0.5;worldedit_gui;World Edit]"
			.."field[0.2,1.5;2,0.5;worldedit_gui_metaload_name;Name;]"
		if pos1 and pos2 then
			formspec = formspec.."button_exit[0,3;3,0.5;worldedit_gui_metaload_go;Meta Load Region]"
		else
			formspec = formspec.."label[0,3;No WorldEdit Region Selected]"
		end
	end	

	return formspec
end

-- register_on_player_receive_fields
minetest.register_on_player_receive_fields(function(player, formname, fields)
	local page = nil
	local name = player:get_player_name()
	if not minetest.check_player_privs(name, {worldedit=true}) then return end
	
	-- gui
	if fields.worldedit_gui then
		page = "worldedit_gui"
	end
	
	-- p_set
	if fields.worldedit_gui_p_set then
		worldedit.set_pos[name] = 1
		minetest.chat_send_player(name, "Select positions by punching two nodes")
		page = "worldedit_gui"
	end
	
	-- pos1
	if fields.worldedit_gui_pos1 then
		local pos = player:getpos()
		pos.x, pos.y, pos.z = math.floor(pos.x), math.floor(pos.y), math.floor(pos.z)
		worldedit.pos1[name] = pos
		worldedit.mark_pos1(name)
		minetest.chat_send_player(name, "WorldEdit position 1 set to " .. minetest.pos_to_string(pos))
		page = "worldedit_gui"
	end
	
	-- pos2
	if fields.worldedit_gui_pos2 then
		local pos = player:getpos()
		pos.x, pos.y, pos.z = math.floor(pos.x), math.floor(pos.y), math.floor(pos.z)
		worldedit.pos2[name] = pos
		worldedit.mark_pos2(name)
		minetest.chat_send_player(name, "WorldEdit position 2 set to " .. minetest.pos_to_string(pos))
		page = "worldedit_gui"
	end
	
	-- volume
	if fields.worldedit_gui_volume then
		local pos1, pos2 = worldedit.pos1[name], worldedit.pos2[name]
		if pos1 == nil or pos2 == nil then
			minetest.chat_send_player(name, "No WorldEdit region selected")
		else
			local volume = worldedit.volume(pos1, pos2)
			minetest.chat_send_player(name, "Current WorldEdit region has a volume of " .. volume .. " nodes (" .. pos2.x - pos1.x .. "*" .. pos2.y - pos1.y .. "*" .. pos2.z - pos1.z .. ")")
		end
		page = "worldedit_gui"
	end
	
	-- mark
	if fields.worldedit_gui_mark then
		worldedit.mark_pos1(name)
		worldedit.mark_pos2(name)
		minetest.chat_send_player(name, "WorldEdit region marked")
		page = "worldedit_gui"
	end
	
	-- reset
	if fields.worldedit_gui_reset then
		worldedit.pos1[name] = nil
		worldedit.pos2[name] = nil
		worldedit.mark_pos1(name)
		worldedit.mark_pos2(name)
		minetest.chat_send_player(name, "WorldEdit region reset")
		page = "worldedit_gui"
	end
	
	-- set - page
	if fields.worldedit_gui_set then
		page = "worldedit_gui_set"
	end
	
	-- set - save nodes
	if fields.worldedit_gui_set_node and fields.worldedit_gui_set_node_save then
		local stack = ItemStack(fields.worldedit_gui_set_node)
		if stack:is_empty() then
			player:get_inventory():set_stack("worldedit_gui_set", 1, nil)
		else
			player:get_inventory():set_stack("worldedit_gui_set", 1, stack)
			worldedit_gui.inv[name]:set_stack("worldedit_gui_set",1,stack)
		end
		page = "worldedit_gui_set"
	end
	
	-- set - action
	if fields.worldedit_gui_set_go then
		local item_name = player:get_inventory():get_stack("worldedit_gui_set", 1):get_name()
		if item_name == "" then item_name = "air" end
		local pos1, pos2 = worldedit.pos1[name], worldedit.pos2[name]
		local count = worldedit.set(pos1, pos2, item_name)
		minetest.chat_send_player(name, count .. " nodes set")
		page = "worldedit_gui_set"
	end
	
	-- replace - page
	if fields.worldedit_gui_replace then
		page = "worldedit_gui_replace"
	end
	
	-- replace - save
	if fields.worldedit_gui_replace_node_1 and fields.worldedit_gui_replace_node_1_save then
		local stack = ItemStack(fields.worldedit_gui_replace_node_1)
		if stack:is_empty() then
			player:get_inventory():set_stack("worldedit_gui_replace", 1, nil)
		else
			player:get_inventory():set_stack("worldedit_gui_replace", 1, stack)
			worldedit_gui.inv[name]:set_stack("worldedit_gui_replace",1,stack)
		end
		page = "worldedit_gui_replace"
	end
	if fields.worldedit_gui_replace_node_2 and fields.worldedit_gui_replace_node_2_save then
		local stack = ItemStack(fields.worldedit_gui_replace_node_2)
		if stack:is_empty() then
			player:get_inventory():set_stack("worldedit_gui_replace", 2, nil)
		else
			player:get_inventory():set_stack("worldedit_gui_replace", 2, stack)
			worldedit_gui.inv[name]:set_stack("worldedit_gui_replace",2,stack)
		end
		page = "worldedit_gui_replace"
	end
	
	-- replace - action
	if fields.worldedit_gui_replace_go then
		local search_node = player:get_inventory():get_stack("worldedit_gui_replace", 1):get_name()
		local replace_node = player:get_inventory():get_stack("worldedit_gui_replace", 2):get_name()
		if search_node == "" then search_node = "air" end
		if replace_node == "" then replace_node = "air" end
		local pos1, pos2 = worldedit.pos1[name], worldedit.pos2[name]
		local count = worldedit.replace(pos1, pos2, search_node, replace_node)
		minetest.chat_send_player(name, count .. " nodes replaced")
		page = "worldedit_gui_replace"
	end
	
	-- cylinder - page
	if fields.worldedit_gui_cylinder then
		page = "worldedit_gui_cylinder"
	end
	
	-- cylinder - action
	if fields.worldedit_gui_cylinder_go then
		local radius = tonumber(fields.worldedit_gui_cylinder_radius)
		local length = tonumber(fields.worldedit_gui_cylinder_length)
		local found, _, axis = fields.worldedit_gui_cylinder_axis:find("^([xyz])$")
		if radius and length and axis then
		print(dump(axis))
			local node = player:get_inventory():get_stack("worldedit_gui_cylinder", 1):get_name()
			local pos = worldedit.pos1[name]
			local count = worldedit.cylinder(pos, axis, length, radius, node)
			minetest.chat_send_player(name, count .. " nodes added")
		else
			minetest.chat_send_player(name, "invalid input")
		end
		page = "worldedit_gui_cylinder"
	end
	
	-- hollow_cylinder - page
	if fields.worldedit_gui_hollow_cylinder then
		page = "worldedit_gui_hollow_cylinder"
	end
	
	-- hollow_cylinder - action
	if fields.worldedit_gui_hollow_cylinder_go then
		local radius = tonumber(fields.worldedit_gui_hollow_cylinder_radius)
		local length = tonumber(fields.worldedit_gui_hollow_cylinder_length)
		local found, _, axis = fields.worldedit_gui_hollow_cylinder_axis:find("^([xyz])$")
		if radius and length and axis then
			local node = player:get_inventory():get_stack("worldedit_gui_hollow_cylinder", 1):get_name()
			local pos = worldedit.pos1[name]
			local count = worldedit.hollow_cylinder(pos, axis, length, radius, node)
			minetest.chat_send_player(name, count .. " nodes added")
		else
			minetest.chat_send_player(name, "invalid input")
		end
		page = "worldedit_gui_hollow_cylinder"
	end
	
	-- spiral - page
	if fields.worldedit_gui_spiral then
		page = "worldedit_gui_spiral"
	end
	
	-- spiral - action
	if fields.worldedit_gui_spiral_go then
		local size = tonumber(fields.worldedit_gui_spiral_size)
		if size then
			local node = player:get_inventory():get_stack("worldedit_gui_spiral", 1):get_name()
			local pos = worldedit.pos1[name]
			local count = worldedit.spiral(pos, size, node)
			minetest.chat_send_player(name, count .. " nodes added")
		else
			minetest.chat_send_player(name, "invalid input")
		end
		page = "worldedit_gui_spiral"
	end
	
	-- dig
	if fields.worldedit_gui_dig then
		local pos1,pos2 = worldedit.pos1[name],worldedit.pos2[name]
		local count = worldedit.dig(pos1, pos2)
		minetest.chat_send_player(name, count .. " nodes dug")
		page = "worldedit_gui"
	end

	-- copy - page
	if fields.worldedit_gui_copy then
		page = "worldedit_gui_copy"
	end
	
	-- copy - action
	if fields.worldedit_gui_copy_go then
		local amount = tonumber(fields.worldedit_gui_copy_amount)
		local found, _, axis = fields.worldedit_gui_copy_axis:find("^([xyz])$")
		if not axis then
			axis, sign = worldedit.player_axis(name)
			amount = amount * sign
		end
		if amount and axis then
			local pos1,pos2 = worldedit.pos1[name],worldedit.pos2[name]
			local count = worldedit.copy(pos1, pos2, axis, amount)
			minetest.chat_send_player(name, count .. " nodes copied")
		else
			minetest.chat_send_player(name, "invalid input")
		end
		page = "worldedit_gui_copy"
	end
	
	-- move - page
	if fields.worldedit_gui_move then
		page = "worldedit_gui_move"
	end
	
	-- move - action
	if fields.worldedit_gui_move_go then
		local amount = tonumber(fields.worldedit_gui_move_amount)
		local found, _, axis = fields.worldedit_gui_move_axis:find("^([xyz])$")
		if not axis then
			axis, sign = worldedit.player_axis(name)
			amount = amount * sign
		end
		if amount and axis then
			local pos1,pos2 = worldedit.pos1[name],worldedit.pos2[name]
			local count = worldedit.move(pos1, pos2, axis, amount)
			minetest.chat_send_player(name, count .. " nodes moved")
		else
			minetest.chat_send_player(name, "invalid input")
		end
		page = "worldedit_gui_move"
	end
	
	-- stack - page
	if fields.worldedit_gui_stack then
		page = "worldedit_gui_stack"
	end
	
	-- stack - action
	if fields.worldedit_gui_stack_go then
		local amount = tonumber(fields.worldedit_gui_stack_amount)
		local found, _, axis = fields.worldedit_gui_stack_axis:find("^([xyz])$")
		if not axis then
			axis, sign = worldedit.player_axis(name)
			amount = amount * sign
		end
		if amount and axis then
			local pos1,pos2 = worldedit.pos1[name],worldedit.pos2[name]
			local count = worldedit.stack(pos1, pos2, axis, amount)
			minetest.chat_send_player(name, count .. " nodes stacked")
		else
			minetest.chat_send_player(name, "invalid input")
		end
		page = "worldedit_gui_stack"
	end
	
	-- transpose - page
	if fields.worldedit_gui_transpose then
		page = "worldedit_gui_transpose"
	end
	
	-- transpose - action
	if fields.worldedit_gui_transpose_go then
		local found, _, axis1 = fields.worldedit_gui_transpose_axis1:find("^([xyz])$")
		local found, _, axis2 = fields.worldedit_gui_transpose_axis2:find("^([xyz])$")
		if not axis1 then
			axis1 = worldedit.player_axis(name)
		end
		if not axis2 then
			axis2 = worldedit.player_axis(name)
		end
		if axis1 and axis2 then
			local pos1,pos2 = worldedit.pos1[name],worldedit.pos2[name]
			local count = worldedit.transpose(pos1, pos2, axis1, axis2)
			minetest.chat_send_player(name, count .. " nodes transposed")
		else
			minetest.chat_send_player(name, "invalid input")
		end
		page = "worldedit_gui_transpose"
	end
	
	-- flip - page
	if fields.worldedit_gui_flip then
		page = "worldedit_gui_flip"
	end
	
	-- flip - action
	if fields.worldedit_gui_flip_go then
		local found, _, axis = fields.worldedit_gui_flip_axis:find("^([xyz])$")
		if not axis then
			axis, sign = worldedit.player_axis(name)
			amount = amount * sign
		end
		if axis then
			local pos1,pos2 = worldedit.pos1[name],worldedit.pos2[name]
			local count = worldedit.flip(pos1, pos2, axis)
			minetest.chat_send_player(name, count .. " nodes flipped")
		else
			minetest.chat_send_player(name, "invalid input")
		end
		page = "worldedit_gui_flip"
	end
	
	-- rotate - page
	if fields.worldedit_gui_rotate then
		page = "worldedit_gui_rotate"
	end
	
	-- rotate - action
	if fields.worldedit_gui_rotate_go then
		local found, _, axis = fields.worldedit_gui_rotate_axis:find("^([xyz])$")
		local angle = tonumber(fields.worldedit_gui_rotate_angle)
		if not axis then
			axis, sign = worldedit.player_axis(name)
			amount = amount * sign
		end
		if axis and (angle==90 or angle==180 or angle==270) then
			local pos1,pos2 = worldedit.pos1[name],worldedit.pos2[name]
			local count = worldedit.rotate(pos1, pos2, axis, angle)
			minetest.chat_send_player(name, count .. " nodes rotated")
		else
			minetest.chat_send_player(name, "invalid input")
		end
		page = "worldedit_gui_rotate"
	end
	
	-- save - page
	if fields.worldedit_gui_save then
		page = "worldedit_gui_save"
	end
	
	-- save - action
	if fields.worldedit_gui_save_go then
		local param = string.lower(string.gsub(fields.worldedit_gui_save_name, "%W", "_"))
		if param then
			local pos1,pos2 = worldedit.pos1[name],worldedit.pos2[name]
			local result, count = worldedit.serialize(pos1, pos2)
			local path = minetest.get_worldpath() .. "/schems"
			local filename = path .. "/" .. param .. ".we"
			os.execute("mkdir \"" .. path .. "\"") --create directory if it does not already exist
			local file, err = io.open(filename, "wb")
			if err ~= nil then
				minetest.chat_send_player(name, "Could not save file to \"" .. filename .. "\"")
			else
				file:write(result)
				file:flush()
				file:close()
			end
			minetest.chat_send_player(name, count .. " nodes saved")
		else
			minetest.chat_send_player(name, "invalid input")
		end
		page = "worldedit_gui_save"
	end
	
	-- load - page
	if fields.worldedit_gui_load then
		page = "worldedit_gui_load"
	end
	
	-- load - action
	if fields.worldedit_gui_load_go then
		local param = string.lower(string.gsub(fields.worldedit_gui_load_name, "%W", "_"))
		if param then
			local pos1 = worldedit.pos1[name]
			local filename = minetest.get_worldpath() .. "/schems/" .. param .. ".we"
			local file, err = io.open(filename, "rb")
			if err ~= nil then
				minetest.chat_send_player(name, "Could not open file \"" .. filename .. "\"")
				return
			end
			local value = file:read("*a")
			file:close()
			local count
			if value:find("{") then --old WorldEdit format
				count = worldedit.deserialize_old(pos1, value)
			else --new WorldEdit format
				count = worldedit.deserialize(pos1, value)
			end
			minetest.chat_send_player(name, count .. " nodes loaded")
		else
			minetest.chat_send_player(name, "invalid input")
		end
		page = "worldedit_gui_load"
	end
	
	-- metasave - page
	if fields.worldedit_gui_metasave then
		page = "worldedit_gui_metasave"
	end
	
	-- metasave - action
	if fields.worldedit_gui_metasave_go then
		local param = string.lower(string.gsub(fields.worldedit_gui_metasave_name, "%W", "_"))
		if param then
			local pos1,pos2 = worldedit.pos1[name],worldedit.pos2[name]
			local count, err = worldedit.metasave(pos1, pos2, param)
			if err then
				minetest.chat_send_player(name, "error saving file: " .. err)
			else
				minetest.chat_send_player(name, count .. " nodes saved")
			end
		else
			minetest.chat_send_player(name, "invalid input")
		end
		page = "worldedit_gui_metasave"
	end
		
	-- metaload - page
	if fields.worldedit_gui_metaload then
		page = "worldedit_gui_metaload"
	end
	
	-- metaload - action
	if fields.worldedit_gui_metaload_go then
		local param = string.lower(string.gsub(fields.worldedit_gui_metaload_name, "%W", "_"))
		if param then
			local pos1 = worldedit.pos1[name]
			local count, err = worldedit.metaload(pos1, param)
			if err then
				minetest.chat_send_player(name, "error loading file: " .. err)
			else
				minetest.chat_send_player(name, count .. " nodes loaded")
			end
		else
			minetest.chat_send_player(name, "invalid input")
		end
		page = "worldedit_gui_metaload"
	end
	
	-- load formspec
	if page~=nil then
		inventory_plus.set_inventory_formspec(player, worldedit_gui.get_formspec(player,page))
	end
end)

-- register_on_joinplayer
minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	if not minetest.check_player_privs(name, {worldedit=true}) then return end

	-- add inventory_plus page
	inventory_plus.register_button(player,"worldedit_gui","World Edit")

	-- setup deteched inventory
	local player_inv = player:get_inventory()
	worldedit_gui.inv[name] = minetest.create_detached_inventory(name.."_worldedit_gui",{
		on_put = function(inv, listname, index, stack, player)
			player:get_inventory():set_stack(listname, index, stack)
			inventory_plus.set_inventory_formspec(player, worldedit_gui.get_formspec(player,listname))
		end,
		on_take = function(inv, listname, index, stack, player)
			player:get_inventory():set_stack(listname, index, nil)
			inventory_plus.set_inventory_formspec(player, worldedit_gui.get_formspec(player,listname))
		end,
		allow_put = function(inv, listname, index, stack, player)
			if inv:get_stack(listname,index):is_empty() then
				return 1
			else
				return 0
			end
		end,
		allow_take = function(inv, listname, index, stack, player)
			return stack:get_count()
		end,
		allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			return 0
		end,
	})
	for _,v in ipairs({"set","cylinder","hollow_cylinder","spiral"}) do
		local page = "worldedit_gui_"..v
		player_inv:set_size(page, 1)
		worldedit_gui.inv[name]:set_size(page, 1)
		worldedit_gui.inv[name]:set_stack(page,1,player_inv:get_stack(page,1))
	end
	player_inv:set_size("worldedit_gui_replace", 2)
	worldedit_gui.inv[name]:set_size("worldedit_gui_replace", 2)
	worldedit_gui.inv[name]:set_stack("worldedit_gui_replace",1,player_inv:get_stack("worldedit_gui_replace",1))
	worldedit_gui.inv[name]:set_stack("worldedit_gui_replace",2,player_inv:get_stack("worldedit_gui_replace",2))
end)

-- log that we started
minetest.log("action", "[MOD]"..minetest.get_current_modname().." -- loaded from "..minetest.get_modpath(minetest.get_current_modname()))