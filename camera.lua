Camera = {}
do
    local meta = {
        _metatable = "Private metatable",
        _DESCRIPTION = "Camera"
    }

    meta.__index = meta

    function meta:follow(theTarget)
        if theTarget then
            self.target = theTarget
        else
            self.target = nil
        end
    end

    function meta:update()
        if self.target then
            self.x = self.target.x
            self.y = self.target.y
        end
    end

    function meta:rangeX()
        return (love.graphics:getWidth() / (self.standardScale * self.scale)) / 2 + 1
    end
        
    function meta:rangeY()
        return (love.graphics:getHeight() / (self.standardScale * self.scale)) / 2 + 1
    end

    setmetatable (Camera, {
        __call = function (C, scale, x, y)
            return setmetatable( {
                x = x,
                y = y,
                standardScale = 32,
                scale = scale,
                target = nil
            }, meta)
        end
    })
end

Camera.__index = Camera