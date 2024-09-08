local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.TheApeCity.QuestProgress) == 1 and player:getStorageValue(Storage.TheApeCity.WhisperMoss) < 1 then
		player:setStorageValue(Storage.TheApeCity.WhisperMoss, 1)
		player:addItem(4827, 1) -- Dostaje Whisper Moss
	else
		doCreatureSay(player, "Same zielska w tej skrzyni.", TALKTYPE_ORANGE_1) -- Tylko dla robiacych questa jest tu cos xd
	end
	return true
end
action:aid(2145)
action:register()
