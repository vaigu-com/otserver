local portal = MoveEvent()

function portal.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	player:teleportTo(DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_PORTALS[item.actionid]))
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

for _, actionId in pairs(Storage.DesertQuestOne.Portals) do
	portal:aid(actionId)
end
portal:type("stepin")
portal:register()
