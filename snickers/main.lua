local pos = 0

function love.load()
    animation = newAnimation(love.graphics.newImage("oldHero.png"), 16, 18, 1)
    background = love.graphics.newImage("airport.png")
    speech = love.graphics.newImage("speech.png")
    win = love.graphics.newImage("win.png")
    press = love.graphics.newImage("press.png")
end
 
function love.draw()
    if pos < 42 then
        for i = 0, love.graphics.getWidth() / background:getWidth() do
            for j = 0, love.graphics.getHeight() / background:getHeight() do
                love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
            end
        end

        local spriteNum = (pos % #animation.quads) + 1
        love.graphics.draw(animation.spriteSheet, animation.quads[spriteNum], pos*15, 440, 0, 8)
        
        if pos == 0 then
            love.graphics.draw(press,10,10)
        end
        
        if pos > 10 then
            love.graphics.draw(speech, 150, 100)
        end
    else
        love.graphics.draw(win, 0, 0)
    end
end
 
function newAnimation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image;
    animation.quads = {};
 
    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end
 
    animation.duration = duration or 1
    animation.currentTime = 0
 
    return animation
end

function love.keypressed(key)
   pos = pos + 1
end