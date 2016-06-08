static.camera = {
    x = 0,
    y = 0,
    scale = 64,
    defaultScale = 64,
    target = nil,
    follow = function(self, theTarget)
        if theTarget then
            target = theTarget
        else
            target = nil
        end
    end,
    update = function(self)
        if target then
            self.x = target.x
            self.y = target.y
        end
    end
}