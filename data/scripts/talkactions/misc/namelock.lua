local talkaction = TalkAction("/namelock")

function talkaction.onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	local name = param
	local reason = ""

	local separatorPos = param:find(",")
	if separatorPos ~= nil then
		name = param:sub(0, separatorPos - 1)
		reason = string.trim(param:sub(separatorPos + 1))
	end

	local PlayerGUID = getPlayerGUIDByName(name)
	if PlayerGUID == 0 then
		return false
	end

	local timeNow = os.time()
	db.query("INSERT INTO `player_namelocks`(`player_id`, `reason`, `namelocked_at`, `namelocked_by`) VALUES (" .. PlayerGUID .. "," .. db.escapeString(reason) .. "," .. timeNow .. "," .. player:getGuid() .. ")")
	local target = Player(name)
	if target ~= nil then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, target:getName() .. " has been Namelocked.")
		target:remove()
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, name .. " has been Namelocked.")
	end
end

talkaction:separator(" ")
talkaction:groupType("gamemaster")
talkaction:register()
