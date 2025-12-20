--[[
DONT_BROADCAST_SERVER_SAVE_COMPLETE = true
local function serverSave()
	if configManager.getBoolean(configKeys.TOGGLE_SAVE_INTERVAL_CLEAN_MAP) then
		cleanMap()
	end

	saveServer()
	if DONT_BROADCAST_SERVER_SAVE_COMPLETE then
		return
	end
	local message = string.format(SAVE_INTERVAL_CONFIG_TIME > 1 and "Server save complete. Next save in %d %ss!" or "Server save complete. Next save in %d %s!", SAVE_INTERVAL_CONFIG_TIME, SAVE_INTERVAL_TYPE)
	Game.broadcastMessage(message, MESSAGE_GAME_HIGHLIGHT)
	logger.info(message)
	Webhook.sendMessage("Server save", message, WEBHOOK_COLOR_WARNING)
end

local save = GlobalEvent("save")
function save.onTime(interval)
	local remainingTime = 60 * 10
	if configManager.getBoolean(configKeys.TOGGLE_SAVE_INTERVAL) then
		--local message = "The server will save all accounts within " .. (remainingTime / 1000) .. " seconds. \z
		--You might lag or freeze for 5 seconds, please find a safe place."
		--Game.broadcastMessage(message, MESSAGE_GAME_HIGHLIGHT)
		--logger.info(string.format(message, SAVE_INTERVAL_CONFIG_TIME, SAVE_INTERVAL_TYPE))
		serverSave()
		return true
	end
	return not configManager.getBoolean(configKeys.TOGGLE_SAVE_INTERVAL)
end
if SAVE_INTERVAL_TIME_SECONDS ~= 0 then
	save:interval(2000)
else
	return logger.error(string.format("[save.onTime] - Save interval type '%s' is not valid, use 'second', 'minute' or 'hour'", SAVE_INTERVAL_TYPE))
end
save:register()
]]

local registerAutoSave = GlobalEvent("save_interval.lua")
function registerAutoSave.onStartup()
	if SAVE_INTERVAL_TIME_SECONDS <= 0 then
		logger.warn("[registerAutoSave.onStartup] saving each interval is disabled because: SAVE_INTERVAL_TIME_SECONDS is <= 0")
		return
	end

	local save = GlobalEvent("save")
	function save.onTime(interval)
		saveServer()
		return true
	end
	save:interval(SAVE_INTERVAL_TIME_SECONDS * 1000)
	save:register()
end
registerAutoSave:register()
