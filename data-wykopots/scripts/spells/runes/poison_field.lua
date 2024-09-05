local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GREEN_RINGS)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_POISON)
combat:setParameter(COMBAT_PARAM_CREATEITEM, ITEM_POISONFIELD_PVP)

local rune = Spell("rune")

function rune.onCastSpell(creature, var, isHotkey)
	local target = creature:getTarget()
	if getCreatureCondition(creature, CONDITION_PACIFIED) then
		if not target then
			creature:sendCancelMessage(RETURNVALUE_YOUAREEXHAUSTED)
			creature:getPosition():sendMagicEffect(CONST_ME_POFF)
			return false
		end
		if target:isPlayer() then
			return combat:execute(creature, var)
		else
			creature:sendCancelMessage(RETURNVALUE_YOUAREEXHAUSTED)
			creature:getPosition():sendMagicEffect(CONST_ME_POFF)
			return false
		end
	else
		return combat:execute(creature, var)
	end
end

rune:id(26)
rune:group("attack")
rune:name("poison field rune")
rune:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
rune:impactSound(SOUND_EFFECT_TYPE_SPELL_POISON_FIELD_RUNE)
rune:runeId(3172)
rune:allowFarUse(true)
rune:setPzLocked(false)
rune:charges(3)
rune:level(14)
rune:magicLevel(0)
rune:cooldown(2 * 1000)
rune:groupCooldown(2 * 1000)
rune:isBlocking(true) -- True = Solid / False = Creature
rune:register()
