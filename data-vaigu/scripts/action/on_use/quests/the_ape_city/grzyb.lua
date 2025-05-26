local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValueByKey(Storage.TheApeCity.QuestProgress) <= 11 then
		player:AddCustomItem({ id = 4829, count = 1, addToStore = true })
	else
		doCreatureSay(player, "Obrzydliwe grzyby.", TALKTYPE_ORANGE_1)
	end
	return true
end
action:aid(2154)
action:register()
