local callback = EventCallback("PlayerOnRequestQuestLineBaseEvent")

function callback.playerOnRequestQuestLine(player, questId)
	player:sendQuestline(questId)
end

callback:register()
