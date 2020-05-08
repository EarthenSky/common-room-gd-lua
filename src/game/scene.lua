local Scene = {}  -- This is a Module


function Scene.load()
    camera = require "src/game/camera"

    tileManager = require "src/game/tileManager"
    tileManager.load()

    player = require "src/game/player"

end

function Scene.init()
    isMenu = false

    camera.init()

    -- generate a map here and manage the player and enemies and stuff
    tileManager.init()
    tileManager.generateDungeon()

    player.init()

    love.graphics.setBackgroundColor(0, 0, 0, 255)
end

-- The order of all the drawing functions.
function Scene.draw()
    tileManager.draw()
    
    player.draw()
    
    --enemies.draw()

    --player.drawInventory()
    --ui.draw()
end

function Scene.update(dt)
    player.update(dt)
end

function Scene.keypressed(key)
    if key == "escape" then
        tileManager.destroyMap()
        menu.init()
    else
        player.keypressed(key)
    end
end


return Scene