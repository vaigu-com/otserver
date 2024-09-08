local playerrecord = GlobalEvent("playerrecord")
function playerrecord.onRecord(current, old)
	addEvent(Game.broadcastMessage, 150, "Nowy rekord: " .. current .. " graczy online.", MESSAGE_EVENT_ADVANCE)
	return true
end
playerrecord:register()
