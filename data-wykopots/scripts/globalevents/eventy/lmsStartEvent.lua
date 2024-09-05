local function sendReminderLMSEvent()
	Game.broadcastMessage(string.format("Last Man Standing rozpocznie sie za 5 minut! Minimum to %s graczy.", lmsConfigTable.minPlayers), MESSAGE_STATUS_WARNING)
end
local function sendReminderLMSEvent2()
	Game.broadcastMessage(string.format("Last Man Standing rozpocznie sie za minute! Minimum to %s graczy.", lmsConfigTable.minPlayers), MESSAGE_STATUS_WARNING)
end

local lmsEvent = GlobalEvent("lmsEvent")

function lmsEvent.onTime(interval)
	-- if #Game.getPlayers() < lmsConfigTable.minPlayers then --Min players is not online, we stop event from executing
	--     return true
	-- end
	if not Game.getStorageValue(lmsStatesTable.EVENT_STATE_STORAGE) then
		Game.setStorageValue(lmsStatesTable.EVENT_STATE_STORAGE, lmsStatesTable.EVENT_STATE_CLOSED)
	end

	-- if Game.getStorageValue(lmsStatesTable.EVENT_STATE_STORAGE) ~= lmsStatesTable.EVENT_STATE_CLOSED then
	--     return true
	-- end

	local teleportTile = Tile(lmsTeleportTable.createTeleportPosition):getItemById(lmsTeleportTable.teleportId)
	if not teleportTile then
		local teleport = Game.createItem(lmsTeleportTable.teleportId, 1, lmsTeleportTable.createTeleportPosition)
		if teleport then
			teleport:setAttribute(ITEM_ATTRIBUTE_UNIQUEID, lmsTeleportTable.teleportUid)
		end
	end

	Game.setStorageValue(lmsStatesTable.EVENT_STATE_STORAGE, lmsStatesTable.EVENT_STATE_INIT)
	Game.setStorageValue(lmsConfigTable.joinedCountStorage, 0)
	Game.broadcastMessage(string.format("Last Man Standing rozpocznie sie za 10 minut! Portal znajduje sie pod depozytem w Mirko Town. Minimum to %s graczy.", lmsConfigTable.minPlayers), MESSAGE_STATUS_WARNING)
	addEvent(startLMSEvent, lmsConfigTable.waitingMinutes * 60 * 1000)
	addEvent(sendReminderLMSEvent, 5 * 60 * 1000)
	addEvent(sendReminderLMSEvent2, 9 * 60 * 1000)
	return true
end

lmsEvent:time("15:00")
--lmsEvent:register()
