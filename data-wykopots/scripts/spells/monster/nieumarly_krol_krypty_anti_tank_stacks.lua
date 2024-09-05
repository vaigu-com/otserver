local config = { last_player_name = "", stacks_count = 0, start_value = -50 }

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SUDDENDEATH)

function onGetFormulaValues(creature, target)
	if not (target:getName() == config.last_player_name) then
		config.last_player_name = target:getName()
		config.stacks_count = 0
	end

	local damage = math.floor(config.start_value * config.stacks_count)
	if not target:isPlayer() then
		damage = damage * 50
	end
	config.stacks_count = config.stacks_count + 1
	doTargetCombatHealth(0, target, COMBAT_ENERGYDAMAGE, damage, damage, CONST_ME_NONE)
	return true
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onGetFormulaValues")

local spell = Spell("instant")
function spell.onCastSpell(creature, var, isHotkey)
	return combat:execute(creature, var)
end

spell:name("nieumarly krol anti tank stacks")
spell:words(NextSpellId())
spell:needTarget(true)
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(false)
spell:needDirection(true)
spell:register()
