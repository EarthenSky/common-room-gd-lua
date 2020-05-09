local Scene = {}  -- This is a Module

--[[
-- this holds a bunch of colliders for the scene to check for collision with, when a collider is registered a 
-- callback function must be provided. Whenn two dynamic colliders hit eachother, the collide function is called for 
-- both sides. If a staic (wall) collider and a dynamic collider collides then only the callback function of the dynamic 
-- collider is called unless the wall is a special collider.
local staticColliders = {}  
local dynamicColliders = {}  
]]

function Scene.load()
    camera = require "src/game/camera"

    tileManager = require "src/game/tileManager"
    tileManager.load()

    player = require "src/game/player"

end

function Scene.init()
    isMenu = false

    world = love.physics.newWorld(0, 0, true)

    camera.init()

    -- generate a map here and manage the player and enemies and stuff
    tileManager.init()
    tileManager.generateDungeon()

    player = player:new()

    love.graphics.setBackgroundColor(0, 0, 0, 255)
end

-- The order of all the drawing functions.
function Scene.draw()
    tileManager.draw()
    
    player:draw()
    
    --enemies.draw()

    --player.drawInventory()
    --ui.draw()
end

function Scene.update(dt)
    player:update(dt)

    world:update(dt)  -- update physics
end

--[[
function Scene.registerCollider(collider, static, callbackFunction)
    entry = { collider=collider, func=callbackFunction }

    if static then
        table.append(staticColliders, entry)
    else
        table.append(dynamicColliders, entry)
    end
    
end


function doCollision()
    -- do collision between all static and dynamic nodes
    for key, valStatic in pairs(staticColliders) do
        for key2, valDynamic in pairs(dynamicColliders) do
            
        end
    end

    local lastEntry = nil
    for key, val in pairs(dynamicColliders) do
        if lastEntry == nil then
            lastEntry = val
        else  -- collide last entry with current entry
            
        end
    end

end
]]

local function cleanScene()
    tileManager.destroyMap()
end

function Scene.keypressed(key)
    if key == "escape" then
        cleanScene()
        menu.init()
    else
        player:keypressed(key)
    end
end


return Scene