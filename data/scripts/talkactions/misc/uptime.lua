local talkaction = TalkAction("!uptime")

function talkaction.onSay(player, words, param)
	local uptime = (os.time() - Game.getStorageValueByKey(Storage.LastStartupTimestamp))

	local hours = math.floor(uptime / 3600)
	local minutes = math.floor((uptime - (3600 * hours)) / 60)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Uptime: " .. hours .. " hours i " .. minutes .. " ,omites.")
	return true
end

talkaction:separator(" ")
talkaction:groupType("normal")
talkaction:register()
