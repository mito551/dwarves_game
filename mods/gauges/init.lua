local hp_bar = {
	physical = false,
    collisionbox = {x=0, y=0, z=0},
	visual = "sprite",
	textures = {"10.png"},
	visual_size = {x=1, y=1/16, z=1},
	wielder = nil,
}

function hp_bar:on_step(dtime)
  local wielder = self.wielder
  if wielder == nil then 
     self.object:remove()
     return   
  elseif minetest.env:get_player_by_name(wielder:get_player_name()) == nil then 
     self.object:remove()
     return 
  end
  hp = wielder:get_hp()
  self.object:set_properties({
        textures = {tostring(hp) .. ".png",},
        }
  )   
end

minetest.register_entity("gauges:hp_bar", hp_bar)

function add_HP_gauge(pl)
    local pos = pl:getpos()
    local ent = minetest.env:add_entity(pos, "gauges:hp_bar")
    if ent~= nil then
       ent:set_attach(pl, "", {x=0,y=9,z=0}, {x=0,y=0,z=0})
       ent = ent:get_luaentity() 
       ent.wielder = pl       
    end
end

minetest.register_on_joinplayer(add_HP_gauge)

