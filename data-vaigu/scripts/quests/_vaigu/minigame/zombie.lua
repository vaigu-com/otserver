local zombieMinigame = MinigameData({
	minigameName = "Zombie",
	competitionType = MINIGAME_COMPETITION_TYPE.LAST_MAN_STANDING,
	requiredPlayers = 1,
	enableDebug = true,
})

local startEvent = TalkAction("!zombie")

function startEvent.onSay(player, words, param)
	local status = zombieMinigame:TryStartLobbyFast()
	return false
end
startEvent:separator(" ")
startEvent:groupType("tutor")
startEvent:register()
