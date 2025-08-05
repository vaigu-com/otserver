Game.setStorageValueByKey(Storage.LastStartupTimestamp, os.time())

local talkaction = TalkAction("!uptime")
function talkaction.onSay(player, words, param)
	local now = os.time()
	local lastSave = Game.getStorageValueByKey(Storage.LastStartupTimestamp)

	local uptime = math.abs(now - lastSave)

	local days = math.floor(uptime / 86400)
	uptime = uptime % 86400
	local hours = math.floor(uptime / 3600)
	uptime = uptime % 3600
	local minutes = math.floor(uptime / 60)

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, T("Uptime: :d: days :h: hours :m: minutes.\n Last save: :lastSave:\nNow: :now:", { d = days, h = hours, m = minutes, lastSave = lastSave, now = now }))
	return true
end

talkaction:separator(" ")
talkaction:groupType("normal")
talkaction:register()
