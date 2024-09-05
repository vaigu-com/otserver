local combat = Combat() -- sudden death
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SUDDENDEATH)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat:setFormula(COMBAT_FORMULA_DAMAGE, -300, 0, -350, 0)

local combat2 = Combat() -- ice strike
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat2:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLICE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEATTACK)
combat2:setFormula(COMBAT_FORMULA_DAMAGE, -300, 0, -350, 0)

local combat3 = Combat() -- death explosion
combat3:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat3:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_DEATH)
combat3:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat3:setArea(createCombatArea(AREA_CIRCLE1X1))
combat3:setFormula(COMBAT_FORMULA_DAMAGE, -200, 0, -250, 0)

local combat4 = Combat() -- ice explosion
combat4:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat4:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ICE)
combat4:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
combat4:setArea(createCombatArea(AREA_CIRCLE1X1))
combat4:setFormula(COMBAT_FORMULA_DAMAGE, -200, 0, -250, 0)

local combat5 = Combat() -- death bomb
combat5:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat5:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_DEATH)
combat5:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat5:setArea(createCombatArea(AREA_SQUARE1X1))
combat5:setFormula(COMBAT_FORMULA_DAMAGE, -180, 0, -250, 0)

local combat6 = Combat() -- ice bomb
combat6:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat6:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ICE)
combat6:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEAREA)
combat6:setArea(createCombatArea(AREA_SQUARE1X1))
combat6:setFormula(COMBAT_FORMULA_DAMAGE, -180, 0, -250, 0)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local combat = { combat, combat2, combat3, combat4, combat5, combat6 }
	local chance = math.random(1, #combat)

	return combat[chance]:execute(creature, var)
end

spell:name("skullfrost spells")
spell:words(NextSpellId())
spell:isAggressive(true)
spell:blockWalls(true)
spell:needTarget(true)
spell:needLearn(true)
spell:register()
