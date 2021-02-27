color = 0
thisColor = ''

sourceColors = {
'#e6194b',
'#3cb44b',
'#ffe119',
'#4363d8',
'#f58231',
'#911eb4',
'#46f0f0',
'#f032e6',
'#bcf60c',
'#fabebe',
'#008080',
'#e6beff',
'#9a6324',
'#fffac8',
'#800000',
'#aaffc3',
'#808000',
'#ffd8b1',
'#000075',
'#808080',
'#ffffff',
'#000000'}

function hex2rgb(hex)
    hex = hex:gsub("#","")
    return {tonumber("0x"..hex:sub(1,2))/255, tonumber("0x"..hex:sub(3,4))/255, tonumber("0x"..hex:sub(5,6))/255}
end

function getColor(char)
    color = tonumber(char)
    thisColor = sourceColors[color]
    return hex2rgb(thisColor)
end

db = false
Clicked = {}
function isClicked(val)
    for index, value in ipairs(Clicked) do
        if value == val then
            return index
        end
    end
    return false
end