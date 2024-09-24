local stopid = { [6594] = true, [799] = true, [431] = true, [430] = true }

local corner1 = DESERT_QUEST_ONE_ANCHOR:Moved(-42, 46, 2)
local corner2 = DESERT_QUEST_ONE_ANCHOR:Moved(-1, 73, 3)

local iceId = { [800] = true, [6967] = true, [6683] = true, [6684] = true, [6685] = true, [6686] = true }
function LoadDesertQuestIceSkating()
	IterateBetweenPositions(corner1, corner2, function(context)
		local tile = Tile(context.pos)
		if not tile then
			return
		end
		local ground = tile:getGround()
		if not ground then
			return
		end

		local groundId = ground:getId()
		if iceId[groundId] then
			ground:setActionId(Storage.DesertQuestOne.Puzzles.SkatingPuzzle.IceTile)
		end
		if stopid[groundId] then
			ground:setActionId(Storage.DesertQuestOne.Puzzles.SkatingPuzzle.StopTile)
		end
	end)
end

local function isDirLegal(dir)
	return 0 <= dir and dir <= 3
end

local function isNextPosWalkable(nextPos)
	local groundId = Tile(nextPos):getGround():getId()
	return stopid[groundId] or iceId[groundId]
end

local function icyRelocate(player, fromPosition, toPos)
	local playerMoveDir = fromPosition:DirectionTo(toPos)

	if not isDirLegal(playerMoveDir) then
		player:teleportTo(fromPosition)
		return
	end

	local offset = Vector.FromDirection(playerMoveDir)
	local nextPos = toPos:Moved(offset)

	if not isNextPosWalkable(nextPos) then
		return false
	end
	addEvent(function()
		player:teleportTo(nextPos)
	end, 10)
end

local function snowyRelocate(player, fromPosition, dir)
	if not isDirLegal(dir) then
		player:teleportTo(fromPosition)
	end
end

local stopTile = MoveEvent()

function stopTile.onStepIn(creature, _, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	local playerMoveDir = fromPosition:DirectionTo(toPosition)

	snowyRelocate(player, fromPosition, playerMoveDir)
	return true
end

stopTile:aid(Storage.DesertQuestOne.Puzzles.SkatingPuzzle.StopTile)
stopTile:type("stepin")
stopTile:register()

local iceTile = MoveEvent()

function iceTile.onStepIn(creature, _, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	icyRelocate(player, fromPosition, toPosition)
	return true
end

iceTile:aid(Storage.DesertQuestOne.Puzzles.SkatingPuzzle.IceTile)
iceTile:type("stepin")
iceTile:register()
