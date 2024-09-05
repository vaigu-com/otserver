local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_UNDEFINEDDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HEARTS)
combat:setArea(createCombatArea(AREA_SQUARE13X13))

function onGetFormulaValues(player, level, maglevel)
	local min = 10000
	local max = 10000
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:group("attack", "special")
spell:id(500)
spell:name("Love Core")
spell:words("exevo love all")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_LIGHTNING)
spell:level(55)
spell:mana(60)
spell:isPremium(true)
spell:cooldown(1 * 1000)
spell:needLearn(false)
spell:vocation("None")
spell:register()
