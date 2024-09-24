	:Script(function(storageToRequiredState)
local slippersTp = Action()
function slippersTp.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end

	local storageVal = player:getStorageValue(Storage.FourActTragedy.Questline)
	if storageVal < 11 or 12 < storageVal then
		return false
	end

	local playerPos = player:getPosition()
	if playerPos.x > item:getPosition().x then
		player:teleportTo(playerPos:Moved(-2, 0, 0))
	elseif playerPos.x < item:getPosition().x then
		player:teleportTo(playerPos:Moved(2, 0, 0))
	end
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

slippersTp:aid(Storage.FourActTragedy.SlippersTorch)
slippersTp:register()
end)
