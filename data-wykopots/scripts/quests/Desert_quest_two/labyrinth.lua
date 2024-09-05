local topLeftGenerate = DESERT_QUEST_TWO_ANCHOR:Moved(-3, -2, 2)
local downRightGenerate = DESERT_QUEST_TWO_ANCHOR:Moved(31, 32, 2)

local dx, dy = topLeftGenerate:DistanceTo(downRightGenerate)
local width = dx + 1
local height = dy + 1

local labyrinth = {}

local directions = {
	{ x = 0, y = -2 },
	{ x = 2, y = 0 },
	{ x = 0, y = 2 },
	{ x = -2, y = 0 },
}

local function generateLabyrinthTable()
	labyrinth = {}
	for i = 1, height do
		labyrinth[i] = {}
		for j = 1, width do
			labyrinth[i][j] = 1
		end
	end
	local startX = math.random(1, width)
	local startY = math.random(1, height)
	labyrinth[startY][startX] = 0

	local frontier = {}
	table.insert(frontier, { x = startX, y = startY })

	while #frontier > 0 do
		local randomIndex = math.random(1, #frontier)
		local currentCell = frontier[randomIndex]

		local unvisitedNeighbors = {}
		for _, direction in ipairs(directions) do
			local nx = currentCell.x + direction.x
			local ny = currentCell.y + direction.y

			if nx >= 1 and nx <= width and ny >= 1 and ny <= height then
				if labyrinth[ny][nx] == 1 then
					local wx = currentCell.x + direction.x / 2
					local wy = currentCell.y + direction.y / 2
					table.insert(unvisitedNeighbors, { x = nx, y = ny, wx = wx, wy = wy })
				end
			end
		end

		if #unvisitedNeighbors > 0 then
			local randomNeighbor = unvisitedNeighbors[math.random(1, #unvisitedNeighbors)]
			local nx = randomNeighbor.x
			local ny = randomNeighbor.y
			local wx = randomNeighbor.wx
			local wy = randomNeighbor.wy

			labyrinth[ny][nx] = 0
			labyrinth[wy][wx] = 0

			table.insert(frontier, { x = nx, y = ny })
		else
			table.remove(frontier, randomIndex)
		end
	end
end

generateLabyrinthTable()

local wallId = 2187
--local wallId = 4858
local function generateLabyrinthItems()
	for i = 1, height do
		for j = 1, width do
			if labyrinth[i][j] == 1 then
				local x = topLeftGenerate.x + i - 1
				local y = topLeftGenerate.y + j - 1
				local z = topLeftGenerate.z
				Game.createItem(wallId, 1, Position(x, y, z))
			end
		end
	end
end

local function clearLabyrinthItems()
	IterateBetweenPositions(topLeftGenerate, downRightGenerate, function(context)
		local pos = context.pos
		local item = Tile(pos):getItemById(wallId)
		if item then
			item:remove()
		end
	end)
end

local function clearEntranceItems()
	local topRightEntrance = topLeftGenerate:Moved(31, 0, 0)

	local positions = {
		topLeftGenerate:Moved(0, 0, 0),
		topLeftGenerate:Moved(0, 1, 0),
		topLeftGenerate:Moved(1, 1, 0),
		topLeftGenerate:Moved(1, 0, 0),
		downRightGenerate:Moved(0, 0, 0),
		downRightGenerate:Moved(0, -1, 0),
		downRightGenerate:Moved(-1, -1, 0),
		downRightGenerate:Moved(-1, 0, 0),
		topRightEntrance:Moved(0, 0, 0),
		topRightEntrance:Moved(0, 1, 0),
		topRightEntrance:Moved(1, 1, 0),
		topRightEntrance:Moved(1, 0, 0),
	}

	for _, position in pairs(positions) do
		local item = Tile(position):getItemById(wallId)
		if item then
			item:remove()
		end
	end
end

local function generateRevealTiles()
	local topLeft = topLeftGenerate:Moved(0, 0, 1)
	local downRight = downRightGenerate:Moved(0, 0, 1)
	IterateBetweenPositions(topLeft, downRight, function(context)
		local pos = context.pos
		local revealGround = Game.createItem(410, 1, pos)
		revealGround:setActionId(Storage.DesertQuestTwo.Puzzles.MazeReveal)
	end)
end

local revealRadius = 2

local function revealInRadius(playerPos, radius)
	local topLeft = playerPos:Moved(-radius, -radius, -1)
	local downRight = playerPos:Moved(radius, radius, -1)
	IterateBetweenPositions(topLeft, downRight, function(context)
		local wallPos = context.pos
		local tile = Tile(wallPos)
		if not tile then
			return
		end
		local wall = tile:getItemById(wallId)
		if not wall then
			return
		end
		local revealPos = wallPos:Moved(0, 0, 2)
		revealPos:sendMagicEffect(CONST_ME_TUTORIALSQUARE)
	end)
end

local reveal = MoveEvent()
function reveal.onStepIn(creature, item, _, _)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	revealInRadius(player:getPosition(), revealRadius)
	return false
end

reveal:type("stepin")
reveal:aid(Storage.DesertQuestTwo.Puzzles.MazeReveal)
reveal:register()

local blockageId = 1791
local stoneRemovePos1 = DESERT_QUEST_TWO_ANCHOR:Moved(-2, -3, 2)
local stoneRemovePos2 = stoneRemovePos1:Moved(32, 0, 0)
function InitializeDQ2Labryrinth()
	generateLabyrinthTable()
	clearLabyrinthItems()
	generateLabyrinthItems()
	clearEntranceItems()
	generateRevealTiles()
	for _, pos in pairs({ stoneRemovePos1, stoneRemovePos2 }) do
		local ground = Game.createItem(431, 1, pos)
		ground:setActionId(Storage.DesertQuestTwo.Puzzles.MazeStoneRemove)
	end
end
local stoneRemove = MoveEvent()
function stoneRemove.onStepIn(creature, item, toPosition, _)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	local player1 = GetTopCreature(stoneRemovePos1)
	local player2 = GetTopCreature(stoneRemovePos2)
	if not (player1 and player2) then
		return
	end

	local stone1 = Tile(stoneRemovePos1:Moved(0, -1, 1)):getItemById(blockageId)
	local stone2 = Tile(stoneRemovePos1:Moved(0, -1, 2)):getItemById(blockageId)
	--local stone3 = Tile(standingTilePos1:Moved(0, -1, 0)):getItemById(blockageId)
	--local stone4 = Tile(standingTilePos1:Moved(32, -1, 0)):getItemById(blockageId)
	if not (stone1 and stone2) then
		return
	end
	toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)

	local stones = { stone1, stone2, stone3, stone4 }
	for _, stone in pairs(stones) do
		stone:moveTo(stone:getPosition():Moved(-1, 0, 0))
	end

	addEvent(function()
		for _, stone in pairs(stones) do
			stone:moveTo(stone:getPosition():Moved(1, 0, 0))
		end
	end, 60 * 1000)

	return false
end

stoneRemove:type("stepin")
stoneRemove:aid(Storage.DesertQuestTwo.Puzzles.MazeStoneRemove)
stoneRemove:register()
