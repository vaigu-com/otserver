local blossom_id = 3734
local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if blossom_id == item.itemid and player:getStorageValue(Storage.PrzyjacielAriela.PomocDlaAriela) == 2 and item.uid == 11001 and player:getItemCount(5921) > 0 then -- tylko gdy mamy poswieconego blossoma
		player:setStorageValue(Storage.PrzyjacielAriela.PomocDlaAriela, 3)
		player:removeItem(5921, 1) -- zabiera nam blossoma
		doCreatureSay(player, "Quel esta", TALKTYPE_ORANGE_1) -- jakis napis po elficku
		return true
	end
	return false
end

action:aid(11001)
action:register()
