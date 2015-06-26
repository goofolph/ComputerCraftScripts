-- chopTree.lua
-- by Goofolph https://github.com/goofolph

-- tables for easy function lookups
digTable = {
  forward = turtle.dig,
  down = turtle.digDown,
  up = turtle.digUp
}
moveTable = {
  forward = turtle.forward,
  down = turtle.down,
  up = turtle.up
}
turnTable = {
  right = turtle.turnRight,
  left = turtle.turnLeft
}
oppositeDir = {
  left = "right",
  right = "left",
  up = "down",
  down = "up",
  forward = "back",
  back = "forward"
}

-- time to wait for gravity (gravel, sand)
local gravSleep = 0.25
-- time to wait between attacks
local attackSleep = 0.05

function turn(dir, count)
  i = 0
  while i < count do
    turnTable[dir]()
    i = i + 1
  end
end

-- moves the turtle while digging anything in it's way
function digMove(dir, distance, grav, attack)
  -- align turtle
  if dir == "left" or dir == "right" then
    turn (dir, 1)
  elseif dir == "back" then
    turn ("left", 2)
  end

  local i = 0
  while i < distance do
    while not turtle.forward() do
      if attack then
        turtle.attack()
        os.sleep(attackSleep)
      end
      turtle.dig()
      if grav then
        os.sleep(gravSleep)
      end
    end
  end

  -- turn back to starting orientation
  if dir == "left" or dir == "right" then
    turn(oppositeDir[dir], 1)
  elseif dir == "back" then
    turn("right", 2)
  end
end
