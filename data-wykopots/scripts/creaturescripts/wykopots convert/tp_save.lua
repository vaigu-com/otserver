local creatureEvent = CreatureEvent("tp_save")

function creatureEvent.onModalWindow(player, modalWindowId, buttonId, choiceId)
	local player = Player(player)

	if modalWindowId == 61 and buttonId == 1 or modalWindowId ~= 61 or modalWindowId == 61 and buttonId == 3 then --cancel button
		return true
	end

	local acc = tostring(player:getAccountId())
	file = io.open("data/savePos/" .. acc .. ".txt", "r")
	if file == nil then
		player:sendCancelMessage("Nie posiadasz zapisanych lokalizacji.")
		return true
	end
	local count = 1
	for line in file:lines() do
		if count > choiceId then
			break
		end

		if count == choiceId then
			local split = line:split(",")
			player:teleportTo(Position(split[1], split[2], split[3]))
			player:sendCancelMessage(text)
		end
		count = count + 1
	end

	file:close()

	return true
end

creatureEvent:register()
