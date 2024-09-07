local errorMessage = "You need to wait before using it again."
local rotwormStew = Action()

function rotwormStew.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local canUse = player:canUseCooldownItem("special-foods-cooldown")
	if not canUse then
		player:say(errorMessage)
	end

	if IsOnEvent(player) then
		player:sendCancelMessage("You cannot eat dishes on this event.")
		return true
	end
	
	player:addHealth(player:getMaxHealth())
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your health has been refilled.")
	player:say("Gulp.", TALKTYPE_MONSTER_SAY)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
	player:setExhaustion("special-foods-cooldown", 10 * 60)
	item:remove(1)
	return true
end

rotwormStew:id(9079)
rotwormStew:register()
