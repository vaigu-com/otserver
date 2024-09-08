local identifierToConfig = {}

local defaultCurrentColor = "White"

local boardPositions = {
	topLeft = CHESS_ANCHOR,
	downRight = CHESS_ANCHOR:Moved(7, 7, 0),
}

local legalGround = {
	[410] = true,
	[409] = true,
}

local function getIdentifierByPos(pos)
	local lever = Tile(pos):getItemById(2772)
	if lever then
		return pos:ToString()
	end
	local tempPos = Position(pos)
	for _ = 1, 8 do
		tempPos = tempPos:Moved(0, -1, 0)
		local groundId = Tile(tempPos):getGround():getId()
		if not legalGround[groundId] then
			tempPos = tempPos:Moved(0, 1, 0)
			goto foundYborder
		end
	end
	::foundYborder::
	for _ = 1, 8 do
		tempPos = tempPos:Moved(-1, 0, 0)
		local groundId = Tile(tempPos):getGround():getId()
		if not legalGround[groundId] then
			tempPos = tempPos:Moved(1, 0, 0)
			goto foundXborder
		end
	end
	::foundXborder::

	local leverPos = tempPos:Moved(2, -2, 0)
	return leverPos:ToString()
end

local kingMoved = {
	["white"] = false,
	["black"] = false,
}

local blackPieceIdToName = {
	[3533] = "enPassantProxy",
	[3541] = "pawn",
	[3542] = "rook",
	[3543] = "knight",
	[3544] = "bishop",
	[3545] = "queen",
	[3546] = "king",
}

local whitePieceIdToName = {
	[3534] = "enPassantProxy",
	[3535] = "pawn",
	[3536] = "rook",
	[3537] = "knight",
	[3538] = "bishop",
	[3539] = "queen",
	[3540] = "king",
}

local colorToEnPassantId = {
	["White"] = 3534, -- white
	["Black"] = 3533, -- black
}

local function getColorById(id)
	if whitePieceIdToName[id] then
		return "white"
	end
	if blackPieceIdToName[id] then
		return "black"
	end
end

local function isPiece(id)
	return blackPieceIdToName[id] ~= nil or whitePieceIdToName[id] ~= nil
end

local function hasChessPiece(toPos)
	local item = toPos:GetTopItem()
	if not item then
		return false
	end
	local id = item:getId()
	return blackPieceIdToName[id] or whitePieceIdToName[id]
end

local function haveSameColours(id1, id2)
	if whitePieceIdToName[id1] and whitePieceIdToName[id2] then
		return true
	end
	if blackPieceIdToName[id1] and blackPieceIdToName[id2] then
		return true
	end
end

local function boolToNumber(bool)
	if bool then
		return 1
	end
	return 0
end

local function isItemOnBorder(item, id)
	local itemPosY = item:getPosition().y
	local topDistance = math.abs(identifierToConfig[id].topLeft.y - itemPosY)
	local downDistance = math.abs(identifierToConfig[id].downRight.y - itemPosY)

	return topDistance <= 0 or downDistance <= 0
end

local function isRookOnCastlingPosition(kingId, rookpos)
	local kingColor = getColorById(kingId)
	local piece = Position(rookpos.x, rookpos.y, rookpos.z):GetTopItem()

	if piece then
		local pieceId = piece:getId()
		if (kingColor == "white" and whitePieceIdToName[pieceId] == "rook") or (kingColor == "black" and blackPieceIdToName[pieceId] == "rook") then
			return true
		end
	end
	return false
end

local function safeRelocate(item, toPosition)
	if not item then
		return nil
	end

	local id = item:getId()
	local aid = item:getActionId()

	item:remove()
	local newItem = Game.createItem(id, 1, toPosition)
	newItem:setActionId(aid)
end

local function isPawnColorDirectionLegal(moveDir, pieceId)
	if whitePieceIdToName[pieceId] then
		if moveDir == DIRECTION_NORTHEAST or moveDir == DIRECTION_NORTHWEST then
			return true
		end
		if moveDir == DIRECTION_NORTH then
			return true
		end
	elseif blackPieceIdToName[pieceId] then
		if moveDir == DIRECTION_SOUTHEAST or moveDir == DIRECTION_SOUTHWEST then
			return true
		end
		if moveDir == DIRECTION_SOUTH then
			return true
		end
	end
end

local function isPawnMoveLegal(fromPosition, toPosition, pieceId)
	local moveDir = fromPosition:DirectionTo(toPosition)
	if not isPawnColorDirectionLegal(moveDir, pieceId) then
		return false
	end
	if IsMoveDiagonal(fromPosition, toPosition) and not hasChessPiece(toPosition) then
		return false
	end
	if not IsMoveDiagonal(fromPosition, toPosition) and hasChessPiece(toPosition) then
		return false
	end
	return true
end

local function createEnPassant(pos, victimColor, id)
	local piece = Game.createItem(colorToEnPassantId[victimColor], 1, pos)
	piece:setActionId(Storage.DesertQuestTwo.Puzzles.Chess.Piece)
	piece:setUniqueId(1000)
	identifierToConfig[id].enPassantPiece = piece
end

local function posHasPlayingPiece(pos)
	local item = pos:GetTopItem()
	if item and isPiece(item:getId()) then
		return true
	end
	return false
end

local function isOnHorizontalEdge(position, leeway)
	leeway = leeway or 1
	local groundId1 = Tile(position:Moved(0, leeway, 0)):getGround():getId()
	local groundId2 = Tile(position:Moved(0, -leeway, 0)):getGround():getId()
	return not (legalGround[groundId1] and legalGround[groundId2])
end

local nameToIllegalityCheck = {
	["pawn"] = function(fromPosition, toPosition, pieceId, id)
		local dy = fromPosition.y - toPosition.y
		local dx = fromPosition.x - toPosition.x
		if math.abs(dy) > 2 or math.abs(dx) > 1 then
			return true
		end
		if math.abs(dy) * math.abs(dx) > 1 then
			return true
		end
		if math.abs(dy) == 2 and not (isOnHorizontalEdge(fromPosition, 1) or isOnHorizontalEdge(fromPosition, 2)) then
			return true
		end
		if math.abs(dy) == 2 and hasChessPiece(toPosition) then
			return true
		end
		local midPos = Position(fromPosition.x, (fromPosition.y + toPosition.y) / 2, fromPosition.z)
		if math.abs(dy) == 2 and hasChessPiece(midPos) then
			return true
		end
		if not isPawnMoveLegal(fromPosition, toPosition, pieceId) then
			return true
		end
		if math.abs(dy) == 2 then
			identifierToConfig[id].enPassantFlag = true
			identifierToConfig[id].enPassantPos = midPos
		end
		return false
	end,
	["bishop"] = function(fromPosition, toPosition)
		local dx = math.abs(fromPosition.x - toPosition.x)
		local dy = math.abs(fromPosition.y - toPosition.y)
		if dx ~= dy then
			return true
		end
		local iterationSignX = 1
		local iterationSignY = 1
		if fromPosition.x > toPosition.x then
			iterationSignX = -1
		end
		if fromPosition.y > toPosition.y then
			iterationSignY = -1
		end
		local noChecks = math.abs(fromPosition.x - toPosition.x) - 1
		for i = 0, noChecks do
			local currentX = fromPosition.x + i * iterationSignX
			local currentY = fromPosition.y + i * iterationSignY
			local currentPos = Position(currentX, currentY, toPosition.z)

			if posHasPlayingPiece(currentPos) then
				return true
			end
		end
		return false
	end,
	["queen"] = function(fromPosition, toPosition)
		local dx = math.abs(fromPosition.x - toPosition.x)
		local dy = math.abs(fromPosition.y - toPosition.y)
		if dx ~= dy and dx ~= 0 and dy ~= 0 then
			return true
		end

		local verticalOnly = boolToNumber(fromPosition.x == toPosition.x)
		local horizontalOnly = boolToNumber(fromPosition.y == toPosition.y)
		local iterationSignX = 1
		local iterationSignY = 1
		if fromPosition.x > toPosition.x then
			iterationSignX = -1
		end
		if fromPosition.y > toPosition.y then
			iterationSignY = -1
		end

		local noChecksY = math.abs(fromPosition.y - toPosition.y) - 1
		local noChecksX = math.abs(fromPosition.x - toPosition.x) - 1
		local noChecks = noChecksX
		if noChecksY > noChecksX then
			noChecks = noChecksY
		end

		for i = 0, noChecks do
			local currentX = fromPosition.x + i * iterationSignX * (1 - verticalOnly)
			local currentY = fromPosition.y + i * iterationSignY * (1 - horizontalOnly)
			local currentPos = Position(currentX, currentY, toPosition.z)

			if posHasPlayingPiece(currentPos) then
				return true
			end
		end
		return false
	end,
	["rook"] = function(fromPosition, toPosition)
		local dx = math.abs(fromPosition.x - toPosition.x)
		local dy = math.abs(fromPosition.y - toPosition.y)
		if (dx ~= 0) and (dy ~= 0) then
			return true
		end

		local verticalOnly = boolToNumber(fromPosition.x == toPosition.x)
		local horizontalOnly = boolToNumber(fromPosition.y == toPosition.y)
		local iterationSignX = 1
		local iterationSignY = 1
		if fromPosition.x > toPosition.x then
			iterationSignX = -1
		end
		if fromPosition.y > toPosition.y then
			iterationSignY = -1
		end

		local noChecksY = math.abs(fromPosition.y - toPosition.y) - 1
		local noChecksX = math.abs(fromPosition.x - toPosition.x) - 1
		local noChecks = noChecksX
		if noChecksY > noChecksX then
			noChecks = noChecksY
		end

		for i = 0, noChecks do
			local currentX = fromPosition.x + i * iterationSignX * (1 - verticalOnly)
			local currentY = fromPosition.y + i * iterationSignY * (1 - horizontalOnly)
			local currentPos = Position(currentX, currentY, toPosition.z)

			if posHasPlayingPiece(currentPos) then
				return true
			end
		end
		return false
	end,
	["knight"] = function(fromPosition, toPosition)
		local dx = fromPosition.x - toPosition.x
		local dy = fromPosition.y - toPosition.y
		if math.abs(dx) == 2 and math.abs(dy) == 1 then
			return false
		end
		if math.abs(dx) == 1 and math.abs(dy) == 2 then
			return false
		end
		return true
	end,
	["king"] = function(fromPosition, toPosition, id)
		local dx = fromPosition.x - toPosition.x
		local dy = fromPosition.y - toPosition.y
		local kingColor = getColorById(id)
		if math.abs(dx) > 2 or math.abs(dy) > 2 then
			return true
		end
		if math.abs(dx) <= 1 and math.abs(dy) <= 1 then
			kingMoved[kingColor] = true
			return false
		end
		if (math.abs(dx) == 0 or math.abs(dx) == 1) and math.abs(dy) > 1 then
			return true
		end
		if math.abs(dx) == 2 then --castling
			if dy ~= 0 then
				return true
			end
			if kingMoved[kingColor] then
				return true
			end
			if dx < 0 then --right direction
				for i = fromPosition.x + 1, fromPosition.x + 2 do
					if hasChessPiece(Position(i, fromPosition.y, fromPosition.z)) then
						return true
					end
				end
				if not isRookOnCastlingPosition(id, Position(fromPosition.x + 3, fromPosition.y, fromPosition.z)) then
					return true
				end
				local rook = Position(fromPosition.x + 3, fromPosition.y, fromPosition.z):GetTopItem()
				safeRelocate(rook, fromPosition:Moved(1, 0, 0))
			end
			if dx > 0 then --left direction
				for i = fromPosition.x - 3, fromPosition.x - 1 do
					if hasChessPiece(Position(i, fromPosition.y, fromPosition.z)) then
						return true
					end
				end
				if not isRookOnCastlingPosition(id, Position(fromPosition.x - 4, fromPosition.y, fromPosition.z)) then
					return true
				end
				local rook = Position(fromPosition.x - 4, fromPosition.y, fromPosition.z):GetTopItem()
				safeRelocate(rook, fromPosition:Moved(-1, 0, 0))
			end
			kingMoved[kingColor] = true
			return false
		end
	end,
}

local function isPieceBeyondBoard(toPosition)
	local groundId = Tile(toPosition):getGround():getId()
	return not legalGround[groundId]
end

local function pieceMovingOnItsTurn(id, pieceId)
	if identifierToConfig[id].currentColorTurn == "Black" and blackPieceIdToName[pieceId] then
		return true
	end
	if identifierToConfig[id].currentColorTurn == "White" and whitePieceIdToName[pieceId] then
		return true
	end
	return false
end

local function isMoveIllegal(piece, fromPosition, toPosition, id)
	local pieceId = piece:getId()
	local toPosItem = toPosition:GetTopItem()
	if toPosItem then
		if haveSameColours(pieceId, toPosItem:getId()) then
			return true
		end
	end

	local beyond = isPieceBeyondBoard(toPosition)
	if beyond then
		return true
	end
	if not pieceMovingOnItsTurn(id, pieceId) then
		return true
	end
	local pieceName = whitePieceIdToName[pieceId] or blackPieceIdToName[pieceId]
	if nameToIllegalityCheck[pieceName] == nil then
		return true
	end
	if nameToIllegalityCheck[pieceName](fromPosition, toPosition, pieceId, id) then
		return true
	end

	return false
end

local function whiteWins() end

local function blackWins() end

local function tryCaptureEnPassant(toPosition, capturedId, id)
	if not identifierToConfig[id].enPassantPiece then
		return false
	end
	local enPassantId = identifierToConfig[id].enPassantPiece:getId()
	if capturedId == enPassantId then
		local victimPos
		if enPassantId == 3534 then
			victimPos = toPosition:Moved(Position(0, -1, 0))
		end
		if enPassantId == 3533 then
			victimPos = toPosition:Moved(Position(0, 1, 0))
		end
		local captureItem = victimPos:GetTopItem()
		if captureItem then
			captureItem:remove()
			victimPos:sendMagicEffect(CONST_ME_EXPLOSIONAREA)
			return true
		end
	end
	return false
end

local function tryCapturePiece(toPosition, id)
	local captureItem = toPosition:GetTopItem()
	local capturedId = 0

	if captureItem then
		capturedId = captureItem:getId()
		if isPiece(capturedId) then
			captureItem:remove()
		end
	end
	if blackPieceIdToName[capturedId] == "king" then
		whiteWins()
		identifierToConfig[id].currentColorTurn = "None"
		return
	end
	if whitePieceIdToName[capturedId] == "king" then
		identifierToConfig[id].currentColorTurn = "None"
		blackWins()
	end

	if tryCaptureEnPassant(toPosition, capturedId, id) then
		return nil
	end

	return captureItem ~= nil
end

local function initialize(usePosition)
	local copyTopLeft = usePosition:Moved(-2, 2, 1)
	local copyDownRight = copyTopLeft:Moved(7, 7, 0)

	IterateBetweenPositions(copyTopLeft, copyDownRight, function(context)
		local pos = context.pos
		local piece = pos:GetTopItem()
		if not piece then
			return
		end
		local newItem = Game.createItem(piece:getId(), 1, pos:Moved(0, 0, -1))
		newItem:setActionId(Storage.DesertQuestTwo.Puzzles.Chess.Piece)
	end)

	local item = Tile(usePosition):getItemById(2772)
	if not item then
		return
	end
	local id = usePosition:ToString()
	identifierToConfig[id] = {}
	identifierToConfig[id].currentColorTurn = defaultCurrentColor
	identifierToConfig[id].leverPos = usePosition
	identifierToConfig[id].topLeft = copyTopLeft:Moved(0, 0, -1)
	identifierToConfig[id].downRight = copyDownRight:Moved(0, 0, -1)
	identifierToConfig[id].enPassantFlag = false
	identifierToConfig[id].enPassantPos = nil
	identifierToConfig[id].enPassantPiece = nil
	identifierToConfig[id].promotionPos = nil
end

local function removePromotionLevers(startPos)
	for i = 0, 7 do
		local currentPos = startPos:Moved(0, i, 0)
		local tile = Tile(currentPos)
		if not tile then
			goto continue
		end
		local item = tile:getItemById(2773)
		if not item then
			goto continue
		end
		item:remove()
		::continue::
	end
end

local function clearBoard(id)
	if not identifierToConfig[id] then
		return
	end
	IterateBetweenPositions(identifierToConfig[id].topLeft, identifierToConfig[id].downRight, function(context)
		local pos = context.pos
		local item = pos:GetTopItem()
		if item then
			item:remove()
		end
	end)

	removePromotionLevers(identifierToConfig[id].topLeft:Moved(8, 0, 0))
end

local function tryClearEnPassant(id)
	if identifierToConfig[id].enPassantPiece then
		identifierToConfig[id].enPassantPiece:remove()
		identifierToConfig[id].enPassantPiece = nil
	end
end

local function isPawn(item)
	local id = item:getId()
	local name = whitePieceIdToName[id] or blackPieceIdToName[id]
	if name == "pawn" then
		return true
	end
	return false
end

local function isPromotionModeActive(id)
	return identifierToConfig[id].currentColorTurn == "PromotionWhite" or identifierToConfig[id].currentColorTurn == "PromotionBlack"
end

local function spawnPromotionLevers(startPos)
	for i = 0, 3 do
		local lever = Game.createItem(2773, 1, startPos:Moved(0, i, 0))
		lever:setActionId(Storage.DesertQuestTwo.Puzzles.Chess.PromoteLever)
	end
end

local function activatePromotionMode(toPosition, id)
	identifierToConfig[id].promotionPos = toPosition

	if identifierToConfig[id].currentColorTurn == "White" then
		local leverPosition = identifierToConfig[id].topLeft:Moved(8, 4, 0)
		spawnPromotionLevers(leverPosition)
	end
	if identifierToConfig[id].currentColorTurn == "Black" then
		local leverPosition = identifierToConfig[id].topLeft:Moved(8, 0, 0)
		spawnPromotionLevers(leverPosition)
	end

	identifierToConfig[id].currentColorTurn = "Promotion" .. identifierToConfig[id].currentColorTurn
end

local function clearCreateEnPassant(id)
	tryClearEnPassant(id)
	if identifierToConfig[id].enPassantFlag then
		createEnPassant(identifierToConfig[id].enPassantPos, identifierToConfig[id].currentColorTurn, id)
	end
	identifierToConfig[id].enPassantFlag = false
end

local chessPiece = MoveEvent()
function chessPiece.onRemoveItem(item, fromPosition)
	if not item then
		return
	end
	local toPosition = item:getPosition()
	local pieceId = item:getId()
	local aid = item:getActionId()
	item:remove()

	if toPosition.z == 255 then
		return false
	end

	local id = getIdentifierByPos(fromPosition)
	if isMoveIllegal(item, fromPosition, toPosition, id) or isPromotionModeActive(id) or (not isPiece(pieceId)) then
		local newItem = Game.createItem(pieceId, 1, fromPosition)
		newItem:setActionId(aid)
		--announce illegal move?
		return true
	end

	local result = tryCapturePiece(toPosition, id)
	if result == true then
		toPosition:sendMagicEffect(CONST_ME_EXPLOSIONAREA)
	elseif result == false then
		toPosition:sendMagicEffect(CONST_ME_POFF)
	end

	local newItem = Game.createItem(pieceId, 1, toPosition)
	newItem:setActionId(aid)

	clearCreateEnPassant(id)

	if isPawn(newItem) and isItemOnBorder(newItem, id) then
		activatePromotionMode(toPosition, id)
	end

	if identifierToConfig[id].currentColorTurn == "White" then
		identifierToConfig[id].currentColorTurn = "Black"
	elseif identifierToConfig[id].currentColorTurn == "Black" then
		identifierToConfig[id].currentColorTurn = "White"
	end

	return true
end

chessPiece:type("removeitem")
chessPiece:aid(Storage.DesertQuestTwo.Puzzles.Chess.Piece)
chessPiece:register()

local lever = Action()
function lever.onUse(creature, item, usePosition, _, _, _)
	local player = creature:getPlayer()
	if not player then
		return false
	end
	local id = getIdentifierByPos(usePosition)
	clearBoard(id)
	initialize(usePosition)
	return false
end

lever:aid(Storage.DesertQuestTwo.Puzzles.Chess.ClearLever)
lever:register()

local function exitPromotion(id)
	if identifierToConfig[id].currentColorTurn == "PromotionWhite" then
		identifierToConfig[id].currentColorTurn = "Black"
	end
	if identifierToConfig[id].currentColorTurn == "PromotionBlack" then
		identifierToConfig[id].currentColorTurn = "White"
	end
	removePromotionLevers(identifierToConfig[id].topLeft:Moved(8, 0, 0))
	identifierToConfig[id].promotionPos = nil
end

local promote = Action()

function promote.onUse(player, leverItem, fromPosition, target, toPosition, isHotkey)
	local newItem = leverItem:getPosition():Moved(1, 0, 0):GetTopItem()
	local id = getIdentifierByPos(fromPosition)
	local promotedItem = identifierToConfig[id].promotionPos:GetTopItem()
	if promotedItem then
		promotedItem:remove()
		local newPromotedItem = Game.createItem(newItem:getId(), 1, identifierToConfig[id].promotionPos)
		newPromotedItem:setActionId(Storage.DesertQuestTwo.Puzzles.Chess.Piece)
		identifierToConfig[id].promotionPos:sendMagicEffect(CONST_ME_CRAPS)
		exitPromotion(id)
	end
end

promote:aid(Storage.DesertQuestTwo.Puzzles.Chess.PromoteLever)
promote:register()
