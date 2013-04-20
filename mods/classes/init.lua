classes = {
	mesh = {
		elf = "elf_character.x",
		human = "character.x",
		dwarf = "dwarf_character.x",
	},
	class = {},
	default = "human",
	file = minetest.get_worldpath().."/classes.mt",
}

classes.load = function(self)
	local input = io.open(self.file, "r")
	local data = nil
	if input then
		data = input:read('*all')
	end
	if data and data ~= "" then
		lines = string.split(data, "\n")
		for _, line in ipairs(lines) do
			data = string.split(line, " ", 2)
			self.class[data[1]] = data[2]
		end
		io.close(input)
	end
end

classes.save = function(self)
	local output = io.open(self.file,'w')
	for name, class in pairs(self.class) do
		if name and class then
			output:write(name.." "..class.."\n")
		end
	end
	io.close(output)
end

classes.get_character_mesh = function(self, name)
	local mesh = ""
	local mod_path = minetest.get_modpath("3d_armor")	
	if mod_path then
		mesh = "3d_armor_"
	end
	if classes.class[name] then
		return mesh..classes.mesh[classes.class[name]]
	end
	return mesh..classes.mesh[classes.default]
end

classes.update_character_mesh = function(self, player)
	if not player then
		return
	end
	local name = player:get_player_name()
	if classes.class[name] then
		player:set_properties({
			visual = "mesh",
			mesh = self:get_character_mesh(name),
			visual_size = {x=1, y=1},
		})
	end
end

local default_class = minetest.setting_get("classes_default_class")
if default_class then
	if classes.mesh[default_class] then
		classes.default = default_class
	end
else
	minetest.setting_set("classes_default_class", classes.default)
end
classes:load()

minetest.register_privilege("class", "Player can change class.")

minetest.register_chatcommand("class", {
	params = "[class]",
	description = "Change or view character class.",
	func = function(name, param)
		if param == "" then
			minetest.chat_send_player(name, "Current character class: "..classes.class[name])
			return
		end
		if not minetest.check_player_privs(name, {class=true}) then
			minetest.chat_send_player(name, "Changing class requires the 'class' privilege!")
			return
		end
		if not classes.mesh[param] then
			local valid = ""
			for k,_ in pairs(classes.mesh) do
				valid = valid.." "..k
			end
			minetest.chat_send_player(name, "Invalid class '"..param.."', choose from:"..valid)
			return 
		end
		if classes.class[name] == param then
			return
		end
		classes.class[name] = param
		classes:save()
		local player = minetest.env:get_player_by_name(name)
		classes:update_character_mesh(player)
	end,
})

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	if not classes.class[name] then
		classes.class[name] = classes.default
	end
	minetest.after(0.5, function(player)
		classes:update_character_mesh(player)
	end, player)
end)

