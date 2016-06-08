static.grid = {
    width = 100,
    height = 20,
    isOpen = function(self, xPos, yPos)
        return  xPos >= 0 and xPos < self.width and 
                yPos >= 0 and yPos < self.height and
                not self.locked[xPos][yPos]
    end,
    cell = {},
    locked = {},
    cellObjects = {}, -- For easy iteration
    
    addCellObject = function(self, obj)
        if self:isOpen(obj.x, obj.y) then
            table.insert(self.cell[obj.x][obj.y], obj)
            table.insert(self.cellObjects, obj)
            self.locked[obj.x][obj.y] = util.anyCellSolid(self.cell[obj.x][obj.y])
            return true
        else
            return false
        end
    end,
    -- Assumes spot is open
    move = function(self, obj, x, y)
        -- Remove from old spot
        util.tableRemoveValue(self.cell[obj.cellX][obj.cellY], obj)
        -- Store in new spot
        table.insert(self.cell[x][y], obj)
        -- Lock spot if necessary
        self.locked[x][y] = util.anyCellSolid(self.cell[x][y])
        -- Create a callback object to unlock old spot
        local callback = {}
        callback.x = obj.cellX
        callback.y = obj.cellY
        callback.done = function(self)
            static.grid.locked[self.x][self.y] = util.anyCellSolid(static.grid.cell[self.x][self.y])
        end
        -- Update cellX,Y
        obj.cellX = x
        obj.cellY = y
        
        return callback
    end
}

-- Load cell grid
static.grid.cell = {}
local i = 0
local j = 0
for i=0,static.grid.width do
    static.grid.locked[i] = {}
    static.grid.cell[i] = {}
    for j=0,static.grid.height do
        static.grid.cell[i][j] = {}
        static.grid.locked[i][j] = false
    end
end