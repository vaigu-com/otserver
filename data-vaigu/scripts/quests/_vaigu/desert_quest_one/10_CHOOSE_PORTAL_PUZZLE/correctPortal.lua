	:Script(function(storageToRequiredState)
local correctPortal = MoveEvent()

function correctPortal.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local toPos = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_PORTALS[Storage.DesertQuestOne.Portals.FinalPuzzle])
	player:teleportTo(toPos)
end

correctPortal:aid(Storage.DesertQuestOne.Puzzles.ChoosePortalPuzzle.CorrectPortal)
correctPortal:type("stepin")
correctPortal:register()
end)
