local talkaction = TalkAction("!lowloot")

FORCED_BASE_LOOT = 1

function talkaction.onSay(player, words, param)
	local rate = 1
	if player:getStorageValue(Storage.ForceBaseLoot) ~= FORCED_BASE_LOOT then
		player:setStorageValue(Storage.ForceBaseLoot, FORCED_BASE_LOOT)
		rate = configManager.getNumber(configKeys.RATE_LOOT)
	elseif player:getStorageValue(Storage.ForceBaseLoot) == FORCED_BASE_LOOT then
		player:setStorageValue(Storage.ForceBaseLoot, 0)
		rate = configManager.getNumber(configKeys.RATE_LOOT) * BONUS_LOOT
	end

	local translatedMessage = player:Localizer(LOCALIZER_UNIVERSAL):Context({ rate = rate }):Get("YOU_CHANGED_YOUR_LOOTRATE")
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, translatedMessage)
	return false
end

talkaction:separator(" ")
talkaction:groupType("normal")
talkaction:register()
