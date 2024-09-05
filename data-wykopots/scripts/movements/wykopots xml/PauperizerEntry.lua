local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	local destination = Position(6392, 948, 9)
	if player:getStorageValue(Storage.PauperizerKill) == 1 then
		player:teleportTo(destination) --{x = 6392, y = 948, z = 9}
		destination:sendMagicEffect(CONST_ME_PURPLEENERGY)
	else
		player:teleportTo(fromPosition)
		fromPosition:sendMagicEffect(CONST_ME_PURPLEENERGY)
		player:say("Odejdz, istoto! Mistyczne moce nie pozwola zblizyc sie do Wladcy!", TALKTYPE_MONSTER_SAY)
	end
	return true
end

movement:type("stepin")
movement:aid(2250)
movement:register()
