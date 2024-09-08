return {
	["Select task you're interested in: "] = "Select task you're interested in: ",
	["Available Task list"] = "Available Task list",
	["Select task you want to cancel: "] = "Select task you want to cancel: ",
	["Ongoing tasks list:"] = "Ongoing tasks list:",
	["You don't have any active tasks. Ask me for {tasks} to sign up for one."] = "You don't have any active tasks. Ask me for {tasks} to sign up for one.",
	["Great job!"] = "Great job!",
	["Hello, I have some {tasks} for you. You can also ask for {trade}, if you want to take a look at my offer. And I'm also selling {creature product} bundles and exchanging task {points}."] = "Hello, I have some {tasks} for you. You can also ask for {trade}, if you want to take a look at my offer. And I'm also selling {creature product} bundles and exchanging task {points}.",
	["Hello, I can see you have completed one of the tasks. Talk to me to get your {reward}!"] = "Hello, I can see you have completed one of the tasks. Talk to me to get your {reward}!",
	["Finish one of {tasks}, then we can talk about reward."] = "Finish one of {tasks}, then we can talk about reward.",
	["TASKS_HELP_WINDOW_INFO"] = function()
		return T("Finishing tasks grants you experience points, money, store coins and after each task you can face the corresponding boss.\n\nYou can have up to :maxTasks: active tasks at the time.", { maxTasks = #Storage.Tasks.PlayerOngoingTasks })
	end,
	["TASK_REWARDS_DIALOGUE"] = function(context)
		local task = context.task
		return T("Your rewards for :name: task is: :exp: experience points, :money: gold and ability to fight with the boss :bossName: (details in questlog).\n You received :points: store coins and task points", {
			name = task.name,
			exp = task.exp,
			money = task.money,
			bossName = task.bossName,
			points = task.tibiaCoins,
		})
	end,
	["TASK_READY_TO_TURN_IN"] = function(context)
		return T("Task for :name: is finshed! You can now face the boss and go to The Great Tracker for reward!", { name = context.task.name })
	end,
	["YOU_HAVE_MAX_ONGOING_TASKS"] = function()
		local maxOngoingTasks = #Storage.Tasks.PlayerOngoingTasks
		return T("You have :maxOngoingTasks: already. You can {cancel} one of them if you want.", { maxOngoingTasks = maxOngoingTasks })
	end,
	["TASK_CURRENT_KILLS"] = function(context)
		local task = context.task
		local currentKills = context.player:getStorageValue(task.storage)
		local name = task.name
		local requiredKills = task.requiredKills
		return T("Task for :name:: :currentKills:/:requiredKills: ", {
			name = name,
			currentKills = currentKills,
			requiredKills = requiredKills,
		})
	end,
	["YOU_DONT_HAVE_REQUIRED_TASK_KILLS"] = function(context)
		local task = context.task
		local player = context.player
		local currentKills = player:getStorageValue(task.storage)
		local requiredKills = task.requiredKills
		local name = task.name
		return T("You didn't execute enough monsters for the :name: task. Your current progress: :currentKills:/:requiredKills: ", {
			name = name,
			currentKills = currentKills,
			requiredKills = requiredKills,
		})
	end,
}
