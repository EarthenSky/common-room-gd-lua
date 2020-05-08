Tile = {}

-- This is more of a struct
-- TODO: if there start to be performance issues, inline this function.
function Tile.new(x, y, text, baseColor)
    local tile = {}
    tile.xPos = x
    tile.yPos = y
    tile.text = text

    if baseColor == nil then 
        tile.baseColour = {0.2, 0.2, 0.2, 1}  -- dark grey
    else 
        tile.baseColour = baseColor
    end

    tile.textColour = {1, 1, 1, 1}        -- white

    return tile
end

return Tile