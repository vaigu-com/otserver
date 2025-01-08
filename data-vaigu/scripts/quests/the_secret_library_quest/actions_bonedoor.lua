local boneDoor = Action()

function boneDoor.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValueByKey(Storage.TheSecretLibrary.Mota) == 9 then
		if target.itemid == 10876 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a reward.")
			player:setStorageValueByKey(Storage.TheSecretLibrary.Mota, 10)
			player:removeItem(32648, 1)
			player:setStorageValueByKey(Storage.TheSecretLibrary.SkullDoor, 1)
		end
		return true
	end
	return false
end

boneDoor:id(1335)
boneDoor:register()
