--Double commented code (----) is not a note, but removed code.

-- Constant variables.
ScreenSize = {x=640, y=640}
CurrentScene = 0

function love.load()
    -- Images are loaded here.

    -- Set up the window.
    love.window.setMode(ScreenSize.x, ScreenSize.y, {resizable=false, vsync=true})
    love.window.setTitle("Love2D Template")
    love.graphics.setBackgroundColor(0, 0, 0, 255)

    -- Other Modules are loaded here.
    ----util = require "util"

    -- Any initialization code goes here.
    ----button = util.createButton({x=100, y=200}, {w=400, h=200}, "It is I, button", 0)  -- Pass zero, instead of function.
end

-- Only drawing and maybe come conditional statements go here.
function love.draw()
    if CurrentScene == 0 then

    elseif CurrentScene == 1 then

    end

    -- Print the current scene in the top left corner and set colour + font size
    love.graphics.setFont(love.graphics.newFont(18))
    love.graphics.setColor(250, 250, 250, 255)
    love.graphics.print(CurrentScene, 2, 2)
end

-- No drawing code, Math or physics code here.
function love.update(dt)
    if CurrentScene == 0 then

    elseif CurrentScene == 1 then

    end
end