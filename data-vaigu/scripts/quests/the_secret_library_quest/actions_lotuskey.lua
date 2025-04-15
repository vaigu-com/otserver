local lotusKey = Action()

function lotusKey.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValueByKey(Storage.TheSecretLibrary.TheLament) == 3 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a lotus key.")
		player:AddCustomItem({id = 28476, count = 1})
		player:setStorageValueByKey(Storage.TheSecretLibrary.TheLament, 4)
		return true
	end
	return false
end

lotusKey:uid(1093)
lotusKey:register()

