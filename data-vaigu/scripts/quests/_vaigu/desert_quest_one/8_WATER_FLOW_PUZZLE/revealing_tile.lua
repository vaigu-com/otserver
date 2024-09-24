	:Script(function(storageToRequiredState)
local function tryPunishCheeser(pos, cheeser)
	local playersPositions = { pos:Moved(0, 2, 0), pos:Moved(0, -2, 0) }
	local penaltyRoomPos = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_PORTALS[Storage.DesertQuestOne.Portals.PenaltyRoom3])
	for _, cheeserPos in pairs(playersPositions) do
		local innocentPlayer = cheeserPos:GetTopCreature()
		if innocentPlayer and innocentPlayer:isPlayer() then
			cheeser:teleportTo(penaltyRoomPos)
			return
		end
	end
end

local function isTileArrayFixed()
	local _, table = next(DESERT_QUEST_ONE_WATER_FLOW.idToRevealedPositions, nil)
	return #table ~= 0
end
function FixRevealingTileArrays()
	if isTileArrayFixed() then
		return
	end
	IterateBetweenPositions(DESERT_QUEST_ONE_WATER_FLOW.tileArrayTopLeft, DESERT_QUEST_ONE_WATER_FLOW.tileArrayDownRight, function(context)
		local pos = context.pos
		local tile = Tile(pos)
		if not tile then
			return
		end
		local ground = tile:getGround()
		if not ground then
			return
		end
		local groundId = ground:getId()
		if DESERT_QUEST_ONE_WATER_FLOW.idToRevealedPositions[groundId] then
			table.insert(DESERT_QUEST_ONE_WATER_FLOW.idToRevealedPositions[groundId], pos)
		end
	end)
end

local revealTiles = MoveEvent()

function revealTiles.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local groundId = item:getId()
	local revealedPositions = DESERT_QUEST_ONE_WATER_FLOW.idToRevealedPositions[groundId]
	if not revealedPositions then
		return false
	end

	for _, pos in pairs(revealedPositions) do
		local blockage = Tile(pos):getItemById(groundId)
		if blockage then
			blockage:transform(DESERT_QUEST_ONE_WATER_FLOW.dry_id)
		end
	end
	tryPunishCheeser(toPosition, creature)
end

revealTiles:aid(Storage.DesertQuestOne.Puzzles.WaterFlowPuzzle.RevealingTile)
revealTiles:type("stepin")
revealTiles:register()

local vanisherOut = MoveEvent()

function vanisherOut.onStepOut(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local groundId = item:getId()
	local revealedPositions = DESERT_QUEST_ONE_WATER_FLOW.idToRevealedPositions[groundId]
	if not revealedPositions then
		return false
	end
	for _, pos in pairs(revealedPositions) do
		local dry = Tile(pos):getItemById(DESERT_QUEST_ONE_WATER_FLOW.dry_id)
		if dry then
			dry:transform(groundId)
		end
	end
end

vanisherOut:aid(Storage.DesertQuestOne.Puzzles.WaterFlowPuzzle.RevealingTile)
vanisherOut:type("stepout")
vanisherOut:register()

FixRevealingTileArrays()
end)
