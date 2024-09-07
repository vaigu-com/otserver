local talkaction = TalkAction("/wb")

function talkaction.onSay(player, words, param)
	print("> " .. player:getName() .. ' broadcasted: "' .. param .. '".')
	broadcastMessage(param, MESSAGE_EVENT_ADVANCE)

	return false
end

talkaction:separator(" ")
talkaction:groupType("tutor")
talkaction:register()
