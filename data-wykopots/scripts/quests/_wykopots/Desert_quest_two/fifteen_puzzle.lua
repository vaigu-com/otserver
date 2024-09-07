local puzzleTopLeft = DESERT_QUEST_TWO_ANCHOR:Moved(1, 0, 0)
local puzzleDownRight = puzzleTopLeft:Moved(3, 3, 0)
local emptySpacePos = Position(puzzleTopLeft)

local pieceIds = {}

local function moveFifteenPuzzleElement(direction, toPosition)
	local nextPiecePos = emptySpacePos:Moved(Vector.FromDirection(direction))
	local piece = nextPiecePos:GetTopItem()
	if not piece then
		return
	end
	if not pieceIds[piece:getId()] then
		return
	end
	piece:moveTo(emptySpacePos)
	emptySpacePos = nextPiecePos
	emptySpacePos:sendMagicEffect(CONST_ME_POFF)
	if toPosition then
		toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
	end
end

local function scramblePuzzle()
	for _ = 1, 300 do
		moveFifteenPuzzleElement(math.random(0, 3))
	end
end

function InitializeDQ2FifteenPuzzle()
	emptySpacePos = Position(puzzleTopLeft)
	IterateBetweenPositions(puzzleTopLeft, puzzleDownRight, function(context)
		local toPos = context.pos
		local fromPos = toPos:Moved(7, -1, 0)
		local copyItem = fromPos:GetTopItem()
		if not copyItem then
			return
		end
		local copyId = copyItem:getId()
		if ItemType(copyId):isMovable() then
			return
		end
		pieceIds[copyId] = true
		Game.createItem(copyId, 1, toPos)
	end)
	scramblePuzzle()
end

local moveTile = MoveEvent()
function moveTile.onStepOut(creature, _, _, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local toPosition = creature:getPosition()
	if IsMoveDiagonal(fromPosition, toPosition) then
		return true
	end
	creature:teleportTo(fromPosition)
	local reverseDirection = toPosition:DirectionTo(fromPosition)
	moveFifteenPuzzleElement(reverseDirection, toPosition)
	return true
end

moveTile:aid(Storage.DesertQuestTwo.Puzzles.FiftenPuzzleMove)
moveTile:type("stepout")
moveTile:register()

local function puzzleIsComplete()
	local result = IterateBetweenPositions(puzzleTopLeft, puzzleDownRight, function(context)
		local toPos = context.pos
		local fromPos = toPos:Moved(7, -1, 0)
		local toItem = toPos:GetTopItem()
		local fromitem = fromPos:GetTopItem()
		if not (toItem and fromitem) then
			return
		end
		return toItem:getId() == fromitem:getId()
	end, { stopCondition = STOP_CONDITIONS.isFalse })
	return result
end

local resetLever = Action()
function resetLever.onUse(creature, item, _, _, _, _)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	if chestSpawned then
		return
	end
	if puzzleIsComplete() then
		TrySpawnDQ2progressChest("FifteenPuzzle")
	end
	scramblePuzzle()
	return false
end

resetLever:aid(Storage.DesertQuestTwo.Puzzles.FiftenPuzzleLever)
resetLever:register()
