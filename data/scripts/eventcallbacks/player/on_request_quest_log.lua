local callback = EventCallback()

function callback.playerOnRequestQuestLog(player)
	player:sendQuestLogMainPage()
end

callback:register()
