
-- Local constants
-- This _has_ to be set to 1
local HATCH_OPENED = 1
-- This has to be != from HATCH_OPENED and is coded on 4 bits
local HATCH_CLOSED = 0

-- Local Functions
local on_hatch_punched = function(pos, node, puncher)
	if (node.name ~= 'hatches:hatch_closed')
		and (node.name ~= 'hatches:hatch_opened') then
		return
	end
	local state = node.param2

	-- Switch the hatch state when hit
	if state == HATCH_OPENED then
		node.name = 'hatches:hatch_closed'
		node.param2 = HATCH_CLOSED
	elseif state == HATCH_CLOSED then
		node.name = 'hatches:hatch_opened'
		node.param2 = HATCH_OPENED
	else
		print('Uninitialized node: ' .. state)
	end

	minetest.env:add_node(pos, {
		name = node.name,
		param2 = node.param2,
	})
end

local on_hatch_placed = function(pos, node, placer)
	if node.name ~= 'hatches:hatch_opened' then
		return
	end

	minetest.env:add_node(pos, {
		name = node.name,
		param2 = HATCH_OPENED,
	})
end

-- Nodes
-- As long as param2 is set to 1 for open hatches, it doesn't matter to
-- use drawtype = 'signlike'
minetest.register_node('hatches:hatch_opened', {
	description = "Hatch",
	drawtype = 'signlike',
	tile_images = {'hatch.png'},
	inventory_image = 'hatch.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = false,
	climbable = true,
	selection_box = {
		type = "wallmounted",
	},
	material = minetest.digprop_constanttime(1.0),
	dug_item = 'NodeItem "hatches:hatch_closed" 1',
})

minetest.register_node('hatches:hatch_closed', {
	description = "Hatch",	
	drawtype = 'raillike',
	tile_images = {'hatch.png'},
	inventory_image = 'hatch.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -2/5, 1/2},
	},
	material = minetest.digprop_constanttime(1.0),
})

-- Crafts
minetest.register_craft({
	output = 'NodeItem "hatches:hatch_closed" 2',
	recipe = {
		{'node "default:wood" 1', 'node "default:wood" 1', 'node "default:wood" 1'},
		{'node "default:wood" 1', 'node "default:wood" 1', 'node "default:wood" 1'},
	},
})

-- Change the hatch state
minetest.register_on_punchnode(on_hatch_punched)
-- Reset param2 for open hatches
minetest.register_on_placenode(on_hatch_placed)
