local talkaction = TalkAction("/facelessoff")

function talkaction.onSay(player, words, param)
	if Game.getStorageValue(57608) == 1 then
		Game.setStorageValue(57608, 0)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Faceless 0.")
	else
		--Game.setStorageValue(GlobalStorage.DailyQuest.MLvl, 22)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "0 already.")
	end
end

talkaction:separator(" ")
talkaction:groupType("gamemaster")
talkaction:register()
