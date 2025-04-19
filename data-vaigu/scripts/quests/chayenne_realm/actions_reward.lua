local chayenneReward = Action()
function chayenneReward.onUse(player, item, fromPosition, itemEx, toPosition)
	if player:getStorageValueByKey(Storage.ChayenneReward) < 1 then
		local backpack = player:AddCustomItem({id = 5949, count = 1})
		backpack:addItem(16244, 1)
		backpack:addItem(3659, 1)
		backpack:addItem(9034, 1)
		backpack:addItem(3027, 1)
		backpack:addItem(5882, 1)
		backpack:addItem(5791, 1)
		backpack:addItem(2995, 1)
		backpack:addItem(6570, 1)
		player:setStorageValueByKey(Storage.ChayenneReward, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a beach backpack.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already got your reward.")
	end
	return true
end

chayenneReward:aid(55023)
chayenneReward:register()
