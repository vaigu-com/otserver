local warzoneConfig = {
	[45700] = { -- tp aid
		center = Position(7530, 1456, 10),
		rangeX = 27,
		rangeY = 25,
		boss = "Gnomevil",
		teleportTo = Position(7519, 1455, 10),
		timerStorage = Storage.BigfootBurden.GnomevilTimer,
		globalStorage = GlobalStorage.GnomevilSpawned,
		interval = 10 * 60 * 60,
	},
	[45702] = { -- tp aid
		center = Position(7523, 1465, 9),
		rangeX = 26,
		rangeY = 25,
		boss = "Deathstrike",
		teleportTo = Position(7509, 1455, 9),
		timerStorage = Storage.BigfootBurden.DeathstrikeTimer,
		globalStorage = GlobalStorage.DeathstrikeSpawned,
		interval = 10 * 60 * 60,
	},
	[45701] = { -- tp aid
		center = Position(7503, 1410, 11),
		rangeX = 20,
		rangeY = 20,
		boss = "Abyssador",
		teleportTo = Position(7496, 1404, 11),
		timerStorage = Storage.BigfootBurden.AbyssadorTimer,
		globalStorage = GlobalStorage.AbyssadorSpawned,
		interval = 10 * 60 * 60,
	},
}

local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	if not creature:isPlayer() then
		creature:teleportTo(fromPosition)
		return false
	end

	local config = warzoneConfig[item:getActionId()]
	if not config then
		return false
	end

	if creature:getStorageValue(config.timerStorage) >= os.time() then
		creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Musisz odczekac 20 godzin po pokonaniu bossa.")
		creature:teleportTo(fromPosition)
		return false
	end

	local destPos = config.teleportTo

	creature:teleportTo(destPos)
	destPos:sendMagicEffect(CONST_ME_TELEPORT)

	if Game.getStorageValue(config.globalStorage) <= 0 then
		Game.setStorageValue(config.globalStorage, 1)
		Game.createMonster(config.boss, config.center)
	end
	return true
end

movement:type("stepin")
movement:aid(45700, 45701, 45702)
movement:register()
