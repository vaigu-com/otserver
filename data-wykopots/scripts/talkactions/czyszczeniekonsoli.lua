local talkaction = TalkAction("/cc")

function talkaction.onSay(player, words, param)
	os.execute("cls")
end

talkaction:separator(" ")
talkaction:groupType("gamemaster")
talkaction:register()
