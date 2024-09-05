local combat = {}

for i = CONDITION_PARAM_SKILL_FIST, CONDITION_PARAM_SKILL_SHIELD do
	for j = 1, 6 do
		local index = ((i - 20) * 6) + j
		combat[index] = Combat()
		combat[index]:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SNOWBALL)
		combat[index]:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_POFF)

		local condition = Condition(CONDITION_ATTRIBUTES)
		condition:setParameter(CONDITION_PARAM_TICKS, 5000)
		condition:setParameter(i, -j)
		combat[index]:addCondition(condition)
	end
end

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return combat[math.random(#combat)]:execute(creature, variant)
end

spell:name("barbarian brutetamer skill reducer")
spell:words(NextSpellId())
spell:isAggressive(true)
spell:blockWalls(true)
spell:needTarget(true)
spell:needLearn(true)
spell:register()
