local tween = require 'tween'

logFile = io.open("luaLog.txt", "a+")
logFile:write('\ninitiating log ' .. os.time() .. '\n')

pressTime = 0
pressed = false
reset = false

local border = {radius = 50, r = 0.659, g = 0.659, b = 0.659}
local circle = {radius = 45, r = 1.000, g = 1.000, b = 1.000}

local borderTween = tween.new(1, border, {r = 0})
local circleTween = tween.new(1, circle, {r = 0})

local segments = 50
local t = {{0,0,0,0}}
for i = 0, segments do
  t[i+2] = {math.cos(math.pi*2/(segments)*i), math.sin(math.pi*2/(segments)*i),0,0}
end
circleMesh = love.graphics.newMesh(t)

function love.update(dt)
	if reset and not pressed then
		local complete = borderTween:update(dt)
		circleTween:update(dt)
		if complete then reset = false end
	else
		border.radius = 50 + pressTime
		circle.radius = 45 + pressTime
	end
end

function love.load()
	math.randomseed(os.time())
	love.window.setTitle('Clicky')
end
 
function love.draw()
	local mx, my = love.mouse.getPosition()
	
	love.graphics.setColor(border.r, border.g, border.b)
	love.graphics.draw(circleMesh, mx, my, 0, border.radius)
	love.graphics.setColor(circle.r, circle.g, circle.b)
	love.graphics.draw(circleMesh, mx, my, 0, circle.radius)

	if love.mouse.isDown(1) then
		pressed = true
		if pressTime < 200 then pressTime = pressTime + 3 end
        --pressTime = pressTime + 3
	else
		if pressed then
			borderTween = tween.new(0.25, border, {radius = 50}, 'outBack')
			circleTween = tween.new(0.25, circle, {radius = 45}, 'outBack')
			border.r = math.random(100) / 100
			border.g = math.random(100) / 100
			border.b = math.random(100) / 100
			circle.r = 1 - border.r
			circle.g = 1 - border.g
			circle.b = 1 -
			border.b
			
			pressed = false
			reset = true
		end
		pressTime = 0
	end
end