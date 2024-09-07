local protOn = TalkAction("/protectionon")

function protOn.onSay(player, words, param)
	print("1")
	if Game.getStorageValue(GlobalStorage.Protection) <= 0 then
		Game.setStorageValue(GlobalStorage.Protection, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Protekcja zostala wlaczaona.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Protekcja jest juz wlaczaona.")
	end
	return true
end

protOn:separator(" ")
protOn:groupType("tutor")
protOn:register()

local protOff = TalkAction("/protectionoff")

function protOff.onSay(player, words, param)
	if Game.getStorageValue(GlobalStorage.Protection) == 1 then
		Game.setStorageValue(GlobalStorage.Protection, 0)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Protekcja zostala wylaczona.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Protekcja jest wylaczona.")
	end
	return true
end

protOff:separator(" ")
protOff:groupType("tutor")
protOff:register()
