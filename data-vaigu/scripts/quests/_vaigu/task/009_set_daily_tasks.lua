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
		if not mem[dailyTask.min] then
			mem[dailyTask.min] = dailyTask.min
			result[#result + 1] = dailyTask.min
		end
	end
	return result
end

local function generateRandomDailyTasks()
	local dailyTasksByLevel = getLevelBracketDailyTasks()
	local randomDailyTasks = {}

	for requiredLevel, dailyTasksForThisLevel in pairs(dailyTasksByLevel) do
		local randomIndex = math.random(1, #dailyTasksForThisLevel)
		local randomTaskStorage = dailyTasksForThisLevel[randomIndex]
		table.insert(randomDailyTasks, randomTaskStorage)
	end
	return randomDailyTasks
end

DAILY_TASKS_LEVEL_BRACKETS_COUNT = #getDailyTasksLevelBrackets()

function SetDailyTaskByIndex(slotIndex, data)
	Game.setStorageValueByKey("daily-task-slot-" .. tostring(slotIndex), data)
end

function GetDailyTaskByIndex(slotIndex)
	return Game.getStorageValueByKey("daily-task-slot-" .. tostring(slotIndex))
end

local function logDailyTasks()
	local logString = "Daily tasks: "
	for slotIndex = 1, DAILY_TASKS_LEVEL_BRACKETS_COUNT do
		logString = logString .. T(":name:, ", { name = GetDailyTaskByIndex(slotIndex).name })
	end
	logger.info(logString)
end

local function wereDailyTasksSetToday(currentTimestamp)
	local lastResetTimestamp = Game.getStorageValueByKey(Storage.DailyTasks.LastResetTimestamp)
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
	local todayDailyTasks = generateRandomDailyTasks()
	for i, task in ipairs(todayDailyTasks) do
		SetDailyTaskByIndex(i, task)
	end
	Game.setStorageValueByKey(Storage.DailyTasks.LastResetTimestamp, currentTimestamp)
end

local function calculateTodayDate()
	local currentDate = os.date("*t")
	local year = currentDate.year
	local month = string.format("%02d", tonumber(currentDate.month))
	local day = string.format("%02d", tonumber(currentDate.day))
	local todayDate = tonumber(year .. month .. day)
	return todayDate
end

local dailyQuest = GlobalEvent("dailyQuest")
function dailyQuest.onStartup()
	Game.setStorageValueByKey(Storage.FlamingOrchid, 0) --39f

	local todayDate = calculateTodayDate()
	if not wereDailyTasksSetToday(todayDate) then
		setTodayDailyTasks(todayDate)
	end

	logDailyTasks()
end

dailyQuest:register()
