Enemy = {}  -- This is a Module

local casterColour = {0.25, 0.9, 0.45, 1}
local dasherColour = {0.45, 0.25, 0.9, 1}
local textColour = {1, 1, 1, 1}  -- white
local DEFAULT_SIZE = 0.5 
local SPEED = 10
local PROJECTILE_SPEED = 10

local VIEW_RADIUS = 3
local MAX_VIEW_RADIUS = 6

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
        selfObj.cooldown = 4.0 -- seconds 
    elseif enemyType == "dasher" then
        selfObj.colour = dasherColour
        selfObj.text = "D"
    end

    selfObj.target = nil
    selfObj.abilityTimer = 0

    local mycollider = {}
    mycollider.body = love.physics.newBody(world, x, y, "dynamic")
    mycollider.body:setMass(10 * selfObj.radius)
    mycollider.shape = love.physics.newCircleShape(selfObj.radius)
    mycollider.fixture = love.physics.newFixture(mycollider.body, mycollider.shape)
    mycollider.fixture:setRestitution(0)

    selfObj.collider = mycollider
    selfObj.collider.fixture:setUserData( setmetatable(selfObj, self) )

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

    -- if player is close
    local x1, y1 = player.collider.body:getPosition()
    local x2, y2 = self.collider.body:getPosition()
    if self.target == nil then
        if util.getDistanceBetween(x1, y1, x2, y2) < VIEW_RADIUS then
            self.target = player

            self.abilityTimer = 0
            print("starting timer")
        end
    else
        if util.getDistanceBetween(x1, y1, x2, y2) > MAX_VIEW_RADIUS then
            self.target = nil
            print("oop goodbye")
        end

        self.abilityTimer = self.abilityTimer + dt  -- update timer while there is a target
    end

    -- shoot projectile
    if self.abilityTimer > self.cooldown then
        print("shooty shooty")
        self.abilityTimer = self.abilityTimer - self.cooldown  -- should prolly include the small amount of overlap time

        local rotation = math.atan2(y1 - y2, x1 - x2)
        local length = 1

        local xVel, yVel = util.polarToCartesian(rotation, length)
        local xPos, yPos = self.collider.body:getPosition()

        enemyManager.spawnProjectile( projectile:new(xPos, yPos, self.radius, xVel, yVel, PROJECTILE_SPEED) )  -- pew pew
    end
end

return Enemy