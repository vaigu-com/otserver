local function getLevelBracketDailyTasks()
	local result = {}
	for _, dailyTask in pairs(GetAllDailyTasks()) do
		result[dailyTask.min] = result[dailyTask.min] or {}
		table.insert(result[dailyTask.min], dailyTask)
	end
	return result
end

local function getDailyTasksLevelBrackets()
	local result = {}
	local mem = {}
	for _, dailyTask in pairs(GetAllDailyTasks()) do
		if mem[dailyTask.min] then
			goto continue
		end
		mem[dailyTask.min] = dailyTask.min
		result[#result+1] = dailyTask.min
		::continue::
	end
	return result
end

local function getRandomDailyTasksStorages()
	local dailyTasksByLevel = getLevelBracketDailyTasks()
	local result = {}
	for _, dailyTasks in pairs(dailyTasksByLevel) do
		local randomIndex = math.random(1, #dailyTasks)
		local randomTaskStorage = dailyTasks[randomIndex].storage
		table.insert(result, randomTaskStorage)
	end
	return result
end

DAILY_TASKS_LEVEL_BRACKETS = getDailyTasksLevelBrackets()

local function logDailyTasks()
	local logString = "Daily tasks: "
	for _, dailyTaskSlot in pairs(Storage.DailyTasks.DailyBoardSlots) do
		local storage = KV.get(dailyTaskSlot)
		local name = GetDailyTaskByStorage(storage).name
		logString = logString .. T(":name:, ", { name = name })
	end
	logger.info(logString)
end

local function dailyTasksWereSetToday(currentTimestamp)
	local lastResetTimestamp = KV.get(Storage.DailyTasks.LastResetTimestamp)
	if not lastResetTimestamp then
		return false
	end
	if currentTimestamp <= lastResetTimestamp then
		return true
	end
	return false
end

local function setTodayDailyTasks(currentTimestamp)
	math.randomseed(os.time())
	local todayDailyTasks = getRandomDailyTasksStorages()
	
	for i, dailyTaskSlot in ipairs(Storage.DailyTasks.DailyBoardSlots) do
		KV.set(dailyTaskSlot, todayDailyTasks[i])
	end
	KV.set(Storage.DailyTasks.LastResetTimestamp,currentTimestamp)
end

local dailyQuest = GlobalEvent("dailyQuest")
function dailyQuest.onStartup()
	Game.setStorageValue(GlobalStorage.FlamingOrchid, 0) --???

	local currentDate = os.date("*t")
	local year = currentDate.year
	local month = string.format("%02d", tonumber(currentDate.month))
	local day = string.format("%02d", tonumber(currentDate.day))
	local currentTimestamp = 	tonumber(year..month..day)
	if not dailyTasksWereSetToday(currentTimestamp) then
		setTodayDailyTasks(currentTimestamp)
	end

	logDailyTasks()
end

dailyQuest:register()