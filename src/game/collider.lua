Collider = {}

-- type is a string
function Collider:new(type, offset, valueTable)
    -- Add member variables here.
    selfObj = {}
    selfObj.xOffset = offset.x
    selfObj.yOffset = offset.y

    if type == "circle" then
        selfObj.radius = valueTable.radius
    elseif type == "rect" then
        selfObj.height = valueTable.height
        selfObj.width = valueTable.width
    end

    -- Make this into a class.
    self.__index = self
    return setmetatable(selfObj, self)
end



return Collider