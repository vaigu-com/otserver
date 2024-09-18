local updateStorages = {
	Storage.TheThreeSramatiansAndTheDragon.Questline,
	Storage.TheThreeSramatiansAndTheDragon.Mission05,
}

local cagePos = Position(6206, 918, 9)

local vampireKidnapping = MoveEvent()

function vampireKidnapping.onStepIn(player, item, position, fromPosition)
	if not player:isPlayer() then
		return true
	end

	if player:getStorageValue(Storage.TheThreeSramatiansAndTheDragon.Questline) ~= 9 then
		return false
	end
	player:teleportTo(cagePos)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:IncrementStorages(updateStorages)
	return true
end

vampireKidnapping:type("stepin")
vampireKidnapping:aid(Storage.TheThreeSramatiansAndTheDragon.VampireCityTrap)
vampireKidnapping:register()
