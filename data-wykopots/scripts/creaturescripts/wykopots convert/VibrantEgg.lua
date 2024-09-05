local mounts = {
	[1] = { name = "Sparkion", ID = 94 },
}

local creatureEvent = CreatureEvent("VibrantEgg")

function creatureEvent.onModalWindow(player, modalWindowId, buttonId, choiceId)
	local player = Player(player)
	player:unregisterEvent("VibrantEgg")
	if modalWindowId == 1001 and buttonId == 100 then
		if choiceId == 0 then
			return false
		end

		if player:removeItem(23538, 1) then
			player:addMount(mounts[choiceId].ID)
			player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You must have a Vibrant Egg in your backpack!")
			return false
		end
	end
end

creatureEvent:register()
