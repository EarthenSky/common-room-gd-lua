Tile = {}

-- This is more of a struct
function Tile:new(x, y, text)
    tile = {}
    tile.xPos = x
    tile.yPos = y
    tile.baseColour = {0.2, 0.2, 0.2, 1}  -- dark grey
    tile.textColour = {1, 1, 1, 1}        -- white
    tile.text = text

    return tile
end

return Tile