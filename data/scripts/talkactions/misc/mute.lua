local talkaction = TalkAction("/mute")

function talkaction.onSay(player, words, param)
	local paramTable = param:split(",")

	local playerIdOrName = paramTable[1]
	local target = Player(playerIdOrName)
	local time = tonumber(paramTable[2])

	if not target then
		player:sendCancelMessage("No such player exists.")
		return false
	end
	if not time or time < 0 then
		player:sendCancelMessage("Wrong time format. Provide uint")
		return false
	end

	if target:getAccountType() >= player:getAccountType() then
		return false
	end

	local condition = Condition(CONDITION_MUTED)
	condition:setParameter(CONDITION_PARAM_TICKS, time * 60 * 1000)

	target:addCondition(condition)
	local _textmsg = "Zostales wyciszony na " .. time .. " minut(y). "
	if paramTable[3] ~= nil and paramTable[3] ~= " " then
		_textmsg = _textmsg .. "Powod: " .. paramTable[3] .. "."
	end
	target:sendTextMessage(MESSAGE_EVENT_ADVANCE, _textmsg)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Wyciszyles " .. target:getName() .. ".")
	return true
end

talkaction:separator(" ")
talkaction:groupType("senior tutor")
talkaction:register()
