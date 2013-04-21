farming_create_soil = {
	'default:dirt',
	'default:dirt_with_grass',
	}
	
farming_soil = {
	'farming:soil',
	'farming:soil_wet',
	}


-- ========= SOIL =========
dofile(minetest.get_modpath("farming").."/soil.lua")

-- ========= HOES =========
dofile(minetest.get_modpath("farming").."/hoes.lua")

-- ========= WHEAT =========
dofile(minetest.get_modpath("farming").."/wheat.lua")

-- ========= COTTON =========
dofile(minetest.get_modpath("farming").."/cotton.lua")

-- ========= PUMPKINS =========
dofile(minetest.get_modpath("farming").."/pumpkin.lua")

-- ========= WEED =========
dofile(minetest.get_modpath("farming").."/weed.lua")

-- ========= RICE =========
dofile(minetest.get_modpath("farming").."/rice.lua")

-- ========= TEA =========
dofile(minetest.get_modpath("farming").."/tea.lua")

-- ========= LIME =========
dofile(minetest.get_modpath("farming").."/lime.lua")
