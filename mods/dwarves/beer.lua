brewer_formspec =
"invsize[8,9;]"..
--"image[1,1;1,2;bubbles_bg.png]"..
"label[0,0;Barrel]"..
"label[1,3;Water level]"..
"list[current_name;src;3,1;1,1;]"..
"list[current_name;dst;5,1;2,2;]"..
"list[current_player;main;0,5;8,4;]"

minetest.register_node("dwarves:barrel", {
	description = "Barrel",
	paramtype = "light",
	tiles = {
		"barrel_top.png",
		"barrel_bottom.png",
		"barrel.png",
		"barrel.png",
		"barrel.png",
		"barrel.png",
	},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.35,-0.5,-0.4, 0.35,0.5,0.4},
			{-0.4,-0.5,-0.35, 0.4,0.5,0.35},
			{-0.25,-0.5,-0.45, 0.25,0.5,0.45},
			{-0.45,-0.5,-0.25, 0.45,0.5,0.25},
			{-0.15,-0.5,-0.5, 0.15,0.5,0.5},
			{-0.5,-0.5,-0.15, 0.5,0.5,0.15},

		},
	},
groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
legacy_facedir_simple = true,
sounds = default.node_sound_wood_defaults(),
water=5000;
water_capacity=5000;
brew_time=0;
brewed = nil;
src_time = 0;
on_construct = function(pos)
local meta = minetest.env:get_meta(pos)
meta:set_string("infotext", "Barrel")
meta:set_float("water", 5000)
meta:set_float("water_capacity", 5000)
meta:set_string("formspec", brewer_formspec)
meta:set_float("brew_time", 0)

local inv = meta:get_inventory()
inv:set_size("src", 1)
inv:set_size("dst", 4)

end,	
can_dig = function(pos,player)
local meta = minetest.env:get_meta(pos);
local inv = meta:get_inventory()
if not inv:is_empty("src") then
return false
end
if not inv:is_empty("dst") then
return false
end

return true
end,

})

minetest.register_abm({
nodenames = {"dwarves:barrel"},
interval = 1,
chance = 1,
action = function(pos, node, active_object_count, active_object_count_wider)

local meta = minetest.env:get_meta(pos)
local charge= meta:get_float("water")
local max_charge= meta:get_float("water_capacity")
local brew_cost=-200

local load = math.floor((charge/max_charge)*100)
meta:set_string("formspec",
"invsize[8,9;]"..
"label[0,0;brewer]"..
"label[1,3;Water level "..(load).."]"..
"list[current_name;src;3,1;1,1;]"..
"list[current_name;dst;5,1;2,2;]"..
"list[current_player;main;0,5;8,4;]"
)



local inv = meta:get_inventory()

local brewer_on = meta:get_float("brewer_on")


local srclist = inv:get_list("src")
if inv:is_empty("src") then meta:set_float("brewer_on",0) end


if (meta:get_float("brewer_on") == 1) then
if charge>=brew_cost then
charge=charge-brew_cost;
meta:set_float("water_capacity",charge)
meta:set_float("src_time", meta:get_float("src_time") + 1)
if meta:get_float("src_time") >= meta:get_float("brew_time") then
-- check if there's room for output in "dst" list
brewed = get_brewed_item (inv:get_stack("src", 1))	
if inv:room_for_item("dst",brewed) then
-- Put result in "dst" list
inv:add_item("dst", brewed)
-- take stuff from "src" list
srcstack = inv:get_stack("src", 1)
srcstack:take_item()
inv:set_stack("src", 1, srcstack)
if inv:is_empty("src") then meta:set_float("brewer_on",0) end

else
print("Barrel is full!")
end
meta:set_float("src_time", 0)
end
end
end

if (meta:get_float("brewer_on")==0) 
then
local brewed=nil
if not inv:is_empty("src") then
brewed = get_brewed_item (inv:get_stack("src", 1))
if brewed then meta:set_float("brewer_on",1) end
brew_time=16
meta:set_float("brew_time",brew_time)
meta:set_float("src_time", 0)
end
end

end
})


function get_brewed_item (items)
new_item =nil
src_item=items:to_table()
item_name=src_item["name"]

if item_name=="farming:wheat_seed" then new_item=ItemStack("dwarves:beer") return new_item end
if item_name=="default:apple" then new_item=ItemStack("dwarves:apple_cider") return new_item end
if item_name=="dwarves:honey" then new_item=ItemStack("dwarves:midus") return new_item end
if item_name=="default:cactus" then new_item=ItemStack("dwarves:tequila") return new_item end
if item_name=="farming:rice_seed" then new_item=ItemStack("dwarves:sake") return new_item end

return nil
end

minetest.register_craftitem("dwarves:beer", {
	description = "Beer",
	inventory_image = "dwarves_beer.png",
	on_use = minetest.item_eat(4)
})

minetest.register_craftitem("dwarves:apple_cider", {
	description = "Apple Cider",
	inventory_image = "dwarves_cider.png",
	on_use = minetest.item_eat(2)
})

minetest.register_craftitem("dwarves:midus", {
	description = "Midus",
	inventory_image = "dwarves_midus.png",
	on_use = minetest.item_eat(3)
})

minetest.register_craftitem("dwarves:tequila", {
	description = "Tequila",
	inventory_image = "dwarves_midus.png",
	on_use = minetest.item_eat(3)
})

minetest.register_craftitem("dwarves:tequila_with_lime", {
	description = "Tequila with Lime",
	inventory_image = "dwarves_midus_with_lime.png",
	on_use = minetest.item_eat(5)
})

minetest.register_craftitem("dwarves:sake", {
	description = "Sake",
	inventory_image = "dwarves_sake.png",
	on_use = minetest.item_eat(4)
})

