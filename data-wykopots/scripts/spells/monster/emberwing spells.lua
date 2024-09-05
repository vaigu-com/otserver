local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_HOLY)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYAREA)
combat:setArea(createCombatArea(AREA_SQUARE1X1))
combat:setFormula(COMBAT_FORMULA_DAMAGE, -170, 0, -230, 0)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat2:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREATTACK)
combat2:setArea(createCombatArea(AREA_SQUARE1X1))
combat2:setFormula(COMBAT_FORMULA_DAMAGE, -170, 0, -230, 0)

local combat3 = Combat()
combat3:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat3:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)
combat3:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREATTACK)
combat3:setArea(createCombatArea(AREA_CIRCLE3X3))
combat3:setFormula(COMBAT_FORMULA_DAMAGE, -200, 0, -270, 0)

local combat4 = Combat()
combat4:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat4:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_HOLY)
combat4:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYAREA)
combat4:setArea(createCombatArea(AREA_CIRCLE3X3))
combat4:setFormula(COMBAT_FORMULA_DAMAGE, -200, 0, -270, 0)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local combat = { combat, combat2, combat3, combat4 }
	local chance = math.random(1, #combat)

	return combat[chance]:execute(creature, var)
end

spell:name("emberwing spells")
spell:words(NextSpellId())
spell:isAggressive(true)
spell:blockWalls(true)
spell:needTarget(true)
spell:needLearn(true)
spell:register()
