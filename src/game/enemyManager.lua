local EnemyManager = {}  -- This is a Module

local enemyList = {}

function EnemyManager.init() 
    enemyList = {}
end

function EnemyManager.load()
    enemy = require "src/game/enemy"
end

function EnemyManager.draw()
    -- set font shared between all enemies
    local font = love.graphics.newFont(14)
    love.graphics.setFont(font)

    -- draw all the enemies
    for key, enemy in pairs(enemyList) do
        enemy:draw(font:getHeight())
    end
end

function EnemyManager.update(dt)
    -- update all the enemies
    for key, enemy in pairs(enemyList) do
        enemy:update(dt)
    end
end

function EnemyManager.spawnCaster(x, y)
    table.insert(enemyList, enemy:new(x, y, "caster"))
end

-- frees the list of tiles.
function EnemyManager.unloadEnemies()
    for key, val in pairs(enemyList) do
        enemyList[key] = nil
    end
end

return EnemyManager