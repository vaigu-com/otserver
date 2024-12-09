local quest = Quest(LOCALIZERS.DailyTasks)

quest
	:Storage(function()
		Storage.DailyTasks = {
			DailyTaskInfo = NextStorage(),
			DailyLimit = NextStorage(),
			DailyBoardSlots = {
				[1] = NextStorage(),
				[2] = NextStorage(),
				[3] = NextStorage(),
			},
			LastResetTimestamp = NextStorage(),
		}
	end)
	:Register()
