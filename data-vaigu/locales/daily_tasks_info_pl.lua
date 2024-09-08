return {
	["You don't have any active daily tasks. You can sign up for daily task on the daily task board. Please report me if you finish one of them."] = "Widze, ze nie podjales sie zadnych zadan. Mozesz przejrzec tablice ogloszen i podjac sie ktoregos z dzisiejszych zadan. Jak jakies ukonczysz to zglos sie do mnie.",
	["Hello |PLAYERNAME|. You already finished a daily {task} from the notice board? You can {cancel} it whenever you want. I also have some {outfit} for the most generous donors."] = "Witaj |PLAYERNAME|. Widziales dzisiejsze {ogloszenie}? Jesli chcesz, to mozesz z niego {zrezygnowac}. Posiadam takze pewnien {stroj} do zaoferowania.",
	["DAILY_TASKS_HELP_WINDOW_INFO"] = function()
		return T("Za wykonywanie zadan z ogloszenia dostajesz nagrody w postaci expa i pieniedzy.\n\nPo zakonczeniu zadania i zebraniu materialow mozesz udac sie po nagrode to Pani Burmistrz.\n\nKazdego dnia mozesz otrzymac nagrode za maksymalnie :maxTasks: zadan.\n\n.Ukonczone zadanie mozesz oddac nastepnego dnia.", { maxTasks = DAILY_TASK_LIMIT })
	end,
	["DAILY_TASK_REWARDS_DIALOGUE"] = function(context)
		local taskConfig = context.taskConfig
		return T("Nagroda za dzisiejszy task na :name: to: :exp: punktow doswiadczenia oraz :money: zlota.\n Utrzymujesz :points: coiny oraz punkty taskow.", {
			name = taskConfig.name,
			exp = taskConfig.exp,
			money = taskConfig.money,
			points = taskConfig.tibiaCoins,
		})
	end,
	["YOU_RECEIVED_DAILY_TASK"] = "Podjales sie dziennego zadania!",
	["YOU_TAKEN_ALL_AVAILABLE_DAILY_TASKS"] = "Podjales sie wszystkich dzisiejszych zadan. Ukoncz ktores z nich aby moc podjac sie kolejnych.",
	["YOU_DONT_HAVE_REQUIRED_DAILY_TASK_ITEMS"] = function(context)
		local dailyTask = context.dailyTask
		local requiredItems = dailyTask.items

		local errorMessage = T("Nie masz wystarczajacej ilosci przedmiotow, aby ukonczyc dzisiejsze zadanie na :name:. Potrzebujesz nastepujacych przedmiotow:", { name = dailyTask.name })
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
		local currentKills = player:getStorageValue(dailyTask.storage)
		local requiredKills = dailyTask.requiredKills
		local name = dailyTask.name
		return T("Nie zabiles wystarczajacej ilosci stworow do dzisiejszego ogloszenia na :name:. Twoj aktualny postep to: :currentKills:/:requiredKills: ", {
			name = name,
			currentKills = currentKills,
			requiredKills = requiredKills,
		})
	end,
	["YOU_EXCEEDED_DAILY_TASK_LIMIT"] = function()
		return T("Wez nie przesadzaj, moge ci wyplacic tylko za :max: ogloszen. Wroc jutro to pogadamy.", { max = DAILY_TASK_LIMIT })
	end,
	["DAILY_TASK_READY_TO_TURN_IN"] = function(context)
		return T("Dzisiejsze zadanie na :name: zostalo ukonczone! Upewnij sie, ze zabrales odpowiednia ilosc przedmiotow i udaj do pani Burmistrz po nagrode!", { name = context.dailyTask.name })
	end,
	["DAILY_TASK_FOR_X"] = function(context)
		local dailyTask = context.dailyTask
		return T("Dzisiejsze zadanie na :name:!", { name = dailyTask.name })
	end,
	["Daily tasks"] = "Ogloszenia",
	["DAILY_TASK_CURRENT_KILLS"] = function(context)
		local taskConfig = context.taskConfig
		local currentKills = context.player:getStorageValue(taskConfig.storage)
		local name = taskConfig.name
		local requiredKills = taskConfig.requiredKills
		return T("Dzisiejsze zadanie na :name:: :currentKills:/:requiredKills: ", {
			name = name,
			currentKills = currentKills,
			requiredKills = requiredKills,
		})
	end,
}
