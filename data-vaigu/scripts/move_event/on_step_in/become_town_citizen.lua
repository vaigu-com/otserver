local function findNearestTown(pos)
	local nearestDist = 65536
	local nearestTown = nil
	for id = 1, 100 do
		local town = Town(id)
		if not town then
			break
		end

		local distToTemple = pos:EuclideanDistance(town:getTemplePosition())
		if distToTemple < nearestDist then
			nearestDist = distToTemple
			nearestTown = town
		end
	end

	return nearestTown
end

local templeTeleport = MoveEvent()
function templeTeleport.onStepIn(creature, item, toPosition, fromPosition)
	if not creature:isPlayer() then
		return false
	end

	local town = findNearestTown(toPosition)
	if not town then
		return true
	end

	local player = creature:getPlayer()
	player:setTown(town)
	player:teleportTo(town:getTemplePosition())
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)

	local localizer = player:Localizer(LOCALIZERS.Universal)
	local translatedTownName = localizer:Get(town:getName())
	local translatedMessage = localizer:Context({ townName = translatedTownName }):Get("YOU_ARE_NOW_CITIZEN_OF")

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, translatedMessage)
	return true
end
templeTeleport:type("stepin")
templeTeleport:key(Storage.BecomeTownCitizen)
templeTeleport:register()
