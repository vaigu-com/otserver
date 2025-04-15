local adventurersWarriorSkeleton = Action()
function adventurersWarriorSkeleton.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValueByKey(Storage.AdventurersGuild.GreatDragonHunt.WarriorSkeleton) < 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have discovered a deceased warrior's skeleton. It seems he tried to hunt the dragons around here - and failed.")
		player:AddCustomItem({id = 5882, count = 1}) -- red dragon scale

		if player:getStorageValueByKey(Storage.AdventurersGuild.QuestLine) < 1 then
			player:setStorageValueByKey(Storage.AdventurersGuild.QuestLine, 1)
		end

		player:setStorageValueByKey(Storage.AdventurersGuild.GreatDragonHunt.WarriorSkeleton, 1)
		player:setStorageValueByKey(Storage.AdventurersGuild.GreatDragonHunt.DragonCounter, 0)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The dead explorer is empty.")
	end

	return true
end

adventurersWarriorSkeleton:aid(50806)
adventurersWarriorSkeleton:register()
