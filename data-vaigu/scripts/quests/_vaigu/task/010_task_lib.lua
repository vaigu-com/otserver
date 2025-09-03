TASK_CANT_START_BECAUSE_HIGHER_LEVEL = -2
TASK_CAN_START_DESPITE_HIGHER_LEVEL = -1

TASK_SLOT_UNNOCUPIED = -1
DAILY_TASK_NOT_STARTED = -1

DAILY_TASK_LIMIT = 3

function Player:TryResetDailyTaskCounter()
	if self:isLockoutExpired(Storage.DailyTasks.LastResetTimestamp) then
		self:setLockoutExpiry(Storage.DailyTasks.DailyTasks, LOCKOUT_EXPIRY_TIME.DAILY)
		self:setStorageValueByKey(Storage.DailyTasks.DailyLimit, 0)
	end
end

local function resetTaskSuccesfulCompletion(player, task)
	player:setStorageValueByKey(task.currentKills, MISSION_NOT_STARTED)
	player:setStorageValueByKey(task.storage, TASK_CANT_START_BECAUSE_HIGHER_LEVEL)
end

local function cancelTask(player, task)
	player:setStorageValueByKey(task.currentKills, MISSION_NOT_STARTED)
	player:setStorageValueByKey(task.storage, TASK_CAN_START_DESPITE_HIGHER_LEVEL)
end

local function resetTaskSlot(player, taskSlot)
	player:setStorageValueByKey(taskSlot, TASK_SLOT_UNNOCUPIED)
end

local function resetDailyTask(player, task)
	player:setStorageValueByKey(task.currentKills, MISSION_NOT_STARTED)
	player:setStorageValueByKey(task.storage, TASK_SLOT_UNNOCUPIED)
end

function Player:DoneAnyTask()
	for _, taskSlot in pairs(Storage.Tasks.PlayerOngoingTasks) do
		local ongoingTaskStorage = self:getStorageValueByKey(taskSlot)
		if ongoingTaskStorage ~= TASK_SLOT_UNNOCUPIED then
			local task = GetTaskByStorage(ongoingTaskStorage)
			if not task then
				self:setStorageValueByKey(taskSlot, -1)
				return
			end
			local state = self:getStorageValueByKey(task.storage)
			if state == REPORT_TASK_TO_NPC then
				return true
			end
		end
	end
	return false
end

function Player:CanTakeAnotherTask()
	local activeTasks = 0
	local maximumAllowedOngoingTasks = #Storage.Tasks.PlayerOngoingTasks
	for _, taskSlot in pairs(Storage.Tasks.PlayerOngoingTasks) do
		local ongoingTaskStorage = self:getStorageValueByKey(taskSlot)
		if ongoingTaskStorage ~= TASK_SLOT_UNNOCUPIED then
			activeTasks = activeTasks + 1
		end
	end

	return activeTasks < maximumAllowedOngoingTasks
end

function Player:HasAnyOngoingTask()
	for _, taskSlot in pairs(Storage.Tasks.PlayerOngoingTasks) do
		local ongoingTaskStorage = self:getStorageValueByKey(taskSlot)
		if ongoingTaskStorage ~= TASK_SLOT_UNNOCUPIED then
			return true
		end
	end

	return false
end

function Player:HasAnyOngoingDailyTask()
	for _, task in pairs(GetAllDailyTasks()) do
		if self:getStorageValueByKey(task.storage) ~= TASK_SLOT_UNNOCUPIED then
			return true
		end
	end
	return false
end

function Player:AddOngoingTask(task)
	for _, taskSlot in pairs(Storage.Tasks.PlayerOngoingTasks) do
		local ongoingTaskStorage = self:getStorageValueByKey(taskSlot)
		if ongoingTaskStorage == TASK_SLOT_UNNOCUPIED then
			self:setStorageValueByKey(task.currentKills, 0)
			self:setStorageValueByKey(task.storage, MISSION_STARTED)
			self:setStorageValueByKey(taskSlot, task.storage)
			return
		end
	end
end

function Player:AddOngoingDailyTask(dailyTask)
	self:setStorageValueByKey(dailyTask.currentKills, 0)
	self:setStorageValueByKey(dailyTask.storage, MISSION_STARTED)
end

local function selectTaskFromList(player, button, choice)
	local task = choice.task
	player:AddOngoingTask(task)
end

local function selectDailyTaskFromList(player, button, choice)
	local dailyTask = choice.dailyTask
	local storage = dailyTask.storage
	player:AddOngoingDailyTask(dailyTask)
	player:AddCustomItem({
		id = 2815,
		key = storage,
		text = "DAILY_TASK_PAMPHLET_DESCRIPTION",
		addToStore = false,
	})
	local dailyTaskActiveMessage = player:Localizer(Storage.DailyTasks.DailyTaskInfo):Get("YOU_RECEIVED_DAILY_TASK")
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, dailyTaskActiveMessage)
end

local function cancelTaskFromList(player, button, choice)
	if choice.task then
		cancelTask(player, choice.task)
	end
	if choice.taskSlot then
		resetTaskSlot(player, choice.taskSlot)
	end
end

local function canceDailyTaskFromList(player, button, choice)
	if choice.dailyTask then
		resetDailyTask(player, choice.dailyTask)
	end
end

local function showDailyTaskHelpWindow(player)
	local translatedMessage = player:Localizer(Storage.Tasks.TaskInfo):Get("DAILY_TASKS_HELP_WINDOW_INFO")
	player:showTextDialog(2819, translatedMessage)
end

local function showTaskHelpWindow(player)
	local translatedMessage = player:Localizer(Storage.Tasks.TaskInfo):Get("TASKS_HELP_WINDOW_INFO")
	player:showTextDialog(7397, translatedMessage)
end

local function playerIsInTaskLevelRange(player, task)
	local playerLevel = player:getLevel()
	local min = task.min or 0
	local max = task.max or 99999
	return min <= playerLevel and playerLevel <= max
end

local function playerHasMinimumLevel(player, task)
	local playerLevel = player:getLevel()
	local min = task.min or 0
	return min <= playerLevel
end

local function playerNeverFinishedTask(player, task)
	return player:getStorageValueByKey(task.storage) == TASK_CAN_START_DESPITE_HIGHER_LEVEL
end

local function playerHasThisTaskTaken(player, task)
	for _, taskSlot in pairs(Storage.Tasks.PlayerOngoingTasks) do
		local ongoingTaskStorage = player:getStorageValueByKey(taskSlot)
		if ongoingTaskStorage == task.storage then
			return true
		end
	end
	return false
end

local function playerCanTakeTask(player, task)
	if playerHasThisTaskTaken(player, task) then
		return false
	end
	if playerIsInTaskLevelRange(player, task) then
		return true
	end
	if playerHasMinimumLevel(player, task) and playerNeverFinishedTask(player, task) then
		return true
	end
	return false
end

function Player:CanTakeDailyTask(dailyTask)
	local minLevel = dailyTask.min
	local maxLevel = dailyTask.max
	local playerLevel = self:getLevel()
	if playerLevel < minLevel then
		return false
	end
	if playerLevel > maxLevel then
		return false
	end

	local storage = dailyTask.storage
	local dailyTaskProgress = self:getStorageValueByKey(storage)
	if dailyTaskProgress ~= DAILY_TASK_NOT_STARTED then
		return false
	end

	return true
end

function OpenTaskWindow(context)
	local player = context.player

	local localizer = player:Localizer(Storage.Tasks.TaskInfo)
	local message = localizer:Get("Select task you're interested in: ")
	local title = localizer:Get("Available Task list")
	local modalWindow = ModalWindow({ title = title, message = message })

	local availableTasks = {}
	for _, task in pairs(GetAllTasks()) do
		if playerCanTakeTask(player, task) then
			table.insert(availableTasks, task)
		end
	end

	table.sort(availableTasks, function(a, b)
		return a.name < b.name
	end)

	for _, task in pairs(availableTasks) do
		local choice = modalWindow:addChoice(T(":name: (:requiredKills:)", {
			name = task.name,
			requiredKills = task.requiredKills,
			task = task.task,
		}))
		choice.task = task
	end

	local select = modalWindow:addButton(localizer:Get("Select"), selectTaskFromList)
	local cancel = modalWindow:addButton(localizer:Get("Cancel"))

	modalWindow:addButton(localizer:Get("Help"), showTaskHelpWindow)
	modalWindow:setDefaultEnterButton(select.id - 1)
	modalWindow:setDefaultEscapeButton(cancel.id - 1)

	modalWindow:sendToPlayer(player)
end

function OpenDailyTaskWindow(context)
	local player = context.player

	local localizerTasks = player:Localizer(Storage.Tasks.TaskInfo)
	local localizerDailyTasks = player:Localizer(Storage.DailyTasks.DailyTaskInfo)
	local message = localizerTasks:Get("Select task you're interested in: ")
	local title = localizerDailyTasks:Get("Daily tasks")
	local modalWindow = ModalWindow({ title = title, message = message })

	for i = 1, DAILY_TASKS_LEVEL_BRACKETS_COUNT do
		local dailyTask = GetDailyTaskByIndex(i)
		if player:CanTakeDailyTask(dailyTask) then
			local choiceText = localizerDailyTasks:Context({ dailyTask = dailyTask }):Get("DAILY_TASK_FOR_X")
			local choice = modalWindow:addChoice(choiceText)
			choice.dailyTask = dailyTask
		end
	end

	local select = modalWindow:addButton(localizerTasks:Get("Select"), selectDailyTaskFromList)
	local cancel = modalWindow:addButton(localizerTasks:Get("Cancel"))

	modalWindow:addButton(localizerTasks:Get("Help"), showDailyTaskHelpWindow)
	modalWindow:setDefaultEnterButton(select.id - 1)
	modalWindow:setDefaultEscapeButton(cancel.id - 1)

	modalWindow:sendToPlayer(player)
end

function OpenTaskCancelWindow(context)
	local player = context.player

	local localizer = player:Localizer(Storage.Tasks.TaskInfo)
	local message = localizer:Get("Select task you want to cancel: ")
	local title = localizer:Get("Ongoing tasks list:")
	local modalWindow = ModalWindow({ title = title, message = message })
	for _, taskSlot in pairs(Storage.Tasks.PlayerOngoingTasks) do
		local ongoingTaskStorage = player:getStorageValueByKey(taskSlot)
		local task = GetTaskByStorage(ongoingTaskStorage)
		if task then
			local choice = modalWindow:addChoice(T(":name:", { name = task.name }))
			choice.taskSlot = taskSlot
			choice.task = task
		end
	end

	local select = modalWindow:addButton(localizer:Get("Select"), cancelTaskFromList)
	local exit = modalWindow:addButton(localizer:Get("Exit"))

	modalWindow:addButton(localizer:Get("Help"), showTaskHelpWindow)
	modalWindow:setDefaultEnterButton(select.id - 1)
	modalWindow:setDefaultEscapeButton(exit.id - 1)

	modalWindow:sendToPlayer(player)
end

function OpenDailyTaskCancelWindow(context)
	local player = context.player

	local localizer = player:Localizer(Storage.Tasks.TaskInfo)
	local message = localizer:Get("Select task you want to cancel: ")
	local title = localizer:Get("Ongoing tasks list:")
	local modalWindow = ModalWindow({ title = title, message = message })
	for _, dailyTask in pairs(GetAllDailyTasks()) do
		if player:getStorageValueByKey(dailyTask.storage) ~= DAILY_TASK_NOT_STARTED then
			local choice = modalWindow:addChoice(T(":name:", { name = dailyTask.name }))
			choice.dailyTask = dailyTask
		end
	end

	local select = modalWindow:addButton(localizer:Get("Select"), canceDailyTaskFromList)
	local exit = modalWindow:addButton(localizer:Get("Exit"))
	modalWindow:setDefaultEnterButton(select.id - 1)
	modalWindow:setDefaultEscapeButton(exit.id - 1)

	modalWindow:sendToPlayer(player)
end

function PlayerFinishedTaskAtLeastOnce(player, task)
	return player:getStorageValueByKey(task.storage) == TASK_CANT_START_BECAUSE_HIGHER_LEVEL
end

TRANSFERABLE_COINS_GAIN_MULTIPLIER = 10
function Player:AddAllCoins(coins)
	self:addTibiaCoins(coins)
	self:addTransferableCoins(coins * TRANSFERABLE_COINS_GAIN_MULTIPLIER)
end

local function grantTaskRewards(context, task)
	local player = context.player

	if not player:TryAddItems(task.rewards or {}) then
		return false
	end
	local money = task.money
	local coins = task.tibiaCoins
	local exp = task.exp

	player:addMoney(money)
	player:AddAllCoins(coins)
	player:IncrementStorage(Storage.Tasks.TaskPoints, coins)
	player:addExperience(exp, true)
	return true
end

local rewardWasNotGranted = false
local rewardWasGranted = true
function Player:TryAddTaskRewards(context, task, taskSlot)
	local storage = task.storage
	local state = self:getStorageValueByKey(storage)
	if state ~= REPORT_TASK_TO_NPC then
		return rewardWasNotGranted
	end
	if not grantTaskRewards(context, task) then
		return rewardWasNotGranted
	end
	resetTaskSuccesfulCompletion(self, task)
	resetTaskSlot(self, taskSlot)
	return rewardWasGranted
end

function Player:GrantRewardsForAllTasks(context)
	local translatedMessage = ""
	for _, taskSlot in pairs(Storage.Tasks.PlayerOngoingTasks) do
		local ongoingTaskStorage = self:getStorageValueByKey(taskSlot)
		local task = GetTaskByStorage(ongoingTaskStorage)
		if task then
			local grantedRewardForThisTask = self:TryAddTaskRewards(context, task, taskSlot)
			if grantedRewardForThisTask then
				translatedMessage = translatedMessage .. self:Localizer(LOCALIZERS.Tasks):Context({ task = task }):Get("TASK_REWARDS_DIALOG") .. "\n"
			end
		end
	end

	translatedMessage = translatedMessage .. self:Localizer(LOCALIZERS.Tasks):Get("Great job!")
	context.npcHandler:say(translatedMessage, context.npc, context.player)
end

function Player:TryAddDailyTaskRewards(context, dailyTask)
	local storage = dailyTask.storage
	local dailyTaskState = self:getStorageValueByKey(storage)
	if dailyTaskState == TASK_SLOT_UNNOCUPIED then
		return ""
	end

	local localizer = self:Localizer(Storage.DailyTasks.DailyTaskInfo):Context({
		dailyTask = dailyTask,
	})

	if self:getStorageValueByKey(Storage.DailyTasks.DailyLimit) >= DAILY_TASK_LIMIT then
		return localizer:Get("YOU_EXCEEDED_DAILY_TASK_LIMIT")
	end

	local requiredKills = dailyTask.requiredKills
	local currentKills = self:getStorageValueByKey(dailyTask.currentKills)
	if currentKills < requiredKills then
		return localizer:Get("YOU_DONT_HAVE_REQUIRED_DAILY_TASK_KILLS")
	end

	local requiredItems = dailyTask.items
	if not self:HasItems(requiredItems) then
		return localizer:Get("YOU_DONT_HAVE_REQUIRED_DAILY_TASK_ITEMS")
	end

	self:RemoveItems(requiredItems)
	grantTaskRewards(context, dailyTask)
	resetTaskSuccesfulCompletion(self, dailyTask)
	resetDailyTask(self, dailyTask)
	self:IncrementStorage(Storage.DailyTasks.DailyLimit, 1)
	return localizer:Get("DAILY_TASK_REWARDS_DIALOG")
end

function Player:GrantRewardsForAllDailyTasks(context)
	local translatedMessage = ""
	for _, dailyTask in pairs(GetAllDailyTasks()) do
		local taskMessage = self:TryAddDailyTaskRewards(context, dailyTask)
		if taskMessage ~= "" then
			translatedMessage = translatedMessage .. taskMessage .. "\n"
		end
	end
	if translatedMessage == "" then
		translatedMessage = self:Localizer(Storage.DailyTasks.DailyTaskInfo):Get("YOU_DONT_HAVE_ONGOING_DAILY_TASK")
	end
	context.npcHandler:say(translatedMessage, context.npc, context.player)
end
