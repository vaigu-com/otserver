local function zombie5min()
	broadcastMessage("Zombie Event startuje za 5 minut! Portal znajduje sie pod depozytem w Mirko Town.", MESSAGE_STATUS_WARNING)
end
local function zombie1min()
	broadcastMessage("Zombie Event startuje za minute! Portal znajduje sie pod depozytem w Mirko Town.", MESSAGE_STATUS_WARNING)
end

local function startZombieEvent()
	if Game.getStorageValue(ze_stateGlobalStorage) < 1 then
		local teleport = Game.createItem(10840, 1, ze_createTeleportPosition)
		if teleport then
			teleport:setAttribute(ITEM_ATTRIBUTE_ACTIONID, 7000)
		end
		Game.setStorageValue(ze_stateGlobalStorage, 1)
		Game.setStorageValue(ze_joinCountGlobalStorage, 0)
		print("Zombie Event has started & waiting for players to join! Min: 3/20.")
		Game.broadcastMessage("Zombie Event startuje! Pozostalo " .. ze_waitTime .. " minut aby dolaczyc. Portal znajduje sie pod depozytem w Mirko Town.", MESSAGE_STATUS_WARNING)
		addEvent(startZombieEvent, ze_waitTime * 60 * 1000)
		addEvent(zombie5min, 5 * 60 * 1000)
		addEvent(zombie1min, 9 * 60 * 1000)
	end
end

local zombieEvent1 = GlobalEvent("zombieEvent1")
function zombieEvent1.onTime(interval)
	startZombieEvent()
	return true
end
zombieEvent1:time("14:50")
zombieEvent1:register()

local zombieEvent2 = GlobalEvent("zombieEvent2")
function zombieEvent2.onTime(interval)
	startZombieEvent()
	return true
end
zombieEvent2:time("20:50")
zombieEvent2:register()
