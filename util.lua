util = {}

-- Returns the value clamped between a and b
util.clamp = function(val, a, b)
    if b then
        if a > b then
            if val > a then return a end
            if val < b then return b end
        else
            if val < a then return a end
            if val > b then return b end
        end
    elseif val < a then return a end
    return val
end

-- Returns a table {x,y} that matches the user's WASD input
util.inputDirection = function()
    local dir = {x = 0, y = 0}
    if love.keyboard.isDown('a') then
        dir.x = dir.x - 1
    end
    if love.keyboard.isDown('s') then
        dir.y = dir.y - 1
    end
    if love.keyboard.isDown('d') then
        dir.x = dir.x + 1
    end
    if love.keyboard.isDown('w') then
        dir.y = dir.y + 1
    end
    return dir
end

-- Returns whether or not the val is in between the a,b values
util.between = function(val, a, b)
    if a < b then return a < val and val < b end
    return b < val and val < a
end

-- Removes the value from the table
util.tableRemoveValue = function(table, val)
    for k,v in pairs(table) do
        if v == val then
            table[k] = nil
            return
        end
    end
end

-- Returns true if any cell in the table is solid
util.anyCellSolid = function(table)
    for k,v in pairs(table) do
        if v.solid then
            return true
        end
    end
    return false
end