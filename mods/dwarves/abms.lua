minetest.register_abm(
        {nodenames = {"default:lava_source"},
	neighbors = {"default:water_source", "default:water_flowing"},
        interval = 1,
        chance = 64,
        action = function(pos)
		minetest.env:add_node(pos, {name="dwarves:stone_with_obsidian"})
        end,
})

minetest.register_abm(
        {nodenames = {"default:lava_source"},
	neighbors = {"default:water_source", "default:water_flowing"},
        interval = 1,
        chance = 32,
        action = function(pos)
		minetest.env:add_node(pos, {name="darkage:basalt"})
        end,
})

minetest.register_abm(
        {nodenames = {"default:lava_source"},
	neighbors = {"default:water_source", "default:water_flowing"},
        interval = 1,
        chance = 1,
        action = function(pos)
		minetest.env:add_node(pos, {name="default:stone"})
        end,
})



minetest.register_abm(
        {nodenames = {"default:lava_flowing"},
	neighbors = {"default:water_source", "default:water_flowing"},
        interval = 1,
        chance = 1,
        action = function(pos)
		minetest.env:add_node(pos, {name="default:cobble"})
        end,
})

minetest.register_abm(
        {nodenames = {"default:water_flowing"},
	neighbors = {"air"},
        interval = 1080,
        chance = 1,
        action = function(pos)
		minetest.env:remove_node(pos)
        end,
})


--[[minetest.register_abm({
	nodenames = {"carts:pickup_plate"},
	interval = 0,
	chance = 1,
	action = function(pos)
		minetest.env:remove_node(pos)
	end
})--]]

minetest.register_abm({
	nodenames = {"group:old"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		minetest.env:remove_node(pos)
	end,
})

local MOSS_CHANCE = 32 + math.random (2, 16)

minetest.register_abm({
    nodenames = {"dwarves:rotten_wood"},
	neighbors = {"default:mossycobble", "dwarves:mossytree"},
    interval = 7200,
    chance = 64 + math.random (2, 16),

    action = function(pos, node, _, _)
            minetest.env:remove_node(pos)
            minetest.env:add_node(pos, { name = "dwarves:mossywood" })
	end
})

minetest.register_abm({
    nodenames = {"default:cobble", "default:tree", "default:wood"},
	neighbors = {"default:water_source", "default:water_flowing"},
    interval = 7200,
    chance = MOSS_CHANCE,

    action = function(pos, node, _, _)        
	if minetest.env:get_node(pos).name == "default:cobble" then
		
        if water then
            minetest.env:remove_node(pos)
            minetest.env:add_node(pos, { name = "default:mossycobble" })
        end
    end
	
	if minetest.env:get_node(pos).name == "default:tree" then
		
        if water then
            minetest.env:remove_node(pos)
            minetest.env:add_node(pos, { name = "dwarves:mossytree" })
        end
    end
	
	if minetest.env:get_node(pos).name == "default:wood" then
		
        if water then
            minetest.env:remove_node(pos)
            minetest.env:add_node(pos, { name = "dwarves:rotten_wood" })
        end
    end

	end
})

minetest.register_abm({
	nodenames = {"default:furnace","default:furnace_active"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.env:get_meta(pos)
		for i, name in ipairs({
				"fuel_totaltime",
				"fuel_time",
				"src_totaltime",
				"src_time"
		}) do
			if meta:get_string(name) == "" then
				meta:set_float(name, 0.0)
			end
		end

		local inv = meta:get_inventory()

		local srclist = inv:get_list("src")
		local cooked = nil
		
		if srclist then
			cooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
		end
		
		local was_active = false
		
		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
			was_active = true
			meta:set_float("fuel_time", meta:get_float("fuel_time") + 1)
			meta:set_float("src_time", meta:get_float("src_time") + 1)
			if cooked and cooked.item and meta:get_float("src_time") >= cooked.time then
				-- check if there's room for output in "dst" list
				if inv:room_for_item("dst",cooked.item) then
					-- Put result in "dst" list
					inv:add_item("dst", cooked.item)
					-- take stuff from "src" list
					srcstack = inv:get_stack("src", 1)
					srcstack:take_item()
					inv:set_stack("src", 1, srcstack)
				else
					print("Could not insert '"..cooked.item:to_string().."'")
				end
				meta:set_string("src_time", 0)
			end
		end
		
		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
			local percent = math.floor(meta:get_float("fuel_time") /
					meta:get_float("fuel_totaltime") * 100)
			meta:set_string("infotext","Furnace active: "..percent.."%")
			hacky_swap_node(pos,"default:furnace_active")
			meta:set_string("formspec",
				"size[8,9]"..
				"image[2,2;1,1;default_furnace_fire_bg.png^[lowpart:"..
						(100-percent)..":default_furnace_fire_fg.png]"..
				"list[current_name;fuel;2,3;1,1;]"..
				"list[current_name;src;2,1;1,1;]"..
				"list[current_name;dst;5,1;2,2;]"..
				"list[current_player;main;0,5;8,4;]")
			return
		end

		local fuel = nil
		local cooked = nil
		local fuellist = inv:get_list("fuel")
		local srclist = inv:get_list("src")
		
		if srclist then
			cooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
		end
		if fuellist then
			fuel = minetest.get_craft_result({method = "fuel", width = 1, items = fuellist})
		end

		if fuel.time <= 0 then
			meta:set_string("infotext","Furnace out of fuel")
			hacky_swap_node(pos,"default:furnace")
			meta:set_string("formspec", default.furnace_inactive_formspec)
			return
		end

		if cooked.item:is_empty() then
			if was_active then
				meta:set_string("infotext","Furnace is empty")
				hacky_swap_node(pos,"default:furnace")
				meta:set_string("formspec", default.furnace_inactive_formspec)
			end
			return
		end

		meta:set_string("fuel_totaltime", fuel.time)
		meta:set_string("fuel_time", 0)
		
		local stack = inv:get_stack("fuel", 1)
		stack:take_item()
		inv:set_stack("fuel", 1, stack)
	end,
})

minetest.register_abm({nodenames = {"default:torch"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node)
	p = {x=pos.x, y=pos.y, z=pos.z-1}
	n = minetest.env:get_node(p)
	
	p1 = {x=pos.x+1, y=pos.y, z=pos.z}
	n1 = minetest.env:get_node(p1)
	
	p2 = {x=pos.x-1, y=pos.y, z=pos.z}
	n2 = minetest.env:get_node(p2)
	
	p3 = {x=pos.x, y=pos.y-1, z=pos.z}
	n3 = minetest.env:get_node(p3)
	
	p4 = {x=pos.x, y=pos.y, z=pos.z+1}
	n4 = minetest.env:get_node(p4)	

	p5 = {x=pos.x, y=pos.y, z=pos.z}
	n5 = minetest.env:get_node(p5)		
	
		if (n.name == "default:water_source") then
			minetest.env:add_node(p5, {name="default:water_flowing"})
			minetest.env:add_item(p5,{name=n5})
		return end	
			
				if (n.name == "default:water_flowing") then
					minetest.env:add_node(p5, {name="default:water_flowing"})
					minetest.env:add_item(p5,{name=n5})
	return end

	if (n1.name == "default:water_source") then
		minetest.env:add_node(p5, {name="default:water_flowing"})
		minetest.env:add_item(p5,{name=n5})
	return end	
		
		if (n.name == "default:water_flowing") then
					minetest.env:add_node(p5, {name="default:water_flowing"})
					minetest.env:add_item(p5,{name=n5})
	return end		
	
	if (n2.name == "default:water_source") then
		minetest.env:add_node(p5, {name="default:water_flowing"})
		minetest.env:add_item(p5,{name=n5})
		
	return end
		if (n.name == "default:water_flowing") then
					minetest.env:add_node(p5, {name="default:water_flowing"})
					minetest.env:add_item(p5,{name=n5})
	return end
	
	if (n3.name == "default:water_source") then
		minetest.env:add_node(p5, {name="default:water_flowing"})
		minetest.env:add_item(p5,{name=n5})
	return end	

		if (n.name == "default:water_flowing") then
					minetest.env:add_node(p5, {name="default:water_flowing"})
					minetest.env:add_item(p5,{name=n5})
	return end
	
	if (n4.name == "default:water_source") then
		minetest.env:add_node(p5, {name="default:water_flowing"})
		minetest.env:add_item(p5,{name=n5})
	return end	
	
		if (n.name == "default:water_flowing") then
					minetest.env:add_node(p5, {name="default:water_flowing"})
					minetest.env:add_item(p5,{name=n5})
	return end
	end,
})

minetest.register_abm({nodenames = {"default:papyrus", "default:cactus"},
	interval = 1.0,
	chance = 1,
	action =  function(pos, node, active_object_count, active_object_count_wider)
	p = {x=pos.x, y=pos.y-1, z=pos.z}
	n = minetest.env:get_node(p)
		
	p5 = {x=pos.x, y=pos.y, z=pos.z}
	n5 = minetest.env:get_node(p5)
	
	if (n.name == "air") 
			then	
		minetest.env:add_node(p5, {name="air"})
		minetest.env:add_item(p5,{name=n5})
		else
		return nil end
	return end
})

minetest.register_abm({nodenames = {"dwarves:hive", "dwarves:hive_artificial"},
	interval = 1,
	chance = 2,
	action = function(pos, node)
	p = {x=pos.x+1, y=pos.y, z=pos.z}
	n = minetest.env:get_node(p)

	p1 = {x=pos.x, y=pos.y, z=pos.z+1}
	n1 = minetest.env:get_node(p1)
	
	p2 = {x=pos.x, y=pos.y, z=pos.z-1}
	n2 = minetest.env:get_node(p2)
	
	p3 = {x=pos.x-1, y=pos.y, z=pos.z}
	n3 = minetest.env:get_node(p3)
	
	p4 = {x=pos.x, y=pos.y+1, z=pos.z}
	n4= minetest.env:get_node(p4)
	
	p5 = {x=pos.x-1, y=pos.y+1, z=pos.z}
	n5 = minetest.env:get_node(p5)
	
	p6 = {x=pos.x+1, y=pos.y+1, z=pos.z}
	n6= minetest.env:get_node(p6)
	
	p7 = {x=pos.x, y=pos.y+1, z=pos.z+1}
	n7 = minetest.env:get_node(p7)
	
	p8 = {x=pos.x, y=pos.y+1, z=pos.z-1}
	n8= minetest.env:get_node(p8)
	
	p9 = {x=pos.x+1, y=pos.y, z=pos.z+1}
	n9= minetest.env:get_node(p9)
	
	p10 = {x=pos.x-1, y=pos.y, z=pos.z+1}
	n10= minetest.env:get_node(p10)
	
	p11 = {x=pos.x+1, y=pos.y, z=pos.z-1}
	n11= minetest.env:get_node(p11)
	
	p12 = {x=pos.x-1, y=pos.y, z=pos.z-1}
	n12= minetest.env:get_node(p12)
	
	if (n.name == "air") then
		minetest.env:add_node(p, {name="dwarves:bees"})
	return end

	if (n1.name == "air") then
		minetest.env:add_node(p1, {name="dwarves:bees"})
	return end		
	
	if (n2.name == "air") then
		minetest.env:add_node(p2, {name="dwarves:bees"})
	return end
	
	if (n3.name == "air") then
		minetest.env:add_node(p3, {name="dwarves:bees"})
	return end
	
	if (n4.name == "air") then
		minetest.env:add_node(p4, {name="dwarves:bees"})
	return end
	
	if (n5.name == "air") then
		minetest.env:add_node(p5, {name="dwarves:bees"})
	return end

	if (n6.name == "air") then
		minetest.env:add_node(p6, {name="dwarves:bees"})
	return end		
	
	if (n7.name == "air") then
		minetest.env:add_node(p7, {name="dwarves:bees"})
	return end
	
	if (n8.name == "air") then
		minetest.env:add_node(p8, {name="dwarves:bees"})
	return end
	
	if (n9.name == "air") then
		minetest.env:add_node(p9, {name="dwarves:bees"})
	return end
	
	if (n11.name == "air") then
		minetest.env:add_node(p11, {name="dwarves:bees"})
	return end

	if (n10.name == "air") then
		minetest.env:add_node(p10, {name="dwarves:bees"})
	return end		
	
	if (n12.name == "air") then
		minetest.env:add_node(p12, {name="dwarves:bees"})
	return end
	
--[[	if (n13.name == "air") then
		minetest.env:add_node(p13, {name="dwarves:bees"})
	return end
	
	if (n14.name == "air") then
		minetest.env:add_node(p14, {name="dwarves:bees"})
	return end--]]
	
end
})

minetest.register_abm(
        {nodenames = {"dwarves:bees"},
	neighbors == {"dwarves:hive", "dwarves:hive_artificial"},
        interval = 1,
        chance = 4,
        action = function(pos)
		minetest.env:remove_node(pos)
        end,
})

minetest.register_abm(
	{nodenames = {"default:cactus"},
    interval = 0.75,
    chance = 1,
    action = function(pos, node, active_object_count, active_object_count_wider)
    objs = minetest.env:get_objects_inside_radius(pos, 1)
	for k, obj in pairs(objs) do
		obj:set_hp(obj:get_hp()-1)
	end
	end,
})
