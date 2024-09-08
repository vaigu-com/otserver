local strawberryCupcake = Action()

function strawberryCupcake.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local errorMessage = player:errorIfCannotUseCooldownItem("strawberry-cupcake-cooldown")
	if errorMessage then
		player:say(errorMessage)
	end

	player:addHealth(player:getMaxHealth())
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your health has been refilled.")
	player:say("Mmmm.", TALKTYPE_MONSTER_SAY)
	player:setExhaustion("strawberry-cupcake-cooldown", 10 * 60)
	item:remove(1)
	return true
end

strawberryCupcake:id(28485)
strawberryCupcake:register()
