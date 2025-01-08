local function wereDailyResetToday(player)
	local nextReset = player:kv():get(Storage.NextDailyReset) or 0
	return os.time() <= nextReset
end

local function wereWeeklyResetThisWeek(player)
	local nextReset = player:kv():get(Storage.NextWeeklyReset) or 0
	return NextWednesdayEpochTime() <= nextReset
end

local dailyStorages = {
	[Storage.GameStore.ExpBoostCount] = 0,
}
local weeklyStorages = {}

local function tryResetDaily(player)
	if wereDailyResetToday(player) then
		return
	end

	for k, v in pairs(dailyStorages) do
		player:kv():set(k, v)
	end

	player:kv():set(Storage.NextDailyReset, NextDayEpochTime())
end

local function tryResetWeekly(player)
	if wereWeeklyResetThisWeek(player) then
		return
	end

	for k, v in pairs(weeklyStorages) do
		player:kv():set(k, v)
	end

	player:kv():set(Storage.NextWeeklyReset, NextDayEpochTime())
end

local playerLogin = CreatureEvent("DailyResetPlayer")
function playerLogin.onLogin(player)
	tryResetDaily(player)
	tryResetWeekly(player)
	return true
end

playerLogin:register()
