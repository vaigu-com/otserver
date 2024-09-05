local combat = {}

for i = 2, 4 do
	local condition = Condition(CONDITION_CURSED)
	condition:setParameter(CONDITION_PARAM_DELAYED, true)

	local damage = i
	condition:addDamage(1, 4000, -damage)
	for j = 1, 9 do
		damage = damage * 1.2
		condition:addDamage(1, 4000, -damage)
	end

	combat[i] = Combat()
	combat[i]:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
	combat[i]:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SMALLCLOUDS)
	combat[i]:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_DEATH)
	combat[i]:setArea(createCombatArea(AREA_SQUAREWAVE7))
	combat[i]:addCondition(condition)
end

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return combat[math.random(2, 4)]:execute(creature, variant)
end

spell:name("mutated bat curse")
spell:words(NextSpellId())
spell:needDirection(true)
spell:isAggressive(true)
spell:blockWalls(true)
spell:needTarget(false)
spell:needLearn(true)
spell:register()
