-- flolands 0.2.1 by paramat.
-- License WTFPL, see license.txt.

-- Editable parameters.

local FLOLANDS = true -- Enable floating island generation (true/false).
local FLOYMIN = 768 -- 768 -- Approximate minimum altitude, lowest level of islands will generate in chunks that contain this altitude.
local FLOLEV = 3 -- 3 -- Number of island levels.
local FLOXMIN = -16384 -- -16384 -- Approximate edges of island area.
local FLOXMAX = 16384 -- 16384
local FLOZMIN = -16384 -- -16384
local FLOZMAX = 16384 -- 16384
local RAR = 0.4 -- 0.4 -- Island rarity in chunk layer. -0.4 = thick layer with holes, 0 = 50%, 0.4 = desert rarity, 0.7 = very rare.
local AMPY = 24 -- 24 -- Amplitude of island centre y variation.
local TGRAD = 24 -- 24 -- Noise gradient to create top surface. Tallness of island top.
local BGRAD = 24 -- 24 -- Noise gradient to create bottom surface. Tallness of island bottom.
local MATCHA = 2197 -- 2197 = 13^3 -- 1/x chance of rare material.
local FLOCHA = 23 -- 23 -- 1/x chance rare material is floatcrystalblock.
local DEBUG = true

local SEEDDIFF1 = 3683 -- 3D perlin1 for island generation.
local OCTAVES1 = 5 -- 5
local PERSISTENCE1 = 0.5 -- 0.5
local SCALE1 = 64 -- 64 -- Approximate scale of floating islands, if you double this add 1 to OCTAVES1.

local SEEDDIFF2 = 9292 -- 3D perlin2 for caves.
local OCTAVES2 = 2 -- 2
local PERSISTENCE2 = 0.5 -- 0.5
local SCALE2 = 8 -- 8

local SEEDDIFF3 = 6412 -- 2D perlin3 for island centre y variation.
local OCTAVES3 = 2 -- 2
local PERSISTENCE3 = 0.5 -- 0.5
local SCALE3 = 128 -- 128 -- Approximate horizontal distance over which island centre y varies.

-- Stuff.

flolands = {}

local floyminq = 80 * math.floor((FLOYMIN + 32) / 80) - 32

-- Nodes.

minetest.register_node("flolands:floatstone", {
	description = "Floatstone",
	tiles = {"flolands_floatstone.png"},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("flolands:floatsand", {
	description = "Turquoise Sand",
	tiles = {"flolands_floatsand.png"},
	groups = {crumbly=3, falling_node=1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("flolands:floatsandstone", {
	description = "Turquoise Sandstone",
	tiles = {"flolands_floatsandstone.png"},
	groups = {crumbly=2, cracky=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("flolands:floatcrystalblock", {
	description = "Floc Block",
	tiles = {"flolands_floatcrystalblock.png"}, 
	groups = {cracky=1},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("flolands:floatglass", {
	description = "High Quality Glass",
	drawtype = "glasslike",
	tiles = {"flolands_floatglass.png"},
	inventory_image = minetest.inventorycube("flolands_floatglass.png"),
	paramtype = "light",
	sunlight_propagates = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

-- Item.

minetest.register_craftitem("flolands:floatcrystal", {
	description = "Floc Crystal",
	inventory_image = "flolands_floatcrystal.png",
})

-- Crafting.

minetest.register_craft({
	output = "flolands:floatsandstone",
	recipe = {
		{"flolands:floatsand", "flolands:floatsand"},
		{"flolands:floatsand", "flolands:floatsand"},
	}
})

minetest.register_craft({
	output = "flolands:floatsand 4",
	recipe = {
		{"flolands:floatsandstone"},
	}
})

minetest.register_craft({
	output = "flolands:floatcrystalblock",
	recipe = {
		{"flolands:floatcrystal", "flolands:floatcrystal", "flolands:floatcrystal"},
		{"flolands:floatcrystal", "flolands:floatcrystal", "flolands:floatcrystal"},
		{"flolands:floatcrystal", "flolands:floatcrystal", "flolands:floatcrystal"},
	}
})

minetest.register_craft({
	output = "flolands:floatcrystal 9",
	recipe = {
		{"flolands:floatcrystalblock"},
	}
})

-- Cooking.

minetest.register_craft({
	type = "cooking",
	output = "flolands:floatglass",
	recipe = "flolands:floatsand",
})

-- On generated function.

if FLOLANDS then
	minetest.register_on_generated(function(minp, maxp, seed)
		if minp.y >= floyminq and minp.y <= floyminq + (FLOLEV - 1) * 80
		and minp.x >= FLOXMIN and maxp.x <= FLOXMAX
		and minp.z >= FLOZMIN and maxp.z <= FLOZMAX then
			-- Floatstone.
			if DEBUG then
				print ("[flolands] Generate structure ("..minp.x.." "..minp.y.." "..minp.z..")")
			end
			local env = minetest.env
			local perlin1 = env:get_perlin(SEEDDIFF1 + minp.y * 100, OCTAVES1, PERSISTENCE1, SCALE1)
			local perlin2 = env:get_perlin(SEEDDIFF2 + minp.y * 100, OCTAVES2, PERSISTENCE2, SCALE2)
			local perlin3 = env:get_perlin(SEEDDIFF3 + minp.y * 100, OCTAVES3, PERSISTENCE3, SCALE3)
			local xl = maxp.x - minp.x
			local yl = maxp.y - minp.y
			local zl = maxp.z - minp.z
			local x0 = minp.x
			local y0 = minp.y
			local z0 = minp.z
			local midy = y0 + yl * 0.5
			-- Loop through columns in chunk.
			for i = 0, xl do
			if DEBUG then
				print ("[flolands] "..i)
			end
			for k = 0, zl do
				local x = x0 + i
				local z = z0 + k
				local noise3 = perlin3:get2d({x=x,y=z})
				local pmidy = midy + noise3 / 1.5 * AMPY
				-- Loop through nodes in column.
				for j = 0, yl do
					local y = y0 + j
					local noise1 = perlin1:get3d({x=x,y=y,z=z})
					local offset = 0
					if y > pmidy then
						offset = (y - pmidy) / TGRAD
					else
						offset = (pmidy - y) / BGRAD
					end
					-- Add floatstone or mese block.
					local noise1off = noise1 - offset - RAR
					if noise1off > 0 and noise1off < 0.7 then
						local noise2 = perlin2:get3d({x=x,y=y,z=z})
						if noise2 - noise1off > -0.7 then
							if math.random(1,MATCHA) ~= 23 then
								env:add_node({x=x,y=y,z=z},{name="flolands:floatstone"})
							else
								if math.random(1,FLOCHA) ~= 7 then
									env:add_node({x=x,y=y,z=z},{name="default:mese"})
								else
									env:add_node({x=x,y=y,z=z},{name="flolands:floatcrystalblock"})
								end
							end
						end
					end
				end
			end
			end
			if DEBUG then
				print ("[flolands] Completed")
			end
			-- Floatsand.
			if DEBUG then
				print ("[flolands] Generate surface ("..minp.x.." "..minp.y.." "..minp.z..")")
			end
			-- Loop through columns in chunk.
			for i = 0, xl do
			for k = 0, zl do
				local x = x0 + i
				local z = z0 + k
				-- Find ground level.
				local ground_y = nil
				for y=maxp.y,minp.y,-1 do
					if env:get_node({x=x,y=y,z=z}).name ~= "air" then
						ground_y = y
						break
					end
				end
				-- Add 1 or 2 nodes depth of floatsand.
				if ground_y then
					if env:get_node({x=x,y=ground_y-1,z=z}).name ~= "air"
					and env:get_node({x=x,y=ground_y-2,z=z}).name ~= "air" then
						env:add_node({x=x,y=ground_y,z=z},{name="flolands:floatsand"})
						if env:get_node({x=x,y=ground_y-3,z=z}).name ~= "air"
						and env:get_node({x=x,y=ground_y-4,z=z}).name ~= "air" then
							env:add_node({x=x,y=ground_y-1,z=z},{name="flolands:floatsand"})
						end
					end
				end
			end
			end
			if DEBUG then
				print ("[flolands] Completed")
			end
		end
	end)
end
