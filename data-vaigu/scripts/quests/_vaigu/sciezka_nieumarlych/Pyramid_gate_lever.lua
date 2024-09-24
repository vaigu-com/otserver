	:Script(function(storageToRequiredState)
local gatePositions = {
	{ x = -12, y = 37, z = -2 },
	{ x = -11, y = 37, z = -2 },
}
local gateId = 2182

local lever = Action()

function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	for _, relativePos in pairs(gatePositions) do
		local pos = Position(SCIEZKA_NIEUMARLYCH_ANCHOR:Moved(relativePos))
		local tile = Tile(pos)
		local gate = tile:getItemById(gateId)
		if gate then
			gate:remove()
		else
			Game.createItem(gateId, 1, pos)
		end
		toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
	end
	return true
end

lever:aid(Storage.PathOfTheUndead.UpperLever)
lever:register()
end)
