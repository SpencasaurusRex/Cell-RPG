cellObject = {}
cellObject.new = function (x, y, image, scale, movable, solid, speed, facing)
    local cellObj = {
        x = x,
        y = y,
        cellX = x,
        cellY = y,
        image = image,
        scale = scale,
        solid = solid,
        movable = movable,
        speed = 5 or speed,
        facing = 3 or facing,
        draw = function(self)
            local w,h = love.graphics.getDimensions()
            local camX = static.camera.x
            local camY = static.camera.y
            local s = self.scale * static.camera.scale
            return  self.image,
                    w / 2 - s * (camX - self.x + .5),
                    h / 2 + s * (camY - self.y - .5),
                    0,
                    static.camera.scale * (self.scale / self.image:getWidth()),
                    static.camera.scale * (self.scale / self.image:getHeight())
        end,
        update = function(self)
            if self.movable and self.dir then
                -- Move the cell
                self.x = self.x + self.dir.x * static.time.delta * self.speed
                self.y = self.y + self.dir.y * static.time.delta * self.speed
                
                local t = self.target
                -- If the cell is done moving on the x axis
                if self.dir.x ~= 0 and not util.between(self.x, t, t - self.dir.x) then
                    -- TODO if player, unless the user is still holding the button
                    self.x = t
                    self.dir = nil
                    self.target = nil
                    self.callback:done()
                -- If the cell is done moving on the y axis
                elseif self.dir.y ~= 0 and not util.between(self.y, t, t - self.dir.y) then
                    self.y = t
                    self.dir = nil
                    self.target = nil
                    self.callback:done()
                end
            end
        end
    }
    if movable then
        cellObj.move = function(self, dir)
            if not self.dir and static.grid:isOpen(self.cellX + dir.x, self.cellY + dir.y) then
                self.dir = dir
                self.target = (dir.x == 0 and self.y + dir.y) or (self.x + dir.x)
                self.callback = static.grid:move(self, self.cellX + dir.x, self.cellY + dir.y)
            end
        end
    end
    return cellObj
end