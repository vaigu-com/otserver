	:Script(function(storageToRequiredState)
local updateStorages = {
	Storage.ThreeSramatiansAndTheDragon.Questline,
	Storage.ThreeSramatiansAndTheDragon.Mission05,
}

local cagePos = Position(6206, 918, 9)

local vampireKidnapping = MoveEvent()

function vampireKidnapping.onStepIn(player, item, position, fromPosition)
	if not player:isPlayer() then
		return true
	end

	if player:getStorageValue(Storage.ThreeSramatiansAndTheDragon.Questline) ~= 9 then
		return false
	end
	player:teleportTo(cagePos)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:IncrementStorages(updateStorages)
	return true
end

vampireKidnapping:type("stepin")
vampireKidnapping:aid(Storage.ThreeSramatiansAndTheDragon.VampireCityTrap)
vampireKidnapping:register()
end)
