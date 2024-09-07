local talkaction = TalkAction("/dailychange")

function talkaction.onSay(player, words, param)
	local split = param:split(",")
	local dailylevel = split[1]
	local value = tonumber(split[2])
	if value == nil or value <= 0 then
		player:sendCancelMessage("You need to put the value.")
		return false
	end

	if dailylevel == "low" then
		Game.setStorageValue(GlobalStorage.DailyQuest.LLvl, value)
	elseif dailylevel == "mid" then
		Game.setStorageValue(GlobalStorage.DailyQuest.MLvl, value)
	elseif dailylevel == "high" then
		Game.setStorageValue(GlobalStorage.DailyQuest.HLvl, value)
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Storage set to " .. value .. "")
	return false
end

talkaction:separator(" ")
talkaction:groupType("senior tutor")
talkaction:register()
