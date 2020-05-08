--Double commented code (----) is not a note, but removed code.

-- Global variables
SCREEN_SIZE = {x=1280, y=720}
isMenu = true

function love.load()
    -- Images are loaded here.

    -- Set up the window.
    love.window.setMode(SCREEN_SIZE.x, SCREEN_SIZE.y, {resizable=false, vsync=true})
    love.window.setTitle("Love2D Template")

    -- Other Modules are loaded here.
    util = require "util"
    menu = require "src/menu"
    scene = require "src/game/scene"
    scene.load()

    -- Any initialization code goes here.
    menu.init()
end

-- Only drawing and maybe come conditional statements go here.
function love.draw()
    if isMenu then
        menu.draw()
    elseif not isMenu then
        scene.draw()
    end

    -- Print if menu
    love.graphics.setFont(love.graphics.newFont(18))
    love.graphics.setColor(0.99, 0.99, 0.99, 1)
    love.graphics.print(isMenu and "inMenu" or "inGame", 2, 2)  -- stupid lua ternary operator :/
end

-- No drawing code, Math or physics code here.
function love.update(dt)
    if isMenu then

    elseif not isMenu then
        scene.update(dt)
    end
end

-- callback function for key events
function love.keypressed(key, scancode, isrepeat)
    if isMenu then
        menu.keypressed(key)
    elseif not isMenu then
        scene.keypressed(key)
    end
end
 