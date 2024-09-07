local errorMessage = "You need to wait before using it again."
local blueberryCupcake = Action()

function blueberryCupcake.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local canUse = player:canUseCooldownItem("blueberry-cupcake-cooldown")
	if not canUse then
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
