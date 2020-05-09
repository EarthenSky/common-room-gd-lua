local Tile = {}

-- This is more of a struct
-- TODO: if there start to be performance issues, inline this function.
function Tile.new(x, y, text, baseColor, isWall)
    local tile = {}
    tile.xPos = x
    tile.yPos = y
    tile.text = text

    if baseColor == nil then 
        tile.baseColour = {0.2, 0.2, 0.2, 1}  -- dark grey
    else 
        tile.baseColour = baseColor
    end

    tile.textColour = {1, 1, 1, 1}  -- white
    
    if isWall then
        local mycollider = {}
        mycollider.body = love.physics.newBody(world, tile.xPos, tile.yPos, "static")
        mycollider.shape = love.physics.newRectangleShape(1, 1) -- tiles are 1x1 size
        mycollider.fixture = love.physics.newFixture(mycollider.body, mycollider.shape)

        tile.collider = mycollider
    end

    return tile
end

return Tile