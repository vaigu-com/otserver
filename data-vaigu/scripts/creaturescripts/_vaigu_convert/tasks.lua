local creatureEvent = CreatureEvent("tasks")

function creatureEvent.onModalWindow(player, modalWindowId, buttonId, choiceId)
	local player = Player(player)

	if (modalWindowId == 200 and buttonId == 2) or choiceId > 200 then --cancel button
		return true
	elseif modalWindowId == 200 and buttonId == 3 then --help button
		player:showTextDialog(7397, "Za wykonywanie taskow dostajesz nagrody w postaci: expa, pieniedzy, osiagniec do CV oraz mozliwosci walki z bossami.\n\nGracz moze miec aktywne 3 zadania na raz.")
		return true
	elseif modalWindowId == 200 and buttonId == 1 then --select button
		if player:getStorageValue(Storage.FirstTaskActive) < 1 then
			player:setStorageValue(Storage.FirstTaskActive, choiceId) --save active task
		elseif player:getStorageValue(Storage.SecondTaskActive) < 1 then
			player:setStorageValue(Storage.SecondTaskActive, choiceId) --save active task
		elseif player:getStorageValue(Storage.FirstTaskDoneTaskActive) < 1 then
			player:setStorageValue(Storage.FirstTaskDoneTaskActive, choiceId) --save active task
		else
			player:say("Blad 653, skontaktuj sie z adminem!", TALKTYPE_MONSTER_SAY)
			return false
		end
		player:setStorageValue(modalWindowId + choiceId, 0)
	elseif modalWindowId == 200 and buttonId == 24 then
		player:setStorageValue(200 + choiceId, -1) --reset
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Anulowales zadanie.")
		if player:getStorageValue(Storage.FirstTaskActive) == choiceId then
			player:setStorageValue(Storage.FirstTaskActive, -1) --save active task
		elseif player:getStorageValue(Storage.SecondTaskActive) == choiceId then
			player:setStorageValue(Storage.SecondTaskActive, -1) --save active task
		elseif player:getStorageValue(Storage.FirstTaskDoneTaskActive) == choiceId then
			player:setStorageValue(Storage.FirstTaskDoneTaskActive, -1) --save active task
		end
	end
	return true
end

creatureEvent:register()
