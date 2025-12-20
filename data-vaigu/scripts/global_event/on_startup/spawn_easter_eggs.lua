local nestId = 14750

local corner1 = Position(5803, 1479, 7)
local corner2 = Position(5998, 1604, 7)

local nestPositions = {}

local function initializeEggNestPositions()
	nestPositions = {}
	IterateBetweenPositions(corner1, corner2, function(context)
		local pos = context.pos
		if pos:GetItemById(nestId) then
			table.insert(nestPositions, pos)
		end
	end)
end

local minute = 60 * 1000
local function spawnIndividualNestLoop(nestPosition)
	if math.random(1, 2) == 1 then
		local nest = nestPosition:GetItemById(nestId)
		if nest then
			nest:remove()
		end
		Game.createItem(nestId, 1, nestPosition)
	end

	local timeTillNextSpawnMinutes = math.random(30, 60) * minute
	addEvent(spawnIndividualNestLoop, timeTillNextSpawnMinutes, nestPosition)
end

local function startAllNestSpawns()
	for _, nestPosition in pairs(nestPositions) do
		spawnIndividualNestLoop(nestPosition)
	end
end

local easterEggs = GlobalEvent("EasterNests")
function easterEggs.onStartup()
	initializeEggNestPositions()
	startAllNestSpawns()
end
easterEggs:register()
