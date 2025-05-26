local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValueByKey(Storage.TheApeCity.WhisperMoss) < 1 then
		player:setStorageValueByKey(Storage.TheApeCity.WhisperMoss, 1)
		player:AddCustomItem({ id = 4827, count = 1, addToStore = true })
	else
		doCreatureSay(player, "Same zielska w tej skrzyni.", TALKTYPE_ORANGE_1)
	end
	return true
end
action:aid(2145)
action:register()
