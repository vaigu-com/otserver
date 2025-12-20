local backTp = Action()

function backTp.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValueByKey(Storage.TheSecretLibrary.BlackTel) == -1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a skull.")
		player:AddCustomItem({ id = 28489, count = 1 })
		player:setStorageValueByKey(Storage.TheSecretLibrary.BlackTel, 1)
		return true
	end
	return false
end

backTp:uid(1098)
backTp:register()
