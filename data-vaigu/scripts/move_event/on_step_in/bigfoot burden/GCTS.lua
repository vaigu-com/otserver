local teleporters = {
	[3215] = { destination = Position(6218, 1048, 8), minState = 1, requiresCrystal = true }, --To Steppes
	[3216] = { destination = Position(7018, 787, 7), minState = 1, requiresCrystal = true }, --To Kongo
	[3217] = { destination = Position(5924, 1395, 9), minState = 1, requiresCrystal = true }, --To Mirkotown
	[3218] = { destination = Position(7517, 1850, 12), minState = 1, requiresCrystal = true }, --To Orshaawa
	[3219] = { destination = Position(7209, 1048, 7), minState = 1, requiresCrystal = true }, --To Maioor'ka
	[3220] = { destination = Position(6448, 1844, 10), minState = 1, requiresCrystal = true }, --To Syberia

	[4121] = { destination = Position(6187, 2380, 8), minState = 1, requiresCrystal = true }, --To Hub

	[3128] = { destination = Position(6272, 2445, 12), minState = 14 }, --{x = 7413, y = 1370, z = 12}
	[3129] = { destination = Position(6181, 2376, 9), minState = 14 }, --{x = 7322, y = 1301, z = 9}
	[3130] = { destination = Position(6139, 2423, 11), minState = 15 }, --{x = 7280, y = 1348, z = 11}
	[3131] = { destination = Position(6189, 2360, 9), minState = 15 }, --{x = 7330, y = 1285, z = 9}
	[3132] = { destination = Position(6258, 2437, 8), minState = 15 }, -- Gnomebase Alpha --{x = 7399, y = 1362, z = 8}
	[3133] = { destination = Position(6182, 2395, 9), minState = 15 }, -- City --{x = 7323, y = 1320, z = 9}
	[3134] = { destination = Position(6231, 2528, 8), minState = 16 }, -- Golems --{x = 7372, y = 1453, z = 8}
	[3135] = { destination = Position(6273, 2490, 8), minState = 16 }, -- Gnomebase Alpha --{x = 7414, y = 1415, z = 8}
	[3136] = { destination = Position(6176, 2469, 12), minState = 16 }, --{x = 7317, y = 1394, z = 12}
	[3137] = { destination = Position(6251, 2482, 8), minState = 16 }, --{x = 7392, y = 1407, z = 8}
	[35669] = { destination = Position(6258, 2437, 8), minState = 1 }, -- leave warzone 3 --{x = 7399, y = 1362, z = 8}
}

local movement = MoveEvent()
function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return
	end

	local teleporter = teleporters[item.actionid]
	if not teleporter then
		return
	end

	if player:getStorageValueByKey(Storage.BigfootBurden.QuestLine) < teleporter.minState then
		player:teleportTo(fromPosition)
		return true
	end

	if not teleporter.requiresCrystal or player:removeItem(16167, 1) then
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:teleportTo(teleporter.destination)
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
movement:type("stepin")
for aid in pairs(teleporters) do
	movement:aid(aid)
end
movement:register()
