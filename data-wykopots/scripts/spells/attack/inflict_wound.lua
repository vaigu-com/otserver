local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_DRAWBLOOD)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_WEAPONTYPE)

local function getHighestSkillLevel(creature)
	local skillLevel = -1
	for skillType = SKILL_CLUB, SKILL_AXE do
		if skillLevel < creature:getEffectiveSkillLevel(skillType) then
			skillLevel = creature:getEffectiveSkillLevel(skillType)
		end
	end
	return skillLevel
end

function onTargetCreature(creature, target)
	local skill = getHighestSkillLevel(creature)
	local min = (creature:getLevel() / 80) + (skill * 0.2) + 2
	local max = (creature:getLevel() / 80) + (skill * 0.4) + 2
	local damage = math.random(math.floor(min), math.floor(max))
	creature:addDamageCondition(target, CONDITION_BLEEDING, 1, target:isPlayer() and math.floor(damage / 4 + 0.5) or damage)
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
spell:id(141)
spell:name("Inflict Wound")
spell:words("utori kor")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_INFLICT_WOUND)
spell:level(40)
spell:mana(30)
spell:isAggressive(true)
spell:range(1)
spell:needTarget(true)
spell:blockWalls(true)
spell:cooldown(30 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("knight;true", "elite knight;true")
spell:register()
