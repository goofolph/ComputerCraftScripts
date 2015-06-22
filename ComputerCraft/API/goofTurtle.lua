-- chopTree.lua
-- by Goofolph https://github.com/goofolph

-- tables for easy function lookups
digTable = {
  "forward" = turtle.dig,
  "down" = turtle.digDown,
  "up" = turtle.digUp
}
moveTable = {
  "forward" = turtle.forward,
  "down" = turtle.down,
  "up" = turtle.up
}
turnTable = {
  "right" = turtle.turnRight,
  "left" = turtle.turnLeft
}
oppositeDir = {
  "left" = "right",
  "right" = "left",
  "up" = "down",
  "down" = "up",
  "forward" = "back",
  "back" = "forward"
}

function turn (dir, count)
  i = 0
  while i < count do
    turnTable[dir] ()
    i = i + 1
  end
end

function digMove (dir, distance, grav)
  if dir == "left" or dir == "right" then
    turn (dir, 1)
  elseif dir == "back" then
    turn ("left", 2)
  end
end