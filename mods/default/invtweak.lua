local tname = ""
minetest.register_on_punchnode(function(pos, node, puncher)
	if puncher:get_wielded_item():get_wear() ~= 0 then
		tname = puncher:get_wielded_item():get_name()
	else
		tname = ""
	end
end)

minetest.register_on_dignode(function(pos, oldnode, digger)
		local num = digger:get_wielded_item():get_wear()
		local index = digger:get_wield_index()
		if num == 0 and tname ~= "" then
			minetest.sound_play("intweak_tool_break", {gain = 1.5, max_hear_distance = 5})
			if auto_refill == true then minetest.after(0.01, refill, digger, tname, index) end
		end
end)