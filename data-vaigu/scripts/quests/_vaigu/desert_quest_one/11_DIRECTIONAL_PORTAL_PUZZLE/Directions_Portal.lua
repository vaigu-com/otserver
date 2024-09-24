	:Script(function(storageToRequiredState)
local N = NORTH
local W = WEST
local E = EAST
local S = SOUTH

local progressStorage = Storage.DesertQuestOne.DirectionalPortal
local labyrinthCenter = DESERT_QUEST_ONE_ANCHOR:Moved({ x = -115, y = 138, z = 2 })
local COMBINATION = { E, N, W, N, W, S, W, S, E, S, E }

local function progressFinalLabyrinth(player, currentProgress)
	player:setStorageValue(progressStorage, currentProgress + 1)
	player:getPosition():sendMagicEffect(CONST_ME_HOLYDAMAGE)
end

local function resetProgress(player)
	player:setStorageValue(progressStorage, 1)
end

local function tryFixProgress(player)
	local currentProgess = player:getStorageValue(progressStorage)
	if currentProgess < 1 then
		resetProgress(player)
	end
end

local function playerCompletedQuest(player)
	if player:getStorageValue(Storage.DesertQuestOne.Questline) > TableSize(Storage.DesertQuestOne.QuestState) then
		return true
	end
end

local tile = MoveEvent()

function tile.onStepIn(creature, tileItem, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if playerCompletedQuest(player) then
		return
	end
	tryFixProgress(player)

	local playerMoveDir = fromPosition:DirectionTo(toPosition)
	local currentProgress = player:getStorageValue(progressStorage)
	if currentProgress > #COMBINATION then
		TryProgressDesertQuest(player, Storage.DesertQuestOne.QuestState.q12)
		return true
	end

	if playerMoveDir == COMBINATION[currentProgress] then
		progressFinalLabyrinth(player, currentProgress)
	else
		player:getPosition():sendMagicEffect(CONST_ME_DIVINE_DAZZLE)
		resetProgress(player)
	end

	player:teleportTo(labyrinthCenter, true)
	return true
end

tile:aid(Storage.DesertQuestOne.Puzzles.DirectionalPortalPuzzle.Tile)
tile:type("stepin")
tile:register()
end)
