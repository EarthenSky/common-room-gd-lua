local Scene = {}  -- This is a Module

--[[
TODO: make tile chunks so that every tile is not individually being drawn to the screen, but larger groups of tiles are 
      stiched together at scene load time or whenever a tile is created and then drawn to the screen together.


]]


TILE_SIZE = 32
Scene.tileList = {}

function Scene.load()
    tile = require "src/tile"
end

function Scene.init()
    isMenu = false

    -- todo generate a map here and manage the player and enemies and stuff

    love.graphics.setBackgroundColor(0, 0, 0, 255)

    table.insert(Scene.tileList, tile:new(4, 4, "wall"))
end

function Scene.draw()
    -- set font shared between all tiles
    love.graphics.setFont(love.graphics.newFont(16))

    for key, tile in pairs(Scene.tileList) do
        love.graphics.setColor(tile.baseColour)
        love.graphics.rectangle("fill", tile.xPos*TILE_SIZE, tile.yPos*TILE_SIZE, TILE_SIZE, TILE_SIZE)

        love.graphics.setColor(tile.textColour)
        love.graphics.print(tile.text, tile.xPos*TILE_SIZE, tile.yPos*TILE_SIZE + 4)
    end
end

-- frees the list of tiles.
local function destroyScene()
    Scene.tileList = nil
    Scene.tileList = {}
end

function Scene.keypressed(key)
    if key == "escape" then
        destroyScene()
        menu.init()
    end
end


return Scene