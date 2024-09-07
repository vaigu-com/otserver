local talkaction = TalkAction("/mute")

function talkaction.onSay(player, words, param)
	local mute = param:split(",")

	if mute[1] == nil or mute[1] == " " then
		player:sendCancelMessage("Nie ma takiego gracza.")
		return false
	end

	if mute[2] == nil or mute[2] == " " then
		player:sendCancelMessage("Invalid time specified.")
		return false
	end

	local target = Player(mute[1])
	local time = tonumber(mute[2])

	if not target then
		player:sendCancelMessage("Nie ma takiego gracza.")
		return false
	elseif target:getAccountType() >= player:getAccountType() then
		player:sendCancelMessage("Nie mozesz wyciszyc tego gracza, bo jest zbyt zajebisty.")
		target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Gracz " .. player:getName() .. " probowal Cie wyciszyc.")
		return false
	else
		local condition = Condition(CONDITION_MUTED)
		condition:setParameter(CONDITION_PARAM_TICKS, time * 60 * 1000)

		target:addCondition(condition)
		local _textmsg = "Zostales wyciszony na " .. time .. " minut(y). "
		if mute[3] ~= nil and mute[3] ~= " " then
			_textmsg = _textmsg .. "Powod: " .. mute[3] .. "."
		end
		target:sendTextMessage(MESSAGE_EVENT_ADVANCE, _textmsg)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Wyciszyles " .. target:getName() .. ".")
		return true
	end
end

talkaction:separator(" ")
talkaction:groupType("senior tutor")
talkaction:register()
