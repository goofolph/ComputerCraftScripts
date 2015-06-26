-- chopTree.lua
-- by Goofolph https://github.com/goofolph

local args = {...}

os.loadAPI("goofTurtle.lua")
goofTurtle = goofTurtle.lua

local saplingSlot = 15
local bonemealSlot = 16

-- don't change these dirs (no support for changes yet)
local outputDir = "down"
local saplingDir = "right"
local bonemealDir = "left"

local numSaplings = 4
local numBonemeal = 64

-- TODO refill inventory
if turtle.getItemCount(saplingSlot) < numSaplings then
  goofTurtle.turn(saplingDir, 1)
  turtle.select(saplingSlot)
  turtle.suck(numSaplings - turtle.getItemCount(saplingSlot))
  goofTurtle.turn(goofTurtle.oppositeDir(saplingDir))
end

if turtle.getItemCount(bonemealSlot) < numBonemeal then
  goofTurtle.turn(bonemealDir, 1)
  turtle.select(bonemealSlot)
  turtle.suck(numBonemeal - turtle.getItemCount(bonemealSlot))
  goofTurtle.turn(goofTurtle.oppositeDir(bonemealDir))
end

-- TODO chop down the tree

local i = 1
while i <= 16 do
  if turtle.getItemCount(i) > 0 then
    turtle.select(i)
    if outputDir == "down" then
      turtle.dropDown();
    end
  end
  i = i + 1
end
