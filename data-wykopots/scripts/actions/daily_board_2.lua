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

local dailyBoard = Action()
function dailyBoard.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	player:setStorageValue(Storage.DailyTasks.DailyTaskInfo, 0)
	if not playerCanTakeAnyDailyTask(player) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, player:Localizer(Storage.DailyTasks.DailyTaskInfo):Get("YOU_TAKEN_ALL_AVAILABLE_DAILY_TASKS"))
		return false
	end

	OpenDailyTaskWindow({ player = player })
	return true
end

dailyBoard:aid(12000)
dailyBoard:register()
