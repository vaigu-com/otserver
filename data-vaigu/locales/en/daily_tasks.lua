return {
	["DAILY_TASK_MISSION_NAME"] = function(context)
		local dailyTask = context.dailyTask
		local name = dailyTask.name
		return T("Hunting of :name:", { name = name })
	end,
	["DAILY_TASK_PAMPHLET_DESCRIPTION"] = function(context)
		local dailyTask = GetDailyTaskByStorage(context.key)
		context.dailyTask = dailyTask
		return context.player:Localizer(context.localizer):Context(context):Get("DAILY_TASK_MISSION_DESCRIPTION")
	end,
	["DAILY_TASK_MISSION_DESCRIPTION"] = function(context)
		local player = context.player
		local dailyTask = context.dailyTask
		local name = dailyTask.name
		local currentKills = player:getStorageValueByKey(dailyTask.currentKills)
		local requiredKills = dailyTask.requiredKills
		local requiredItems = dailyTask.items
		local dailyTaskDescription = T("Daily task for :name:!\n\n", { name = name })
		dailyTaskDescription = dailyTaskDescription .. T("You have killed :currentKills:/:requiredKills: :name:.", {
			name = name,
			currentKills = currentKills,
			requiredKills = requiredKills,
		})
		if requiredItems then
			dailyTaskDescription = dailyTaskDescription .. "\n\nYou will also need to bring the following creature products to the Mayor:\n" .. ItemsToString(requiredItems)
		end
		dailyTaskDescription = dailyTaskDescription .. T("\nYou will get :money: gold and :tibiaCoins: store coins!", {
			money = dailyTask.money,
			tibiaCoins = dailyTask.tibiaCoins,
		})

		return dailyTaskDescription
	end,
	["Daily task"] = "Daily task",
	["Daily tasks information"] = "Daily tasks information",
	["You don't have any active daily tasks. You can sign up for daily task on the daily task board. Please report me if you finish one of them."] = "You don't have any active daily tasks. You can sign up for daily task on the daily task board. Please report me if you finish one of them.",
	["Hello |PLAYERNAME|. You already finished a daily {task} from the notice board? You can {cancel} it whenever you want. I also have some {outfit} for the most generous donors."] = "Hello |PLAYERNAME|. You already finished a daily {task} from the notice board? You can {cancel} it whenever you want. I also have some {outfit} for the most generous donors.",
	["DAILY_TASKS_HELP_WINDOW_INFO"] = function()
		return T("For completing the daily tasks you'll get the following rewards: exp, gold and store coins.\n\nAfter finishing a task you can claim reward from the Mayor.\n\nYou can finish up to :maxTasks: tasks daily.\n\nYou can report a finished task the next day.", { maxTasks = DAILY_TASK_LIMIT })
	end,
	["DAILY_TASK_REWARDS_DIALOG"] = function(context)
		local dailyTask = context.dailyTask
		return T("Your rewards for :name: daily task is: :exp: experience points, :money: gold.\n You received :points: store coins and task points", {
			name = dailyTask.name,
			exp = dailyTask.exp,
			money = dailyTask.money,
			points = dailyTask.tibiaCoins,
		})
	end,
	["YOU_RECEIVED_DAILY_TASK"] = "You received a daily task!",
	["YOU_TAKEN_ALL_AVAILABLE_DAILY_TASKS"] = "You have taken all today available daily tasks. Finish some of them to be able to take more.",
	["YOU_DONT_HAVE_REQUIRED_DAILY_TASK_ITEMS"] = function(context)
		local dailyTask = context.dailyTask
		local requiredItems = dailyTask.items

		local errorMessage = T("You do not have enough of creature products for the :name: task. You have to collect the following:", { name = dailyTask.name })
		for _, item in pairs(requiredItems) do
			local id = item.id
			local itemName = ItemType(id):getName()
			local count = item.count
			errorMessage = errorMessage .. T("\t:count: :itemName:", { count = count, itemName = itemName })
		end
		errorMessage = errorMessage .. "."
		return errorMessage
	end,
	["YOU_DONT_HAVE_REQUIRED_DAILY_TASK_KILLS"] = function(context)
		local dailyTask = context.dailyTask
		local player = context.player
		local currentKills = player:getStorageValueByKey(dailyTask.storage)
		local requiredKills = dailyTask.requiredKills
		local name = dailyTask.name
		return T("You didn't execute enough monsters for the :name: daily task. Your current progress: :currentKills:/:requiredKills: ", {
			name = name,
			currentKills = currentKills,
			requiredKills = requiredKills,
		})
	end,
	["YOU_EXCEEDED_DAILY_TASK_LIMIT"] = function()
		return T("I can only pay you for the first :max: daily tasks, please come back tomorrow.", { max = DAILY_TASK_LIMIT })
	end,
	["DAILY_TASK_READY_TO_TURN_IN"] = function(context)
		return T("Daily task for :name: is finshed! Make sure you have all required items for this task and ask Mayor for the reward.", { name = context.dailyTask.name })
	end,
	["DAILY_TASK_FOR_X"] = function(context)
		local dailyTask = context.dailyTask
		return T("Task for :name:!", { name = dailyTask.name })
	end,
	["Daily tasks"] = "Daily tasks",
	["DAILY_TASK_CURRENT_KILLS"] = function(context)
		local dailyTask = context.dailyTask
		local currentKills = context.player:getStorageValueByKey(dailyTask.currentKills)
		local name = dailyTask.name
		local requiredKills = dailyTask.requiredKills
		return T("Daily task for :name:: :currentKills:/:requiredKills: ", {
			name = name,
			currentKills = currentKills,
			requiredKills = requiredKills,
		})
	end,
}
