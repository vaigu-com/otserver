local save = TalkAction("/save")

function save.onSay(player, words, param)
	-- create log
	logCommand(player, words, param)
	if SAVE_INTERVAL_TIME_SECONDS > 0 then
		player:sendTextMessage(MESSAGE_ADMINISTRATOR, "Cannot manually save server with /save, beacause: SAVE_INTERVAL_TIME_SECONDS is > 0")
		return
	end

	player:sendTextMessage(MESSAGE_ADMINISTRATOR, "Saving server...")
	saveServer()
	player:sendTextMessage(MESSAGE_ADMINISTRATOR, "Server was saved!")

	return true
end

save:separator(" ")
save:groupType("god")
save:register()
