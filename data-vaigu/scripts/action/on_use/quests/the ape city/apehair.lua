local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValueByKey(Storage.TheApeCity.QuestProgress) == 15 and player:getStorageValueByKey(Storage.TheApeCity.HolyApeHair) < 1 then
		player:setStorageValueByKey(Storage.TheApeCity.HolyApeHair, 1)
		player:AddCustomItem({ id = 4832, addToStore = true })
	else
		doCreatureSay(player, "Smieszne te listki.", TALKTYPE_ORANGE_1) -- Tylko dla robiacych questa jest tu cos xd
	end
	return true
end

action:aid(2155)
action:register()
