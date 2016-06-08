local playerSprite = love.graphics.newImage('Graphics/player.png') 
static.player = cellObject.new(0, 0, playerSprite, 32, true, true)
local update = static.player.update
static.player.update = function(self)
    local dir = util.inputDirection()
    if (dir.x == 0) == not (dir.y == 0) then
        self:move(dir)
    end
    update(self)
end