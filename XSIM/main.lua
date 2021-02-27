local gamera = require 'gamera'
require 'devices'
require 'sites'
require 'helpers'

-- game variables (entities)
local world, player, target, cam1, cam2

-- world functions
local function drawWorld(cl,ct,cw,ch)
  local w = world.w / world.columns
  local h = world.h / world.rows

  local minX = max(floor(cl/w), 0)
  local maxX = min(floor((cl+cw)/w), world.columns-1)
  local minY = max(floor(ct/h), 0)
  local maxY = min(floor((ct+ch)/h), world.rows-1)

  love.graphics.setColor(0,1,0)
  love.graphics.rectangle("fill", 500, 500, 1300, 850)

  love.graphics.setColor(0,0,0)
  for key,device in pairs(Devices) do
    d = Devices[key]
    love.graphics.rectangle("fill", d.x*w, d.y*h, d.w, d.h)
  end
end

-- target functions
local function updateTarget(dt)
  target.x, target.y = cam1:toWorld(love.mouse.getPosition())
end

local function drawTarget()
  love.graphics.setColor(1,1,0)
  love.graphics.circle("fill", target.x, target.y, 50)
end

-- player functions
local function updatePlayer(dt)
  local dx,dy = makeZero(target.x - player.x, -5,5),
                makeZero(target.y - player.y, -5,5)
  player.x = player.x + 2 * dx * dt
  player.y = player.y + 2 * dy * dt
end

local function drawPlayer()
  love.graphics.setColor(0,1,0)
  love.graphics.rectangle('fill',
                          player.x - player.w / 2,
                          player.y - player.h / 2,
                          player.w,
                          player.h)
end

-- camera functions
local function updateCameras(dt)
  cam1:setPosition(player.x, player.y)
  cam2:setPosition(player.x, player.y)
end

-- scale camera
function love.wheelmoved(x, y)
  local scaleFactor = y / 50
  cam1:setScale(cam1:getScale() + scaleFactor)
end

local function drawCam1ViewPort()
  love.graphics.setColor(0,0,1,0.25)
  love.graphics.rectangle('fill', cam1:getVisible())
end

-- main love functions
function love.load()
  love.window.setTitle("XSIM")
  love.window.setIcon(love.image.newImageData("XSIM.png"))

  world  = { w = 50000, h = 50000, rows = 10000, columns = 10000 }
  target = { x = 500,  y = 500 }
  player = { x = 200,  y = 200, w = 1000, h = 1000 }

  cam1 = gamera.new(0, 0, world.w, world.h)
  cam1:setWindow(10,10,520,580)

  cam2 = gamera.new(0,0, world.w, world.h)
  cam2:setWindow(540,10,250,180)
  cam2:setScale(0) -- it will self-adjust to the minimum available

  generateDevices()
end

function love.update(dt)
  updatePlayer(dt)
  updateCameras(dt)
  updateTarget(dt)
end

function love.draw()
  cam1:draw(function(l,t,w,h)
    drawWorld(l,t,w,h)
    --drawPlayer()
    --drawTarget()
  end)

  cam2:draw(function(l,t,w,h)
    drawWorld(l,t,w,h)
    drawPlayer()
    --drawTarget()
    drawCam1ViewPort()
  end)

  love.graphics.setColor(1,1,1)
  love.graphics.rectangle('line', cam1:getWindow())
  love.graphics.rectangle('line', cam2:getWindow())

  local msg = [[ XSIM demo
    * mouse: move player
    * mousewheel: zoom
  ]]
  love.graphics.print(msg, 540, 300)
end

-- exit with esc
function love.keypressed(key)
  if key == 'escape' then love.event.quit() end
end
