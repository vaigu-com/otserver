local bone = Action()

function bone.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValueByKey(Storage.TheSecretLibrary.Mota) == 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a reward.")
		player:setStorageValueByKey(Storage.TheSecretLibrary.Mota, 2)
		return true
	end
	return false
end

bone:uid(1083)
bone:register()
