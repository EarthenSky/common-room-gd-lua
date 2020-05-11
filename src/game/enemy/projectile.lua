Projectile = {}  -- This is a Module

-- TODO: create this class and have the enemy use it to attack
-- TODO: particle effects later for upgrades?

local projectileColour = {0.95, 0.15, 0.8, 1}
local textColour = {1, 1, 1, 1}  -- white

local DEFAULT_PROJECTILE_SIZE = 0.2
local PROJECTILE_DAMAGE = 1

-- Used in spawning projectiles. Gives a little distance between the enemy shooting the projectile and the 
-- actual projectile. Make sure this is not too large.
local bias = 0.005

-- enemyType is a string
function Projectile:new(xCenter, yCenter, offsetRadius, xVel, yVel, speed)
    -- Add member variables here.
    selfObj = {}
    selfObj.rotation = 0
    selfObj.radius = DEFAULT_PROJECTILE_SIZE -- for now
    selfObj.colour = projectileColour
    selfObj.text = "P"

    selfObj.xVel, selfObj.yVel = xVel * speed, yVel * speed
    selfObj.speed = speed
    selfObj.id = nil

    -- to make sure that the projectile does not spawn inside of the 
    local xOffset = (offsetRadius + selfObj.radius + bias) * xVel
    local yOffset = (offsetRadius + selfObj.radius + bias) * yVel

    local mycollider = {}
    mycollider.body = love.physics.newBody(world, xCenter + xOffset, yCenter + yOffset, "dynamic")
    mycollider.body:setMass(10 * selfObj.radius)
    mycollider.shape = love.physics.newCircleShape(selfObj.radius)
    mycollider.fixture = love.physics.newFixture(mycollider.body, mycollider.shape)
    mycollider.fixture:setRestitution(0.9)

    selfObj.collider = mycollider
    selfObj.collider.fixture:setUserData( setmetatable(selfObj, self) )  -- reference to self

    selfObj.collider.body:setLinearVelocity(selfObj.xVel, selfObj.yVel)

    -- Make this into a class.
    self.__index = self
    return setmetatable(selfObj, self)
end

function Projectile:setId(id)
    print( id )
    self.id = id
    print( self.id )
end

function Projectile:draw(fontHeight)
    local xPos, yPos = self.collider.body:getPosition()
    
    xPos, yPos = camera.worldToScreen(xPos, yPos)

    love.graphics.setColor(self.colour)
    love.graphics.circle("fill", xPos, yPos, self.radius * camera.UNIT_SIZE)
 
    love.graphics.setColor(textColour)
    local yOffset = -fontHeight / 2
    love.graphics.printf(self.text, xPos - self.radius * camera.UNIT_SIZE, yPos + yOffset, self.radius * 2 * camera.UNIT_SIZE, "center")
end

-- projectile is boring it just moves
function Projectile:update(dt)
    --self.collider.body:setLinearVelocity(self.xVel, self.yVel)
    print("update " .. self.id)
end

-- a is self collider --probably...
function Projectile:beginContact(a, b, col)
    print(self.id)
    if b:getUserData() ~= nil and b:getUserData().name == "player" then
        print("hit player")
        b:getUserData():takeDamage(PROJECTILE_DAMAGE)
    end
        
    -- kill self
    print(self.id)
    enemyManager.destroyProjectile(self.id)
end

return Projectile