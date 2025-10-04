local heartDestructionReward = Action()
function heartDestructionReward.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.uid == 1038 then
		if player:getStorageValueByKey(14337) < 1 then
			player:AddItemsAnnounce({
				[23525] = {
					{ id = 23512, count = 1 },
					{ id = 23538, count = 1 },
					{ id = 23536, count = 1 },
					{ id = 23509, count = 1 },
					{ id = 3043, count = 20 },
					{ id = 22721, count = 5 },
				},
			})

			player:setStorageValueByKey(14337, 1)
			player:setStorageValueByKey(Storage.Finished.HeartOfDestruction, 1)
			--player:addAchievement("Ender of the End")
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found an energetic backpack.")
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The chest is empty.")
		end
	end

	return true
end

heartDestructionReward:uid(1038)
heartDestructionReward:register()
