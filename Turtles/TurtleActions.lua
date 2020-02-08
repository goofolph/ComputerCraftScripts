-- ************************************************************************** --
-- Minecraft Mining Turtle Quarry
-- Author Goofolph
--
-- Usage:
--      os.loadAPI("TurtleActions.lua")
--
-- Description:
--      Useful commands for Turtles that extends the build in API.
-- ************************************************************************** --

-- delay between mining a block or attacking an entity before attempting to move
-- again. eg (sand/gravel falling, mob walking forward)
local moveDelay = 0.5

-- minFuel to have at all times
local minFuel = 10

-- Moves turtle relative from current position.
--
-- Moves turtle relative directions in the x (forward), y (up), and z (right)
-- directions.
--
-- Args:
--      xdif: distance to move in facing direction
--      ydif: distance to move in upwards direction
--      zdif: distance to move in right facing direction
--      mine: mines blocks in the way if true
--      attack: attacks entities in the way if true
--      keepFace: turns to face original direction if true
--
-- Returns:
--      status, xdist, ydist, zdist
--      status is true if no errors occured, false otherwise. xdist, ydist, and
--          zdist are there in case target distance could not be reached
function move(xdif, ydif, zdif, mine, attack, keepFace)
    print("")
end

-- Moves turtle forward from current position.
--
-- Args:
--      dist: distance to move forwarad
--      mine: mines blocks in the way if true
--      attack: attacks entities in the way if true
--
-- Returns:
--      status, dist
--      status is true if there were no errors, false otherwise. dist is there
--          in case taraget distance could not be reached
function forward(dist, mine, attack)
    dist = dist or 1
    for i = 1,dist,1 do
        while not turtle.forward() do
            if mine and turtle.detect() then
                if not turtle.dig() then
                    return false, dist-i
                end
            elseif attack and turtle.attack() then
            else
                sleep(moveDelay)
            end
        end
    end
    return true, dist
end

-- Moves turtle upwards from current position.
--
-- Args:
--      dist: distance to move up
--      mine: mines blocks in the way if true
--      attack: attacks entities in the way if true
--
-- Returns:
--      status, dist
--      status is true if there were no errors, false otherwise. dist is there
--          in case taraget distance could not be reached
function up(dist, mine, attack)
    dist = dist or 1
    for i = 1,dist,1 do
        while not turtle.up() do
            if mine and turtle.detectUp() then
                if not turtle.digUp() then
                    return false, dist-1
                end
            elseif attack and turtle.attackUp() then
            else
                sleep(moveDelay)
            end
        end
    end
    return true, dist
end

-- Moves turtle down from current position.
--
-- Args:
--      dist: distance to move down
--      mine: mines blocks in the way if true
--      attack: attacks entities in the way if true
--
-- Returns:
--      status, dist
--      status is true if there were no errors, false otherwise. dist is there
--          in case taraget distance could not be reached
function down(dist, mine, attack)
    dist = dist or 1
    for i = 1,dist,1 do
        while not turtle.down() do
            if mine and turtle.detectDown() then
                if not turtle.digDown() then
                    return false, dist-1
                end
            elseif attack and turtle.attackDown() then
            else
                sleep(moveDelay)
            end
        end
    end
    return true, dist
end

-- Moves turtle back from current position.
--
-- Args:
--      dist: distance to move back
--      mine: mines blocks in the way if true
--      attack: attacks entities in the way if true
--      keepFace: turns to face original direction if true
--
-- Returns:
--      status, dist
--      status is true if there were no errors, false otherwise. dist is there
--          in case taraget distance could not be reached
function back(dist, mine, attack, keepFace)
    dist = dist or 1
    turtle.turnLeft()
    turtle.turnLeft()
    local retStatus, retDist = forward(dist, mine, attack)
    if keepFace then
        turtle.turnLeft()
        turtle.turnLeft()
    end
    return retStatus, retDist
end

-- Moves turtle to the right of current position.
--
-- Args:
--      dist: distance to move right
--      mine: mines blocks in the way if true
--      attack: attacks entities in the way if true
--      keepFace: turns to face original direction if true
--
-- Returns:
--      status, dist
--      status is true if there were no errors, false otherwise. dist is there
--          in case taraget distance could not be reached
function right(dist, mine, attack, keepFace)
    dist = dist or 1
    turtle.turnRight()
    local retStatus, retDist = forward(dist, mine, attack)
    if keepFace then
        turtle.turnLeft()
    end
    return retStatus, retDist
end

-- Moves turtle to the left of current position.
--
-- Args:
--      dist: distance to move left
--      mine: mines blocks in the way if true
--      attack: attacks entities in the way if true
--      keepFace: turns to face original direction if true
--
-- Returns:
--      status, dist
--      status is true if there were no errors, false otherwise. dist is there
--          in case taraget distance could not be reached
function left(dist, mine, attack, keepFace)
    dist = dist or 1
    turtle.turnLeft()
    local retStatus, retDist = forward(dist, mine, attack)
    if keepFace then
        turtle.turnRight()
    end
    return retStatus, retDist
end

-- Counts number of free inventory slots.
--
-- Returns:
--      number of free inventory slots
function freeSlots()
    local free = 16
    for i = 1,16,1 do
        if turtle.getItemCount(i) > 0 then
            free = free-1
        end
    end
    return free
end

-- Ensures turtle has desired amount of fuel.
--
-- Args:
--      targetFuel: amount of desired fuel
--
-- Returns:
--      true on success, false otherwise
function refuel(targetFuel)
    targetFuel = math.max(targetFuel, minFuel)
    if turtle.getFuelLevel() == "unlimited" or turtle.getFuelLevel() >= targetFuel then
        return true
    end
    for i = 1,16,1 do
        turtle.select(i)
        while turtle.refuel(1) do
            if turtle.getFuelLevel() >= targetFuel then
                return true
            end
        end
    end
    return false
end

-- Digs block in front until clear.
--
-- Continues to dig until area is clear to handle falling sand/gravel/cobblegen.
--
-- Returns:
--      true on success, false otherwise
function dig()
    while turtle.detect() do
        if not turtle.dig() then
            return false
        else
            sleep(moveDelay)
        end
    end
    return true
end

-- Digs block in front until clear.
--
-- Continues to dig until area is clear to handle falling sand/gravel/cobblegen.
--
-- Returns:
--      true on success, false otherwise
function digUp()

    while turtle.detectUp() do
        if not turtle.digUp() then
            return false
        else
            sleep(moveDelay)
        end
    end
    return true
end

-- Digs block in front until clear.
--
-- Continues to dig until area is clear to handle falling sand/gravel/cobblegen.
--
-- Returns:
--      true on success, false otherwise
function digDown()

    while turtle.detectDown() do
        if not turtle.digDown() then
            return false
        else
            sleep(moveDelay)
        end
    end
    return true
end

-- Digs block in front until clear.
--
-- Continues to dig until area is clear to handle falling sand/gravel/cobblegen.
--
-- Returns:
--      true on success, false otherwise
function digRight(keepFace)
    turtle.turnRight()
    local ret = dig()
    if keepFace then
        turtle.turnLeft()
    end
    return ret
end

-- Digs block in front until clear.
--
-- Continues to dig until area is clear to handle falling sand/gravel/cobblegen.
--
-- Returns:
--      true on success, false otherwise
function digLeft(keepFace)
    turtle.turnLeft()
    local ret = dig()
    if keepFace then
        turtle.turnRight()
    end
    return ret
end
