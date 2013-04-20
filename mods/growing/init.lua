GROUND_LIST_PAP={
    'default:dirt',
    'default:dirt_with_grass',
    'default:sand',
    'default:desert_sand',
}
GROUND_LIST_CAC={
    'default:desert_sand',
    'default:sand',
}

minetest.register_abm({
    nodenames = {"default:papyrus"},
    interval = 50,
    chance = 20,
    action = function(pos, node)
        pos.y = pos.y-1
        local name = minetest.env:get_node(pos).name
        if name == "default:dirt" or name == "default:dirt_with_grass" or name == "default:sand" or name == "default:desert_sand" then
            if minetest.env:find_node_near(pos, 3, {"default:water_source", "default:water_flowing"}) == nil then
                return
            end
            pos.y = pos.y+1
            local height = 0
            while minetest.env:get_node(pos).name == "default:papyrus" do
                height = height+1
                pos.y = pos.y+1
            end
            if height < 4 then
                if minetest.env:get_node(pos).name == "air" then
                    minetest.env:set_node(pos, node)
                end
            end
        end
    end
})
minetest.register_abm({
    nodenames = {"default:cacti"},
    interval = 50,
    chance = 20,
    action = function(pos, node)
        pos.y = pos.y-1
        local name = minetest.env:get_node(pos).name
        if name == "default:desert_sand" or name == "default:sand" then
            if minetest.env:find_node_near(pos, 3, {"default:water_source", "default:water_flowing"}) == nil then
                return
            end
            pos.y = pos.y+1
            local height = 0
            while minetest.env:get_node(pos).name == "default:papyrus" do
                height = height+1
                pos.y = pos.y+1
            end
            if height < 4 then
                if minetest.env:get_node(pos).name == "air" then
                    minetest.env:set_node(pos, node)
                end
            end
        end
    end
})

local table_containts = function(t, v)
    for _, i in ipairs(t) do
        if i==v then
            return true
        end
    end
    return false
end

minetest.register_abm({
    nodenames = {'default:papyrus'},
    interval = 0.5,
    chance = 1.0,
    action = function(pos, node, active_object_count, active_object_count_wider)
        if table_containts(GROUND_LIST_PAP, minetest.env:get_node({x = pos.x, y = pos.y-1, z = pos.z}).name) then return end
        for i = -1, 1 do
            for k = -1, 1 do
                if minetest.env:get_node({x = pos.x+i, y = pos.y-1, z = pos.z+k}).name == 'default:papyrus' then return end
            end
        end
        minetest.env:add_item(pos, "default:papyrus")
        minetest.env:add_node(pos, {name="air"})
    end,
})

minetest.register_abm({
    nodenames = {'default:papyrus'},
    interval = 0.5,
    chance = 1.0,
    action = function(pos, node, active_object_count, active_object_count_wider)
        if table_containts(GROUND_LIST_PAP, minetest.env:get_node({x = pos.x, y = pos.y-1, z = pos.z}).name) then return end
        for i = -1, 1 do
            for k = -1, 1 do
                if minetest.env:get_node({x = pos.x+i, y = pos.y-1, z = pos.z+k}).name == 'default:papyrus' then return end
            end
        end
        minetest.env:add_item(pos, "default:papyrus")
        minetest.env:add_node(pos, {name="air"})
    end,
})