local smallLaser = Combat()
smallLaser:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
smallLaser:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
local smallArea = createCombatArea(AREA_SIDEBEAMS1)
smallLaser:setArea(smallArea)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	Game.createMonster("Laga Dyga", creature:getPosition(), true, true)
	return true
end

spell:name("nieumarly krol summon laga dyga")
spell:words(NextSpellId())
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:needDirection(true)
spell:register()
