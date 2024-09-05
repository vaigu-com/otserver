local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.TheApeCity.QuestProgress) == 11 then
		if player:getStorageValue(Storage.TheApeCity.WitchesCapSpotTimer) < os.time() then
			player:addItem(4829, 1) -- Dostaje Witches' Cap
			player:setStorageValue(Storage.TheApeCity.WitchesCapSpotTimer, os.time() + 20 * 60 * 60) -- + 20 * 60 * 3600
		else
			doCreatureSay(player, "Dzis juz go wzialem.", TALKTYPE_ORANGE_1)
		end
	else
		doCreatureSay(player, "Obrzydliwe grzyby.", TALKTYPE_ORANGE_1) -- Tylko dla robiacych questa jest tu cos xd
	end
	return true
end
action:aid(2154)
action:register()
