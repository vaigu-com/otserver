local greenTp = Action()

function greenTp.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValueByKey(Storage.TheSecretLibrary.BlueTel) == -1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a piece of ebony.")
		player:AddCustomItem({id = 28491, count = 1})
		player:setStorageValueByKey(Storage.TheSecretLibrary.BlueTel, 1)
		return true
	end
	return false
end

greenTp:uid(1097)
greenTp:register()

