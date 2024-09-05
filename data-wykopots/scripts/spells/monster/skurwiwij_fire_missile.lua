local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)

function onGetFormulaValues(creature, target)
	local skurwiwijEncounterState = SkurwiwijEncounter:Get()
	local pylonPower = skurwiwijEncounterState.pylons.pylonVis.power
	local damage = math.floor(50 + pylonPower * 2)
	if damage > 50 then
		doTargetCombatHealth(0, target, COMBAT_FIREDAMAGE, -damage, -damage, CONST_ME_FIREDAMAGE)
	end
	return true
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onGetFormulaValues")

local spell = Spell("instant")
function spell.onCastSpell(creature, var, isHotkey)
	return combat:execute(creature, var)
end

spell:name("skurwiwij fire missile")
spell:words(NextSpellId())
spell:needTarget(true)
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(false)
spell:needDirection(true)
spell:register()
