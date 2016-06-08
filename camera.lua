static.camera = {
    x = 0,
    y = 0,
    scale = 64,
    defaultScale = 64,
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
    end
}