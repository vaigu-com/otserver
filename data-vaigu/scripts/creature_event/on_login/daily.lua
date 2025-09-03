-- key: storage to be reset
-- value: storage reset target value
local dailyStorages = {
	[Storage.GameStore.ExpBoostCount] = 0,
}
local weeklyStorages = {}

local function tryResetDaily(player)
	if not player:isLockoutExpired(Storage.NextDailyReset) then
		return
	end

	for k, v in pairs(dailyStorages) do
		player:kv():set(k, v)
	end

	player:setLockoutExpiry(Storage.NextDailyReset, LOCKOUT_EXPIRY_TIME.DAILY)
end

local function tryResetWeekly(player)
	if not player:isLockoutExpired(Storage.NextWeeklyReset) then
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
