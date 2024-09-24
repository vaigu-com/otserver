	:Script(function(storageToRequiredState)
local starLeftStepIn = MoveEvent()

function starLeftStepIn.onStepIn(creature, _, _, _)
	local pos = creature:getPosition()
	local toPos = pos:Moved(36, 0, 0)

	creature:teleportTo(toPos)
end

starLeftStepIn:aid(Storage.PerIustitiaAdAstra.MovingStarTile)
starLeftStepIn:register()
end)
