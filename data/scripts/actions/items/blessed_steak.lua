local errorMessage = "You need to wait before using it again."
local blessedSteak = Action()

function blessedSteak.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local canUse = player:canUseCooldownItem("special-foods-cooldown")
	if not canUse then
		player:say(errorMessage)
	end

	player:addMana(player:getMaxMana())
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your mana has been refilled.")
	player:say("Chomp.", TALKTYPE_MONSTER_SAY)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
	player:setExhaustion("special-foods-cooldown", 10 * 60)
	item:remove(1)
	return true
end

blessedSteak:id(9086)
blessedSteak:register()
