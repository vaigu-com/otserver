local shutdownAtServerSave = true
local closeAtServerSave = false
local cleanMapAtServerSave = true

local function serverSave()
	if shutdownAtServerSave then
		Game.setGameState(GAME_STATE_SHUTDOWN, true)
	end
	if closeAtServerSave then
		Game.setGameState(GAME_STATE_CLOSED, true)
	end
	if cleanMapAtServerSave then
		cleanMap()
	end
	-- Updating daily reward next server save.
	UpdateDailyRewardGlobalStorage(DailyReward.storages.lastServerSave, os.time())
	-- Reset gamestore exp boost count.
	db.query("UPDATE `player_storage` SET `value` = 0 WHERE `player_storage`.`key` = 51052")
	-- Add +1 day since start
	db.query("UPDATE `server_config` SET `value` = `value` + 1 WHERE `server_config`.`config` = 'day_since_start'")
end

local function secondServerSaveWarning()
	Game.broadcastMessage("Uwaga! Za minute restart serwera, wracamy po krotkiej przerwie.", MESSAGE_GAME_HIGHLIGHT)
	addEvent(serverSave, 60000)
end

local function firstServerSaveWarning()
	Game.broadcastMessage("Za 3 minuty restart serwera, radzimy udac sie w bezpieczne miejsce.", MESSAGE_GAME_HIGHLIGHT)
	addEvent(secondServerSaveWarning, 120000)
end

local serverSaveEvent = GlobalEvent("serversave")
function serverSaveEvent.onTime(interval)
	Game.broadcastMessage("Za 5 minut restart serwera, radzimy udac sie w bezpieczne miejsce.", MESSAGE_GAME_HIGHLIGHT)
	Game.setGameState(GAME_STATE_STARTUP)
	addEvent(firstServerSaveWarning, 120000)
	return not shutdownAtServerSave
end

serverSaveEvent:time(configManager.getString(configKeys.GLOBAL_SERVER_SAVE_TIME))
serverSaveEvent:register()
