local old_nodes = {}
local old_entities = {}

for _,node_name in ipairs(old_nodes) do
	minetest.register_node(":"..node_name, {
		groups = {old=1},
	})
end

for _,entity_name in ipairs(old_entities) do
	minetest.register_entity(":"..entity_name, {
		on_activate = function(self, staticdata)
			self.object:remove()
		end,
	})
end