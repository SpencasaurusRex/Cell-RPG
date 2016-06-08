function love.conf(t)
    -- Generic
    t.console = true

    -- Window
    t.window.width      = 932  
    t.window.height     = 642
    t.window.title      = "Cell RPG"
    t.window.resizable  = true

    -- Modules
    t.modules.touch     = false
    t.modules.mouse     = false
    t.modules.physics   = false
    t.modules.video     = false
end