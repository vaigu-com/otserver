local setting = {
	[7950] = Position(6346, 1956, 13), -- from pustynia --{x = 6346, y = 1956, z = 13}
}

local nightmarebeastteleport = MoveEvent()

function nightmarebeastteleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local targetPosition = setting[item.actionid]
	if not targetPosition then
		return true
	end

	if player:getStorageValue(Storage.TheDreamCourts.KilledBosses) >= 5 then
		player:teleportTo(targetPosition)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	else
		player:teleportTo(fromPosition)
		player:sendCancelMessage("You need to defeat arena bosses at least 5 times before facing The Nightmare Beast.")
	end
	return true
end

nightmarebeastteleport:type("stepin")

for index, value in pairs(setting) do
	nightmarebeastteleport:aid(index)
end

nightmarebeastteleport:register()
