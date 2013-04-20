minetest.register_node("dwarves:hive_artificial", {
	description = "Hive",
	tiles = {"dwarves_hive_top.png", "dwarves_hive_top.png", "dwarves_hive_side.png",
		"dwarves_hive_side.png", "dwarves_hive_side.png", "dwarves_hive_front.png"},
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec",
				"size[8,9]"..
				"list[current_name;main;0,0;8,4;]"..
				"list[current_player;main;0,5;8,4;]")
		meta:set_string("infotext", "Hive")
		local inv = meta:get_inventory()
		inv:set_size("main", 4*4)
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local meta = minetest.env:get_meta(pos)
		local meta2 = meta
		meta:from_table(oldmetadata)
		local inv = meta:get_inventory()
		for i=1,inv:get_size("main") do
			local stack = inv:get_stack("main", i)
			if not stack:is_empty() then
				local p = {x=pos.x+math.random(0, 10)/10-0.5, y=pos.y, z=pos.z+math.random(0, 10)/10-0.5}
				minetest.env:add_item(p, stack)
			end
		end
		meta:from_table(meta2:to_table())
	end,
})

minetest.register_node("dwarves:hive", {
	description = "Natural Hive",
	tiles = {"dwarves_natural_hive.png"},
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3,-0.4,-0.25, 0.3,0.4,0.25},
			{-0.15,-0.4,-0.35, 0.15,0.4,0.35},
			{-0.35,-0.3,-0.15, 0.35,0.3,0.15},
			{-0.3,-0.4,-0.25, 0.3,0.4,0.25},
			{-0.15,-0.4,-0.35, 0.15,0.4,0.35},
			{0.2,0.5,0.2, -0.2,0.45,-0.5},

		},
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec",
				"size[8,9]"..
				"list[current_name;main;0,0;8,4;]"..
				"list[current_player;main;0,5;8,4;]")
		meta:set_string("infotext", "Hive")
		local inv = meta:get_inventory()
		inv:set_size("main", 4*4)
	end,
	drop = 'dwarves:honeycomb 4',
})

minetest.register_abm({nodenames = {"dwarves:hive_artificial", "dwarves:hive"},
	interval = 300.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)	
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		local mainlist = inv:get_list("main")
		honey = get_honey (inv:get_stack("main", 1))	
		if inv:room_for_item("main",honey) then
		inv:add_item("main", honey)
	end
	end
})

function empty_inventory (pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end

function get_honey (items)
new_item =nil
		
if empty_inventory then new_item=ItemStack("dwarves:honey") return new_item end

return nil
end

minetest.register_craftitem("dwarves:honeycomb", {
	description = "Honeycomb",
	inventory_image = "dwarves_honeycomb.png",
})

minetest.register_craftitem("dwarves:honey", {
	description = "Honey",
	inventory_image = "dwarves_honey.png",
})


minetest.register_craft({
	output = 'dwarves:hive_artificial',
	recipe = {
		{'default:wood', 'dwarves:honeycomb', 'default:wood'},
		{'dwarves:honeycomb', 'default:wood', 'dwarves:honeycomb'},
		{'default:wood', 'dwarves:honeycomb', 'default:wood'},
	}
})

minetest.register_node("dwarves:bees", {
	description = "Bees (cheater!)",
	drawtype = "plantlike",
	tiles = {"bees.png"},
	inventory_image = "bees.png",
	wield_image = "bees.png",
	paramtype = "facedir",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.1, -0.5, -0.1, 0.1, 0.5, 0.1},
	},
	damage_per_second = 2*1,
	groups = {not_in_creative_inventory=1},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
})