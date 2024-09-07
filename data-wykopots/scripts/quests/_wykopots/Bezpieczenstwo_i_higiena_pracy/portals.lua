local portal = MoveEvent()

function portal.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	player:teleportTo(BEZPIECZENSTWO_I_HIEGIENA_PRACY_PORTALS[item:getActionId()])
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

for _, actionId in pairs(Storage.BezpieczenstwoIHigienaPracy.Portals) do
	portal:aid(actionId)
end
portal:type("stepin")
portal:register()

local portalUse = Action()

function portalUse.onUse(creature, item, fromPosition, target, toPosition, isHotkey)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	player:teleportTo(BEZPIECZENSTWO_I_HIEGIENA_PRACY_PORTALS[item:getActionId()])
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

for _, actionId in pairs(Storage.BezpieczenstwoIHigienaPracy.Portals) do
	portalUse:aid(actionId)
end
portalUse:register()
