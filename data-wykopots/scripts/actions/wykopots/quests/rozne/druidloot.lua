local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 5078 or item.itemid == 5079 or item.itemid == 5076 or item.itemid == 5077 then
		if player:getStorageValue(Storage.SciezkaDruida.WaterLock) < 1 and player:getStorageValue(Storage.SciezkaDruida.KragDruidow) > 3 then
			player:addItem(5938, 1) -- dostaje wode
			player:setStorageValue(Storage.SciezkaDruida.WaterLock, 1) -- lock wody
			toPosition:sendMagicEffect(34)
			player:setStorageValue(Storage.SciezkaDruida.KragDruidow, 5)
		else
			if player:getStorageValue(Storage.SciezkaDruida.KragDruidow) < 4 then
				doCreatureSay(player, "Nie jestes godzien wziac swietej wody!", TALKTYPE_ORANGE_1)
			else
				doCreatureSay(player, "Nie mozesz korzystac wiecej ze swietego zrodla!", TALKTYPE_ORANGE_1)
			end
		end
	elseif item.itemid == 5656 then
		if player:getStorageValue(Storage.SciezkaDruida.FlowerLock) < 1 and player:getStorageValue(Storage.SciezkaDruida.KragDruidow) > 6 then
			player:addItem(5937, 1) -- dostaje kwiat
			player:setStorageValue(Storage.SciezkaDruida.FlowerLock, 1) -- lock kwiatu
			toPosition:sendMagicEffect(47)
		else
			if player:getStorageValue(Storage.SciezkaDruida.KragDruidow) < 7 then
				doCreatureSay(player, "Nie jestes godzien wziac swietego kwiatu!", TALKTYPE_ORANGE_1)
			else
				doCreatureSay(player, "Nie mozesz juz wziac wiecej ze swietego kwiatu!", TALKTYPE_ORANGE_1)
			end
		end
	end
	return true
end

action:aid(11063, 11064)
action:register()
