local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLHOLY)

function onTargetCreature(creature, target)
	local condition = Condition(CONDITION_DAZZLED)
	condition:setParameter(CONDITION_PARAM_OWNER, creature:getId())
	condition:setParameter(CONDITION_PARAM_DELAYED, true)

	local min = (creature:getLevel() / 80) + (creature:getMagicLevel() * 0.3) + 2
	local max = (creature:getLevel() / 80) + (creature:getMagicLevel() * 0.5) + 3
	local rounds = math.random(math.floor(min), math.floor(max))
	condition:addDamage(rounds, math.random(10, 12) * 1000, -(target:isPlayer() and 10 or 20))
	target:addCondition(condition)
	return true
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
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

spell:group("attack")
spell:id(143)
spell:name("Holy Flash")
spell:words("utori san")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_HOLY_FLASH)
spell:level(70)
spell:mana(30)
spell:isAggressive(true)
spell:range(3)
spell:needTarget(true)
spell:blockWalls(true)
spell:cooldown(40 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("paladin;true", "royal paladin;true")
spell:register()
