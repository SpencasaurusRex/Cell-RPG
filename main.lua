
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
    local i,j
    for i=0,static.grid.width do
        for j=0,static.grid.height do
            local cellObj = cellObject.new(i, j, grassSprite, 32, false, false)
            static.grid:addCellObject(cellObj)
        end
    end
    static.grid:addCellObject(static.player)
end

function love.update(dt)
    static.time.delta = dt
    handleInput()
    static.camera:update()
	static.player:update()
end

function love.draw()
    local k,v
    for k,v in pairs(static.grid.cellObjects) do
        if math.abs(v.x - static.player.x) < static.camera:rangeX() and math.abs(v.y - static.player.y) < static.camera:rangeY() then
            v:draw()
        end
    end
end

function love.wheelmoved(x,y)
    static.camera.scale = static.camera.scale + y / 2
    static.camera.scale = util.clamp(static.camera.scale, 1)
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
