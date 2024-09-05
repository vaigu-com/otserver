local talkaction = TalkAction("/unlock")

function talkaction.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	local resultId = db.storeQuery("SELECT `id` FROM `players` WHERE `name` = " .. db.escapeString(param))
	if resultId == false then
		return false
	end

	db.asyncQuery("DELETE FROM `player_namelocks` WHERE `player_id` = " .. result.getDataInt(resultId, "id"))
	result.free(resultId)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, param .. " has been unlocked.")
	return false
end

talkaction:separator(" ")
talkaction:groupType("gamemaster")
talkaction:register()
