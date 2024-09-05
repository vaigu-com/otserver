local tileIn = MoveEvent()

function tileIn.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end

	local storageVal = player:getStorageValue(Storage.BezpieczenstwoIHigienaPracy.Questline)

	if storageVal < 10 then
		return false
	end

	if storageVal > 14 then
		return false
	end

	local toPos = fromPosition:Moved(-1, -1, 1)
	player:teleportTo(toPos)
end

tileIn:aid(Storage.BezpieczenstwoIHigienaPracy.KrolTile)
tileIn:register()
