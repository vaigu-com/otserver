local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITBYFIRE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)

function onTargetCreature(creature, target)
	local rounds = 10
	if creature:isPlayer() then
		local min = (creature:getLevel() / 80) + (creature:getMagicLevel() * 0.3) + 2
		local max = (creature:getLevel() / 80) + (creature:getMagicLevel() * 0.55) + 4
		local rounds = math.random(math.floor(min), math.floor(max))
	end
	creature:addDamageCondition(target, CONDITION_FIRE, 2, target:isPlayer() and 5 or 10, { 8, 10 }, rounds)
	return true
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

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

rune:group("attack")
rune:name("soulfire rune")
rune:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
rune:impactSound(SOUND_EFFECT_TYPE_SPELL_SOUL_FIRE_RUNE)
rune:runeId(3195)
rune:allowFarUse(true)
rune:charges(3)
rune:level(27)
rune:magicLevel(7)
rune:cooldown(2 * 1000)
rune:groupCooldown(2 * 1000)
rune:needTarget(true)
rune:isBlocking(true) -- True = Solid / False = Creature
rune:register()
