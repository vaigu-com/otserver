local grimDisappear = MoveEvent()

function grimDisappear.onStepIn(creature, item, position, fromPosition)
	local monster = creature:getMonster()
	if not monster then
		return true
	end

	if monster:getName():lower() ~= "grim reaper" then
		return true
	end

	doTargetCombatHealth(0, monster, COMBAT_PHYSICALDAMAGE, -10000, -10000, CONST_ME_DRAWBLOOD)
	monster:say("I will find you!", TALKTYPE_MONSTER_SAY)
	--position:sendMagicEffect(CONST_ME_BLOCKHIT)
	return true
end

grimDisappear:type("stepin")
grimDisappear:aid(11050)
grimDisappear:register()
