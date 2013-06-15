-- Ore generation

local function generate_ore(name, wherein, minp, maxp, seed, chunks_per_volume, ore_per_chunk, height_min, height_max)
	if maxp.y < height_min or minp.y > height_max then
		return
	end
	local y_min = math.max(minp.y, height_min)
	local y_max = math.min(maxp.y, height_max)
	local volume = (maxp.x-minp.x+1)*(y_max-y_min+1)*(maxp.z-minp.z+1)
	local pr = PseudoRandom(seed)
	local num_chunks = math.floor(chunks_per_volume * volume)
	local chunk_size = 3
	if ore_per_chunk <= 4 then
		chunk_size = 2
	end
	local inverse_chance = math.floor(chunk_size*chunk_size*chunk_size / ore_per_chunk)
	--print("generate_ore num_chunks: "..dump(num_chunks))
	for i=1,num_chunks do
	if (y_max-chunk_size+1 <= y_min) then return end
		local y0 = pr:next(y_min, y_max-chunk_size+1)
		if y0 >= height_min and y0 <= height_max then
			local x0 = pr:next(minp.x, maxp.x-chunk_size+1)
			local z0 = pr:next(minp.z, maxp.z-chunk_size+1)
			local p0 = {x=x0, y=y0, z=z0}
			for x1=0,chunk_size-1 do
			for y1=0,chunk_size-1 do
			for z1=0,chunk_size-1 do
				if pr:next(1,inverse_chance) == 1 then
					local x2 = x0+x1
					local y2 = y0+y1
					local z2 = z0+z1
					local p2 = {x=x2, y=y2, z=z2}
					if minetest.env:get_node(p2).name == wherein then
						minetest.env:set_node(p2, {name=name})
					end
				end
			end
			end
			end
		end
	end
	--print("generate_ore done")
end

--[[minetest.register_on_generated(function(minp, maxp, seed)
	math.randomseed(os.time())
	local current_seed = seed + math.random(1,1000)
	local function get_next_seed()
		current_seed = current_seed + 1
		return current_seed
	end
	generate_ore("moreores:mineral_copper", "default:stone", minp, maxp, seed+16,   1/25/25/25,    4, -31000,  64)
	generate_ore("moreores:mineral_tin", "default:stone", minp, maxp, seed+17,   1/15/15/15,    2, -31000,  8)
	generate_ore("moreores:mineral_silver", "default:stone", minp, maxp, seed+18,   1/17/17/17,    5, -31000,  2)
	generate_ore("moreores:mineral_gold", "default:stone", minp, maxp, seed+19,   1/20/20/20,    3, -31000,  -64)
	generate_ore("moreores:mineral_lead", "default:stone", minp, maxp, seed+21, 1/25/25/25, 2, -31000, -256)
	generate_ore("moreores:mineral_electrum", "default:stone", minp, maxp, seed+20,   1/15/15/15,    1, -31000,  -512)
	generate_ore("dwarves:stone_with_obsidian", "default:stone", minp, maxp, seed+22,   1/13/13/13,    4, -31000,  64)
	generate_ore("dwarves:ruby_ore", "default:stone", minp, maxp, seed+23,   1/16/16/16,    2, -31000,  -64)
	generate_ore("dwarves:emerald_ore", "default:stone", minp, maxp, seed+24,   1/18/18/18,    2, -31000,  -64)
	generate_ore("dwarves:sapphire_ore", "default:stone" , minp, maxp, seed+25,   1/20/20/20,    2, -31000,  -64)
	generate_ore("dwarves:diamond_ore", "default:stone", minp, maxp, seed+26,   1/18/18/18,    3, -31000,  -256)
	generate_ore("dwarves:mithril_ore", "default:stone" , minp, maxp, seed+28,   2/32/32/32,    1, -31000,  -128)
	generate_ore("dwarves:mithril_ore", "default:stone", minp, maxp, seed+29,   1/32/32/32,    3, -31000,  -512)
	generate_ore("dwarves:ebony_ore", "default:stone", minp, maxp, seed+27,   4/64/64/64,    3, -31000,  -256)
	generate_ore("dwarves:ebony_ore", "default:stone" , minp, maxp, seed+28,   1/24/24/24,    5, -31000,  -64)
	generate_ore("moreores:mineral_copper", "flolands:floatstone", minp, maxp, seed+16,   1/25/25/25,    4, -31000,  64)
	generate_ore("moreores:mineral_tin", "flolands:floatstone", minp, maxp, seed+17,   1/15/15/15,    2, -31000,  8)
	generate_ore("moreores:mineral_silver", "flolands:floatstone", minp, maxp, seed+18,   1/17/17/17,    5, -31000,  2)
	generate_ore("moreores:mineral_gold", "flolands:floatstone", minp, maxp, seed+19,   1/20/20/20,    3, -31000,  -64)
	generate_ore("moreores:mineral_lead", "flolands:floatstone", minp, maxp, seed+21, 1/25/25/25, 2, -31000, -256)
	generate_ore("moreores:mineral_electrum", "flolands:floatstone", minp, maxp, seed+20,   1/15/15/15,    1, -31000,  -512)
	generate_ore("dwarves:stone_with_obsidian", "flolands:floatstone", minp, maxp, seed+22,   1/13/13/13,    4, -31000,  64)
	generate_ore("dwarves:ruby_ore", "flolands:floatstone", minp, maxp, seed+23,   1/16/16/16,    2, -31000,  -64)
	generate_ore("dwarves:emerald_ore", "flolands:floatstone", minp, maxp, seed+24,   1/18/18/18,    2, -31000,  -64)
	generate_ore("dwarves:sapphire_ore", "flolands:floatstone" , minp, maxp, seed+25,   1/20/20/20,    2, -31000,  -64)
	generate_ore("dwarves:diamond_ore", "flolands:floatstone", minp, maxp, seed+26,   1/18/18/18,    3, -31000,  -256)
	generate_ore("dwarves:mithril_ore", "flolands:floatstone" , minp, maxp, seed+28,   2/32/32/32,    1, -31000,  -128)
	generate_ore("dwarves:mithril_ore", "flolands:floatstone", minp, maxp, seed+29,   1/32/32/32,    3, -31000,  -512)
	generate_ore("dwarves:ebony_ore", "flolands:floatstone", minp, maxp, seed+27,   4/64/64/64,    3, -31000,  -256)
	generate_ore("dwarves:ebony_ore", "flolands:floatstone" , minp, maxp, seed+28,   1/24/24/24,    5, -31000,  -64)	


end)--]]

--it will fail if clust_num_ores > clust_size^3
--clust_num_ores < clust_size^3

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "dwarves:stone_with_obsidian",
	wherein        = "default:stone",
	clust_scarcity = 13*13*13,
	clust_num_ores = 4,
	clust_size     = 4+math.random(0,3),
	height_min     = -31000,
	height_max     = 64,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "dwarves:ruby_ore",
	wherein        = "default:stone",
	clust_scarcity = 16*16*16,
	clust_num_ores = 2,
	clust_size     = 2+math.random(0,2),
	height_min     = -31000,
	height_max     = -64,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "dwarves:emerald_ore",
	wherein        = "default:stone",
	clust_scarcity = 18*18*18,
	clust_num_ores = 2,
	clust_size     = 2+math.random(0,2),
	height_min     = -31000,
	height_max     = -64,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "dwarves:sapphire_ore",
	wherein        = "default:stone",
	clust_scarcity = 16*16*16,
	clust_num_ores = 1,
	clust_size     = 2+math.random(0,2),
	height_min     = -31000,
	height_max     = -128,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "dwarves:diamond_ore",
	wherein        = "default:stone",
	clust_scarcity = 18*18*18,
	clust_num_ores = 1,
	clust_size     = 2+math.random(0,2),
	height_min     = -31000,
	height_max     = -128,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "dwarves:mithril_ore",
	wherein        = "default:stone",
	clust_scarcity = 20*20*20,
	clust_num_ores = 1,
	clust_size     = 2+math.random(0,4),
	height_min     = -31000,
	height_max     = -256,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "dwarves:ebony_ore",
	wherein        = "default:stone",
	clust_scarcity = 24*24*24,
	clust_num_ores = 3,
	clust_size     = 2+math.random(0,4),
	height_min     = -31000,
	height_max     = -64,
})

--[[minetest.register_ore({
	ore_type       = "scatter",
	ore            = "dwarves:stone_with_obsidian",
	wherein        = "flolands:floatstone",
	clust_scarcity = 13*13*13,
	clust_num_ores = 4,
	clust_size     = 3+math.random(0,3),
	height_min     = 31000,
	height_max     = 1000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "dwarves:ruby_ore",
	wherein        = "flolands:floatstone",
	clust_scarcity = 16*16*16,
	clust_num_ores = 2,
	clust_size     = 2+math.random(0,2),
	height_min     = 31000,
	height_max     = 1000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "dwarves:emerald_ore",
	wherein        = "flolands:floatstone",
	clust_scarcity = 18*18*18,
	clust_num_ores = 2,
	clust_size     = 2+math.random(0,2),
	height_min     = 31000,
	height_max     = 1000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "dwarves:sapphire_ore",
	wherein        = "flolands:floatstone",
	clust_scarcity = 16*16*16,
	clust_num_ores = 1,
	clust_size     = 2+math.random(0,2),
	height_min     = 31000,
	height_max     = 1000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "dwarves:diamond_ore",
	wherein        = "flolands:floatstone",
	clust_scarcity = 18*18*18,
	clust_num_ores = 1,
	clust_size     = 2+math.random(0,2),
	height_min     = 31000,
	height_max     = 1000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "dwarves:mithril_ore",
	wherein        = "flolands:floatstone",
	clust_scarcity = 20*20*20,
	clust_num_ores = 1,
	clust_size     = 2+math.random(0,4),
	height_min     = 31000,
	height_max     = 1000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "dwarves:ebony_ore",
	wherein        = "flolands:floatstone",
	clust_scarcity = 24*24*24,
	clust_num_ores = 3,
	clust_size     = 2+math.random(0,4),
	height_min     = 31000,
	height_max     = 1000,
})--]]

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "dwarves:hive",
	wherein        = "default:leaves",
	clust_scarcity = 25*25*25,
	clust_num_ores = 1,
	clust_size     = 1,
	height_min     = -31000,
	height_max     = 31000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "dwarves:hive",
	wherein        = "default:jungleleaves",
	clust_scarcity = 25*25*25,
	clust_num_ores = 1,
	clust_size     = 1,
	height_min     = -31000,
	height_max     = 31000,
})