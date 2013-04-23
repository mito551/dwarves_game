

minetest.register_node("ithildin:ithildin_flowing_water", {
	description = "Ithildin Flowing Water",
	inventory_image = minetest.inventorycube("default_water.png"),
	drawtype = "flowingliquid",
	tiles = {"default_water.png"},
	special_tiles = {
		{
			image="default_water_flowing_animated.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.8}
		},
		{
			image="default_water_flowing_animated.png",
			backface_culling=true,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.8}
		},
	},
	alpha = WATER_ALPHA,
	paramtype = "light",	light_source = LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	liquidtype = "flowing",
	liquid_alternative_flowing = "ithildin:ithildin_flowing_water",
	liquid_alternative_source = "ithildin:ithildin_water",
	liquid_viscosity = WATER_VISC,
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {water=3, liquid=3, puts_out_fire=1, not_in_creative_inventory=1},
})

minetest.register_node("ithildin:ithildin_water", {
	description = "Ithildin Water Source",
	inventory_image = minetest.inventorycube("ithildin_water.png"),
	drawtype = "liquid",
	tiles = {
		{name="default_water_source_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.0}}
	},
	special_tiles = {
		-- New-style water source material (mostly unused)
		{
			name="default_water_source_animated.png",
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.0},
			backface_culling = false,
		}
	},
	alpha = WATER_ALPHA,
	paramtype = "light",	light_source = LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	liquidtype = "source",
	liquid_alternative_flowing = "default:water_flowing",
	liquid_alternative_source = "default:water_source",
	liquid_viscosity = WATER_VISC,
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {water=3, liquid=3, puts_out_fire=1},
})
local LANTERN_NODES = {}
local LIGHT_THRESHOLD_NIGHT = 4
local LIGHT_THRESHOLD_DAY = 10

for i = 0, LIGHT_MAX do
    table.insert(LANTERN_NODES, 'ithildin:ithildin_' .. i)
end

-- Functions
minetest.register_abm({
    nodenames = LANTERN_NODES,
    interval = 6,
    chance = 1,
    action = function(pos, node, _, __)
        local aname = node.name

        minetest.env:remove_node(pos)
        local l = minetest.env:get_node_light(pos, nil) - 1

        if l == nil then
            l = 0
        end

        if l < LIGHT_THRESHOLD_NIGHT then
            l = 0
        elseif l > LIGHT_THRESHOLD_DAY then
            l = LIGHT_MAX
        end

         local nname = 'ithildin:ithildin_' .. (LIGHT_MAX - l)

        minetest.env:add_node(pos, { name = nname })
    end
})

-- Nodes
for i, ml in ipairs(LANTERN_NODES) do
    minetest.register_node(ml, {
	description = "Ithildin",
        tiles = { 'ithildin_' .. (i - 1) .. '.png' },
        inventory_image = 'ithildin_' .. (i - 1) .. '.png',
        drawtype = 'glasslike',
        paramtype = "light",
        walkable = true,
        sunlight_propagates = true,
        light_source = i - 1,
        groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
        furnace_burntime = 4,
    })
end

-- Crafts
minetest.register_craft({
    output = 'NodeItem "ithildin:ithildin_0" 1',
    recipe = {
        {'node "default:torch" 1', 'node "dwarves:mithril_ingot" 1', 'node "default:torch" 1'},
        {'node "default:glass" 1', 'node "default:mese" 1', 'node "default:glass" 1'},
        {'node "default:torch" 1', 'node "dwarves:mithril_ingot" 1', 'node "default:torch" 1'},
    },
})
local LANTERN_NODES = {}
local LIGHT_THRESHOLD_NIGHT = 4
local LIGHT_THRESHOLD_DAY = 10

for i = 0, LIGHT_MAX do
    table.insert(LANTERN_NODES, 'ithildin:ithildin_' .. i)
end

-- Functions
minetest.register_abm({
    nodenames = LANTERN_NODES,
    interval = 6,
    chance = 1,
    action = function(pos, node, _, __)
        local aname = node.name

        minetest.env:remove_node(pos)
        local l = minetest.env:get_node_light(pos, nil) - 1

        if l == nil then
            l = 0
        end

        if l < LIGHT_THRESHOLD_NIGHT then
            l = 0
        elseif l > LIGHT_THRESHOLD_DAY then
            l = LIGHT_MAX
        end

         local nname = 'ithildin:ithildin_' .. (LIGHT_MAX - l)

        minetest.env:add_node(pos, { name = nname })
    end
})

-- Nodes
for i, ml in ipairs(LANTERN_NODES) do
    minetest.register_node(ml, {
	description = "Ithildin_Stone",
        tiles = { 'ithildin_stone_' .. (i - 1) .. '.png' },
        inventory_image = 'ithildin_stone.png',
        drawtype = 'glasslike',
        paramtype = "light",
        walkable = true,
        sunlight_propagates = true,
        light_source = i - 1,
        groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
        furnace_burntime = 4,
    })
end

-- Crafts
minetest.register_craft({
    output = 'NodeItem "ithildin:ithildin_stone_0" 1',
    recipe = {
        {'node "default:torch" 1', 'node "dwarves:mithril_ingot" 1', 'node "default:torch" 1'},
        {'node "default:glass" 1', 'node "default:cobblestone" 1', 'node "default:glass" 1'},
        {'node "default:torch" 1', 'node "dwarves:mithril_ingot" 1', 'node "default:torch" 1'},
    },
})