local function wereDailyResetToday(player)
	return IsLockoutExpired(player, Storage.NextDailyReset)
end

local function wereWeeklyResetThisWeek(player)
	return IsLockoutExpired(player, Storage.NextWeeklyReset)
end

-- key: storage to be reset
-- value: storage reset target value
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

	player:setLockoutExpiry(Storage.NextDailyReset, LOCKOUT_EXPIRY_TIME.DAILY)
end

local function tryResetWeekly(player)
	if wereWeeklyResetThisWeek(player) then
		return
	end

	for k, v in pairs(weeklyStorages) do
		player:kv():set(k, v)
	end

	player:setLockoutExpiry(Storage.NextWeeklyReset, LOCKOUT_EXPIRY_TIME.WEEKLY)
end

local playerLogin = CreatureEvent("DailyResetPlayer")
function playerLogin.onLogin(player)
	tryResetDaily(player)
	tryResetWeekly(player)
	return true
end

playerLogin:register()
