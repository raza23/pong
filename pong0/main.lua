WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200
-- Give the window a better look, more retro.
-- game runs on the virtual coordinates but window size stays the same
-- game is almost like zoomed in
Class = require 'class'
push = require 'push'

require 'Ball'
require 'Paddle'

function love.load()
    math.randomseed(os.time())
    
    love.graphics.setDefaultFilter('nearest','nearest')
    helloFont = love.graphics.newFont('tabarra.ttf',12)
    enterFont = love.graphics.newFont('tabarra.ttf',10)
    scoreFont = love.graphics.newFont('B20Sans.ttf',18)
    player1score = 0
    player2score = 3
    
    -- paddle positions
    paddle1 = Paddle(5,20,5,20)
    paddle2 = Paddle(VIRTUAL_WIDTH-10,VIRTUAL_HEIGHT - 30,5,20)

    -- *player1y = 30
    -- *player2y = VIRTUAL_HEIGHT - 40
    
    -- ball positinos
    ballx = VIRTUAL_WIDTH/2-2
    bally = VIRTUAL_HEIGHT/2-2
    ball = Ball(ballx,bally,5,5)
    -- like a ternary
    -- *balldx = math.random(2) == 1 and -100 or 100
    -- *balldy = math.random(-50,50) 

    gameState = 'start'
    



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
    paddle1:update(dt)
    paddle2:update(dt)

    if love.keyboard.isDown('w') then
        -- player1y = math.max(0,player1y - PADDLE_SPEED * dt)
        paddle1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        -- player1y = math.min(VIRTUAL_HEIGHT - 20,player1y + PADDLE_SPEED * dt)
        paddle1.dy = PADDLE_SPEED
    else
        paddle1.dy = 0
    end

    if love.keyboard.isDown('up') then
        -- * player2y = math.max(0,player2y - PADDLE_SPEED * dt)
        paddle2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        -- * player2y = math.min(VIRTUAL_HEIGHT - 20,player2y + PADDLE_SPEED * dt)
        paddle2.dy = PADDLE_SPEED
    else    
        paddle2.dy = 0
    end

    if gameState == 'play' then
        ball:update(dt)
        -- *ballx = ballx + balldx * dt
        -- *bally = bally + balldy * dt
    end


end

function gameStart()
    ball.x = VIRTUAL_WIDTH/2-2
    ball.y = VIRTUAL_HEIGHT/2-2
    -- like a ternary
    ball.dx = math.random(2) == 1 and -100 or 100
    ball.dy = math.random(-50,50) 
end



function love.keypressed(key)
    --  if x is pressed quits the game
    if key == 'x' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then 
            gameState = 'play' 
        elseif gameState == 'play' then gameState = 'start'
            gameStart()
        
        end
    end
end




function love.draw()
    push:apply('start')

    -- sets background color
    love.graphics.clear(130 / 255,12 / 255,52/255,255/255)
    
--  draws ball
    -- * love.graphics.rectangle('fill',ballx,bally,5,5)
    ball:render()
-- draws rectangles
paddle1:render()
paddle2:render()
    -- * love.graphics.rectangle('fill',5,player1y,5,20)
    -- * love.graphics.rectangle('fill',VIRTUAL_WIDTH- 10,player2y,5,20)



    -- love.graphics.printf("Hello Pong",0,WINDOW_HEIGHT/2 - 6, WINDOW_WIDTH,'center')
    love.graphics.setFont(helloFont)
    if gameState == 'start' then
        love.graphics.printf("Hello Pong",0,20, VIRTUAL_WIDTH,'center')
    love.graphics.setFont(enterFont)
        love.graphics.printf("Press Enter",0,35, VIRTUAL_WIDTH,'center')

    elseif gameState == 'play' then
        love.graphics.setFont(helloFont)
        love.graphics.printf("PLAY",0,20, VIRTUAL_WIDTH,'center')
    end



    love.graphics.setFont(scoreFont)
    love.graphics.print('P1',VIRTUAL_WIDTH/2-50,VIRTUAL_HEIGHT/4)
    love.graphics.print(player1score, VIRTUAL_WIDTH/2-50,VIRTUAL_HEIGHT/3)

    love.graphics.print('P2',VIRTUAL_WIDTH/2+30,VIRTUAL_HEIGHT/4)
    love.graphics.print(player2score, VIRTUAL_WIDTH/2 + 30,VIRTUAL_HEIGHT/3)

    push:apply('end')

end