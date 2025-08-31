local crystalId = ItemId.TELEPORT_CRYSTAL
local teleportsData = {
	{ stepInPosition = Position(6449, 1844, 10), destinationPosition = Position(32801, 31766, 9), requiresCrystal = true },
	{ stepInPosition = Position(7207, 1048, 7), destinationPosition = Position(32801, 31766, 9), requiresCrystal = true },
	{ stepInPosition = Position(6218, 1050, 8), destinationPosition = Position(32801, 31766, 9), requiresCrystal = true },
	{ stepInPosition = Position(5924, 1393, 9), destinationPosition = Position(32801, 31766, 9), requiresCrystal = true },
	{ stepInPosition = Position(7517, 1848, 12), destinationPosition = Position(32801, 31766, 9), requiresCrystal = true },
	{ stepInPosition = Position(7016, 786, 7), destinationPosition = Position(32801, 31766, 9), requiresCrystal = true },
	{ stepInPosition = Position(5570, 1606, 7), destinationPosition = Position(32801, 31766, 9), requiresCrystal = true },


	{ stepInPosition = Position(32330, 32173, 9), destinationPosition = Position(32801, 31766, 9), requiresCrystal = true },
	{ stepInPosition = Position(32403, 32818, 6), destinationPosition = Position(32801, 31766, 9), requiresCrystal = true },
	{ stepInPosition = Position(33187, 32384, 8), destinationPosition = Position(32801, 31766, 9), requiresCrystal = true },
	{ stepInPosition = Position(32196, 31183, 8), destinationPosition = Position(32801, 31766, 9), requiresCrystal = true },
	{ stepInPosition = Position(33154, 31834, 10), destinationPosition = Position(32801, 31766, 9), requiresCrystal = true },
	{ stepInPosition = Position(32795, 31761, 10), destinationPosition = Position(33000, 31870, 13) },
	{ stepInPosition = Position(33000, 31871, 13), destinationPosition = Position(32795, 31762, 10) },
	{ stepInPosition = Position(32803, 31745, 10), destinationPosition = Position(32864, 31844, 11) },
	{ stepInPosition = Position(32864, 31845, 11), destinationPosition = Position(32803, 31746, 10) },
	{ stepInPosition = Position(32796, 31780, 10), destinationPosition = Position(32988, 31862, 9) },
	{ stepInPosition = Position(32986, 31861, 9), destinationPosition = Position(32798, 31783, 10) },
	{ stepInPosition = Position(33001, 31916, 9), destinationPosition = Position(32959, 31953, 9) },
	{ stepInPosition = Position(32959, 31952, 9), destinationPosition = Position(33001, 31915, 9) },
	{ stepInPosition = Position(32980, 31907, 9), destinationPosition = Position(32904, 31894, 13) },
	{ stepInPosition = Position(32904, 31893, 13), destinationPosition = Position(32979, 31907, 9) },
	{ stepInPosition = Position(32772, 31799, 10), destinationPosition = Position(32790, 31795, 10) },
	{ stepInPosition = Position(32789, 31796, 10), destinationPosition = Position(32771, 31800, 10) },

	{ stepInPosition = Position(32803, 31798, 9), destinationPosition = Position(6447, 1844, 10), requiresCrystal = true }, -- sybir
	{ stepInPosition = Position(32805, 31743, 9), destinationPosition = Position(7208, 1049, 7), requiresCrystal = true }, -- maioorka
	{ stepInPosition = Position(32786, 31754, 9), destinationPosition = Position(6217, 1049, 8), requiresCrystal = true }, --steppes
	{ stepInPosition = Position(32772, 31776, 9), destinationPosition = Position(5923, 1394, 9), requiresCrystal = true }, -- mirko
	{ stepInPosition = Position(32831, 31797, 9), destinationPosition = Position(7516, 1849, 12), requiresCrystal = true }, -- orshaawa
	{ stepInPosition = Position(32827, 31757, 9), destinationPosition = Position(7017, 787, 7), requiresCrystal = true }, -- kongo
	{ stepInPosition = Position(32783, 31792, 9), destinationPosition = Position(5571, 1605, 7), requiresCrystal = true }, -- knurow
}
local stepInPositionToTeleportData = {}
for _, teleportData in pairs(teleportsData) do
	stepInPositionToTeleportData[teleportData.stepInPosition:ToString()] = teleportData
end

local function canUseTeleport(teleportData, player, fromPosition)
	if not teleportData then
		return false
	end

	if player:getStorageValueByKey(Storage.BigfootsBurden.QuestLine) < 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have no idea on how to use this device. Xelvar in Syberia might tell you more about it.")
		return false
	end

	if teleportData.requiresCrystal and not player:HasItem({ id = crystalId }) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need a teleport crystal to pass there.")
		return false
	end

	return true
end

local gnomebaseTeleport = MoveEvent()
function gnomebaseTeleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return
	end

	local teleportData = stepInPositionToTeleportData[player:getPosition():ToString()]

	if not canUseTeleport(teleportData, player, fromPosition) then
		player:teleportTo(fromPosition)
		return true
	end

	if teleportData.requiresCrystal then
		player:RemoveItem({ id = crystalId })
	end
	player:teleportTo(teleportData.destinationPosition, false)

	return true
end

for _, teleportData in pairs(teleportsData) do
	local stepInPosition = teleportData.stepInPosition
	gnomebaseTeleport:position(stepInPosition)
end
gnomebaseTeleport:register()
