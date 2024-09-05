local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_TICKS, 4000)
condition:setParameter(CONDITION_PARAM_STAT_MAGICPOINTSPERCENT, 70)

local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_STUN)
combat:setArea(createCombatArea(AREA_CIRCLE6X6))
combat:addCondition(condition)

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:name("shock head skill reducer 2")
spell:words(NextSpellId())
spell:isAggressive(true)
spell:blockWalls(true)
spell:needTarget(false)
spell:needLearn(true)
spell:register()
