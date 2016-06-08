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
            self.locked[obj.x][obj.y] = obj.solid
            table.insert(self.cell[obj.x][obj.y], obj)
            table.insert(self.cellObjects, obj)
            return true
        else
            return false
        end
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