local pseudoQuest = Quest(LOCALIZERS.NONE)

pseudoQuest
	:NoQuestlog()
	:Constant(function()
		Minigames = {}
	end)
	:Script(function()
		local nextGlobalEventId = 0
		local function nextScheduledMinigameGlobalEventName()
			nextGlobalEventId = nextGlobalEventId + 1
			return "ScheduledMinigame" .. nextGlobalEventId
		end

		local hourToMinuteToMinigame = {
			[0] = {
				[10] = nil
			},
		}
		for hour, minuteToMinigame in pairs(hourToMinuteToMinigame) do
			for minute, minigame in pairs(minuteToMinigame) do
				local lotteryEvent = GlobalEvent(nextScheduledMinigameGlobalEventName())
				function lotteryEvent.onTime(interval)
					minigame:TryStartLobby()
					return true
				end
				lotteryEvent:time(hour .. ":" .. minute)
				lotteryEvent:register()
			end
		end
	end)
	:Register()
