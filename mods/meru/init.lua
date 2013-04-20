-- meru 0.1.0 by paramat.
-- License WTFPL, see license.txt.

-- Editable parameters.

local MERU = true
local MERUX = 0 -- Approximate centre, will be rounded to nearest chunk.
local MERUZ = 272
local VGRAD = 448 -- 448 -- Vertical noise gradient. Height is approx twice this.
local HGRAD = 24 -- 24 -- Horizontal noise gradient. Radius is approx twice this.
local CAVOFF = 0.8 -- 0.8 -- Cave noise offset.
local DEBUG = true

local SEEDDIFF1 = 4689 -- 3D noise for surface generation
local OCTAVES1 = 5 -- 5
local PERSISTENCE1 = 0.53 -- 0.53
local SCALE1 = 64 -- 64

local SEEDDIFF2 = 9294 -- 3D noise for caves.
local OCTAVES2 = 2 -- 2
local PERSISTENCE2 = 0.5 -- 0.5
local SCALE2 = 8 -- 8

-- End of editable parameters.

local SEEDDIFF3 = 9130 -- 9130 -- Values must match minetest mapgen desert perlin.
local OCTAVES3 = 3 -- 3
local PERSISTENCE3 = 0.5 -- 0.5
local SCALE3 = 250 -- 250

-- Stuff.

meru = {}

local meruxq = (80 * math.floor((MERUX + 32) / 80)) - 32
local meruzq = (80 * math.floor((MERUZ + 32) / 80)) - 32

-- On generated function.

if MERU then
	minetest.register_on_generated(function(minp, maxp, seed)
		if (minp.x == meruxq or minp.x == meruxq - 80)
		and (minp.z == meruzq or minp.z == meruzq - 80) 
		and minp.y >= -32 and minp.y <= 928 then
			local env = minetest.env
			local perlin1 = env:get_perlin(SEEDDIFF1, OCTAVES1, PERSISTENCE1, SCALE1)
			local perlin2 = env:get_perlin(SEEDDIFF2, OCTAVES2, PERSISTENCE2, SCALE2)
			local perlin3 = env:get_perlin(SEEDDIFF3, OCTAVES3, PERSISTENCE3, SCALE3)
			local xl = maxp.x - minp.x
			local yl = maxp.y - minp.y
			local zl = maxp.z - minp.z
			local x0 = minp.x
			local y0 = minp.y
			local z0 = minp.z
			-- Loop through nodes in chunk.
			for i = 0, xl do
				-- For each plane do.
				if DEBUG then
					print ("[meru] Plane "..i.." Chunk ("..minp.x.." "..minp.y.." "..minp.z..")")
				end
				for k = 0, zl do
					-- For each column do.
					local x = x0 + i
					local z = z0 + k
					local noise3 = perlin3:get2d({x=x+150,y=z+50}) -- Offsets must match minetest mapgen desert perlin.
					local desert = false
					if noise3 > 0.45 or math.random(0,10) > (0.45 - noise3) * 100 then -- Smooth transition 0.35 to 0.45.
						desert = true 
					end
					for j = 0, yl do
						-- For each node do.
						local y = y0 + j
						local noise1 = perlin1:get3d({x=x,y=y,z=z})
						local radius = ((x - meruxq) ^ 2 + (z - meruzq) ^ 2) ^ 0.5
 						local offset = - y / VGRAD - radius / HGRAD
						local noise1off = noise1 + offset + 2
						if noise1off > 0 and noise1off < 1 then
							local noise2 = perlin2:get3d({x=x,y=y,z=z})
							if noise2 - noise1off / 2 + CAVOFF > 0 then
								if desert then
									env:add_node({x=x,y=y,z=z},{name="default:desert_stone"})
								else
									env:add_node({x=x,y=y,z=z},{name="default:stone"})
								end
							end
						end
					end
				end
			end
			if DEBUG then
				print ("[meru] Completed")
			end
		end
	end)
end
