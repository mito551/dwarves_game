--
-- Tool definition
--

dofile(minetest.get_modpath("dwarves").."/oregen.lua")
dofile(minetest.get_modpath("dwarves").."/beer.lua")
dofile(minetest.get_modpath("dwarves").."/honey.lua")
dofile(minetest.get_modpath("dwarves").."/raft.lua")
dofile(minetest.get_modpath("dwarves").."/abms.lua")


minetest.register_tool("dwarves:heal", {
	description = "Healing Wand",
	inventory_image = "dwarves_tool_heal.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			fleshy={times={[1]=0.75, [2]=0.95, [3]=0.80}, uses=50, maxlevel=4},
		},
		damage_groups = {fleshy=-4},
	}
})


minetest.register_tool("dwarves:dagger_steel", {
	description = "Steel Dagger",
	inventory_image = "dwarves_tool_steelknife.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level=0,
		groupcaps={
			choppy={times={[1]=4.25, [2]=2.45, [3]=2.25}, uses=150, maxlevel=2},
		},
		damage_groups = {fleshy=7},	
	}
})

minetest.register_tool("dwarves:dagger_ebony", {
	description = "Ebony Dagger",
	inventory_image = "dwarves_tool_ebonyknife.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=4.25, [2]=2.45, [3]=2.25}, uses=150, maxlevel=2},
		},
		damage_groups = {fleshy=9},	
	}
})

minetest.register_tool("dwarves:dagger_obs", {
	description = "Obsidian Dagger",
	inventory_image = "dwarves_tool_obsdagger.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=4.25, [2]=2.45, [3]=2.25}, uses=75, maxlevel=2},
		},
		damage_groups = {fleshy=7},	
	}
})

minetest.register_tool("dwarves:axe", {
	description = "An Axe",
	inventory_image = "dwarves_sonic_axe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=5,
		groupcaps={
			cracky={times={[1]=0.01, [2]=0.01, [3]=0.01, [4]=0.1, [5]=0.501, [6]=0.501}, uses=200, maxlevel=6},
			crumbly={times={[1]=0.01, [2]=0.01, [3]=0.01, [4]=0.1, [5]=0.501, [6]=0.501}, uses=200, maxlevel=6},
			snappy={times={[1]=0.01, [2]=0.01, [3]=0.01, [4]=0.1, [5]=0.5, [6]=0.501}, uses=200, maxlevel=6}
		}
	},
})

minetest.register_node("dwarves:glass", {
	description = "Ultimate Glass",
	drawtype = "glasslike",
	tiles = {"default_glass.png"},
	inventory_image = minetest.inventorycube("default_glass.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=6,cracky=6, level=6},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_tool("dwarves:pick_ebony", {
	description = "Ebony Pickaxe",
	inventory_image = "dwarves_tool_ebonypick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			cracky={times={[1]=2.5, [2]=1.5, [3]=1.0}, uses=60, maxlevel=4},
		},
		damage_groups = {fleshy=4},	
	},
})

minetest.register_tool("dwarves:axe_ebony", {
	description = "Ebony Axe",
	inventory_image = "dwarves_tool_ebonyaxe.png",
	tool_capabilities = {
		max_drop_level=3,
		groupcaps={
			choppy={times={[1]=2.5, [2]=1.5, [3]=1.0}, uses=60, maxlevel=4},
		},
		damage_groups = {fleshy=4},	
	},
})

minetest.register_tool("dwarves:shovel_ebony", {
	description = "Ebony Shovel",
	inventory_image = "dwarves_tool_ebonyshovel.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			crumbly={times={[1]=2.5, [2]=1.5, [3]=1.0}, uses=60, maxlevel=4},
		},
		damage_groups = {fleshy=2},	
	},
})

minetest.register_tool("dwarves:sword_ebony", {
	description = "Ebony Sword",
	inventory_image = "dwarves_tool_ebonysword.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			fleshy={times={[1]=0.75, [2]=0.95, [3]=0.80}, uses=50, maxlevel=4},
		},
		damage_groups = {fleshy=7},
	}
})

minetest.register_tool("dwarves:pick_obs", {
	description = "Obsidian Pickaxe",
	inventory_image = "dwarves_tool_obspick.png",
	tool_capabilities = {
		max_drop_level=1,
		groupcaps={
			cracky={times={[1]=4.5, [2]=2.0, [3]=1.5}, uses=100, maxlevel=2}
		},
		damage_groups = {fleshy=4},	
	},
})

minetest.register_tool("dwarves:shovel_obs", {
	description = "Obsidian Shovel",
	inventory_image = "dwarves_tool_obsshovel.png",
	tool_capabilities = {
		max_drop_level=1,
		groupcaps={
			crumbly={times={[1]=2.25, [2]=1.25, [3]=1.00}, uses=75, maxlevel=2}
		},
		damage_groups = {fleshy=2},	
	},
})


minetest.register_tool("dwarves:axe_obs", {
	description = "Obsidian Axe",
	inventory_image = "dwarves_tool_obsaxe.png",
	tool_capabilities = {
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=4.25, [2]=2.45, [3]=2.25}, uses=75, maxlevel=2},
		},
		damage_groups = {fleshy=4},		
	},
})

minetest.register_tool("dwarves:club_obs", {
	description = "Obsidian Club",
	inventory_image = "dwarves_tool_obsclub.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=1.90, [2]=0.90, [3]=0.30}, uses=40, maxlevel=4},
		},
		damage_groups = {fleshy=6},
	}
})

minetest.register_tool("dwarves:durin_axe", {
	description = "Durin's Axe",
	inventory_image = "dwarves_tool_durinaxe.png",
	tool_capabilities = {
		full_punch_interval = 0.75,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=3.50, [2]=1.50, [3]=1.60}, uses=200, maxlevel=1},
		},
		damage_groups = {fleshy=14},
	}
})

minetest.register_tool("dwarves:sword_obs", {
	description = "Obsidian Sword",
	inventory_image = "dwarves_tool_obssword.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=1.90, [2]=0.90, [3]=0.30}, uses=40, maxlevel=4},
		},
		damage_groups = {fleshy=10},
	}
})

minetest.register_tool("dwarves:bataxe_pob", {
	description = "Pobe Battle Axe",
	inventory_image = "dwarves_tool_pobataxe.png",
	tool_capabilities = {
		full_punch_interval = 1.75,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=3.50, [2]=1.50, [3]=1.60}, uses=200, maxlevel=1},
		},
		damage_groups = {fleshy=14},
	}
})

minetest.register_tool("dwarves:pick_adam", {
	description = "Adamantium Pickaxe",
	inventory_image = "dwarves_tool_adampick.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.0, [2]=1.0, [3]=0.50}, uses=175, maxlevel=5},
		},
		damage_groups = {fleshy=5},
	},
})

minetest.register_tool("dwarves:axe_adam", {
	description = "Adamantium Axe",
	inventory_image = "dwarves_tool_adamaxe.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.10, [2]=0.90, [3]=0.50}, uses=200, maxlevel=5},
		},
		damage_groups = {fleshy=6},
	},
})


minetest.register_tool("dwarves:shovel_adam", {
	description = "Adamantium Shovel",
	inventory_image = "dwarves_tool_adamshovel.png",
	wield_image = "dwarves_tool_adamshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.10, [2]=0.50, [3]=0.30}, uses=200, maxlevel=5},
		},
		damage_groups = {fleshy=4},
	},
})

minetest.register_tool("dwarves:axe_pobe", {
	description = "Pobe Axe",
	inventory_image = "dwarves_tool_pobaxe.png",
	tool_capabilities = {
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=0.90, [2]=0.70, [3]=0.45}, uses=75, maxlevel=5},
		},
		damage_groups = {fleshy=7},
	},
})


minetest.register_tool("dwarves:sword_pobe", {
	description = "Pobe Sword",
	inventory_image = "dwarves_tool_pobsword.png",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=1.90, [2]=0.90, [3]=0.30}, uses=40, maxlevel=4},
		},
		damage_groups = {fleshy=7},
	}
})

minetest.register_craftitem("dwarves:flint_and_steel", {
    description = "Flint and Steel",
    inventory_image = "dwarves_flint_and_steel.png",
    stack_max = 1,
    on_use = function(itemstack, user, pointed_thing)
    if pointed_thing.type=="node" then
            if minetest.env:get_node(pointed_thing.above).name == "air" then
                minetest.sound_play("flint", {pos=pointed_thing.under, loop=false})
                itemstack:add_wear(1000)
                minetest.env:add_node(pointed_thing.above, {name="fire:basic_flame"})
                return itemstack
        end
    end
end,
})


--
-- Crafting definition
--

minetest.register_craft({
    type = "shapeless",
    output = 'default:steel_ingot',
    recipe = {
        "default:iron_ingot",
        "default:coal_lump",
    },
})

minetest.register_craft({
    type = "shapeless",
    output = 'dwarves:flint_and_steel',
    recipe = {
        "default:steel_ingot",
        "dwarves:flint",
    },
})

minetest.register_craft({
    type = "shapeless",
    output = 'dwarves:pobe',
    recipe = {
        "default:steel_ingot",
        "default:coal_lump",
    },
})

minetest.register_craft({
    type = "shapeless",
    output = 'dwarves:brass',
    recipe = {
        "default:iron_ingot",
        "moreores:copper_ingot",
    },
})

minetest.register_craft({
	output = 'default:steel_ingot',
	recipe = {
		{'default:iron_ingot', 'default:coal_lump'},
	}
})

minetest.register_craft({
	output = 'dwarves:brass',
	recipe = {
		{'default:iron_ingot', 'moreores:copper_ingot'},
	}
})

minetest.register_craft({
	output = 'dwarves:castiron',
	recipe = {
		{'default:iron_ingot', 'dwarves:charcoal'},
		{'dwarves:charcoal', 'default:iron_ingot'},
	}
})

minetest.register_craft({
	output = 'dwarves:pick_obs',
	recipe = {
		{'dwarves:obsidian', 'dwarves:obsidian', 'dwarves:obsidian'},
		{'', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'dwarves:axe_obs',
	recipe = {
		{'dwarves:obsidian', 'dwarves:obsidian', ''},
		{'dwarves:obsidian', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'dwarves:shovel_obs',
	recipe = {
		{'', 'dwarves:obsidian', ''},
		{'', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'dwarves:sword_obs',
	recipe = {
		{'', 'dwarves:obsidian', ''},
		{'', 'dwarves:obsidian', ''},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'dwarves:pick_ebony',
	recipe = {
		{'dwarves:ebony_ingot', 'dwarves:ebony_ingot', 'dwarves:ebony_ingot'},
		{'', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'dwarves:axe_ebony',
	recipe = {
		{'dwarves:ebony_ingot', 'dwarves:ebony_ingot', ''},
		{'dwarves:ebony_ingot', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'dwarves:shovel_ebony',
	recipe = {
		{'', 'dwarves:ebony_ingot', ''},
		{'', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'dwarves:sword_ebony',
	recipe = {
		{'', 'dwarves:ebony_ingot', ''},
		{'', 'dwarves:ebony_ingot', ''},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'dwarves:knife_ebony',
	recipe = {
		{'dwarves:ebony_ingot'},
		{'default:stick'},
	}
})

minetest.register_craft({
	output = 'dwarves:knife_steel',
	recipe = {
		{'default:steel_ingot'},
		{'default:stick'},
	}
})


minetest.register_craft({
	output = 'dwarves:sword_silver',
	recipe = {
		{'', 'moreores:silver_ingot', ''},
		{'', 'moreores:silver_ingot', ''},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:torch 1',
	recipe = {
		{'dwarves:charcoal'},
		{'default:stick'},
	}
})

minetest.register_craft({
	output = '"dwarves:copper_coin" 3',
	recipe = {
		{'default:copper_ingot', 'default:copper_ingot', 'default:copper_ingot'},
	}
})

minetest.register_craft({
	output = '"dwarves:brass_coin" 3',
	recipe = {
		{'dwarves:brass', 'dwarves:brass', 'dwarves:brass'},
	}
})

minetest.register_craft({
	output = '"dwarves:bronze_coin" 3',
	recipe = {
		{'default:bronze_ingot', 'default:bronze_ingot', 'default:bronze_ingot'},
	}
})

minetest.register_craft({
	output = 'dwarves:axe_pobe',
	recipe = {
		{'dwarves:pobe', 'dwarves:pobe'},
		{'dwarves:pobe', 'default:stick'},
		{'', 'default:stick'},
	}
})

minetest.register_craft({
	output = 'dwarves:axe_pobe',
	recipe = {
		{'dwarves:pobe', 'dwarves:pobe'},
		{'default:stick', 'dwarves:pobe'},
		{'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'dwarves:bataxe_pob',
	recipe = {
		{'dwarves:pobe', 'dwarves:pobe', 'dwarves:pobe'},
		{'dwarves:pobe', 'default:stick', 'dwarves:pobe'},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'dwarves:sword_pob',
	recipe = {
		{'', 'dwarves:pobe', ''},
		{'', 'dwarves:pobe', ''},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'dwarves:obsidian',
	recipe = {
		{'dwarves:obsidian_lump', 'dwarves:obsidian_lump'},
		{'dwarves:obsidian_lump', 'dwarves:obsidian_lump'},
	}
})

minetest.register_craft( {
	output = 'craft "dwarves:gold_chumps" 9',
	recipe = {
		{'craft "moreores:gold_ingot"'},
	}
})

minetest.register_craft( {
	output = 'craft "dwarves:silver_chumps" 9',
	recipe = {
		{'craft "moreores:silver_ingot"'},
	}
})

minetest.register_craft( {
	output = 'craft "moreores:gold_ingot"',
	recipe = {
		{'dwarves:gold_chumps', 'dwarves:gold_chumps', 'dwarves:gold_chumps' },
		{'dwarves:gold_chumps', 'dwarves:gold_chumps', 'dwarves:gold_chumps' },
		{'dwarves:gold_chumps', 'dwarves:gold_chumps', 'dwarves:gold_chumps' },
	}
})

minetest.register_craft( {
	output = 'craft "moreores:silver_ingot"',
	recipe = {
		{'dwarves:silver_chumps', 'dwarves:silver_chumps', 'dwarves:silver_chumps' },
		{'dwarves:silver_chumps', 'dwarves:silver_chumps', 'dwarves:silver_chumps' },
		{'dwarves:silver_chumps', 'dwarves:silver_chumps', 'dwarves:silver_chumps' },
	}
})

minetest.register_craft( {
	output = 'dwarves:adamantium',
	recipe = {
		{'dwarves:diamond', 'dwarves:mithril_ingot', 'dwarves:pobe' },
	}
})

minetest.register_craft({
	output = 'dwarves:silver_ring',
	recipe = {
		{'dwarves:silver_chumps', 'dwarves:silver_chumps'},
	}
})

minetest.register_craft({
	output = 'dwarves:gold_ring',
	recipe = {
		{'dwarves:gold_chumps', 'dwarves:gold_chumps'},
	}
})

minetest.register_craft({
	output = 'dwarves:gold_necklace_ruby',
	recipe = {
		{'', 'dwarves:gold_chumps', ''},
		{'dwarves:gold_chumps', 'dwarves:ruby', 'dwarves:gold_chumps'},
		{'', 'dwarves:gold_chumps', ''},
	}
})

minetest.register_craft({
	output = 'dwarves:gold_necklace_diamond',
	recipe = {
		{'', 'dwarves:gold_chumps', ''},
		{'dwarves:gold_chumps', 'dwarves:diamond', 'dwarves:gold_chumps'},
		{'', 'dwarves:gold_chumps', ''},
	}
})

minetest.register_craft({
	output = 'dwarves:gold_necklace_emerald',
	recipe = {
		{'', 'dwarves:gold_chumps', ''},
		{'dwarves:gold_chumps', 'dwarves:emerald', 'dwarves:gold_chumps'},
		{'', 'dwarves:gold_chumps', ''},
	}
})

minetest.register_craft({
	output = 'dwarves:gold_necklace_sapphire',
	recipe = {
		{'', 'dwarves:gold_chumps', ''},
		{'dwarves:gold_chumps', 'dwarves:sapphire', 'dwarves:gold_chumps'},
		{'', 'dwarves:gold_chumps', ''},
	}
})

minetest.register_craft({
	output = 'dwarves:silver_necklace_ruby',
	recipe = {
		{'', 'dwarves:silver_chumps', ''},
		{'dwarves:silver_chumps', 'dwarves:ruby', 'dwarves:silver_chumps'},
		{'', 'dwarves:silver_chumps', ''},
	}
})

minetest.register_craft({
	output = 'dwarves:silver_necklace_diamond',
	recipe = {
		{'', 'dwarves:silver_chumps', ''},
		{'dwarves:silver_chumps', 'dwarves:diamond', 'dwarves:silver_chumps'},
		{'', 'dwarves:silver_chumps', ''},
	}
})

minetest.register_craft({
	output = 'dwarves:silver_necklace_emerald',
	recipe = {
		{'', 'dwarves:silver_chumps', ''},
		{'dwarves:silver_chumps', 'dwarves:emerald', 'dwarves:silver_chumps'},
		{'', 'dwarves:silver_chumps', ''},
	}
})

minetest.register_craft({
	output = 'dwarves:silver_necklace_sapphire',
	recipe = {
		{'', 'dwarves:silver_chumps', ''},
		{'dwarves:silver_chumps', 'dwarves:sapphire', 'dwarves:silver_chumps'},
		{'', 'dwarves:silver_chumps', ''},
	}
})

minetest.register_craft({
	output = 'craft "dwarves:glass_lamp" 2',
	recipe = {
		{'', 'default:glass', ''},
		{'default:glass', 'default:torch', 'default:glass'},
		{'', 'default:glass', ''},
	}
})

minetest.register_craft({
	output = 'dwarves:barrel',
	recipe = {
		{'group:wood', '', 'group:wood'},
		{'group:wood', '', 'group:wood'},
		{'group:wood', 'bucket:bucket_water', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'dwarves:axe_adam',
	recipe = {
		{'dwarves:adamantium', 'dwarves:adamantium'},
		{'dwarves:adamantium', 'default:stick'},
		{'', 'default:stick'},
	}
})

minetest.register_craft({
	output = 'dwarves:axe_adam',
	recipe = {
		{'dwarves:adamantium', 'dwarves:adamantium'},
		{'default:stick', 'dwarves:adamantium'},
		{'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'dwarves:pick_adam',
	recipe = {
		{'dwarves:adamantium', 'dwarves:adamantium', 'dwarves:adamantium'},
		{'', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'dwarves:shovel_adam',
	recipe = {
		{'', 'dwarves:adamantium', ''},
		{'', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'dwarves:magic_essence',
	recipe = {
		{'', 'dwarves:ruby', ''},
		{'dwarves:sapphire', 'dwarves:diamond', 'dwarves:emerald'},
		{'', 'default:steel_ingot', ''},
	}
})

minetest.register_craft({
	output = 'dwarves:obsidian',
	recipe = {
		{'dwarves:obsidian_shard', 'dwarves:obsidian_shard', 'dwarves:obsidian_shard'},
		{'dwarves:obsidian_shard', 'dwarves:obsidian_shard', 'dwarves:obsidian_shard'},
		{'dwarves:obsidian_shard', 'dwarves:obsidian_shard', 'dwarves:obsidian_shard'},
	}
})

minetest.register_craft({
	output = 'dwarves:sword_obs',
	recipe = {
		{'dwarves:obsidian_shard', 'dwarves:obsidian_shard'},
		{'dwarves:obsidian_shard', 'dwarves:obsidian_shard'},
		{'default:iron_ingot', 'dwarves:sapphire'},
	}
})

minetest.register_craft({
	output = 'dwarves:dagger_obs',
	recipe = {
		{'dwarves:obsidian_shard', 'dwarves:obsidian_shard'},
		{'default:iron_ingot', 'dwarves:sapphire'},
	}
})

minetest.register_craft({
	output = 'default:mese',
	recipe = {
		{'group:wood', 'default:gold_ingot', 'group:wood'},
		{'default:steel_ingot', 'dwarves:obsidian', 'dwarves:ebony_ingot'},
		{'group:wood', 'default:bronze_ingot', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'default:wood 4',
	recipe = {
		{"dwarves:mossytree"},
	},
	--replacements = {{"dwarves:mossytree", "dwarves:moss"}},
})

minetest.register_craft({
	output = 'dwarves:heal',
	recipe = {
		{'dwarves:emerald', 'dwarves:magic_essence', 'dwarves:emerald'},
		{'', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
    type = "shapeless",
    output = 'dwarves:flint',
    recipe = {
        "default:gravel",
        "default:gravel",
		"default:gravel",
    },
})

minetest.register_craft({
    type = "shapeless",
    output = 'dwarves:mossywood',
    recipe = {
        "dwarves:moss",
        "dwarves:rotten_wood",
    },
})

minetest.register_craft({
    type = "shapeless",
    output = 'dwarves:mossytree',
    recipe = {
        "dwarves:moss",
        "default:tree",
    },
})

minetest.register_craft({
    type = "shapeless",
    output = 'default:mossycobble',
    recipe = {
        "dwarves:moss",
        "default:cobble",
    },
})
--
-- Cooking recipes
--

minetest.register_craft({
	type = "cooking",
	output = 'dwarves:flint',
	recipe = "default:gravel",
})

minetest.register_craft({
	type = "cooking",
	output = 'dwarves:water_boiled',
	recipe = "bucket:bucket_water",
})

minetest.register_craft({
	type = "cooking",
	output = 'default:iron_lump',
	recipe = "default:steel_ingot",
})

minetest.register_craft({
	type = "cooking",
	output = "dwarves:charcoal",
	recipe = "group:tree",
})

minetest.register_craft({
	type = "cooking",
	output = "dwarves:ebony_ingot",
	recipe = "dwarves:ebony_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "dwarves:mithril_ingot",
	recipe = "dwarves:mithril_lump",
})


--
-- Fuels
--

minetest.register_craft({
	type = "fuel",
	recipe = "dwarves:charcoal",
	burntime = 40,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:torch",
	burntime = 60,
})

--
-- Node definitions
--

-- default node sounds

minetest.register_node("dwarves:glass_lamp", {
	description = "Glass Lamp",
	drawtype = "glasslike",
	tiles = {"dwarves_glass_lamp.png"},
	inventory_image = minetest.inventorycube("dwarves_glass_lamp.png"),
	paramtype = "light",
	light_source = LIGHT_MAX,
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("dwarves:stone_with_obsidian", {
	description = "Obsidian Ore",
	tiles = {"default_stone.png^dwarves_mineral_obsidian.png"},
	is_ground_content = true,
	groups = {cracky=3},
	drop = {
		max_items = 4,
		items = {
			{
				items = {'dwarves:obsidian_lump'},
			},
			{

				items = {'dwarves:obsidian_lump'},
			},
						{

				items = {'dwarves:obsidian_lump'},
			},
			{

				items = {'dwarves:obsidian_lump'},
			},
			{
				items = {'dwarves:obsidian_shard'},
				rarity = 15
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("dwarves:diamond_ore", {
	description = "Diamond Ore",
	tiles = {"dwarves_mineral_diamond.png"},
	is_ground_content = true,
	groups = {cracky=1, level=5},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'dwarves:diamond'},
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("dwarves:mithril_ore", {
	description = "Mithril Ore",
	tiles = {"default_stone.png^dwarves_mineral_mithril.png"},
	is_ground_content = true,
	groups = {cracky=1, level=5},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'dwarves:mithril_lump'},
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("dwarves:ebony_ore", {
	description = "Ebony Ore",
	tiles = {"default_stone.png^dwarves_mineral_ebony.png"},
	is_ground_content = true,
	groups = {cracky=2, level=3},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'dwarves:ebony_lump'},
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("dwarves:sapphire_ore", {
	description = "Sapphire Ore",
	tiles = {"dwarves_mineral_sapphire.png"},
	is_ground_content = true,
	groups = {cracky=1, level=5},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'dwarves:sapphire'},
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("dwarves:ruby_ore", {
	description = "Ruby Ore",
	tiles = {"dwarves_mineral_ruby.png"},
	is_ground_content = true,
	groups = {cracky=2, level=4},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'dwarves:ruby'},
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("dwarves:emerald_ore", {
	description = "Emerald Ore",
	tiles = {"dwarves_mineral_emerald.png"},
	is_ground_content = true,
	groups = {cracky=2, level=4},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'dwarves:emerald'},
			},
		}
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("dwarves:obsidian", {
	description = "Obsidian",
	tiles = {"dwarves_obsidian.png"},
	is_ground_content = true,
	drop = {
		max_items = 2,
		items = {
			{
				items = {'dwarves:obsidian_shard 4'},
			},
			{
				items = {'dwarves:obsidian_shard 2'},
				rarity = 15
			},
			{
				items = {'dwarves:obsidian_shard 4'},
				rarity = 15
			},
			{
				items = {'dwarves:obsidian_shard 3'},
				rarity = 15
			},
		}
	},
	groups = {snappy=1,bendy=2,cracky=1,melty=2,level=4},
	sounds = default.node_sound_stone_defaults(),
})


minetest.register_node("dwarves:castiron", {
	description = "Cast Iron",
	tiles = {"dwarves_castiron.png"},
	is_ground_content = true,
	groups = {cracky=1,level=4},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("dwarves:obsidian_shard", {
	description = "Obsidian Shard",
	inventory_image = "dwarves_obsshard.png",
})

minetest.register_craftitem("dwarves:charcoal", {
	description = "Charcoal",
	inventory_image = "default_coal_lump.png",
})

minetest.register_node("dwarves:mossytree", {
	description = "Mossy Tree",
	tiles = {"default_tree_top.png", "default_tree_top.png", "dwarves_mossytree.png"},
	is_ground_content = true,
	groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("dwarves:mossywood", {
	description = "Mossy Wooden Planks",
	tiles = {"dwarves_mossywood.png"},
	is_ground_content = true,
	groups = {schoppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("dwarves:rotten_wood", {
	description = "Rotten Wooden Planks",
	tiles = {"dwarves_rotten_wood.png"},
	is_ground_content = true,
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
})


minetest.register_craftitem("dwarves:obsidian_lump", {
	description = "Obsidian Chunk",
	inventory_image = "dwarves_obsidian_lump.png",
})

minetest.register_craftitem("dwarves:pobe", {
	description = "Pobe",
	inventory_image = "dwarves_pobedit.png",
})

minetest.register_craftitem("dwarves:diamond", {
	description = "Diamond",
	inventory_image = "dwarves_diamond.png",
})

minetest.register_craftitem("dwarves:emerald", {
	description = "Emerald",
inventory_image = "dwarves_emerald.png",
})

minetest.register_craftitem("dwarves:ruby", {
	description = "Ruby",
	inventory_image = "dwarves_ruby.png",
})

minetest.register_craftitem("dwarves:sapphire", {
	description = "Sapphire",
	inventory_image = "dwarves_sapphire.png",
})

minetest.register_craftitem("dwarves:brass", {
	description = "Brass",
	inventory_image = "dwarves_brass.png",
})

minetest.register_craftitem("dwarves:ebony_lump", {
	description = "Ebony Lump",
	inventory_image = "dwarves_ebony_lump.png",
})

minetest.register_craftitem("dwarves:ebony_ingot", {
	description = "Ebony Ingot",
	inventory_image = "dwarves_ebony_ingot.png",
})

minetest.register_craftitem("dwarves:brass_coin", {
	description = "Brass Coin",
	inventory_image = "dwarves_brass_coins.png",
})

minetest.register_craftitem("dwarves:bronze_coin", {
	description = "Bronze Coin",
	inventory_image = "dwarves_bronze_coins.png",
})

minetest.register_craftitem("dwarves:copper_coin", {
	description = "Copper Coin",
	inventory_image = "dwarves_copper_coins.png",
})

minetest.register_craftitem("dwarves:gold_chumps", {
	description = "Golden Chunk",
	inventory_image = "dwarves_golden_chunk.png",
})

minetest.register_craftitem("dwarves:silver_chumps", {
	description = "Silver Chunk",
	inventory_image = "dwarves_silver_chunk.png",
})

minetest.register_craftitem("dwarves:mithril_lump", {
	description = "Mithril Lump",
	inventory_image = "dwarves_mithril_lump.png",
})

minetest.register_craftitem("dwarves:mithril_ingot", {
	description = "Mithril Ingot",
	inventory_image = "dwarves_mithril_ingot.png",
})

minetest.register_craftitem("dwarves:adamantium", {
	description = "Adamantium",
	inventory_image = "dwarves_adamantium.png",
})

minetest.register_craftitem("dwarves:flint", {
	description = "Flint",
	inventory_image = "dwarves_flint.png",
})

minetest.register_craftitem("dwarves:adamantium_conc", {
	description = "Adamantium Concetration",
	inventory_image = "dwarves_adamantium_conc.png",
})

minetest.register_craftitem("dwarves:water_boiled", {
	description = "Boiled Water",
	inventory_image = "dwarves_water_boiled.png",
})

minetest.register_craftitem("dwarves:magic_essence", {
	description = "King's Diamond",
	inventory_image = "dwarves_magic_essence.png",
})

minetest.register_craftitem("dwarves:moss", {
	description = "Moss",
	inventory_image = "dwarves_moss.png",
})