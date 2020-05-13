WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243
-- Give the window a better look, more retro.
-- game runs on the virtual coordinates but window size stays the same
-- game is almost like zoomed in

push = require 'push'

function love.load()
    love.graphics.setDefaultFilter('nearest','nearest')
    font = love.graphics.newFont('tabarra.ttf',12)
    love.graphics.setFont(font)

    -- love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT,{
    --     fullscreen = false, 
    --     vsync = true,
    --     resizable = false
    -- })
    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
            fullscreen = false, 
            vsync = true,
            resizable = true
        })
end

function love.keypressed(key)
    --  if x is pressed quits the game
    if key == 'x' then
        love.event.quit()
    end
end




function love.draw()
    push:apply('start')

    -- sets background color
    love.graphics.clear(130 / 255,12 / 255,52/255,255/255)
    
--  draws ball
    love.graphics.rectangle('fill',VIRTUAL_WIDTH/2-2,VIRTUAL_HEIGHT/2-2,5,5)
-- draws rectangles
    love.graphics.rectangle('fill',5,20,5,20)
    love.graphics.rectangle('fill',VIRTUAL_WIDTH- 10,VIRTUAL_HEIGHT - 50,5,20)



    -- love.graphics.printf("Hello Pong",0,WINDOW_HEIGHT/2 - 6, WINDOW_WIDTH,'center')
    love.graphics.printf("Hello Pong",0,20, VIRTUAL_WIDTH,'center')

    push:apply('end')

end