local function timeToMessage(timeElapsed)
	timeElapsed = os.date("*t", timeElapsed)
	local hours = timeElapsed.hour
	local minutes = timeElapsed.min
	local seconds = timeElapsed.sec
	local result = ""
	if hours > 0 then
		result = T(":r: :h: hours", { r = result, h = hours })
	end
	if minutes > 0 then
		result = T(" :r: :h: minutes", { r = result, h = minutes })
	end
	if seconds >= 0 then
		result = T(" :r: :h: seconds", { r = result, h = seconds })
	end
end

return {
	["MINIGAMES_BROADCAST_SPEEDRUN"] = function(context)
		local timeMessage = timeToMessage(context.timeElaps)
		return T("Player :playerName: has taken :place: in :eventName: event. It took them :timeMessage: to finish. ", {
			playerName = context.playerName,
			place = context.ordinalStringPlace,
			eventName = context.eventName,
			timeMessage = timeMessage,
		})
	end,
	["MINIGAMES_BROADCAST_LMS_NO_MONSTERS"] = function(context)
		local timeMessage = timeToMessage(context.timeElaps)
		return T("Player :playerName: has taken :place: in :eventName: event. They lasted :timeMessage:. ", {
			playerName = context.playerName,
			place = context.ordinalStringPlace,
			eventName = context.eventName,
			timeMessage = timeMessage,
		})
	end,
	["MINIGAMES_BROADCAST_LMS_YES_MONSTERS"] = function(context)
		local timeMessage = timeToMessage(context.timeElaps)
		return T(
			"Player :playerName: has taken :place: in :eventName: event. They lasted :timeMessage:, and faced :monsterCount: monsters.",
			{
				playerName = context.playerName,
				place = context.ordinalStringPlace,
				eventName = context.eventName,
				timeMessage = timeMessage,
				monsterCount = context.monsterCount,
			}
		)
	end,
}
