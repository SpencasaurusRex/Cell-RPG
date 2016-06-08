
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

    -- Setup input variables
    spacePressedLastFrame = false

    -- Load in 10x10 grass square
    local grassSprite  = love.graphics.newImage('Graphics/grass.png')
    local i = 0
    local j = 0
    for i=0,10 do
        for j=0,10 do
            local cellObj = cellObject.new(i, j, grassSprite, false, false)
            static.grid:addCellObject(cellObj)        
        end
    end
    result = static.grid:addCellObject(static.player)
    print(result)
end

function love.update(dt)
    static.time.delta = dt
    handleInput()
    for k,v in pairs(static.grid.cellObjects) do
        v:update()
    end
end

function love.draw()
    for k,v in pairs(static.grid.cellObjects) do
        love.graphics.draw(v:draw())
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