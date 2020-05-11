local Scene = {}  -- This is a Module

function Scene.load()
    camera = require "src/game/camera"

    tileManager = require "src/game/tileManager"
    tileManager.load()

    player = require "src/game/player"

    enemyManager = require "src/game/enemyManager"
    enemyManager.load()

end

function Scene.init()
    isMenu = false

    love.graphics.setBackgroundColor(0, 0, 0, 255)

    camera.init()

    world = love.physics.newWorld(0, 0, true)

    -- generate a map here and manage the player and enemies and stuff
    tileManager.init()
    tileManager.generateDungeon()

    -- setup objects in the world
    player = player:new(0, 0)
    enemyManager.spawnCaster(-1, 3)
end

-- The order of all the drawing functions.
function Scene.draw()
    tileManager.draw()
    
    player:draw()
    enemyManager.draw()

    --player.drawInventory()
    --ui.draw()
end

function Scene.update(dt)
    world:update(dt)  -- update physics

    player:update(dt)
    enemyManager.update(dt)
end

local function cleanScene()
    enemyManager.unloadEnemies()
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