local path = MoveEvent()
function path.onStepIn(player, item, toPosition, fromPosition)
	if not player:isPlayer() then
		return false
	end

	local storageVal = player:getStorageValue(Storage.AssassinsCreedSquurvaali.Mission05)
	local playerMount = player:getOutfit().lookMount
	if storageVal == 1 and playerMount == 689 then
		return true
	end

	player:teleportTo(fromPosition)
	player:getPosition():sendMagicEffect(CONST_ME_STUN)
	player:say(player:Localizer(Storage.AssassinsCreedSquurvaali.Localizer):Get("A magical force brought you back to the solid ground."), TALKTYPE_MONSTER_SAY)
	return false
end
path:aid(Storage.AssassinsCreedSquurvaali.HeavenPath)
path:register()

local lastTile = MoveEvent()
function lastTile.onStepIn(player, item, toPosition, fromPosition)
	if not player:isPlayer() then
		return false
	end
	-- ToDo: fix position after new map is added
	player:teleportTo(Position(5745, 801, 4), true)
	return true
end
lastTile:aid(Storage.AssassinsCreedSquurvaali.HeavenLastTile)
lastTile:register()
