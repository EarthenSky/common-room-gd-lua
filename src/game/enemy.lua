Enemy = {}  -- This is a Module

local casterColour = {0.25, 0.9, 0.45, 1}
local dasherColour = {0.45, 0.25, 0.9, 1}
local textColour = {1, 1, 1, 1}  -- white
local DEFAULT_SIZE = 0.5 
local SPEED = 10

-- enemyType is a string
function Enemy:new(x, y, enemyType)
    -- Add member variables here.
    selfObj = {}
    selfObj.rotation = 0
    selfObj.radius = DEFAULT_SIZE -- for now
    selfObj.type = enemyType

    -- enemy specific diifferences
    if enemyType == "caster" then
        selfObj.colour = casterColour
        selfObj.text = "C"
        selfObj.castCooldown = 1.5 -- seconds 
    elseif enemyType == "dasher" then
        selfObj.colour = dasherColour
        selfObj.text = "D"
    end

    local mycollider = {}
    mycollider.body = love.physics.newBody(world, x, y, "dynamic")
    mycollider.body:setMass(10 * selfObj.radius)
    mycollider.body:setPosition(x, y)
    mycollider.shape = love.physics.newCircleShape(selfObj.radius)
    mycollider.fixture = love.physics.newFixture(mycollider.body, mycollider.shape)
    mycollider.fixture:setRestitution(0)
    mycollider.fixture:setUserData("enemy " .. enemyType)

    selfObj.collider = mycollider

    -- Make this into a class.
    self.__index = self
    return setmetatable(selfObj, self)
end

function Enemy:draw(fontHeight)
    local xPos, yPos = self.collider.body:getPosition()

    --print(xPos .. " | " .. yPos)
    
    xPos, yPos = camera.worldToScreen(xPos, yPos)

    --print(xPos .. " | " .. yPos)

    love.graphics.setColor(self.colour)
    love.graphics.circle("fill", xPos, yPos, self.radius * camera.UNIT_SIZE)
 
    love.graphics.setColor(textColour)
    local yOffset = -fontHeight / 2
    love.graphics.printf(self.text, xPos - self.radius * camera.UNIT_SIZE, yPos + yOffset, self.radius * 2 * camera.UNIT_SIZE, "center")
end

function Enemy:update(dt)
    self.collider.body:setLinearVelocity(0, 0)
    -- enemy behaviours
end

return Enemy