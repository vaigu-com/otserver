local updateStorages = { [Storage.ThreeSramatiansAndTheDragon.Questline] = 8, [Storage.ThreeSramatiansAndTheDragon.Mission04] = 2 }

local FirePlace = Action()
function FirePlace.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end

	if player:getStorageValue(Storage.ThreeSramatiansAndTheDragon.Questline) ~= 7 then
		return false
	end
	player:UpdateStorages(updateStorages)
	return true
end

FirePlace:aid(Storage.ThreeSramatiansAndTheDragon.AbandonedFireplace)
FirePlace:register()
