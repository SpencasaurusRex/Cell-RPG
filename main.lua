
function love.load(arg)
    -- Setup static constants
    static = 
    {
        time = {delta = 0},
    }
    require 'camera'
    require 'grid'
    require 'cellObject'
    require 'util'
    require 'player'

    static.camera:follow(static.player)

    -- Setup input variables
    spacePressedLastFrame = false

    -- Load in grass plot
    local grassSprite  = love.graphics.newImage('Graphics/grass.png')
    local i = 0
    local j = 0
    for i=0,static.grid.width do
        for j=0,static.grid.height do
            local cellObj = cellObject.new(i, j, grassSprite, false, false)
            static.grid:addCellObject(cellObj)        
        end
    end
    result = static.grid:addCellObject(static.player)
end

function love.update(dt)
    static.time.delta = dt
    handleInput()
    for k,v in pairs(static.grid.cellObjects) do
        v:update()
    end
    static.camera:update()
end

function love.draw()
    for k,v in pairs(static.grid.cellObjects) do
        love.graphics.draw(v:draw())
    end

    -- Visualize blocked cells
    local blockedSprite = love.graphics.newImage('Graphics/square.png')
    local i = 0
    local j = 0
    for i=0,static.grid.width do
        for j=0,static.grid.height do
            if static.grid.locked[i][j] then
                love.graphics.draw(cellObject.new(i, j, blockedSprite, false, false):draw())
            end
        end
    end
end

function love.quit()
    
end

function handleInput()
    if love.keyboard.isDown('escape') then
        love.event.push('quit')
    end

    if love.keyboard.isDown('space') then
        if not spacePressedLastFrame then
            -- player:activate()
            spacePressedLastFrame = true
        end
    else
        spacePressedLastFrame = false
    end
end