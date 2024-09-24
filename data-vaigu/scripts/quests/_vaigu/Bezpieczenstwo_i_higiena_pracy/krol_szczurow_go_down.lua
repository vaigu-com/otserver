	:Script(function(storageToRequiredState)
local tileIn = MoveEvent()

function tileIn.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end

	local storageVal = player:getStorageValue(Storage.SafetyAndOccupationalHygiene.Questline)

	if storageVal < 11 then
		return false
	end

	if storageVal > 15 then
		return false
	end

	local toPos = fromPosition:Moved(-1, -1, 1)
	player:teleportTo(toPos)
end

tileIn:aid(Storage.SafetyAndOccupationalHygiene.KrolTile)
tileIn:register()
end)
