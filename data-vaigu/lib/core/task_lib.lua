TASK_FINISHED = -2
TASK_CAN_START_DESPITE_HIGHER_LEVEL = -1

TASK_SLOT_UNNOCUPIED = -1
DAILY_TASK_NOT_STARTED = -1

DAILY_TASK_LIMIT = 3

function Player:TryResetDailyTaskCounter()
    local lastResetTimestamp = self:getStorageValue(Storage.DailyTasks.LastResetTimestamp)
    local todayTimeStamp = KV.get(Storage.DailyTasks.LastResetTimestamp)
    if lastResetTimestamp >= todayTimeStamp then return end
    self:setStorageValue(Storage.DailyTasks.LastResetTimestamp, todayTimeStamp)
    self:setStorageValue(Storage.DailyTasks.DailyLimit, 0)
end

local function resetTaskKillCounter(player, task)
    player:setStorageValue(task.storage, TASK_FINISHED)
end

local function cancelTask(player, task)
    player:setStorageValue(task.storage, TASK_CAN_START_DESPITE_HIGHER_LEVEL)
end

local function resetTaskSlot(player, taskSlot)
    player:setStorageValue(taskSlot, TASK_SLOT_UNNOCUPIED)
end

function Player:DoneAnyTask()
    for _, taskSlot in pairs(Storage.Tasks.PlayerOngoingTasks) do
        local ongoingTaskStorage = self:getStorageValue(taskSlot)
        if ongoingTaskStorage == TASK_SLOT_UNNOCUPIED then goto continue end
        local currentKills = self:getStorageValue(ongoingTaskStorage)
        local requiredKills = GetTaskByStorage(ongoingTaskStorage).requiredKills
        if currentKills >= requiredKills then return true end
        ::continue::
    end
    return false
end

function Player:CanTakeAnotherTask()
    local activeTasks = 0
    local maximumAllowedOngoingTasks = #Storage.Tasks.PlayerOngoingTasks
    for _, taskSlot in pairs(Storage.Tasks.PlayerOngoingTasks) do
        local ongoingTaskStorage = self:getStorageValue(taskSlot)
        if ongoingTaskStorage ~= TASK_SLOT_UNNOCUPIED then
            activeTasks = activeTasks + 1
        end
    end

    return activeTasks < maximumAllowedOngoingTasks
end

function Player:HasAnyOngoingTask()
    for _, taskSlot in pairs(Storage.Tasks.PlayerOngoingTasks) do
        local ongoingTaskStorage = self:getStorageValue(taskSlot)
        if ongoingTaskStorage ~= TASK_SLOT_UNNOCUPIED then return true end
    end

    return false
end

function Player:HasAnyOngoingDailyTask()
    for _, task in pairs(GetAllDailyTasks()) do
        if self:getStorageValue(task.storage) ~= TASK_SLOT_UNNOCUPIED then
            return true
        end
    end
    return false
end

function Player:AddOngoingTask(storage)
    for _, taskSlot in pairs(Storage.Tasks.PlayerOngoingTasks) do
        local ongoingTaskStorage = self:getStorageValue(taskSlot)
        if ongoingTaskStorage == TASK_SLOT_UNNOCUPIED then
            self:setStorageValue(taskSlot, storage)
            self:setStorageValue(storage, 0)
            return
        end
    end
end

function Player:AddOngoingDailyTask(storage) self:setStorageValue(storage, 0) end

local function selectTaskFromList(player, button, choice)
    local task = choice.task
    player:AddOngoingTask(task.storage)
end

local function selectDailyTaskFromList(player, button, choice)
    local dailyTask = choice.dailyTask
    local storage = dailyTask.storage
    player:AddOngoingDailyTask(storage)
    player:AddCustomItem({
        id = 2815,
        aid = storage,
        text = "DAILY_TASK_PAMPHLET_DESCRIPTION",
        addToStore = false
    })
    local dailyTaskActiveMessage = player:Localizer(Storage.DailyTasks
                                                        .DailyTaskInfo):Get(
                                       "YOU_RECEIVED_DAILY_TASK")
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, dailyTaskActiveMessage)
end

local function cancelTaskFromList(player, button, choice)
    if choice.taskSlot then resetTaskSlot(player, choice.taskSlot) end
    cancelTask(player, choice.task)
end

local function canceDailyTaskFromList(player, button, choice)
    if choice.taskSlot then resetTaskSlot(player, choice.taskSlot) end
    cancelTask(player, choice.dailyTask)
end

local function showDailyTaskHelpWindow(player)
    local translatedMessage = player:Localizer(Storage.Tasks.TaskInfo):Get(
                                  "DAILY_TASKS_HELP_WINDOW_INFO")
    player:showTextDialog(2819, translatedMessage)
end

local function showTaskHelpWindow(player)
    local translatedMessage = player:Localizer(Storage.Tasks.TaskInfo):Get(
                                  "TASKS_HELP_WINDOW_INFO")
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
    return player:getStorageValue(task.storage) ==
               TASK_CAN_START_DESPITE_HIGHER_LEVEL
end

local function playerHasThisTaskTaken(player, task)
    for _, taskSlot in pairs(Storage.Tasks.PlayerOngoingTasks) do
        local ongoingTaskStorage = player:getStorageValue(taskSlot)
        if ongoingTaskStorage == task.storage then return true end
    end
    return false
end

local function playerCanTakeTask(player, task)
    if playerHasThisTaskTaken(player, task) then return false end
    if playerIsInTaskLevelRange(player, task) then return true end
    if playerHasMinimumLevel(player, task) and
        playerNeverFinishedTask(player, task) then return true end
    return false
end

function Player:CanTakeDailyTask(dailyTask)
    local minLevel = dailyTask.min
    local maxLevel = dailyTask.max
    local playerLevel = self:getLevel()
    if playerLevel < minLevel then return false end
    if playerLevel > maxLevel then return false end

    local storage = dailyTask.storage
    local dailyTaskProgress = self:getStorageValue(storage)
    if dailyTaskProgress ~= DAILY_TASK_NOT_STARTED then return false end

    return true
end

function OpenTaskWindow(context)
    local player = context.player

    local localizer = player:Localizer(Storage.Tasks.TaskInfo)
    local message = localizer:Get("Select task you're interested in: ")
    local title = localizer:Get("Available Task list")
    local modalWindow = ModalWindow({title = title, message = message})

    local availableTasks = {}
    for _, task in pairs(GetAllTasks()) do
        if playerCanTakeTask(player, task) then
            local availableTask = {
                name = task.name,
                requiredKills = task.requiredKills,
                storage = task.storage
            }
            table.insert(availableTasks, availableTask)
        end
    end

    table.sort(availableTasks, function(a, b) return a.name < b.name end)

    for _, task in pairs(availableTasks) do
        local choice = modalWindow:addChoice(
                           T(":name: (:requiredKills:)", {
                name = task.name,
                requiredKills = task.requiredKills
            }))
        choice.task = task.task
    end

    local select = modalWindow:addButton(localizer:Get("Select"),
                                         selectTaskFromList)
    local cancel = modalWindow:addButton(localizer:Get("Cancel"))

    modalWindow:addButton(localizer:Get("Help"), showTaskHelpWindow)
    modalWindow:setDefaultEnterButton(select.id - 1)
    modalWindow:setDefaultEscapeButton(cancel.id - 1)

    modalWindow:sendToPlayer(player)
end

function OpenDailyTaskWindow(context)
    local player = context.player

    local localizerTasks = player:Localizer(Storage.Tasks.TaskInfo)
    local localizerDailyTasks = player:localizer(Storage.DailyTasks
                                                     .DailyTaskInfo)
    local message = localizerTasks:Get("Select task you're interested in: ")
    local title = localizerDailyTasks:Get("Daily tasks")
    local modalWindow = ModalWindow({title = title, message = message})

    for _, taskSlot in pairs(Storage.DailyTasks.DailyBoardSlots) do
        local storage = KV.get(taskSlot)
        local dailyTask = GetDailyTaskByStorage(storage)
        if not player:CanTakeDailyTask(dailyTask) then goto continue end
        local choiceText = localizerDailyTasks:Context({dailyTask = dailyTask})
                               :Get("DAILY_TASK_FOR_X")
        local choice = modalWindow:addChoice(choiceText)
        choice.dailyTask = dailyTask
        ::continue::
    end

    local select = modalWindow:addButton(localizerTasks:Get("Select"),
                                         selectDailyTaskFromList)
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
    local modalWindow = ModalWindow({title = title, message = message})
    for _, taskSlot in pairs(Storage.Tasks.PlayerOngoingTasks) do
        local ongoingTaskStorage = player:getStorageValue(taskSlot)
        local task = GetTaskByStorage(ongoingTaskStorage)
        if task then
            local choice =
                modalWindow:addChoice(T(":name:", {name = task.name}))
            choice.taskSlot = taskSlot
            choice.task = task
        end
    end

    local select = modalWindow:addButton(localizer:Get("Select"),
                                         cancelTaskFromList)
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
    local modalWindow = ModalWindow({title = title, message = message})
    for _, dailyTask in pairs(GetAllDailyTasks()) do
        if player:getStorageValue(dailyTask.storage) == DAILY_TASK_NOT_STARTED then
            goto continue
        end
        local choice = modalWindow:addChoice(
                           T(":name:", {name = dailyTask.name}))
        choice.dailyTask = dailyTask
        ::continue::
    end

    local select = modalWindow:addButton(localizer:Get("Select"), canceDailyTaskFromList)
    local exit = modalWindow:addButton(localizer:Get("Exit"))
    modalWindow:setDefaultEnterButton(select.id - 1)
    modalWindow:setDefaultEscapeButton(exit.id - 1)

    modalWindow:sendToPlayer(player)
end

function PlayerFinishedTaskAtLeastOnce(player, task)
    return player:getStorageValue(task.storage) == TASK_FINISHED
end

local function grantTaskRewards(context)
    local player = context.player
    local task = context.task or context.dailyTask

    if not player:TryAddItems(task.rewards or {}) then return false end
    local money = task.money
    local points = task.tibiaCoins
    local exp = task.exp

    player:addMoney(money)
    player:addTibiaCoins(points)
    player:addTransferableCoins(points)
    player:IncrementStorage(Storage.taskPoints, points)
    player:addExperience(exp, true)
    return false
end

local function allowBossAccess(player, task)
    local bossAccessStorage = task.bossStorage
    player:IncrementStorage(bossAccessStorage, 1)
end

function Player:TryAddTaskRewards(context, task)
    local storage = task.storage
    local currentKills = self:getStorageValue(storage)
    local requiredKills = task.requiredKills
    if currentKills < requiredKills then return "" end
    if not grantTaskRewards(context) then return "" end
    allowBossAccess(self, task)
    resetTaskKillCounter(self, task)
    resetTaskSlot(self, task.storage)

    return self:Localizer(Storage.Tasks.TaskInfo):Context({task = task}):Get(
               "TASK_REWARDS_DIALOGUE")
end

function Player:GrantRewardsForAllTasks(context)
    local translatedMessage = ""
    for _, taskSlot in pairs(Storage.Tasks.PlayerOngoingTasks) do
        local ongoingTaskStorage = self:getStorageValue(taskSlot)
        local task = GetTaskByStorage(ongoingTaskStorage)
        local taskMessage = self:TryAddTaskRewards(context, task)
        if taskMessage ~= "" then
            translatedMessage = translatedMessage .. taskMessage .. "\n"
        end
    end

    translatedMessage = translatedMessage ..
                            self:Localizer(Storage.Tasks.TaskInfo)
                                :Get("Great job!")
    context.npcHandler:say(translatedMessage, context.npc, context.player)
end

function Player:TryAddDailyTaskRewards(context, dailyTask)
    local storage = dailyTask.storage
    local currentKills = self:getStorageValue(storage)
    if currentKills == TASK_SLOT_UNNOCUPIED then return "" end
    local requiredKills = dailyTask.requiredKills
    local requiredItems = dailyTask.items
    local localizer = self:Localizer(Storage.DailyTasks.DailyTaskInfo):Context({
        dailyTask = dailyTask
    })
    if self:getStorageValue(Storage.DailyTasks.DailyLimit) >= DAILY_TASK_LIMIT then
        return self:Localizer(Storage.DailyTasks.DailyTaskInfo):Get(
                   "YOU_EXCEEDED_DAILY_TASK_LIMIT")
    end
    if currentKills < requiredKills then
        return localizer:Get("YOU_DONT_HAVE_REQUIRED_DAILY_TASK_KILLS")
    end
    if not self:HasItems(requiredItems) then
        return localizer:Get("YOU_DONT_HAVE_REQUIRED_DAILY_TASK_ITEMS")
    end

    context.dailyTask = dailyTask
    self:RemoveItems(requiredItems)
    grantTaskRewards(context)
    resetTaskKillCounter(self, dailyTask)
    resetTaskSlot(self, storage)
    self:IncrementStorage(Storage.DailyTasks.DailyLimit, 1)
    return localizer:Get("DAILY_TASK_REWARDS_DIALOGUE")
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
        translatedMessage = self:Localizer(Storage.DailyTasks.DailyTaskInfo)
                                :Get("YOU_DONT_HAVE_ONGOING_DAILY_TASK")
    end
    context.npcHandler:say(translatedMessage, context.npc, context.player)

end
