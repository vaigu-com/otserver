local function configureCombat(combat, damage)
	combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
	combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SMALLCLOUDS)
	combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_DEATH)
end

local damage = 0.935

local condition2 = Condition(CONDITION_EXHAUST_COMBAT)
condition2:setParameter(CONDITION_PARAM_SUBID, 88888)
condition2:setParameter(CONDITION_PARAM_TICKS, 15 * 60 * 1000)

local doCombatFunc = MonsterSpellCreateCursedCombatList(damage, damage, damage, 37, 37, 1.2, 4000, configureCombat)

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	if not creature:getCondition(CONDITION_EXHAUST_COMBAT, CONDITIONID_COMBAT, 88888) then
		creature:addCondition(condition2)
		creature:say("Terofar cast a greater death curse on you!", TALKTYPE_ORANGE_1)

		return doCombatFunc():execute(creature, variant)
	end

	return false
end

spell:name("terofar curse")
spell:words(NextSpellId())
spell:isAggressive(true)
spell:blockWalls(true)
spell:needTarget(true)
spell:needLearn(true)
spell:register()
