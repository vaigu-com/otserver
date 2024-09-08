local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.TheApeCity.QuestProgress) == 5 and player:getStorageValue(Storage.TheApeCity.ParchmentDecyphering) < 1 then
		player:setStorageValue(Storage.TheApeCity.ParchmentDecyphering, 1)
		player:AddCustomItem({ id = 4831,addToStore = true }) 
	else
		doCreatureSay(player, "Regal z ksiazkami i pergaminami.", TALKTYPE_ORANGE_1) -- Tylko dla robiacych questa jest tu cos xd
	end
	return true
end
action:aid(2151)
action:register()
