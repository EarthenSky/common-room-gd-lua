local Menu = {}  -- This is a Module


local optionList = {}
optionList[0] = { text = "play game" }
optionList[1] = { text = "settings" }
optionList[2] = { text = "exit" }

local fontcolor = {0.98, 0.98, 0.98, 1}
local backcolor = {79/255, 51/255, 29/255, 1}

local FONT_SIZE = 32
local font = love.graphics.newFont(32)
local ITEM_DISTANCE = 48
local Y_OFFSET = 128

local hoveredOption


-- called when entering the menu
function Menu.init()
    isMenu = true

    hoveredOption = -1

    love.graphics.setBackgroundColor(backcolor)

    optionList[0].func = scene.init
    optionList[2].func = love.event.quit
end

function Menu.draw()
    -- set font shared between all menu items
    love.graphics.setFont(font)
    love.graphics.setColor(fontcolor)

    -- horizontally centers but follows rules for vertical positioning
    for i, option in pairs(optionList) do
        local text = option.text
        local xpos = (SCREEN_SIZE.x - font:getWidth(text)) / 2
        local ypos = Y_OFFSET + i * (ITEM_DISTANCE + font:getHeight())
        
        if i == hoveredOption then
            xpos = xpos + ITEM_DISTANCE
        end

        love.graphics.print(text, xpos, ypos)
    end
end

function Menu.keypressed(key)
    -- cover basic movement operations for options
    if key == "w" or key == "up" then
        hoveredOption = hoveredOption - 1
    elseif key == "s" or key == "down" then
        hoveredOption = hoveredOption + 1
    end

    -- cover overflowing
    if key == "w" or key == "up" or key == "s" or key == "down" then
        if hoveredOption > table.getn(optionList) then
            hoveredOption = 0
        elseif hoveredOption < 0 then
            hoveredOption = table.getn(optionList)
        end
    end

    -- resets the cursor to be not hovering anything
    if key == "lshift" then
        hoveredOption = -1
    end

    -- select the thing
    if key == "return" then
        if optionList[hoveredOption].func ~= nil then
            optionList[hoveredOption].func()
        end
    end

    -- bai bai
    if key == "escape" then
        love.event.quit(0)
    end
end

return Menu