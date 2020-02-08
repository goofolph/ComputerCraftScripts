os.loadAPI("TurtleActions.lua")
local ta = TurtleActions

if #arg ~= 1 then
    print("Usage: tunnel <distance>")
    return
end

local dist = arg[1]

-- current position up or down
local isUp = false

for i = 1,dist,1 do
    ta.forward(1, true, true)
    ta.digLeft(true)
    ta.digRight(true)
    if isUp then
        ta.down(1, true, true)
    else
        ta.up(1, true, true)
    end
    ta.digLeft(true)
    ta.digRight(true)
    isUp = not isUp
end
