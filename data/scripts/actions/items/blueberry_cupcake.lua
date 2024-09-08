local blueberryCupcake = Action()

function blueberryCupcake.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local errorMessage = player:errorIfCannotUseCooldownItem("blueberry-cupcake-cooldown")
	if errorMessage then
		player:say(errorMessage)
	end

	player:addMana(player:getMaxMana())
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your mana has been refilled.")
	player:say("Mmmm.", TALKTYPE_MONSTER_SAY)
	player:setExhaustion("blueberry-cupcake-cooldown", 10 * 60)
	item:remove(1)
	return true
end

blueberryCupcake:id(28484)
blueberryCupcake:register()
