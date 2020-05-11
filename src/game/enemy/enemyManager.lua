local EnemyManager = {}  -- This is a Module

local font = love.graphics.newFont(14)

local enemyList = {}
local projectileList = {}

function EnemyManager.init() 
    enemyList = {}
    projectileList = {}
end

function EnemyManager.load()
    enemy = require "src/game/enemy/enemy"
    projectile = require "src/game/enemy/projectile"
end

function EnemyManager.draw()
    -- set font shared between all enemies
    love.graphics.setFont(font)
    local fontHeight = font:getHeight()

    -- draw all the enemies
    for key, enemy in pairs(enemyList) do
        enemy:draw(fontHeight)
    end

    for key, proj in pairs(projectileList) do
        proj:draw(fontHeight)
    end
end

function EnemyManager.update(dt)
    -- update all the enemies
    for key, enemy in pairs(enemyList) do
        enemy:update(dt)
    end

    for key, proj in pairs(projectileList) do
        proj:update(dt)
    end
end


--////////////////////////////////////////////////////////////////////////////--


function EnemyManager.spawnCaster(x, y)
    table.insert( enemyList, enemy:new(x, y, "caster") )
end 

function EnemyManager.spawnProjectile(projectile)
    print( #projectileList + 1 )
    projectile:setId( #projectileList + 1 )
    table.insert( projectileList, projectile )
    print( projectileList[1].id ) 
end

-- unloads currently loaded assets
function EnemyManager.destroyProjectile(projectileIndex)
    print("dead~!!!!")
    projectileList[projectileIndex].collider.body:destroy()  -- remove projectile from simulation
    table.remove( projectileList, projectileIndex )
end


--////////////////////////////////////////////////////////////////////////////--


-- frees the list of tiles.
local function unloadEnemies()
    for key, val in pairs(enemyList) do
        enemyList[key].collider.body:destroy()  -- remove projectile from simulation
        enemyList[key] = nil
    end
end

-- frees the list of tiles.
local function unloadProjectiles()
    for key, val in pairs(projectileList) do
        projectileList[key].collider.body:destroy()  -- remove projectile from simulation
        projectileList[key] = nil
    end
end

-- unloads currently loaded assets
function EnemyManager.unloadCurrent()
    unloadEnemies()
    unloadProjectiles()
end


return EnemyManager