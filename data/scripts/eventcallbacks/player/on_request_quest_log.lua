local callback = EventCallback("PlayerOnRequestQuestLogBaseEvent")

function callback.playerOnRequestQuestLog(player)
	player:sendQuestLogMainPage()
end

callback:register()
