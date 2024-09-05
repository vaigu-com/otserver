local talk = TalkAction("/d")
function talk.onSay(player, words, param)
	player:teleportTo(Position(5889, 1558, 7))
	return false
end
talk:separator(" ")
talk:groupType("gamemaster")
talk:register()

local talk = TalkAction("/dqmain")
function talk.onSay(player, words, param)
	player:teleportTo(Position(5227, 928, 8))
	return false
end
talk:separator(" ")
talk:groupType("gamemaster")
talk:register()

local talk = TalkAction("/retro")
function talk.onSay(player, words, param)
	player:teleportTo(Position(4759, 854, 7))
	return false
end
talk:separator(" ")
talk:groupType("gamemaster")
talk:register()

local talk = TalkAction("/dqstart")
function talk.onSay(player, words, param)
	player:teleportTo(Position(5228, 929, 9))
	return false
end
talk:separator(" ")
talk:groupType("gamemaster")
talk:register()
