--
-- Nodes file for Extra Biomes
-- 

-- Nodeblocks

minetest.register_node("extra_biomes:stone", {
	description = "Extra Biomes Stone",
	tiles = {"extra_biomes_stone.png"},
	is_ground_content = true,
	groups = {cracky=6, stone=1, melt=3000},
	freezemelt = "default:lava_source",
	drop = {
		max_items = 1,
		items = {
			{
				items = {'default:stone_with_coal'},
				rarity = 7,
			},
			{
				items = {'default:stone_with_iron'},
				rarity = 7,
			},
			{
				items = {'default:stone_with_gold'},
				rarity = 7,
			},			
			{
				items = {'default:stone_with_copper'},
				rarity = 7,
			},
			{
				items = {'default:stone_with_mese'},
				rarity = 7,
			},
			{
				items = {'default:stone'},
				rarity = 5,
			},
		},
	},
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("extra_biomes:dirt", {
	description = "Extra Biomes Dirt",
	tiles = {"extra_biomes_dirt.png"},
	is_ground_content = true,
	groups = {crumbly=6, soil=1, melt=3050},
	freezemelt = "default:water_source",
	drop = {
		max_items = 1,
		items = {
			{
				items = {'default:coal_lump'},
				rarity = 7,
			},
			{
				items = {'default:gold_lump'},
				rarity = 7,
			},
			{
				items = {'default:iron_lump'},
				rarity = 7,
			},
			{
				items = {'default:copper_lump'},
				rarity = 7,
			},
			{
				items = {'default:mese_crystal'},
				rarity = 7,
			},
			{
				items = {'default:dirt_with_grass'},
				rarity = 5,
			},
		},
	},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})
