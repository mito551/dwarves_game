--[[math.randomseed(os.time())


-- The growable table is to be used as following:
--   name describes the node that is to grow
--   surfaces is a table of:
--     the name of the node the said node is allowed to grow
--     the odds it has over 1000 to grow at each callback cycle

growable = {
	{
		name = "papyrus",
		surfaces = {
			-- Papyrus will grow normally on dirt,
			-- it has 50/1000 chances of growing on a cycle
			{name = "dirt", odds = 50},
			-- Papyrus won't grow very well on sand
			{name = "sand", odds = 10}
		}
	},
	{
		name = "cactus",
		surfaces = {
			{name = "sand", odds = 50}
		}
	},
	{
		-- Grass has chances of growing
		name = "junglegrass",
		surfaces = {
			{name = "sand", odds = 2},
			{name = "dirt", odds = 1}
		}
	},
	{
		-- In case you want a nive frontyard with high hurdles
		name = "leaves",
		surfaces = {
			{name = "dirt", odds = 10}
		}
	}
}

for _, e in ipairs(growable) do
	minetest.register_abm({
		nodenames = { e.name },
		interval = 360,
		chance = 2,
		action = function(pos, node, active_object_count, active_object_count_wider)
			for _, s in ipairs(e.surfaces) do
				if (math.random(1, 1000) > 1001 - s.odds) then
					p_bottom1 = {x = pos.x, y = pos.y - 1, z = pos.z}
					n_bottom1 = minetest.env:get_node(p_bottom1)
					p_bottom2 = {x = pos.x, y = pos.y - 2, z = pos.z}
					n_bottom2 = minetest.env:get_node(p_bottom2)
					p_top = {x = pos.x, y = pos.y + 1, z = pos.z}
					n_top = minetest.env:get_node(p_top)
					n_namelen = string.len(s.name)

					if (string.sub(n_bottom1.name, 1, n_namelen) == s.name) or (string.sub(n_bottom2.name, 1, n_namelen) == s.name and n_bottom1.name == e.name) then
						if n_top.name == "air" then
							minetest.env:add_node(p_top, {name = e.name})
						end
					end
				end
			end
		end
	})
end--

math.randomseed(os.time())

--[[
-- growname describes the node that is to grow
-- surfaces is a table of:
--   the name of the node that said node is allowed to grow on top of
--   the odds it has over 1000 to grow at each callback cycle
--]]

function add_grow_type(growname, surfaces)
	minetest.register_abm({
		nodenames = { growname },
		interval = 200,
		chance = 2,
		action = function(pos, node, active_object_count, active_object_count_wider)
			-- First check if there is space above to grow
			p_top = {x = pos.x, y = pos.y + 1, z = pos.z}
			n_top = minetest.env:get_node(p_top)

			if n_top.name == "air" then
				-- Calc current height
				cur_height = 1
				p_next = {x = pos.x, y = pos.y - 1, z = pos.z}
				n_next  = minetest.env:get_node(p_next);
				while true do
					if n_next.name ~= node.name then
						break
					end
					cur_height = cur_height + 1
					p_next = {x = p_next.x, y = p_next.y - 1, z = p_next.z}
					n_next = minetest.env:get_node(p_next)
				end

				for _, s in ipairs(surfaces) do
					if n_next.name == s.name and (math.random(1, 1000) > (1000 - s.odds)) then
						if cur_height < s.max_height then
							minetest.env:add_node(p_top, {name = node.name})
						end
					end
				end
			end
		end
    })
end

add_grow_type("default:papyrus", {
{name = "default:dirt", odds = 30, max_height = 3},
{name = "default:dirt_with_grass", odds = 30, max_height = 3},
{name = "default:dirt_with_grass_footsteps", odds = 30, max_height = 3},
{name = "default:sand", odds = 10, max_height = 3}
})

add_grow_type("default:cacti", {
{name = "default:dirt", odds = 15, max_height = 3},
{name = "default:dirt_with_grass", odds = 15, max_height = 3},
{name = "default:dirt_with_grass_footsteps", odds = 15, max_height = 3},
{name = "default:sand", odds = 20, max_height = 4}
})


--]]--randomproofs