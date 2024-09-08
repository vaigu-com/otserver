local rotwormStew = Action()

function rotwormStew.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local errorMessage = player:errorIfCannotUseCooldownItem("special-foods-cooldown")
	if errorMessage then
		player:say(errorMessage)
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
