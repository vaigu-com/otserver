local scissors = Action()

function scissors.onUse(player, item, frompos, item2, topos)
	if player:getStorageValue(Storage.Quest.U12_20.KilmareshQuest.Set.Ritual) == 1 then
<<<<<<< HEAD
		player:AddCustomItem({id = 31327, count = 1})
=======
		player:addItem(31327, 1)
>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
		player:setStorageValue(Storage.Quest.U12_20.KilmareshQuest.Set.Ritual, 2)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a  ritual scissors.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Empty.")
	end

	return true
end

scissors:uid(uniqueid)
scissors:register()
