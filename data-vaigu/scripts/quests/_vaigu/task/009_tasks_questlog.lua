local quest = Quest(LOCALIZERS.Tasks)

quest
	:Storage(function()
		Storage.Tasks = {
			TaskInfo = {},
			TaskPoints = {},
			PlayerOngoingTasks = {
				[1] = {},
				[2] = {},
				[3] = {},
			},
		}
	end)
	:Questlog(function(localizer)
		TaskQuestlog = {
			name = "Tasks",
			localizer = localizer,
			missions = {
				{
					name = "Task informations",
					storage = Storage.Tasks.TaskInfo,
					description = "TASKS_HELP_WINDOW_INFO",
				},
			},
		}
		table.insert(Quests, TaskQuestlog)
	end)
	:Script(function()
		GenerateTasksAuxillaryData()
		RegisterTasksInQuestsTable()
		RegisterTasksBossTp()
	end)
	:Register()
