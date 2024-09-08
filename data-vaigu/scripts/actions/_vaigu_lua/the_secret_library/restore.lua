local restoreIdol = Action()
function restoreIdol.onUse(player, item, fromPosition, itemEx, toPosition)
	if Game.getStorageValue(GlobalStorage.RestoredIdols) <= 8 then
		if item.itemid == 28738 then
			item:transform(28740)
			toPosition:sendMagicEffect(CONST_ME_THUNDER)
		elseif item.itemid == 28739 then
			item:transform(28741)
			toPosition:sendMagicEffect(CONST_ME_THUNDER)
		end
		if Game.getStorageValue(GlobalStorage.RestoredIdols) < 1 then
			Game.setStorageValue(GlobalStorage.RestoredIdols, 1)
		else
			Game.setStorageValue(GlobalStorage.RestoredIdols, (Game.getStorageValue(GlobalStorage.RestoredIdols) + 1))
		end
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have restored " .. Game.getStorageValue(GlobalStorage.RestoredIdols) .. " of 9 Broken Idols.")
	end
	return true
end
restoreIdol:id(28738, 28739)
restoreIdol:register()
