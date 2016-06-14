local playerSprite = love.graphics.newImage('Graphics/player.png')
static.player = cellObject.new(0, 0, playerSprite, 20, true, true)

-- Override the update method to pull in wasd input
local update = static.player.update
static.player.update = function(self)
    local dir = util.inputDirection()
    if (dir.x == 0) == not (dir.y == 0) then
        self:move(dir)
    elseif dir.x == 0 and dir.y == 0 then
    	self:stop()
    end
    update(self)
end
