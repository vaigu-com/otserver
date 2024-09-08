local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.TheApeCity.QuestProgress) == 7 then
		player:setStorageValue(Storage.TheApeCity.TombWall, 1)
		doCreatureSay(player, "(.)(.),|,8--> Bendriksai.", TALKTYPE_ORANGE_1)
	else
		doCreatureSay(player, "Kolejne hieroglify. Ale zaraz, te sa jakies dziwne", TALKTYPE_ORANGE_1) -- Tylko dla robiacych questa jest tu cos xd
	end
	return true
end
action:aid(2153)
action:register()
