local questFirst = Action()

function questFirst.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.DeeplingsWorldChange.Crystal) == 7 then
		player:AddCustomItem({id = 3035, count = 10})
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a reward.")
		player:setStorageValue(Storage.DeeplingsWorldChange.Crystal, 8)
		return true
	end
	return false
end

questFirst:uid(1105)
questFirst:register()
