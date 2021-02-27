function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function makeZero(x,minX,maxX)
    if x > maxX or x < minX then return x end
    return 0
end

isDown = love.keyboard.isDown
floor = math.floor
min, max = math.min, math.max
