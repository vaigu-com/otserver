local heroRathletonReward = Action()
function heroRathletonReward.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(24850) < 1 then
		player:AddCustomItem({id = 21203, count = 5})
		player:AddCustomItem({id = 3035, count = 4})
		player:AddCustomItem({id = 21897})
		player:AddCustomItem({id = 9058})
		player:AddCustomItem({id = 836})
		player:addAchievement("The Professors Nut")
		player:setStorageValue(24850, 1) -- storage da recompensa
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You opened the Maxxen's chest.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The chest is empty.")
	end
	return true
end

heroRathletonReward:uid(24850)
heroRathletonReward:register()
