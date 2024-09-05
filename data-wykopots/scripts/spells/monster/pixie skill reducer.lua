local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_TICKS, 6000)
condition:setParameter(CONDITION_PARAM_SKILL_SHIELDPERCENT, 30)
condition:setParameter(CONDITION_PARAM_SKILL_DISTANCEPERCENT, 30)
condition:setParameter(CONDITION_PARAM_SKILL_MELEEPERCENT, 30)

local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, 184)
combat:setArea(createCombatArea(AREA_CIRCLE2X2))
combat:addCondition(condition)

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:name("pixie skill reducer")
spell:words(NextSpellId())
spell:isAggressive(true)
spell:blockWalls(true)
spell:needTarget(false)
spell:needLearn(true)
spell:register()
