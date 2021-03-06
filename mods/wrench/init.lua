--[""] = {name="", lists={}, metas={}},
local supported_nodes = {
["default:chest"] = {name="wrench:default_chest", lists={"main"}, metas={}},
["default:chest_locked"] = {name="wrench:default_chest_locked", lists={"main"}, metas={{string="owner"},{string="infotext"}}},
["default:furnace"] = {name="wrench:default_furnace", lists={"fuel", "src", "dst"}, metas={{string="infotext"},{float="fuel_totaltime"},{float="fuel_time"},{float="src_totaltime"},{float="src_time"}}},
["default:furnace_active"] = {name="wrench:default_furnace", lists={"fuel", "src", "dst"}, metas={{string="infotext"},{float="fuel_totaltime"},{float="fuel_time"},{float="src_totaltime"},{float="src_time"}}},
["default:sign_wall"] = {name="wrench:default_sing_wall", lists={}, metas={{string="infotext"},{string="text"}}},
["technic:iron_chest"] = {name="wrench:technic_iron_chest", lists={"main"}, metas={}},
["technic:iron_locked_chest"] = {name="wrench:technic_iron_locked_chest", lists={"main"}, metas={{string="infotext"},{string="owner"}}},
["technic:copper_chest"] = {name="wrench:technic_copper_chest", lists={"main"}, metas={}},
["technic:copper_locked_chest"] = {name="wrench:technic_copper_locked_chest", lists={"main"}, metas={{string="infotext"},{string="owner"}}},
["technic:silver_chest"] = {name="wrench:technic_silver_chest", lists={"main"}, metas={{string="infotext"},{string="formspec"}}},
["technic:silver_locked_chest"] = {name="wrench:technic_silver_locked_chest", lists={"main"}, metas={{string="infotext"},{string="owner"},{string="formspec"}}},
["technic:gold_chest"] = {name="wrench:technic_gold_chest", lists={"main"}, metas={{string="infotext"},{string="formspec"}}},
["technic:gold_locked_chest"] = {name="wrench:technic_gold_locked_chest", lists={"main"}, metas={{string="infotext"},{string="owner"},{string="formspec"}}},
["technic:mithril_chest"] = {name="wrench:technic_mithril_chest", lists={"main"}, metas={{string="infotext"},{string="formspec"}}},
["technic:mithril_locked_chest"] = {name="wrench:technic_mithril_locked_chest", lists={"main"}, metas={{string="infotext"},{string="owner"},{string="formspec"}}},
["technic:battery_box"] = {name="wrench:technic_battery_box", lists={"src", "dst"}, metas={{string="infotext"},{string="formspec"},{int="LV_EU_demand"},{int="LV_EU_supply"},{int="LV_EU_input"},{int="internal_EU_charge"},{float="last_side_shown"}}},
["technic:mv_battery_box"] = {name="wrench:technic_mv_battery_box", lists={"src", "dst"}, metas={{string="infotext"},{string="formspec"},{int="MV_EU_demand"},{int="MV_EU_supply"},{int="MV_EU_input"},{int="internal_EU_charge"},{float="last_side_shown"}}},
["technic:hv_battery_box"] = {name="wrench:technic_hv_battery_box", lists={"src", "dst"}, metas={{string="infotext"},{string="formspec"},{int="HV_EU_demand"},{int="HV_EU_supply"},{int="HV_EU_input"},{int="internal_EU_charge"},{float="last_side_shown"}}},
["technic:electric_furnace"] = {name="wrench:technic_electric_furnace", lists={"src", "dst"}, metas={{string="infotext"},{string="formspec"},{int="state"},{int="LV_EU_demand"},{int="LV_EU_input"},{int="src_time"}}},
["technic:electric_furnace_active"] = {name="wrench:technic_electric_furnace_active", lists={"src", "dst"}, metas={{string="infotext"},{string="formspec"},{int="state"},{int="LV_EU_demand"},{int="LV_EU_input"},{int="src_time"}}},
["technic:mv_electric_furnace"] = {name="wrench:technic_mv_electric_furnace", lists={"src", "dst", "upgrade1", "upgrade2"}, metas={{string="infotext"},{string="formspec"},{int="state"},{int="MV_EU_demand"},{int="MV_EU_input"},{int="tube_time"},{int="src_time"}}},
["technic:mv_electric_furnace_active"] = {name="wrench:technic_mv_electric_furnace_active", lists={"src", "dst", "upgrade1", "upgrade2"}, metas={{string="infotext"},{string="formspec"},{int="state"},{int="MV_EU_demand"},{int="MV_EU_input"},{int="tube_time"},{int="src_time"}}},
["technic:coal_alloy_furnace"] = {name="wrench:technic_coal_alloy_furnace", lists={"fuel", "src", "src2", "dst"}, metas={{string="infotext"},{float="fuel_totaltime"},{float="fuel_time"},{float="src_totaltime"},{float="src_time"}}},
["technic:coal_alloy_furnace_active"] = {name="wrench:technic_coal_alloy_furnace_active", lists={"fuel", "src", "src2", "dst"}, metas={{string="infotext"},{float="fuel_totaltime"},{float="fuel_time"},{float="src_totaltime"},{float="src_time"}}},
["technic:alloy_furnace"] = {name="wrench:technic_alloy_furnace", lists={"src", "src2", "dst"}, metas={{string="infotext"},{string="formspec"},{int="state"},{int="LV_EU_demand"},{int="LV_EU_input"},{int="tube_time"},{int="src_time"}}},
["technic:alloy_furnace_active"] = {name="wrench:technic_alloy_furnace_active", lists={"src", "src2", "dst"}, metas={{string="infotext"},{string="formspec"},{int="state"},{int="LV_EU_demand"},{int="LV_EU_input"},{int="tube_time"},{int="src_time"}}},
["technic:mv_alloy_furnace"] = {name="wrench:technic_mv_alloy_furnace", lists={"src", "src2", "dst", "upgrade1", "upgrade2"}, metas={{string="infotext"},{string="formspec"},{int="state"},{int="MV_EU_demand"},{int="MV_EU_input"},{int="tube_time"},{int="src_time"}}},
["technic:mv_alloy_furnace_active"] = {name="wrench:technic_mv_alloy_furnace_active", lists={"src", "src2", "dst", "upgrade1", "upgrade2"}, metas={{string="infotext"},{string="formspec"},{int="state"},{int="MV_EU_demand"},{int="MV_EU_input"},{int="tube_time"},{int="src_time"}}},
["technic:tool_workshop"] = {name="wrench:technic_tool_workshop", lists={"src"}, metas={{string="infotext"},{string="formspec"},{int="state"},{int="LV_EU_demand"},{int="LV_EU_input"}}},
["technic:grinder"] = {name="wrench:technic_grinder", lists={"src", "dst"}, metas={{string="infotext"},{string="formspec"},{int="state"},{int="LV_EU_demand"},{int="LV_EU_input"},{int="src_time"}}},
["technic:grinder_active"] = {name="wrench:technic_grinder_active", lists={"src", "dst"}, metas={{string="infotext"},{string="formspec"},{int="state"},{int="LV_EU_demand"},{int="LV_EU_input"},{int="src_time"}}},
["technic:mv_grinder"] = {name="wrench:technic_mv_grinder", lists={"src", "dst", "upgrade1", "upgrade2"}, metas={{string="infotext"},{string="formspec"},{int="state"},{int="MV_EU_demand"},{int="MV_EU_input"},{int="tube_time"},{int="src_time"}}},
["technic:mv_grinder_active"] = {name="wrench:technic_mv_grinder_active", lists={"src", "dst", "upgrade1", "upgrade2"}, metas={{string="infotext"},{string="formspec"},{int="state"},{int="MV_EU_demand"},{int="MV_EU_input"},{int="tube_time"},{int="src_time"}}},
["technic:extractor"] = {name="wrench:technic_extractor", lists={"src", "dst"}, metas={{string="infotext"},{string="formspec"},{int="state"},{int="LV_EU_demand"},{int="LV_EU_input"},{int="src_time"}}},
["technic:extractor_active"] = {name="wrench:technic_extractor_active", lists={"src", "dst"}, metas={{string="infotext"},{string="formspec"},{int="state"},{int="LV_EU_demand"},{int="LV_EU_input"},{int="src_time"}}},
["technic:compressor"] = {name="wrench:technic_compressor", lists={"src", "dst"}, metas={{string="infotext"},{string="formspec"},{int="state"},{int="LV_EU_demand"},{int="LV_EU_input"},{int="src_time"}}},
["technic:compressor_active"] = {name="wrench:technic_compressor_active", lists={"src", "dst"}, metas={{string="infotext"},{string="formspec"},{int="state"},{int="LV_EU_demand"},{int="LV_EU_input"},{int="src_time"}}},
["technic:cnc"] = {name="wrench:technic_cnc", lists={"src", "dst"}, metas={{string="infotext"},{string="formspec"},{int="state"},{int="LV_EU_demand"},{int="LV_EU_input"},{int="src_time"},{string="cnc_product"}}},
["technic:cnc_active"] = {name="wrench:technic_cnc_active", lists={"src", "dst"}, metas={{string="infotext"},{string="formspec"},{int="state"},{int="LV_EU_demand"},{int="LV_EU_input"},{int="src_time"},{string="cnc_product"}}},
}
local chest_mark_colors = {
    {'_black','Black'},
    {'_blue','Blue'}, 
    {'_brown','Brown'},
    {'_cyan','Cyan'},
    {'_dark_green','Dark Green'},
    {'_dark_grey','Dark Grey'},
    {'_green','Green'},
    {'_grey','Grey'},
    {'_magenta','Magenta'},
    {'_orange','Orange'},
    {'_pink','Pink'},
    {'_red','Red'},
    {'_violet','Violet'},
    {'_white','White'},
    {'_yellow','Yellow'},
    {'','None'}
}
for i=1,15,1 do
	supported_nodes["technic:gold_chest"..chest_mark_colors[i][1]] = {name="wrench:technic_gold_chest"..chest_mark_colors[i][1], lists={"main"}, metas={{string="infotext"},{string="formspec"}}}
	supported_nodes["technic:gold_locked_chest"..chest_mark_colors[i][1]] = {name="wrench:technic_gold_locked_chest"..chest_mark_colors[i][1], lists={"main"}, metas={{string="infotext"},{string="owner"},{string="formspec"}}}
end

local function convert_to_original_name(name)
	for key,value in pairs(supported_nodes) do
		if name == value.name then return key end
	end
end

for name,info in pairs(supported_nodes) do
	local olddef = minetest.registered_nodes[name]
	if olddef ~= nil then
		local newdef = {}
		for key,value in pairs(olddef) do
			newdef[key] = value
		end
		newdef.stack_max = 1
		newdef.description = newdef.description.." with items"
		newdef.groups = {}
		newdef.groups.not_in_creative_inventory = 1
		newdef.on_construct = nil
		newdef.on_destruct = nil
		newdef.after_place_node = function(pos, placer, itemstack)
			local node = minetest.get_node(pos)
			local item = convert_to_original_name(itemstack:get_name())
			minetest.set_node(pos, {name = item, param2 = node.param2})
			minetest.after(0.5, function(pos, placer, itemstack)
				local meta = minetest.get_meta(pos)
				local inv = meta:get_inventory()
				local data = minetest.deserialize(itemstack:get_metadata())
				local lists = data.lists
				for listname,list in pairs(lists) do
					inv:set_list(listname, list)
				end
				local metas = data.metas
				for i=1,#metas,1 do
					local temp = metas[i]
					if temp.string ~= nil then
						meta:set_string(temp.string, temp.value)
					end
					if temp.int ~= nil then
						meta:set_int(temp.int, temp.value)
					end
					if temp.float ~= nil then
						meta:set_float(temp.float, temp.value)
					end
				end
			end, pos, placer, itemstack)
		end
		minetest.register_node(info.name, newdef)
	end
end

minetest.register_tool("wrench:wrench", {
	description = "Wrench",
	inventory_image = "technic_wrench.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {times={[6]=1.2, [7]=0.70}, uses=0},
			snappy = {times={[6]=0.70, [7]=0.40}, uses=0},
			oddly_breakable_by_hand = {times={[1]=10.00,[2]=8.50,[3]=7.00,[4]=4.00,[5]=2.70, [6]=2.0, [7]=1.40}, uses=0}
		},
		damage_groups = {fleshy=1},
	},
	on_place = function(itemstack, placer, pointed_thing)
		if not placer:is_player() then return end
		local pos = pointed_thing.under
		if pos == nil then return end
		local name = minetest.get_node(pos).name
		local support = supported_nodes[name]
		if support == nil then return end
		local meta = minetest.get_meta(pos)
		if name:find("_locked") ~= nil then
			if meta:get_string("owner") ~= nil then
				if meta:get_string("owner") ~= placer:get_player_name() then
					minetest.log("action", placer:get_player_name()..
					" tried to destroy a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
					return
				end
			end
		end
		
		local lists = support.lists
		local inv = meta:get_inventory()
		local empty = true
		local metadata_str = {}
		local list_str = {}
		for i=1,#lists,1 do
			if not inv:is_empty(lists[i]) then empty = false end
			local list = inv:get_list(lists[i])
			for j=1,#list,1 do
				list[j] = list[j]:to_string()
			end
			list_str[lists[i]] = list
		end
		metadata_str.lists = list_str
		
		local metas = support.metas
		local meta_str = {}
		for i=1,#metas,1 do
			local temp = metas[i]
			if temp.string ~= nil then
				meta_str[i] = {string = temp.string, value = meta:get_string(temp.string)}
			end
			if temp.int ~= nil then
				meta_str[i] = {int = temp.int, value = meta:get_int(temp.int)}
			end
			if temp.float ~= nil then
				meta_str[i] = {float = temp.float, value = meta:get_float(temp.float)}
			end
		end
		metadata_str.metas = meta_str
		
		inv = placer:get_inventory()
		local stack = {name = name}
		if inv:room_for_item("main", stack) then
			minetest.remove_node(pos)
			itemstack:add_wear(65535/20)
			if empty and #lists > 0 then
				inv:add_item("main", stack)
			else
				stack.name = supported_nodes[name].name
				stack.metadata = minetest.serialize(metadata_str)
				inv:add_item("main", stack)
			end
		end
		return itemstack
	end,
})

minetest.register_craft({
	output = "wrench:wrench",
	recipe = {
	{"default:iron_ingot","","default:iron_ingot"},
	{"","default:iron_ingot",""},
	{"","default:iron_ingot",""},
	},
})