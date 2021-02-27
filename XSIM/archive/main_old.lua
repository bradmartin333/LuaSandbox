require 'map-functions'
require 'helper'

function love.load()
    loadMap()

    zoomPos = {x = 0, y = 0}
    camPos = {x = 0, y = 0, z = 1}
    mouse = {}
end

function love.draw()
    drawMap()
end

function love.update(dt)
    mouse.x, mouse.y = love.mouse.getPosition()

    local speed = 1000
    if love.keyboard.isDown("w") then
        camPos.y = camPos.y - speed * dt
    end
    if love.keyboard.isDown("s") then
        camPos.y = camPos.y + speed * dt
    end
    if love.keyboard.isDown("a") then
        camPos.x = camPos.x - speed * dt
    end
    if love.keyboard.isDown("d") then
        camPos.x = camPos.x + speed * dt
    end
    updateCam(camPos, zoomPos)
end

function love.mousemoved(x, y, dx, dy, istouch)
    if love.mouse.isDown(3) then
        camPos.x = camPos.x - dx
        camPos.y = camPos.y - dy
    end
end

function love.wheelmoved(x, y)
    if y > 0 then
        camPos.z = camPos.z + 0.1
    elseif y < 0 then
        camPos.z = camPos.z - 0.1
    end
end
