local setting = {
	[7929] = Position(5844, 732, 11), -- to gazer
	[7930] = Position(5844, 856, 11), -- to ripper
	[7931] = Position(5826, 729, 9), -- to cath
	[7932] = Position(5830, 729, 9), -- from cath
}

local greenteleport = MoveEvent()

function greenteleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local targetPosition = setting[item.actionid]
	if not targetPosition then
		return true
	end

	if (player:getStorageValue(Storage.TheDreamCourts.Tukh1)) == 1 and (player:getStorageValue(Storage.TheDreamCourts.Tukh2) == 1) then
		player:teleportTo(targetPosition)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		if player:getStorageValue(Storage.TheDreamCourts.StrickenMission) == 2 then
			player:setStorageValue(Storage.TheDreamCourts.StrickenMission, 3)
		end
	else
		player:teleportTo(fromPosition)
		player:sendCancelMessage("Ghostly powers wont let you enter this portal.")
	end
	return true
end

greenteleport:type("stepin")

for index, value in pairs(setting) do
	greenteleport:aid(index)
end

greenteleport:register()
