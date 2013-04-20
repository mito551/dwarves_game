---
--worldtime 1.01
--Copyright (C) 2012 Bad_Command
--
--This library is free software; you can redistribute it and/or
--modify it under the terms of the GNU Lesser General Public
--License as published by the Free Software Foundation; either
--version 2.1 of the License, or (at your option) any later version.
--
--This program is distributed in the hope that it will be useful,
--but WITHOUT ANY WARRANTY; without even the implied warranty of
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--GNU General Public License for more details.
--
--You should have received a copy of the GNU Lesser General Public
--License along with this library; if not, write to the Free Software
--Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
---

--- 
-- To use worldtime, call this method in your mod:
--  worldtime.get()
---

worldtime={}
worldtime.version = 1.01

-- config.lua contains configuration parameters
dofile(minetest.get_modpath("worldtime").."/config.lua")
-- worldtime.lua contains the code
dofile(minetest.get_modpath("worldtime").."/worldtime.lua")

worldtime.intialize()
worldtime.persist()
minetest.register_globalstep(worldtime.timechange)
