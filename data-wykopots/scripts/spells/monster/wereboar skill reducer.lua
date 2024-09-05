local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_TICKS, 4000)
condition:setParameter(CONDITION_PARAM_SKILL_DISTANCEPERCENT, 75)
condition:setParameter(CONDITION_PARAM_SKILL_MELEEPERCENT, 75)
condition:setParameter(CONDITION_PARAM_STAT_MAGICPOINTSPERCENT, 75)

local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)
combat:setArea(createCombatArea(AREA_CIRCLE2X2))
combat:addCondition(condition)

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:name("wereboar skill reducer")
spell:words(NextSpellId())
spell:isAggressive(true)
spell:blockWalls(true)
spell:needTarget(true)
spell:needLearn(true)
spell:register()
