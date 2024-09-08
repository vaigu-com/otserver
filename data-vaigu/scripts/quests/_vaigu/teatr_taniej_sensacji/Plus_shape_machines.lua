local function getConfigByAid(aid)
	return TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.aidToMachineConfig[aid]
end

local function resetArea(config)
	IterateBetweenPositions(config.topLeft, config.downRight, function(context)
		local pos = context.pos
		local ground = Tile(pos):getGround()
		local groundId = ground:getId()
		local unlitId = TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.litToUnlit[groundId]
		if unlitId then
			Tile(pos):getItemById(groundId):transform(unlitId)
		end
		return true
	end)
end

local function isPuzzleCompleted(config)
	return IterateBetweenPositions(config.topLeft, config.downRight, function(context)
		local pos = context.pos
		local groundId = Tile(pos):getGround():getId()
		if TEATR_TANIEJ_SENSACJI_PLUS_SHAPE.unlitToLit[groundId] then
			return false
		end
		return true
	end, { stopCondition = STOP_CONDITIONS.isFalse })
end

local function lightUpPillar(config)
	local tile = Tile(LIBRUM_VORTEX_ANCHOR:Moved(config.pillar.pos))
	local item = tile:getItemById(config.pillar.unlitId)
	if item then
		item:transform(config.pillar.litId)
	end
end

local device = Action()
function device.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local config = getConfigByAid(item:getActionId())
	if not isPuzzleCompleted(config) then
		resetArea(config)
		fromPosition:sendMagicEffect(CONST_ME_POFF)
		return false
	end
	resetArea(config)
	fromPosition:sendMagicEffect(CONST_ME_ENERGYHIT)

	lightUpPillar(config)
	return true
end

device:aid(Storage.TeatrTaniejSensacji.PlusShapePuzzle.MachineNorth)
device:aid(Storage.TeatrTaniejSensacji.PlusShapePuzzle.MachineWest)
device:aid(Storage.TeatrTaniejSensacji.PlusShapePuzzle.MachineCenter)
device:register()
