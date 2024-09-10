return {
	["Select task you're interested in: "] = "Wybierz interesujace cie zadanie:  ",
	["Available Task list"] = "Lista dostepnych taskow",
	["Select task you want to cancel: "] = "Anuluj wybrany task: ",
	["Ongoing tasks list:"] = "Wziete taski:",
	["You don't have any active tasks. Ask me for {tasks} to sign up for one."] = "Nie masz aktywnych zadan. Zapytaj mnie o {taski}, aby rozpoczac zadanie.",
	["Great job!"] = "Dobra robota!",
	["Hello, I have some {tasks} for you. You can also ask for {trade}, if you want to take a look at my offer. And I'm also selling {creature product} bundles and exchanging task {points}."] = "Posiadam paczki creature productow na kazdy z {imbuingow}. Kosztowac cie to bedzie troche zlota oraz {punktow}.",
	["Hello, I can see you have completed one of the tasks. Talk to me to get your {reward}!"] = "Siemaneczko, widze ze zadanie o ktore cie prosilem zostalo wykonane. Nalezy ci sie {nagroda}!",
	["Finish one of {tasks}, then we can talk about reward."] = "Ukoncz jakis z {taskow}, to porozmawiamy o nagrodzie.",
	["TASKS_HELP_WINDOW_INFO"] = function()
		return T("Za wykonywanie taskow dostajesz nagrody w postaci: expa, pieniedzy, osiagniec od CV oraz mozliwosci walki z bossami.\n\nMozesz posiadac jednoczesnie :maxTasks: zadania.", { maxTasks = #Storage.Tasks.PlayerOngoingTasks })
	end,
	["TASK_REWARDS_DIALOG"] = function(context)
		local task = context.task
		return T("Nagroda za task na :name: to: :exp: puktow doswiadczenia, :money: zlota oraz mozliwosc walki z bossem :bossName: (szczegoly w questlogu).\n Utrzymujesz :points: coiny oraz punkty taskow.", {
			name = task.name,
			exp = task.exp,
			money = task.money,
			bossName = task.bossName,
			points = task.tibiaCoins,
		})
	end,
	["TASK_READY_TO_TURN_IN"] = function(context)
		return T("Task na :name: zostal zakonczony! Mozesz zmierzyc sie z bossem oraz udac do npc po nagrode.", { name = context.task.name })
	end,
	["YOU_HAVE_MAX_ONGOING_TASKS"] = function()
		local maxOngoingTasks = #Storage.Tasks.PlayerOngoingTasks
		return T("Posiadasz :maxOngoingTasks: zadania. {Anuluj} je, aby wziac nowe.", { maxOngoingTasks = maxOngoingTasks })
	end,
	["TASK_CURRENT_KILLS"] = function(context)
		local task = context.task
		local currentKills = context.player:getStorageValue(task.storage)
		local name = task.name
		local requiredKills = task.requiredKills
		return T("Task na :name:: :currentKills:/:requiredKills: ", {
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
		return T("Nie zabiles wystarczajacej ilosci stworow do taska na :name:. Twoj aktualny postep to: :currentKills:/:requiredKills: ", {
			name = name,
			currentKills = currentKills,
			requiredKills = requiredKills,
		})
	end,
}
