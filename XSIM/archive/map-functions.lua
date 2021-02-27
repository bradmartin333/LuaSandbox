require 'helper'

Quads = {}
TileTable = {}
Pos = {}
ZoomPos = {}

function loadMap()
    local filePath = 'qual-source-template.txt'
    --local filePath = 'qual-target-template.txt'
    if love.filesystem.getInfo(filePath) then parseMap(love.filesystem.read(filePath)) end
end

function parseMap(tileString)
    tile = 100
    grid = tile * 2

    local quadInfo = {
        {'o', 0,    0   },
        {'_', 0,    tile},
        {' ', tile, 0   },
        {'x', tile, tile}
    }

    local width = #(tileString:match("[^\n]+"))

    for x = 1,width,1 do TileTable[x] = {} end  

    local rowIndex,columnIndex = 1,1
    for row in tileString:gmatch("[^\n]+") do
        assert(#row == width, 'Map is not aligned: width of row ' .. tostring(rowIndex) .. ' should be ' .. tostring(width) .. ', but it is ' .. tostring(#row))
        columnIndex = 1
        for character in row:gmatch(".") do
            TileTable[columnIndex][rowIndex] = character
            columnIndex = columnIndex + 1
        end
        rowIndex=rowIndex+1
    end
end

function updateCam(c, zed)
    Pos.x = c.x
    Pos.y = c.y
    Pos.z = c.z
    ZoomPos.x = zed.x
    ZoomPos.y = zed.y
end

function drawMap()
    --- debouncing
    local click = false

    if love.mouse.isDown(1) then
        if db ~= true then
            db = true
            click = true
        end
    else
        db = false
    end
    --- end debouncing

    for x,column in ipairs(TileTable) do
        for y,char in ipairs(column) do

            local drawPos = {}
            drawPos.x = (x-1)*grid
            drawPos.y = (y-1)*grid

            if tonumber(char) ~= nil then
                local tileStr = "col" .. x .. "row" .. y
                local index = isClicked(tileStr)
                local r, g, b = {1, 1, 1}

                if CheckCollision(drawPos.x,drawPos.y) then
                    if click then
                        if index == false then
                            table.insert(Clicked, tileStr)
                        else 
                            table.remove(Clicked, index)
                        end
                    end
                elseif index ~= false then
                    r, g, b = {0.988,0.012,0.988}
                else
                    r, g, b = getColor(char)
                end

                love.graphics.setColor(r, g, b, a)
                love.graphics.rectangle("fill", drawPos.x, drawPos.y, tile, tile)
            else
                love.graphics.setColor(0,0,0)
                love.graphics.rectangle("fill", drawPos.x, drawPos.y, tile, tile)
            end
        end
    end
end

function CheckCollision(x, y)
    checkMouse = {}
    checkMouse.x = (mouse.x + Pos.x - tile) / Pos.z
    checkMouse.y = (mouse.y + Pos.y - tile) / Pos.z
    return checkMouse.x < x + tile and
           x < checkMouse.x + tile and
           checkMouse.y < y + tile and
           y < checkMouse.y + tile
end