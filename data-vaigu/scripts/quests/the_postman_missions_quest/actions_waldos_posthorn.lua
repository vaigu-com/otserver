local postmanWaldos = Action()
function postmanWaldos.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValueByKey(Storage.Postman.Mission08) == 1 then
		player:setStorageValueByKey(Storage.Postman.Mission08, 2)
		player:AddCustomItem({ id = 3219, count = 1 })
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You found Waldo's posthorn.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The dead human is empty.")
	end
	return true
end

postmanWaldos:uid(3118)
postmanWaldos:register()
