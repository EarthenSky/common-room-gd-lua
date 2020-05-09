Player = {}  -- This is a Module

local playerColor = {0.9, 0.25, 0.45, 1}
local size = 0.57 
local speed = 10

function Player:new()
    -- Add member variables here.
    selfObj = {}
    selfObj.rotation = 0
    selfObj.playerVerticies = {}

    local mycollider = {}
    mycollider.body = love.physics.newBody(world, 0, 0, "dynamic")
    mycollider.body:setMass(10)
    mycollider.shape = love.physics.newCircleShape(size)
    mycollider.fixture = love.physics.newFixture(mycollider.body, mycollider.shape)
    mycollider.fixture:setRestitution(0)
    mycollider.fixture:setUserData("player")

    selfObj.collider = mycollider

    -- Make this into a class.
    self.__index = self
    return setmetatable(selfObj, self)
end

function Player:draw()
    local xPos, yPos = self.collider.body:getPosition()
    
    -- construct verticies with new rotation
    self.playerVerticies = { xPos + size * math.sin(self.rotation), 
                             yPos + size * math.cos(self.rotation), 
                             xPos + size * math.sin(self.rotation + 2/3 * math.pi), 
                             yPos + size * math.cos(self.rotation + 2/3 * math.pi), 
                             xPos + size * math.sin(self.rotation + 4/3 * math.pi), 
                             yPos + size * math.cos(self.rotation + 4/3 * math.pi) }

    camera.worldToScreen_Verticies(self.playerVerticies)  -- updates playerVerticies

    love.graphics.setColor(playerColor)
    love.graphics.polygon("fill", self.playerVerticies)
end

function Player:update(dt)
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

    self.collider.body:setLinearVelocity(xmov, ymov)
    camera.set(self.collider.body:getX(), self.collider.body:getY())  -- camera is locked onto the player

    -- set rotation of player by having them look at the mouse.
    local mousex, mousey = love.mouse.getPosition()
    self.rotation = math.atan2( mousey - (SCREEN_SIZE.y/2), mousex - (SCREEN_SIZE.x/2) ) + math.pi/2

end

function Player:keypressed(key)
    if key == "shift" then
        -- open inventory
    end
end

return Player