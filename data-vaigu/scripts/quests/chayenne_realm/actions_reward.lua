local chayenneReward = Action()
function chayenneReward.onUse(player, item, fromPosition, itemEx, toPosition)
	if player:getStorageValueByKey(Storage.ChayenneReward) < 1 then
		player:AddItemsAnnounce({
			[5949] = {
				{ id = 16244 },
				{ id = 3659 },
				{ id = 9034 },
				{ id = 3027 },
				{ id = 5882 },
				{ id = 5791 },
				{ id = 2995 },
				{ id = 6570 },
			},
		})

		player:setStorageValueByKey(Storage.ChayenneReward, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a beach backpack.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already got your reward.")
	end
	return true
end

chayenneReward:aid(55023)
chayenneReward:register()
