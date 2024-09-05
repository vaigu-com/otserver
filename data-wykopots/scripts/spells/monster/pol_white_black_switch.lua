local plusArea = createCombatArea(AREA_PLUS5)
local params = Combat()
params:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
params:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
params:setArea(plusArea)
params:setFormula(COMBAT_FORMULA_DAMAGE, -1500, 0, -1500, 0)

local whiteColor = 0
local blackColor = 114

local colorToCorrectGroundId = {
	[whiteColor] = 409,
	[blackColor] = 410,
}

local function damageAllPlayers(bossPos, damage)
	local corner1, corner2 = bossPos:GetBoundariesByRadius(7)
	IterateBetweenPositions(corner1, corner2, function(context)
		local pos = context.pos
		local tile = Tile(pos)
		if not tile then
			return true
		end
		local maybePlayer = tile:getTopCreature()
		if not maybePlayer or not maybePlayer:getPlayer() then
			return true
		end
		doTargetCombatHealth(0, maybePlayer, COMBAT_ENERGYDAMAGE, -damage, -damage, CONST_ME_ELECTRICALSPARK)
	end)
end

local damagePerFail = 300
local function tryDamagePlayersOnWrongTiles(creature)
	local bossPos = creature:getPosition()
	local corner1, corner2 = bossPos:GetBoundariesByRadius(7)
	local polState = CreatureStateRegistry:getState(creature)
	local correctGroundId = colorToCorrectGroundId[polState.currentColor]

	local playersAreOnCorrectTiles = IterateBetweenPositions(corner1, corner2, function(context)
		local pos = context.pos
		local tile = Tile(pos)
		if not tile then
			return true
		end
		local maybePlayer = tile:getTopCreature()
		if not maybePlayer or not maybePlayer:getPlayer() then
			return true
		end
		local groundId = tile:getGround():getId()
		return groundId == correctGroundId
	end, { stopCondition = STOP_CONDITIONS.isFalse })
	if playersAreOnCorrectTiles then
		return
	end

	polState.penaltyDamage = polState.penaltyDamage + damagePerFail
	damageAllPlayers(bossPos, polState.penaltyDamage)
end

local outfit = {
	lookType = 1444,
	lookHead = 0,
	lookBody = 91,
	lookLegs = 0,
	lookFeet = 0,
}
local function updateColor(color, creature, polState)
	outfit.lookLegs = color
	creature:setOutfit(outfit)

	polState.currentColor = color
end

local spell = Spell("instant")
function spell.onCastSpell(creature, var)
	local polState = CreatureStateRegistry:getState(creature)
	if polState.currentColor == whiteColor then
		updateColor(blackColor, creature, polState)
	else
		updateColor(whiteColor, creature, polState)
	end

	addEvent(function()
		tryDamagePlayersOnWrongTiles(creature)
	end, 1000)
	return true
end

spell:name("pol white black switch")
spell:words(NextSpellId())
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:needDirection(true)
spell:register()
