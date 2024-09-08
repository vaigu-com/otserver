local function grim5min()
	broadcastMessage("Grim Event startuje za 5 minut! Portal znajduje sie pod depozytem w Mirko Town.", MESSAGE_STATUS_WARNING)
end
local function grim2min()
	broadcastMessage("Grim Event startuje za minute! Portal znajduje sie pod depozytem w Mirko Town.", MESSAGE_STATUS_WARNING)
end

local function startGrimEvent()
	if Game.getStorageValue(ge_stateGlobalStorage) < 1 then
		local teleport = Game.createItem(10840, 1, ge_createTeleportPosition)
		if teleport then
			teleport:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 7001)
		end
		Game.setStorageValue(ge_stateGlobalStorage, 1)
		Game.setStorageValue(ge_joinCountGlobalStorage, 0)
		print("Grim Event has started & waiting for players to join! Min: 3/20.")
		Game.broadcastMessage("Grim Event startuje! Pozostalo " .. ge_waitTime .. " minut aby dolaczyc. Portal znajduje sie pod depozytem w Mirko Town.", MESSAGE_STATUS_WARNING)
		addEvent(startGrimEvent, ge_waitTime * 60 * 1000)
		addEvent(grim5min, 5 * 60 * 1000)
		addEvent(grim2min, 9 * 60 * 1000)
	end
end

local grimEvent1 = GlobalEvent("grimEvent1")

function grimEvent1.onTime(interval)
	startGrimEvent()
	return true
end

grimEvent1:time("15:50")
grimEvent1:register()

local grimEvent2 = GlobalEvent("GrimEvent2")

function grimEvent2.onTime(interval)
	startGrimEvent()
	return true
end

grimEvent2:time("21:50")
grimEvent2:register()
