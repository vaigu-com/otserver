local fish = Action()

function fish.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValueByKey(Storage.TheSecretLibrary.HighDry) == 2 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a hawser.")
		player:AddCustomItem({ id = 32407, count = 1 })
		player:setStorageValueByKey(Storage.TheSecretLibrary.HighDry, 3)
		return true
	end
	return false
end

fish:uid(1102)
fish:register()
