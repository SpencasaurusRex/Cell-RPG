static.camera = {
    x = 0,
    y = 0,
    standardScale = 32,
    scale = 3,
    target = nil,
    follow = function(self, theTarget)
        if theTarget then
            self.target = theTarget
        else
            self.target = nil
        end
    end,
    update = function(self)
        if self.target then
            self.x = self.target.x
            self.y = self.target.y
        end
    end,
    rangeX = function(self)
        return (love.graphics:getWidth() / (self.standardScale * self.scale)) / 2 + 1
    end,
    rangeY = function(self)
        return (love.graphics:getHeight() / (self.standardScale * self.scale)) / 2 + 1
    end
}