print("009_tasks.lua")
local quest = Quest(LOCALIZERS.Tasks)

quest
	:Storage(function()
		Storage.Tasks = {
			TaskInfo = NextStorage(),
			taskPoints = NextStorage(),
			PlayerOngoingTasks = {
				[1] = NextStorage(),
				[2] = NextStorage(),
				[3] = NextStorage(),
			},
		}
	end)
	:Register()
