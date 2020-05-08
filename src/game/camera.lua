local Camera = {}  -- This is a Module

Camera.UNIT_SIZE = 48  -- the size of 1 single space.

local xPos
local yPos

function Camera.init()
    xPos = 0
    yPos = 0
end

function Camera.move(x, y)
    if x ~= nil then
        xPos = xPos + x
    end

    if y ~= nil then
        yPos = yPos + y
    end
end

function Camera.set(x, y)
    xPos = x
    yPos = y
end

-- todo: implement this
function Camera.panTo(x, y, speed)
    
end

-- returns x and y together
function Camera.worldToScreen(x, y)
    return x * Camera.UNIT_SIZE + SCREEN_SIZE.x / 2 - xPos * Camera.UNIT_SIZE, (-y) * Camera.UNIT_SIZE + SCREEN_SIZE.y / 2 - (-yPos) * Camera.UNIT_SIZE
end

function Camera.worldToScreen_Verticies(verticies)
    for key, val in pairs(verticies) do
        if key % 2 == 1 then -- in lua lists start at 1
            verticies[key] = val * Camera.UNIT_SIZE + SCREEN_SIZE.x / 2 - xPos * Camera.UNIT_SIZE
        else
            verticies[key] = (-val) * Camera.UNIT_SIZE + SCREEN_SIZE.y / 2 - (-yPos) * Camera.UNIT_SIZE
        end
    end
end

return Camera