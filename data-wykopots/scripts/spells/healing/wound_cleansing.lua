local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 4) + 25
	local max = (level / 5) + (maglevel * 8) + 50
	return min, max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	if creature:getStorageValue(Storage.healLock) == 1 then
		creature:sendCancelMessage("You cannot heal on this event.")
		return false
	end
	return combat:execute(creature, variant)
end

spell:name("Wound Cleansing")
spell:words("exura ico")
spell:group("healing")
spell:vocation("knight;true", "elite knight;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_WOUND_CLEANSING)
spell:id(123)
spell:cooldown(1 * 1000)
spell:groupCooldown(1 * 1000)
spell:level(8)
spell:mana(40)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:register()
