local abomiEntry = MoveEvent()

function abomiEntry.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	local destination = Position(6466, 896, 10)
	if player:getStorageValue(Storage.PauperizerKill) == 1 then
		player:teleportTo(destination) --{x = 6392, y = 948, z = 9}
		destination:sendMagicEffect(CONST_ME_PURPLEENERGY)
	else
		player:teleportTo(fromPosition)
		fromPosition:sendMagicEffect(CONST_ME_PURPLEENERGY)
		player:say("Odejdz, istoto!", TALKTYPE_MONSTER_SAY)
	end
	return true
end

abomiEntry:aid(2252)
abomiEntry:register()
