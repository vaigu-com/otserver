local notifySeconds = {
	15 * 60,
	10 * 60,
	5 * 60,
	4 * 60,
	3 * 60,
	2 * 60,
	1 * 60,
	45,
	30,
	15,
	14,
	13,
	12,
	11,
	10,
	9,
	8,
	7,
	6,
	5,
	4,
	3,
	2,
	1,
}

local function formatNotifyMessage(seconds)
	local minutes = math.floor(seconds / 60)
	local sec = seconds % 60
	return string.format("%d:%02d", minutes, sec)
end

local function getNotifyTime(hour, offsetSeconds)
	local totalSeconds = hour * 3600 - offsetSeconds
	if totalSeconds < 0 then
		totalSeconds = totalSeconds + 24 * 3600
	end
	local h = math.floor(totalSeconds / 3600)
	local m = math.floor((totalSeconds % 3600) / 60)
	local s = totalSeconds % 60
	return string.format("%02d:%02d:%02d", h, m, s)
end

local serverRestart = tonumber(configManager.getString(configKeys.SERVER_RESTART_HOUR))
for _, seconds in ipairs(notifySeconds) do
	local notifyEvent = GlobalEvent("notifyRestart_" .. seconds)
	function notifyEvent.onTime(interval)
		local formattedTime = formatNotifyMessage(seconds)
		if seconds >= 15 then
			Game.broadcastMessage("SERVER_RESTART_NOTIFY", MESSAGE_GAME_HIGHLIGHT, true, { formattedTime = formattedTime })
		else
			Game.broadcastMessage("SERVER_RESTART_NOTIFY", MESSAGE_STATUS, true, { formattedTime = formattedTime })
		end
	end

	local notifyTime = getNotifyTime(serverRestart, seconds)
	notifyEvent:time(notifyTime)
	notifyEvent:register()
end

local dailyRestart = GlobalEvent("dailyRestart")
function dailyRestart.onTime(interval)
	Game.setGameState(GAME_STATE_CLOSED, true)

	addEvent(function()
		Game.setGameState(GAME_STATE_SHUTDOWN, true)
	end, 15 * 1000)
end
dailyRestart:time(string.format("%02d:00:00", serverRestart))
dailyRestart:register()

local dailyRestartForce = GlobalEvent("dailyRestartForce")
function dailyRestartForce.onTime(interval)
	Game.setGameState(GAME_STATE_SHUTDOWN, true)
end
dailyRestartForce:time(string.format("%02d:00:20", serverRestart))
dailyRestartForce:register()

-- TODO: rework daily resets to happen at set time, not only at restart; this allows not to restart server besides maintenances
