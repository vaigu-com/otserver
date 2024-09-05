local talkaction = TalkAction("!lowexp")

function talkaction.onSay(player, words, param)
	if player:getStorageValue(Storage.expRatex3) <= 0 then
		player:setStorageValue(Storage.expRatex3, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Zmieniles swoj exp rate na x3.")
	elseif player:getStorageValue(Storage.expRatex3) == 1 then
		player:setStorageValue(Storage.expRatex3, 0)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Zmieniles swoj exp rate na standardowy.")
	end
	return false
end

talkaction:separator(" ")
talkaction:groupType("normal")
talkaction:register()
