--[[
	local player1centerPos = Position(1434, 1319, 8)
local player2centerPos = Position(1443, 1319, 8)

local MINIMUM_ARROW_SPAWNING_DELAY = 500

local BASE_ARROW_SPAWNING_DELAY = 1245
local BASE_ARROW_MOVE_TIME = 500

local ARROW_SPAWNING_MOVE_TIME_DECREMENT = 1
local ARROW_SPAWNING_DELAY_DECREMENT = 10
assert((BASE_ARROW_SPAWNING_DELAY - MINIMUM_ARROW_SPAWNING_DELAY) / ARROW_SPAWNING_DELAY_DECREMENT < (BASE_ARROW_MOVE_TIME / ARROW_SPAWNING_MOVE_TIME_DECREMENT))

local currentArrowSpawningDelay = 1245
local currentArrowMoveTime = 200

local player1score = 0
local player2score = 0

local baseArrow = {
	speed = nil,
	startPos = nil,
	id = nil,
	monsterObject = nil,
}

local colorToId = {
	["YELLOW"] = 2650,
	["RED"] = 2656,
	["WHITE"] = 2667,
	["BLUE"] = 2659,
}

local colorToPos = {
	["YELLOW"] = Position(1437, 1326, 8),
	["RED"] = Position(1438, 1326, 8),
	["WHITE"] = Position(1439, 1326, 8),
	["BLUE"] = Position(1440, 1326, 8),
}

local moveDirToX = {
	[3] = 2023,
	[0] = 2022,
	[1] = 2020,
	[2] = 2021,
}

local colorsBag = {}

local function initializeColorsBag(bag)
	bag = {
		"YELLOW",
		"YELLOW",
		"YELLOW",
		"RED",
		"RED",
		"RED",
		"WHITE",
		"WHITE",
		"WHITE",
		"BLUE",
		"BLUE",
		"BLUE",
	}
	return bag
end

local function tryInitializeColorsBag(bag)
	if #bag == 0 then
		bag = initializeColorsBag(bag)
	end
	return bag
end

local function pickRandomColor(bag)
	local random = math.random(1, #bag)
	local color = bag[random]
	bag[random] = bag[#bag]
	bag[#bag] = nil
	return color
end

local function arrowIsOnLastTile(arrow)
	local pos = arrow.monsterObject:getPosition()
	if pos.y <= 1316 then
		return true
	end
	return false
end

local function moveArrow(arrow)
	if arrowIsOnLastTile(arrow) then
		arrow.monsterObject:remove()
		arrow = nil
		return
	end

	local pos = arrow.monsterObject:getPosition()
	pos.y = pos.y - 1
	arrow.monsterObject:teleportTo(pos)

	addEvent(function()
		moveArrow(arrow)
	end, currentArrowMoveTime)
end

local function spawnArrow()
	local arrow = Deepcopied(baseArrow)
	local color = pickRandomColor(colorsBag)
	arrow.id = colorToId[color]
	arrow.startPos = colorToPos[color]

	local monsterObject = Game.createMonster("Rat", arrow.startPos, false, true)
	monsterObject:changeSpeed(currentArrowMoveTime)
	arrow.monsterObject = monsterObject

	moveArrow(arrow)
end

local function canStartGame()
	local player1 = Tile(player1centerPos):getTopCreature()
	local player2 = Tile(player2centerPos):getTopCreature()
	return true
	--return (player1 and player2)
end
local function gameCanContinue()
	if currentArrowSpawningDelay <= MINIMUM_ARROW_SPAWNING_DELAY then
		return false
	end

	return true
end

local function startGame()
	if not gameCanContinue() then
		return false --tie
	end
	colorsBag = tryInitializeColorsBag(colorsBag)
	currentArrowSpawningDelay = currentArrowSpawningDelay - ARROW_SPAWNING_DELAY_DECREMENT
	currentArrowMoveTime = currentArrowMoveTime - ARROW_SPAWNING_MOVE_TIME_DECREMENT
	spawnArrow()
	addEvent(function()
		startGame()
	end, currentArrowSpawningDelay)
end

local function playerPressedCorrectly(x)
	local y = 1318
	local tile = Tile(x, y, 8)
	local creature = tile:getTopCreature()

	if creature then
		return true
	else
		return false
	end
end

local function tryGetScore(playerScore, fromPos, toPos)
	local moveDir = GetMoveDirection(fromPos, toPos)
	local x = moveDirToX[moveDir]
	if playerPressedCorrectly(x) then
		playerScore = playerScore + 1
		Position(x, 1318, 8):sendMagicEffect(CONST_ME_CAKE)
	else
		playerScore = playerScore - 1
		Position(fromPos):sendMagicEffect(CONST_ME_CAKE)
	end
	return playerScore
end

local tile = MoveEvent()
function tile.onStepIn(creature, _, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	player1score = tryGetScore(player1score, fromPosition, toPosition)
	player:teleportTo(fromPosition)
	return true
end

tile:aid(8720)
tile:type("stepin")
tile:register()

local tile = MoveEvent()
function tile.onStepIn(creature, _, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	player2score = tryGetScore(player2score, fromPosition, toPosition)
	player:teleportTo(fromPosition)
	return true
end

tile:aid(8721)
tile:type("stepin")
tile:register()

local lever = Action()
function lever.onUse(creature, item, _, _, _, _)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	if not canStartGame() then
		return true
	end
	startGame()
end

lever:aid(8727)
lever:register()

]]
