-- chopTree.lua
-- by Goofolph https://github.com/goofolph

local args = {...}

goofTurtle = os.loadAPI("goofTurtle.lua")

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

-- TODO chop down the tree

-- TODO drop off gathered materials
