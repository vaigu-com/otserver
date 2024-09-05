local destination = {
	[4121] = { position = Position(7328, 1305, 8), storageValue = 1, needCrystal = true }, --from mirko
	[3220] = { position = Position(6448, 1844, 10), storageValue = 1, needCrystal = true }, --{x = 6448, y = 1844, z = 10}
	[3128] = { position = Position(7413, 1370, 12), storageValue = 14 }, --{x = 7413, y = 1370, z = 12}
	[3129] = { position = Position(7322, 1301, 9), storageValue = 14 }, --{x = 7322, y = 1301, z = 9}
	[3130] = { position = Position(7280, 1348, 11), storageValue = 15 }, --{x = 7280, y = 1348, z = 11}
	[3131] = { position = Position(7330, 1285, 9), storageValue = 15 }, --{x = 7330, y = 1285, z = 9}
	[3132] = { position = Position(7399, 1362, 8), storageValue = 15 }, -- Gnomebase Alpha --{x = 7399, y = 1362, z = 8}
	[3133] = { position = Position(7323, 1320, 9), storageValue = 15 }, -- City --{x = 7323, y = 1320, z = 9}
	[3134] = { position = Position(7372, 1453, 8), storageValue = 16 }, -- Golems --{x = 7372, y = 1453, z = 8}
	[3135] = { position = Position(7414, 1415, 8), storageValue = 16 }, -- Gnomebase Alpha --{x = 7414, y = 1415, z = 8}
	[3136] = { position = Position(7317, 1394, 12), storageValue = 16 }, --{x = 7317, y = 1394, z = 12}
	[3137] = { position = Position(7392, 1407, 8), storageValue = 16 }, --{x = 7392, y = 1407, z = 8}
	[35669] = { position = Position(7399, 1362, 8), storageValue = 1 }, -- leave warzone 3 --{x = 7399, y = 1362, z = 8}
	[3215] = { position = Position(32369, 32241, 7), storageValue = 1, needCrystal = true },
	[3216] = { position = Position(32212, 31133, 7), storageValue = 1, needCrystal = true },
	[3217] = { position = Position(5940, 1471, 7), storageValue = 1, needCrystal = true }, -- mirko
	[3218] = { position = Position(33213, 32454, 1), storageValue = 1, needCrystal = true },
	[3219] = { position = Position(33217, 31814, 8), storageValue = 1, needCrystal = true },
}

local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return
	end

	local teleportCrystal = destination[item.actionid]
	if not teleportCrystal then
		return
	end

	if player:getStorageValue(Storage.BigfootBurden.QuestLine) >= teleportCrystal.storageValue then
		if not teleportCrystal.needCrystal or player:removeItem(16167, 1) then
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:teleportTo(teleportCrystal.position)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		else
			player:teleportTo(fromPosition)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			if getPlayerLanguage(player) == "PL" then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Aby uzyc potrzebujesz krysztalu teleportacyjnego.")
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need a teleport crystal to pass there.")
			end
		end
		return true
	end

	-- There is no destination with storageValue == 2, should this check for storage?
	if teleportCrystal.storageValue == 2 then
		if getPlayerLanguage(player) == "PL" then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nie masz pojecia jak tego uzyc.")
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You cant use that.")
		end
	else
		player:teleportTo(fromPosition)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		if teleportCrystal == 4121 then
			if getPlayerLanguage(player) == "PL" then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nie posiadasz uprawnien! Porozmawiaj z Xelvarem, ktory znajduje sie na Sybirze.")
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are not allowed to pass there! Talk with Xelvar on Sybir first.")
			end
		else
			if getPlayerLanguage(player) == "PL" then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nie posiadasz uprawnien!")
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You dont have permission to pass there!")
			end
		end
	end
	return true
end

movement:type("stepin")
for index, value in pairs(destination) do
	movement:aid(index)
end
movement:register()
