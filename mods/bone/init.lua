local n
local n2
local pos

function apple_leave()
	if math.random(0, 10) == 3 then
		return {name = "default:apple"}
	else
		return {name = "default:leaves"}
	end
end

function air_leave()
	if math.random(0, 50) == 3 then
		return {name = "air"}
	else
		return {name = "default:leaves"}
	end
end

function generate_tree(pos, trunk, leaves)
	pos.y = pos.y-1
	local nodename = minetest.env:get_node(pos).name
		
	pos.y = pos.y+1
	if not minetest.env:get_node_light(pos) then
		return
	end

	node = {name = ""}
	for dy=1,4 do
		pos.y = pos.y+dy
		if minetest.env:get_node(pos).name ~= "air" then
			return
		end
		pos.y = pos.y-dy
	end
	node = {name = "default:tree"}
	for dy=0,4 do
		pos.y = pos.y+dy
		minetest.env:set_node(pos, node)
		pos.y = pos.y-dy
	end

	node = {name = "default:leaves"}
	pos.y = pos.y+3
	local rarity = 0
	if math.random(0, 10) == 3 then
		rarity = 1
	end
	for dx=-2,2 do
		for dz=-2,2 do
			for dy=0,3 do
				pos.x = pos.x+dx
				pos.y = pos.y+dy
				pos.z = pos.z+dz

				if dx == 0 and dz == 0 and dy==3 then
					if minetest.env:get_node(pos).name == "air" and math.random(1, 5) <= 4 then
						minetest.env:set_node(pos, node)
						if rarity == 1 then
							minetest.env:set_node(pos, apple_leave())
						else
							minetest.env:set_node(pos, air_leave())
						end
					end
				elseif dx == 0 and dz == 0 and dy==4 then
					if minetest.env:get_node(pos).name == "air" and math.random(1, 5) <= 4 then
						minetest.env:set_node(pos, node)
						if rarity == 1 then
							minetest.env:set_node(pos, apple_leave())
						else
							minetest.env:set_node(pos, air_leave())
						end
					end
				elseif math.abs(dx) ~= 2 and math.abs(dz) ~= 2 then
					if minetest.env:get_node(pos).name == "air" then
						minetest.env:set_node(pos, node)
						if rarity == 1 then
							minetest.env:set_node(pos, apple_leave())
						else
							minetest.env:set_node(pos, air_leave())
						end
					end
				else
					if math.abs(dx) ~= 2 or math.abs(dz) ~= 2 then
						if minetest.env:get_node(pos).name == "air" and math.random(1, 5) <= 4 then
							minetest.env:set_node(pos, node)
						if rarity == 1 then
							minetest.env:set_node(pos, apple_leave())
						else
							minetest.env:set_node(pos, air_leave())
						end
						end
					end
				end
				pos.x = pos.x-dx
				pos.y = pos.y-dy
				pos.z = pos.z-dz
			end
		end
	end
end

local function duengen(pointed_thing)
pos = pointed_thing.under
n = minetest.env:get_node(pos)
if n.name ~= ""  and n.name == "default:sapling" then
	minetest.env:set_node(pos, {name="air"})
	generate_tree(pos, "default:tree", "default:leaves")
else
	for i = -2, 3, 1 do
		for j = -3, 2, 1 do
			pos = pointed_thing.above
			pos = {x=pos.x+i, y=pos.y, z=pos.z+j}
			n = minetest.env:get_node(pos)
			n2 = minetest.env:get_node({x=pos.x, y=pos.y-1, z=pos.z})

			if n.name ~= ""  and n.name == "air" and n2.name == "default:dirt_with_grass" then
				minetest.env:set_node(pos, {name="default:jungle_grass"})
				
			end
		end
	end
end
end


minetest.register_craftitem("bone:bonemeal", {
	description = "Bone Meal",
	inventory_image = "bone_bonemeal.png",
	liquids_pointable = false,
	stack_max = 99,
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type == "node" then
			duengen(pointed_thing)
			itemstack:take_item()
			return itemstack
		end
	end,

})

minetest.register_craft({
	type = "cooking",
	output = "bone:bonemeal",
	recipe = "bones:bones",
})