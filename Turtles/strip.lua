os.loadAPI("TurtleActions.lua")
local ta = TurtleActions

if #arg ~= 2 then
    print("Usage: strip <distance>")
end

local dist = arg[1]
local sideDepth = arg[2]

-- how often to make a branch tunnel
local tunnelSpacing = 4

local function inventoryDelay()
    while ta.freeSlots() == 0 do
        sleep(1)
    end
end

local function bridge()
    if not turtle.detectDown() then
        for i = 1,16,1 do
            turtle.select(i)
            if turtle.placeDown() then
                return true
            end
        end
    else
        return true
    end
    return false
end

for i = 1,dist,1 do
    inventoryDelay()
    ta.forward(1, true, true)
    bridge()
    ta.digUp()
    -- every so often mine a branch
    if i % tunnelSpacing == 0 then
        -- dig left side first
        turtle.turnLeft()
        for i = 1,sideDepth,1 do
            inventoryDelay()
            ta.forward(1, true, true)
            bridge()
            ta.digUp()
        end
        -- return to start
        ta.back(sideDepth, true, true)
        -- dig right side
        for i = 1,sideDepth,1 do
            inventoryDelay()
            ta.forward(1, true, true)
            bridge()
            ta.digUp()
        end
        -- return to start and face forward again
        ta.back(sideDepth, true, true)
        turtle.turnRight()
    end
end
