local save = TalkAction("/startday", "!startday")

function save.onSay(player, words, param)
	-- create log
	logCommand(player, words, param)

	if isNumber(param) then
		db.query("UPDATE `server_config` SET `value` = " .. param .. " WHERE `server_config`.`config` = 'day_since_start'")
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Starday set to " .. param)
	else
		print'not a number'
	end
	return false
end

save:separator(" ")
save:groupType("god")
save:register()
