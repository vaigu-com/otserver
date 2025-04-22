local postmanWaldos = Action()
function postmanWaldos.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.U7_24.ThePostmanMissions.Mission08) == 1 then
		player:setStorageValue(Storage.Quest.U7_24.ThePostmanMissions.Mission08, 2)
<<<<<<< HEAD
		player:AddCustomItem({id = 3219, count = 1})
=======
		player:addItem(3219, 1)
>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You found Waldo's posthorn.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The dead human is empty.")
	end
	return true
end

postmanWaldos:uid(3118)
postmanWaldos:register()
