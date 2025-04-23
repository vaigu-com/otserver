local chests = {
	[19910] = { itemid = 235 },
}

local othersSteal = Action()
function othersSteal.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if chests[item.uid] then
		if player:getStorageValue(Storage.Quest.U8_2.TheThievesGuildQuest.StealFromThieves) > 1 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "It's empty.")
			return true
		end

		local chest = chests[item.uid]
<<<<<<< HEAD
		player:AddCustomItem({id = chest.itemid, count = 1})
=======
		player:addItem(chest.itemid, 1)
>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
		player:setStorageValue(Storage.Quest.U8_2.TheThievesGuildQuest.StealFromThieves, 2)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You found a bag.")
	end

	return true
end

othersSteal:aid(19910)
othersSteal:register()
