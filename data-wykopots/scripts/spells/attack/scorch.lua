local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITBYFIRE)
combat:setArea(createCombatArea(AREA_WAVE4))

function onGetFormulaValues(player, level, maglevel)
	level = math.min(level, 20)
	maglevel = math.min(maglevel, 20)
	local min = (level / 5) + (maglevel * 0.3) + 2
	local max = (level / 5) + (maglevel * 0.45) + 3
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	if getCreatureCondition(creature, CONDITION_PACIFIED) then
		creature:sendCancelMessage(RETURNVALUE_YOUAREEXHAUSTED)
		creature:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	else
		return combat:execute(creature, var)
	end
end

spell:group("attack")
spell:id(178)
spell:name("Scorch")
spell:words("exevo infir flam hur")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_SCORCH)
spell:level(1)
spell:mana(8)
spell:isAggressive(true)
spell:isPremium(false)
spell:needDirection(true)
spell:cooldown(4 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
