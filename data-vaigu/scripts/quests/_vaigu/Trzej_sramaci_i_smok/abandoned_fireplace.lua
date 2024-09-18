local updateStorages = { [Storage.TheThreeSramatiansAndTheDragon.Questline] = 8, [Storage.TheThreeSramatiansAndTheDragon.Mission04] = 2 }

local FirePlace = Action()
function FirePlace.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end

	if player:getStorageValue(Storage.TheThreeSramatiansAndTheDragon.Questline) ~= 7 then
		return false
	end
	player:UpdateStorages(updateStorages)
	return true
end

FirePlace:aid(Storage.TheThreeSramatiansAndTheDragon.AbandonedFireplace)
FirePlace:register()
