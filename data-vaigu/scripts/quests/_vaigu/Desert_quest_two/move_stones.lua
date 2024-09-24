	:Script(function(storageToRequiredState)
local orbId = 3064

local function canMoveOrb(pos)
	local tile = Tile(pos)
	if not tile then
		return false
	end
	local orb = tile:getItemById(orbId)
	if orb then
		return false
	end
	if not pos:IsPathable() then
		return false
	end

	return true
end

local function tryMoveOrb(fromPosition, toPosition)
	if IsMoveDiagonal(fromPosition, toPosition) then
		return
	end
	local direction = fromPosition:DirectionTo(toPosition)
	local offset = Vector.FromDirection(direction):Scaled(2)
	local orbPos = toPosition
	local newOrbPos = fromPosition:Moved(offset)
	fromPosition:sendMagicEffect(CONST_ME_POFF)
	if canMoveOrb(newOrbPos) then
		local orb = Tile(orbPos):getItemById(orbId)
		orb:moveTo(newOrbPos)
	end
end

local initTopleft = DESERT_QUEST_TWO_ANCHOR:Moved(-23, -63, 0)
local initDownRight = DESERT_QUEST_TWO_ANCHOR:Moved(-1, -51, 0)
local resetPlayersTo = DESERT_QUEST_TWO_ANCHOR:Moved(-3, -48, -2)

function InitializeDQ2orbs()
	IterateBetweenPositions(initTopleft, initDownRight, function(context)
		local initPos = context.pos
		local visiblePos = initPos:Moved(0, 0, -1)
		local player = visiblePos:GetTopCreature()
		if player then
			player:teleportTo(resetPlayersTo, true)
		end
		local visibleTile = Tile(visiblePos)
		if not visibleTile then
			return
		end
		local ground = visibleTile:getGround()
		if ground then
			ground:setActionId(Storage.SpecialStepins.DontAllowDiagonal)
		end
		local previousStone = Tile(visiblePos):getItemById(orbId)
		if previousStone then
			previousStone:remove()
		end
		local initialStone = Tile(initPos):getItemById(orbId)
		if initialStone then
			local stone = Game.createItem(orbId, 1, initPos:Moved(0, 0, -1))
			stone:setActionId(Storage.DesertQuestTwo.Puzzles.OrbsMove)
		end
	end)
end

local moveOrb = MoveEvent()
function moveOrb.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end
	player:teleportTo(fromPosition)
	tryMoveOrb(fromPosition, toPosition)
	return false
end
moveOrb:type("stepin")
moveOrb:aid(Storage.DesertQuestTwo.Puzzles.OrbsMove)
moveOrb:register()

local resetOrbs = Action()
function resetOrbs.onUse(creature, item, fromPosition, target, toPosition, isHotkey)
	local player = creature:getPlayer()
	if not player then
		return false
	end
	InitializeDQ2orbs()
	return true
end
resetOrbs:aid(Storage.DesertQuestTwo.Puzzles.OrbsReset)
resetOrbs:register()
end)
