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
			Board = NextStorage(),
		}
	end)
	:Questlog(function()
		Quests[DAILY_TASK_STORAGE] = {
			name = "Daily task",
			missions = {
				[Storage.DailyTasks.DailyTaskInfo] = {
					name = "Daily tasks information",
					description = "DAILY_TASKS_HELP_WINDOW_INFO",
				},
			},
		}
	end)
	:StartupItems({
		{ id = 19245, pos = Position(5845, 1529, 7), aid = Storage.DailyTasks.Board },
	})
	:Script(function()
		local function playerCanTakeAnyDailyTask(player)
			for _, taskSlot in pairs(Storage.DailyTasks.DailyBoardSlots) do
				local storage = KV.get(taskSlot)
				local dailyTask = GetDailyTaskByStorage(storage)
				if player:CanTakeDailyTask(dailyTask) then
					return true
				end
			end
			return false
		end

		local function onDailyTaskBoardUse(player)
			player:setStorageValue(Storage.DailyTasks.DailyTaskInfo, 0)
			if not playerCanTakeAnyDailyTask(player) then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, player:Localizer(Storage.DailyTasks.DailyTaskInfo):Get("YOU_TAKEN_ALL_AVAILABLE_DAILY_TASKS"))
				return false
			end

			SPECIAL_ACTIONS_DAILY_TASK.openDailyTaskWindow({ player = player })
			return true
		end

		local dailyBoard = Action()
		function dailyBoard.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			return onDailyTaskBoardUse(player)
		end

		dailyBoard:aid(Storage.DailyTasks.Board)
		dailyBoard:register()

		local dailyBoardLook = Look()
		function dailyBoardLook.onLook(player, item)
			return onDailyTaskBoardUse(player)
		end

		dailyBoardLook:aid(Storage.DailyTasks.Board)
		dailyBoardLook:register()
	end)
	:Script(function()
		RegisterDailyTasksInQuestsTable()
	end)
	:Register()
