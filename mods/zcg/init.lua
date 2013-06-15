-- ZCG mod for minetest
-- See README for more information
-- Released by Zeg9 under WTFPL

zcg = {}

zcg.users = {}
zcg.crafts = {}
zcg.itemlist = {}

zcg.items_in_group = function(group)
	local items = {}
	for name, item in pairs(minetest.registered_items) do
		for _, g in ipairs(group:split(',')) do
			if item.groups[g] then
				table.insert(items,name)
			end
		end
	end
	return items
end

local table_copy = function(table)
	out = {}
	for k,v in pairs(table) do
		out[k] = v
	end
	return out
end

zcg.add_craft = function(input, output, groups)
	if not groups then groups = {} end
	local c = {}
	c.width = input.width
	c.type = input.type
	c.items = input.items
	if c.items == nil then return end
	for i, item in pairs(c.items) do
		if item:sub(0,6) == "group:" then
			local groupname = item:sub(7)
			if groups[groupname] ~= nil then
				c.items[i] = groups[groupname]
			else
				for _, gi in ipairs(zcg.items_in_group(groupname)) do
					local g2 = groups
					g2[groupname] = gi
					zcg.add_craft({
						width = c.width,
						type = c.type,
						items = table_copy(c.items)
					}, output, g2) -- it is needed to copy the table, else groups won't work right
				end
				return
			end
		end
	end
	if c.width == 0 then c.width = 3 end
	table.insert(zcg.crafts[output],c)
end

zcg.load_crafts = function(name)
	zcg.crafts[name] = {}
	local _recipes = minetest.get_all_craft_recipes(name)
	if _recipes then
		for i, recipe in ipairs(_recipes) do
			if (recipe and recipe.items and recipe.type) then
				zcg.add_craft(recipe, name)
			end
		end
	end
	if zcg.crafts[name] == nil or #zcg.crafts[name] == 0 then
		zcg.crafts[name] = nil
	else
		table.insert(zcg.itemlist,name)
	end
end

zcg.need_load_all = true

zcg.load_all = function()
	print("Loading all crafts, this may take some time...")
	local i = 0
	for name, item in pairs(minetest.registered_items) do
		if (name and name ~= "") then
			zcg.load_crafts(name)
		end
		i = i+1
	end
	table.sort(zcg.itemlist)
	zcg.need_load_all = false
	print("All crafts loaded !")
end

zcg.formspec = function(pn)
	if zcg.need_load_all then zcg.load_all() end
	page = zcg.users[pn].page
	alt = zcg.users[pn].alt
	current_item = zcg.users[pn].current_item
	local formspec = "size[8,7.5]"
	.. "button[0,0;2,.5;main;Back]"
	-- Show craft recipe
	if current_item ~= "" then
		if zcg.crafts[current_item] then
			if alt > #zcg.crafts[current_item] then
				alt = #zcg.crafts[current_item]
			end
			if alt > 1 then
				formspec = formspec .. "button[7,0;1,1;zcg_alt:"..(alt-1)..";^]"
			end
			if alt < #zcg.crafts[current_item] then
				formspec = formspec .. "button[7,2;1,1;zcg_alt:"..(alt+1)..";v]"
			end
			local c = zcg.crafts[current_item][alt]
			if c then
				for i, item in pairs(c.items) do
					formspec = formspec .. "item_image_button["..((i-1)%c.width+3)..","..(math.floor((i-1)/c.width))..";1,1;"..item..";zcg:"..item..";]"
				end
				formspec = formspec .. "label[0,2;Method: "..c.type.."]"
				formspec = formspec .. "item_image_button[7,1;1,1;"..zcg.users[pn].current_item..";;]"
			end
		end
	end
	
	-- Node list
	local npp = 8*3 -- nodes per page
	local i = 0 -- for positionning buttons
	local s = 0 -- for skipping pages
	for _, name in ipairs(zcg.itemlist) do
		if s < page*npp then s = s+1 else
			if i >= npp then break end
			formspec = formspec .. "item_image_button["..(i%8)..","..(math.floor(i/8)+3.5)..";1,1;"..name..";zcg:"..name..";]"
			i = i+1
		end
	end
	if page > 0 then
		formspec = formspec .. "button[0,7;1,.5;zcg_page:"..(page-1)..";<<]"
	end
	if i >= npp then
		formspec = formspec .. "button[1,7;1,.5;zcg_page:"..(page+1)..";>>]"
	end
	formspec = formspec .. "label[2,6.85;Page "..(page+1).."/"..(math.floor(#zcg.itemlist/npp+1)).."]" -- The Y is approximatively the good one to have it centered vertically...
	return formspec
end

minetest.register_on_joinplayer(function(player)
	inventory_plus.register_button(player,"zcg","Craft guide")
end)

minetest.register_on_player_receive_fields(function(player,formname,fields)
	pn = player:get_player_name();
	if zcg.users[pn] == nil then zcg.users[pn] = {current_item = "", alt = 1, page = 0} end
	if fields.zcg then
		inventory_plus.set_inventory_formspec(player, zcg.formspec(pn))
		return
	end
	for k, v in pairs(fields) do
		if (k:sub(0,4)=="zcg:") then
			zcg.users[pn].current_item = k:sub(5)
			inventory_plus.set_inventory_formspec(player,zcg.formspec(pn))
		elseif (k:sub(0,9)=="zcg_page:") then
			zcg.users[pn].page = tonumber(k:sub(10))
			inventory_plus.set_inventory_formspec(player,zcg.formspec(pn))
		elseif (k:sub(0,8)=="zcg_alt:") then
			zcg.users[pn].alt = tonumber(k:sub(9))
			inventory_plus.set_inventory_formspec(player,zcg.formspec(pn))
		end
	end
end)
