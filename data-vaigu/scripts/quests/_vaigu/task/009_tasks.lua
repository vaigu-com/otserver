local quest = Quest(LOCALIZERS.Tasks)

quest
	:Storage(function()
		Storage.Tasks = {
			TaskInfo = NextStorage(),
			TaskPoints = NextStorage(),
			PlayerOngoingTasks = {
				[1] = NextStorage(),
				[2] = NextStorage(),
				[3] = NextStorage(),
			},
		}
	end)
	:Questlog(function()
		Quests[TASKS_QUEST_STORAGE] = {
			name = "Tasks",
			missions = {
				[Storage.Tasks.TaskInfo] = {
					name = "Task informations",
					description = "TASKS_HELP_WINDOW_INFO",
				},
			},
		}
	end)
	:Script(function()
		RegisterTasksInQuestsTable()
	end)
	:Register()
