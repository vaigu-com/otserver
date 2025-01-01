local callback = EventCallback()

function callback.playerOnRequestQuestLine(player, questId)
	player:sendQuestline(questId)
end

callback:register()
