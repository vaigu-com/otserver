local strandHair = Action()

function strandHair.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValueByKey(Storage.TheSecretLibrary.TheLament) == 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a strand of hair.")
		player:AddCustomItem({ id = 28490, count = 1 })
		player:setStorageValueByKey(Storage.TheSecretLibrary.TheLament, 2)
		return true
	end
	return false
end

strandHair:uid(1091)
strandHair:register()
