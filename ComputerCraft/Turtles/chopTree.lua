-- chopTree.lua
-- by Goofolph https://github.com/goofolph

-- version 0.1.0

local args = {...}

os.loadAPI("gTurtle")

local saplingSlot = 15
local bonemealSlot = 16

-- don't change these dirs (no support for changes yet)
local outputDir = "down"
local saplingDir = "right"
local bonemealDir = "left"

local numSaplings = 4
local numBonemeal = 64

-- unload inventory
local i = 1
while i <= 16 do
  if turtle.getItemCount(i) > 0 then
    turtle.select(i)
    if outputDir == "down" then
      if i == saplingSlot then
        if turtle.getItemCount(i) > numSaplings then
          turtle.dropDown(turtle.getItemCount(i) - numSaplings)
        end
      elseif i == bonemealSlot then
        if turtle.getItemCount(i) > numBonemeal then
          turtle.dropDown(turtle.getItemCount(i) - numBonemeal)
        end
      else
        turtle.dropDown(turtle.getItemCount(i));
      end
    end
  end
  i = i + 1
end

-- refill saplings
if turtle.getItemCount(saplingSlot) < numSaplings then
  gTurtle.turn(saplingDir, 1)
  turtle.select(saplingSlot)
  turtle.suck(numSaplings - turtle.getItemCount(saplingSlot))
  gTurtle.turn(gTurtle.oppositeDir[saplingDir], 1)
end

-- refill bonemeal
if turtle.getItemCount(bonemealSlot) < numBonemeal then
  gTurtle.turn(bonemealDir, 1)
  turtle.select(bonemealSlot)
  turtle.suck(numBonemeal - turtle.getItemCount(bonemealSlot))
  gTurtle.turn(gTurtle.oppositeDir[bonemealDir], 1)
end

-- plants the tree
if not turtle.detect() then
  turtle.select(saplingSlot)
  turtle.place()
end

turtle.select(bonemealSlot)
while turtle.place() do
  os.sleep(0.2)
end

-- chop down the tree
if turtle.detect() then
  gTurtle.digMove("forward", 1, false, false)
  local height = 1
  while turtle.detectUp() do
    gTurtle.digMove("up", 1, false, false)
    height = height + 1
  end
  gTurtle.digMove("down", height - 1, false, false)
  gTurtle.digMove("back", 1, false, false)
end

os.unloadAPI("gTurtle")
