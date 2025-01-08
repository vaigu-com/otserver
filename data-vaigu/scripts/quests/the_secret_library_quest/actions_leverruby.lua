local leverRuby = Action()

function leverRuby.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValueByKey(Storage.TheSecretLibrary.Mota) == 7 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a reward.")
		player:addItem(32409, 1)
		player:setStorageValueByKey(Storage.TheSecretLibrary.Mota, 8)
		return true
	end
	return false
end

leverRuby:uid(1088)
leverRuby:register()

