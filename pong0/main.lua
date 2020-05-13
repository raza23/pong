WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200
-- Give the window a better look, more retro.
-- game runs on the virtual coordinates but window size stays the same
-- game is almost like zoomed in

push = require 'push'

function love.load()
    love.graphics.setDefaultFilter('nearest','nearest')
    helloFont = love.graphics.newFont('tabarra.ttf',12)
    scoreFont = love.graphics.newFont('B20Sans.ttf',18)
    player1score = 0
    player2score = 3
    
    player1y = 30
    player2y = VIRTUAL_HEIGHT - 40
    



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

function love.update(dt)
    if love.keyboard.isDown('w') then
        player1y = player1y - PADDLE_SPEED * dt

    elseif love.keyboard.isDown('s') then
        player1y = player1y + PADDLE_SPEED * dt

    end

    if love.keyboard.isDown('up') then
        player2y = player2y - PADDLE_SPEED * dt

    elseif love.keyboard.isDown('down') then
        player2y = player2y + PADDLE_SPEED * dt

    end


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
    love.graphics.rectangle('fill',5,player1y,5,20)
    love.graphics.rectangle('fill',VIRTUAL_WIDTH- 10,player2y,5,20)



    -- love.graphics.printf("Hello Pong",0,WINDOW_HEIGHT/2 - 6, WINDOW_WIDTH,'center')
    love.graphics.setFont(helloFont)
    love.graphics.printf("Hello Pong",0,20, VIRTUAL_WIDTH,'center')

    love.graphics.setFont(scoreFont)
    love.graphics.print('P1',VIRTUAL_WIDTH/2-50,VIRTUAL_HEIGHT/4)
    love.graphics.print(player1score, VIRTUAL_WIDTH/2-50,VIRTUAL_HEIGHT/3)

    love.graphics.print('P2',VIRTUAL_WIDTH/2+30,VIRTUAL_HEIGHT/4)
    love.graphics.print(player2score, VIRTUAL_WIDTH/2 + 30,VIRTUAL_HEIGHT/3)

    push:apply('end')

end