local talkaction = TalkAction("!uptime")

function talkaction.onSay(player, words, param)
	local uptime = (os.time() - Game.getStorageValue(GlobalStorage.ServerStartStorage))

	local hours = math.floor(uptime / 3600)
	local minutes = math.floor((uptime - (3600 * hours)) / 60)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Uptime: " .. hours .. " godzin i " .. minutes .. " minut.")
	return true
end

talkaction:separator(" ")
talkaction:groupType("normal")
talkaction:register()
