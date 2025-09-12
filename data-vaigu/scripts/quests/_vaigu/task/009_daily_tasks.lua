local quest = Quest(LOCALIZERS.DailyTasks)

quest
	:Storage(function()
		Storage.DailyTasks = {
			DailyTaskInfo = {},
			DailyLimit = {},
			LastResetTimestamp = {},
			Board = {},
		}
	end)
	:Questlog(function(localizer)
		DailyTaskQuestlog = {
			name = "Daily task",
			localizer = localizer,
			missions = {
				{
					name = "Daily tasks information",
					storage = Storage.DailyTasks.DailyTaskInfo,
					description = "DAILY_TASKS_HELP_WINDOW_INFO",
				},
			},
		}
		table.insert(Quests, DailyTaskQuestlog)
	end)
	:Script(function()
		local function playerCanTakeAnyDailyTask(player)
			for i = 1, DAILY_TASKS_LEVEL_BRACKETS_COUNT do
				local dailyTask = GetDailyTaskByIndex(i)
				if player:CanTakeDailyTask(dailyTask) then
					return true
				end
			end
			return false
		end

		local function onDailyTaskboardUse(player)
			player:setStorageValueByKey(Storage.DailyTasks.DailyTaskInfo, MISSION_FINISHED)
			if not playerCanTakeAnyDailyTask(player) then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, player:Localizer(LOCALIZERS.DailyTasks):Get("YOU_TAKEN_ALL_AVAILABLE_DAILY_TASKS"))
				return false
			end

			SPECIAL_ACTIONS_DAILY_TASK.openDailyTaskWindow({ player = player })
			return true
		end

		local dailyBoard = Action()
		function dailyBoard.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			return onDailyTaskboardUse(player)
		end
		dailyBoard:key(Storage.DailyTasks.Board)
		dailyBoard:register()

		local dailyBoardLook = Look()
		function dailyBoardLook.onLook(player, item)
			onDailyTaskboardUse(player)
			return DONT_SHOW_ONLOOK
		end
		dailyBoardLook:key(Storage.DailyTasks.Board)
		dailyBoardLook:register()
	end)
	:Script(function()
		RegisterDailyTasksInQuestsTable()
	end)
	:Script(function()
		local function onPamphlet(player, item)
			local key = item:getKey()
			local text = item:getAttribute(ITEM_ATTRIBUTE_TEXT)
			local translatedText = player:Localizer(LOCALIZERS.DailyTasks):Context({ key = key }):Get(text)
			SimpleTextDisplay(player, translatedText)
		end

		local dailyPamphletUse = Action()
		function dailyPamphletUse.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			onPamphlet(player, item)
			item:remove()
			return true
		end

		local dailyPamphletLook = Look()
		function dailyPamphletLook.onLook(player, item)
			onPamphlet(player, item)
			item:remove()
			return DONT_SHOW_ONLOOK
		end

		for _, dailyTask in pairs(GetAllDailyTasks()) do
			local key = dailyTask.storage
			dailyPamphletUse:key(key)
			dailyPamphletLook:key(key)
		end
		dailyPamphletUse:register()
		dailyPamphletLook:register()
	end)
	:Register()
