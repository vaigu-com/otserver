local sparksNumber = 3

local passableId = 5062
local unpassableId = 6288

local fadeDelay = 10
local currentFadeTimer = 0

local function tryCreatePassableSparksLoop(topPos)
	if os.time() > currentFadeTimer then
		for i = 0, 2 do
			local sparkPos = topPos:Moved(0, i, 0)
			local sparkItem = Tile(sparkPos):getItemById(unpassableId)
			if sparkItem then
				sparkItem:remove()
			end
			Game.createItem(passableId, 1, sparkPos)
		end
		return
	end

	addEvent(function()
		tryCreatePassableSparksLoop(topPos)
	end, 1000)
end

local function createUnpassableSparks(topPos)
	for i = 0, 2 do
		local sparkPos = topPos:Moved(0, i, 0)
		local passableSpark = Tile(sparkPos):getItemById(passableId)
		if not passableSpark then
			return
		end
		passableSpark:remove()
		Game.createItem(unpassableId, 1, sparkPos)
	end
	tryCreatePassableSparksLoop(topPos)
end

local beforeSparks = MoveEvent()
function beforeSparks.onStepIn(creature, _, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	currentFadeTimer = os.time() + fadeDelay

	local centerPos = DESERT_QUEST_TWO_ANCHOR:Moved(-26, 1, 1)
	local unpassableSpark = Tile(centerPos):getItemById(unpassableId)
	if unpassableSpark then
		return
	end

	createUnpassableSparks(centerPos)
	return true
end

beforeSparks:aid(Storage.DesertQuestTwo.Puzzles.FireBlockageTile)
beforeSparks:type("stepin")
beforeSparks:register()
