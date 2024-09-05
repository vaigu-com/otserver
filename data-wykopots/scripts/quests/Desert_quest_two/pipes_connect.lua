local currentlyVerifying = false

local topLeft = DESERT_QUEST_TWO_ANCHOR:Moved(17, -52, 1)
local downRight = DESERT_QUEST_TWO_ANCHOR:Moved(27, -46, 1)

local winningId = 20684

local idToDir = {
	[20670] = { NORTH, SOUTH },
	[20673] = { EAST, WEST },
	[20678] = { SOUTH, EAST },
	[20677] = { SOUTH, WEST },
	[20679] = { NORTH, WEST },
	[20676] = { NORTH, EAST },
}

local dirToOpposite = {
	[NORTH] = SOUTH,
	[SOUTH] = NORTH,
	[EAST] = WEST,
	[WEST] = EAST,
}

local function getOppositeDirection(dir)
	return dirToOpposite[dir]
end

local straightId = { 20673, 20670 }
local turningId = { 20678, 20677, 20679, 20676 }

local function tryGetPipeItem(pos)
	for key, _ in pairs(idToDir) do
		local pipeItem = Tile(pos):getItemById(key)
		if pipeItem then
			return pipeItem
		end
	end
	return nil
end

local function rotatePipeRandom(item)
	local pipeId = item:getId()
	if table.contains(straightId, pipeId) then
		item:transform(straightId[math.random(1, #straightId)])
	elseif table.contains(turningId, pipeId) then
		item:transform(turningId[math.random(1, #turningId)])
	end
end

local function copyOriginal()
	IterateBetweenPositions(topLeft, downRight, function(context)
		local pos = context.pos
		local pipeItem = tryGetPipeItem(pos:Moved(0, 0, 1))
		if not pipeItem then
			return
		end
		local item = Game.createItem(pipeItem:getId(), 1, pos)
		item:setActionId(Storage.DesertQuestTwo.Puzzles.WaterPipeStepIn)
	end)
end

local function clearPipes()
	IterateBetweenPositions(topLeft, downRight, function(context)
		local pos = context.pos
		for _ = 1, 3 do
			local item = tryGetPipeItem(pos)
			if not item then
				return
			end
			if idToDir[item:getId()] then
				item:remove()
			end
		end
	end)
end

local function rotatePipesRandom()
	IterateBetweenPositions(topLeft, downRight, function(context)
		local pos = context.pos
		local item = tryGetPipeItem(pos)
		if item then
			rotatePipeRandom(item)
		end
	end)
end

function InitializeDQ2PipePuzzle()
	clearPipes()
	copyOriginal()
	rotatePipesRandom()
end

local function onSucceedVerify()
	rotatePipesRandom()
	currentlyVerifying = false
	return true
end

local function onFailVerify()
	currentlyVerifying = false
	return false
end

local function verifyPipesConnection(currentPos, currentDir)
	local offset = Vector.FromDirection(currentDir)
	local nextPipePos = currentPos:Moved(offset)
	local nextPipe = tryGetPipeItem(nextPipePos)
	local winningPipe = Tile(nextPipePos):getItemById(winningId)
	if winningPipe then
		nextPipePos:sendMagicEffect(CONST_ME_CAKE)
		TrySpawnDQ2progressChest("Pipes")
		return onSucceedVerify()
	end
	if not nextPipe then
		return onFailVerify()
	end
	local pipeOutlets = idToDir[nextPipe:getId()]

	local nextDir = -1
	if getOppositeDirection(pipeOutlets[1]) == currentDir then
		nextDir = pipeOutlets[2]
	elseif getOppositeDirection(pipeOutlets[2]) == currentDir then
		nextDir = pipeOutlets[1]
	else
		return onFailVerify()
	end

	nextPipePos:sendMagicEffect(CONST_ME_WATERSPLASH)
	addEvent(function()
		verifyPipesConnection(nextPipePos, nextDir)
	end, 100)
end

local finishLever = Action()
function finishLever.onUse(creature, item, _, _, _, _)
	local player = creature:getPlayer()
	if not player then
		return false
	end
	if currentlyVerifying then
		return false
	end

	local nextDir = SOUTH
	if not verifyPipesConnection(topLeft, nextDir) then
		return
	end

	return false
end

finishLever:aid(Storage.DesertQuestTwo.Puzzles.WaterPipesLever)
finishLever:register()

local function rotatePipe(item)
	local itemId = item:getId()
	if table.contains(straightId, itemId) then
		for i = 1, #straightId do
			if straightId[i] == itemId then
				local nextId = straightId[i + 1] or straightId[1]
				item:transform(nextId)
			end
		end
	elseif table.contains(turningId, itemId) then
		for i = 1, #turningId do
			if turningId[i] == itemId then
				local nextId = turningId[i + 1] or turningId[1]
				item:transform(nextId)
			end
		end
	end
end

local playerRotatePipe = MoveEvent()
function playerRotatePipe.onStepIn(creature, item, _, _)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	rotatePipe(item)
	return false
end

playerRotatePipe:type("stepin")
playerRotatePipe:aid(Storage.DesertQuestTwo.Puzzles.WaterPipeStepIn)
playerRotatePipe:register()
