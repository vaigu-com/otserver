local combat = Combat()
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_INVISIBLE)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:name("djinn cancel invisibility")
spell:words(NextSpellId())
spell:isAggressive(true)
spell:blockWalls(true)
spell:needTarget(false)
spell:needLearn(true)
spell:register()
