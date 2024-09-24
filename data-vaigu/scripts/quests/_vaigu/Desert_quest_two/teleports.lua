	:Script(function(storageToRequiredState)
local aidToDestination = {
	[Storage.DesertQuestTwo.Teleports.ToIdenticalRoom] = DESERT_QUEST_TWO_ANCHOR:Moved(-85, -21, 0),
	[Storage.DesertQuestTwo.Teleports.FromIdenticalRoom] = DESERT_QUEST_TWO_ANCHOR:Moved(6, -32, -5),
}

local lever = Action()
function lever.onUse(creature, item, _, _, _, _)
	local player = creature:getPlayer()
	if not player then
		return false
	end
	player:teleportTo(aidToDestination[item:getActionId()])
end

for _, value in pairs(Storage.DesertQuestTwo.Teleports) do
	lever:aid(value)
end
lever:register()
end)
