local savingEvent = 0
local scheduledSavesEnabled = configManager.getBoolean(configKeys.TOGGLE_SAVE_INTERVAL)

local save = TalkAction("/save")

function save.onSay(player, words, param)
	-- create log
	logCommand(player, words, param)
	if scheduledSavesEnabled then
        player:sendTextMessage(MESSAGE_ADMINISTRATOR, "Cannot save server with /save beacause: 'toggleSaveInterval' is true")
        return
    end

    player:sendTextMessage(MESSAGE_ADMINISTRATOR, "Server server...")
    saveServer()
    if configManager.getBoolean(configKeys.TOGGLE_SAVE_ASYNC) then
        logger.warn("/save - saves are async, saving outcome indeterminate")
    else
    	player:sendTextMessage(MESSAGE_ADMINISTRATOR, "Server was saved!")
    end

	return true
end

save:separator(" ")
save:groupType("god")
save:register()
