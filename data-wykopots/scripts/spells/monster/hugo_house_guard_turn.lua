local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGYBALL)
local function tryCatchPlayers(creature)
	local currentDirection = creature:getDirection()
	local nextDirection = currentDirection
	nextDirection = nextDirection + (-1) ^ math.random(0, 1)
	nextDirection = nextDirection % 4

	creature:setDirection(nextDirection)
end

local spell = Spell("instant")
function spell.onCastSpell(creature, var, isHotkey)
	tryCatchPlayers(creature)
	return combat:execute(creature, var)
end

spell:name("hugo house guard turn")
spell:words(NextSpellId())
spell:needTarget(true)
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(false)
spell:needDirection(true)
spell:register()
