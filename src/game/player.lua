local Player = {}  -- This is a Module

local playerColor = {0.9, 0.25, 0.45, 1}
local size = 0.57 
local speed = 10

local xPos
local yPos
local rotation
local playerVerticies = {0, 0.57, 0.5, -0.27, -0.5, -0.27}

function Player.init()
    xPos = 0
    yPos = 0
    rotation = 0
end

function Player.draw()
    
    playerVerticies = { xPos + size * math.sin(rotation), yPos + size * math.cos(rotation), 
                        xPos + size * math.sin(rotation + 2/3 * math.pi), yPos + size * math.cos(rotation + 2/3 * math.pi), 
                        xPos + size * math.sin(rotation + 4/3 * math.pi), yPos + size * math.cos(rotation + 4/3 * math.pi) }
    --playerVerticies = {0, 0.57, 0.5, -0.27, -0.5, -0.27}
    camera.worldToScreen_Verticies(playerVerticies)  -- updates playerVerticies

    love.graphics.setColor(playerColor)
    love.graphics.polygon("fill", playerVerticies)
end

local function movePlayer(x, y)
    xPos = xPos + x
    yPos = yPos + y

    camera.move(x, y)  -- camera is locked onto the player
end

function Player.update(dt)
    local xmov, ymov = 0, 0

    if love.keyboard.isDown("w", "up") then
        ymov = ymov + speed
    end
    
    if love.keyboard.isDown("s", "down") then
        ymov = ymov - speed
    end

    if love.keyboard.isDown("a", "left") then
        xmov = xmov - speed
    end
    
    if love.keyboard.isDown("d", "right") then
        xmov = xmov + speed
    end

    movePlayer(xmov * dt, ymov * dt)
    
end

function Player.keypressed(key)
    if key == "shift" then
        -- open inventory
    end
end

return Player