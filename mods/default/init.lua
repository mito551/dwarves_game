-- Minetest 0.4 mod: default
-- See README.txt for licensing and other information.

-- The API documentation in here was moved into doc/lua_api.txt

WATER_ALPHA = 160
WATER_VISC = 1
LAVA_VISC = 7
LIGHT_MAX = 16
local FLOWING_WATER_SOUND = true
local LAVA_SOUND = true
local LAVA_PARTICLE = true
local CACTUS_HURT_SOUND = true

-- Definitions made by this mod that other mods can use too
default = {}

-- Load other files
dofile(minetest.get_modpath("default").."/player.lua")
dofile(minetest.get_modpath("default").."/mapgen.lua")
dofile(minetest.get_modpath("default").."/functions.lua")
dofile(minetest.get_modpath("default").."/dwarvestuff.lua")
dofile(minetest.get_modpath("default").."/invtweak.lua")
dofile(minetest.get_modpath("default").."/snowmapgen.lua")
dofile(minetest.get_modpath("default").."/snowconfig.lua")
dofile(minetest.get_modpath("default").."/functions.lua")
dofile(minetest.get_modpath("default").."/nodes.lua")
dofile(minetest.get_modpath("default").."/tools.lua")
dofile(minetest.get_modpath("default").."/craftitems.lua")
dofile(minetest.get_modpath("default").."/crafting.lua")
dofile(minetest.get_modpath("default").."/snow.lua")
--
-- Tool definition
--

minetest.register_alias("dwarves:diamond", "default:diamond")


