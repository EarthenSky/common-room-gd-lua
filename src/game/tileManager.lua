local TileManager = {}  -- This is a Module

--[[
TODO: make tile chunks so that every tile is not individually being drawn to the screen, but larger groups of tiles are 
      stiched together at scene load time or whenever a tile is created and then drawn to the screen together.

]]


local TILE_SIZE = 1 * camera.UNIT_SIZE
local tileList

function TileManager.init() 
    tileList = {}
end

function TileManager.load()
    tile = require "src/game/tile"
end

function TileManager.generateDungeon()
    local i = 0
    for y = 6, -6, -1 do
        for x = -6, 6, 1 do
            -- modifier which gives a bit of a checkered pattern to the ground
            local mod = 0.02
            if (x + y) % 2 == 0 then
                mod = -mod
            end

            -- gives the room a wall
            if y == 6 or y == -6 or x == 6 or x == -6 then
                table.insert( tileList, tile.new(x, y, "w", {0.2 + mod, 0.2 + mod, 0.2 + mod, 1} ) )
            else 
                table.insert( tileList, tile.new(x, y, "f", {0.5 + mod, 0.5 + mod, 0.5 + mod, 1}) )
            end
            i = i + 1
            
        end
    end
end

function TileManager.draw()
    -- set font shared between all tiles
    local font = love.graphics.newFont(14)
    love.graphics.setFont(font)

    local yOffset = (TILE_SIZE - font:getHeight()) / 2

    -- draw each tile
    for key, tile in pairs(tileList) do
        local x, y = camera.worldToScreen(tile.xPos - 0.5, tile.yPos + 0.5)  -- 0.5 is half of a tile size
        
        love.graphics.setColor(tile.baseColour)
        love.graphics.rectangle("fill", x, y, TILE_SIZE, TILE_SIZE)

        love.graphics.setColor(tile.textColour)
        love.graphics.printf(tile.text, x, y + yOffset, TILE_SIZE, "center")
    end
end

-- frees the list of tiles.
function TileManager.destroyMap()
    for key in pairs(tileList) do
        tileList[key] = nil
    end
end

return TileManager