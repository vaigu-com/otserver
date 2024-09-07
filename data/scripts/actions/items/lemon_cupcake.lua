local distanceCondition = Condition(CONDITION_ATTRIBUTES)
distanceCondition:setParameter(CONDITION_PARAM_BUFF_SPELL, 1)
distanceCondition:setParameter(CONDITION_PARAM_TICKS, 60 * 60 * 1000)
distanceCondition:setParameter(CONDITION_PARAM_SKILL_DISTANCE, 10)
distanceCondition:setParameter(CONDITION_PARAM_FORCEUPDATE, true)

local errorMessage = "You need to wait before using it again."
local lemonCupcake = Action()

function lemonCupcake.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local canUse = player:canUseCooldownItem("lemon-cupcake-cooldown")
	if not canUse then
		player:say(errorMessage)
	end

	player:addCondition(distanceCondition)
	player:sendTextMessage(MESSAGE_FAILURE, "You feel more focused.")
	player:say("Mmmm.", TALKTYPE_MONSTER_SAY)
	player:setExhaustion("lemon-cupcake-cooldown", 10 * 60)
	item:remove(1)
	return true
end

lemonCupcake:id(28486)
lemonCupcake:register()
