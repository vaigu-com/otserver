local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.TheApeCity.QuestProgress) == 15 and player:getStorageValue(Storage.TheApeCity.HolyApeHair) < 1 then
		player:setStorageValue(Storage.TheApeCity.HolyApeHair, 1)
		player:AddCustomItem({ id = 4832,addToStore = true }) 
	else
		doCreatureSay(player, "Smieszne te listki.", TALKTYPE_ORANGE_1) -- Tylko dla robiacych questa jest tu cos xd
	end
	return true
end

action:aid(2155)
action:register()
