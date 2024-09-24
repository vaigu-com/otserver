local doors = {
	{ pos = Position(SCIEZKA_NIEUMARLYCH_ANCHOR:Moved({ x = -8, y = 12, z = 1 })), id = 1564 },
	{ pos = Position(SCIEZKA_NIEUMARLYCH_ANCHOR:Moved({ x = -9, y = 12, z = 1 })), id = 1563 },
}

local function eachTileHasItem(top_left, down_right, id, anchor)
	if anchor then
		top_left = anchor:Moved(top_left)
		down_right = anchor:Moved(down_right)
	end

	for i = top_left.x, down_right.x do
		for j = top_left.y, down_right.y do
			local pos = Position(i, j, top_left.z)
			if not pos:hasItem(id) then
				return false
			end
		end
	end
	return true
end

local beforeGate = MoveEvent()

function beforeGate.onStepIn(player, item, toPosition, fromPosition)
	if not player:isPlayer() then
		return false
	end
	if not eachTileHasItem(Vector(-12, 15, 1), Vector(-10, 15, 1), 12952, SCIEZKA_NIEUMARLYCH_ANCHOR) then
		return false
	end
	for _, door in pairs(doors) do
		local pos = door.pos
		local id = door.id
		local tile = Tile(pos)
		if tile:getItemById(id) then
			tile:getItemById(id):remove()
			pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
		end
	end
	player:setStorageValue(Storage.PathOfTheUndead.SkipDoor, 1)
end

beforeGate:aid(Storage.PathOfTheUndead.GuardianGateTile)
beforeGate:type("stepin")
beforeGate:register()
