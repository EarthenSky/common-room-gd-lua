local Util = {}

function Util.shallowcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function Util.getDistanceBetween(x1, y1, x2, y2)
    local xdif = (x1 - x2)
    local ydif = (y1 - y2)
    return math.sqrt(xdif * xdif + ydif * ydif)
end

-- returns (x, y) pair
function Util.polarToCartesian(rotation, length)
    local x, y = math.cos(rotation), math.sin(rotation)
    return x * length, y * length
end

return Util