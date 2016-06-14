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
        speed = 3 or speed,
        facing = 3 or facing,
        draw = function(self)
            local w,h = love.graphics.getDimensions()
			local camX = static.camera.x
			local camY = static.camera.y
			local s = self.scale * static.camera.scale

			love.graphics.draw(
				self.image,
				w / 2 - s * (camX - self.x) - s / 2,
				h / 2 + s * (camY - self.y) + s / 2 - s,
				0,
				static.camera.scale * self.scale / self.image:getWidth(),
				static.camera.scale * self.scale / self.image:getHeight())
        end,
        update = function(self)
            if self.move and self.dir then
                -- Move the cell
                self.x = self.x + self.dir.x * static.time.delta * self.speed
                self.y = self.y + self.dir.y * static.time.delta * self.speed

                local t = self.target
                -- If the cell is done moving on the x axis
                if self.dir.x ~= 0 and not util.between(self.x, t, t - self.dir.x) then
                    self.callback:done()
                    -- If we should keep going
                    if self.next and self.next.x == self.dir.x then
                        self.target = self.target + self.dir.x
                        self.callback = static.grid:move(self, self.cellX + self.dir.x, self.cellY)
                    else
                        self.x = t
                        self.dir = nil
                        self.target = nil
                    end
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
            if static.grid:isOpen(self.cellX + dir.x, self.cellY + dir.y) then
                if self.dir then
                    self.next = dir
                else
                    self.dir = dir
                    self.target = (dir.x == 0 and self.y + dir.y) or (self.x + dir.x)
                    self.callback = static.grid:move(self, self.cellX + dir.x, self.cellY + dir.y)    
                end
            end
        end
        cellObj.stop = function(self)
            self.next = nil
        end
    end
    return cellObj
end
