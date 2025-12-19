--[[
local talkaction = TalkAction("!lowloot")

FORCED_BASE_LOOT = 1

function talkaction.onSay(player, words, param)
	local rate = 1
	if player:getStorageValueByKey(Storage.ForceBaseLoot) ~= FORCED_BASE_LOOT then
		player:setStorageValueByKey(Storage.ForceBaseLoot, FORCED_BASE_LOOT)
		rate = configManager.getNumber(configKeys.RATE_LOOT)
	elseif player:getStorageValueByKey(Storage.ForceBaseLoot) == FORCED_BASE_LOOT then
		player:setStorageValueByKey(Storage.ForceBaseLoot, 0)
		rate = configManager.getNumber(configKeys.RATE_LOOT)
	end

	local translatedMessage = player:Localizer(LOCALIZERS.Universal):Context({ rate = rate }):Get("YOU_CHANGED_YOUR_LOOTRATE")
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, translatedMessage)
	return false
end

talkaction:separator(" ")
talkaction:groupType("normal")
talkaction:register()
]]
