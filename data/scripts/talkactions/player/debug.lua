local debug = TalkAction("!debug")
function debug.onSay(player, words, param)
	local state = player:getStorageValueByKey(Storage.DebugOnLook)

	local nextState = nil
	if state == ACCESS_GRANTED then
		nextState = ACCESS_NOT_GRANTED
	else
		nextState = ACCESS_GRANTED
	end

	player:setStorageValueByKey(Storage.DebugOnLook, nextState)
	return true
end
debug:groupType("normal")
debug:register()
