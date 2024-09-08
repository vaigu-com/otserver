local vortex = MoveEvent()

function vortex.onStepIn(player, _, toPosition, fromPosition)
	if not player:isPlayer() then
		return false
	end

	local storageVal = player:getStorageValue(Storage.PerIustitiaAdAstra.RukcaAccess)
	if storageVal == -1 then
		return true
	end

	local toPos = toPosition:Moved(0, 0, 1)
	player:teleportTo(toPos, true)
	toPos:sendMagicEffect(CONST_ME_WATERSPLASH)
end

vortex:aid(Storage.PerIustitiaAdAstra.RukcaAccess)
vortex:register()
