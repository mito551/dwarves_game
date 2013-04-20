This mod deletes old blocks and objects from Minetest.
Insert the names of the old nodes in the table "old_nodes" like this:
local old_nodes = {"modname:nodename1", "modname:nodename2"}
The nodes will automatically be removed when a player is close to them.
The same will happen to entities when you insert there names
into the table "old_entities".

License:
Sourcecode: WTFPL