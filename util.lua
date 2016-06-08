util = {}
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
util.between = function(val, a, b)
    if a < b then return a < val and val < b end
    return b < val and val < a
end