local flaskDiscardStorage = "talkaction.potions.flask"

local dontReceiveFlasks = true
local doReceiveFlasks = nil

function Player:ShouldReceiveEmptyPotionFlasks()
	return self:getStorageValueByKey(flaskDiscardStorage) == doReceiveFlasks
end

local function setNotReceive(player)
	player:setStorageValueByKey(flaskDiscardStorage, dontReceiveFlasks)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You will not receive flasks!")
	player:getPosition():sendMagicEffect(CONST_ME_REDSMOKE)
end

local function setYesReceive(player)
	player:removeStorageValueByKey(flaskDiscardStorage)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You will receive flasks.")
	player:getPosition():sendMagicEffect(CONST_ME_REDSMOKE)
end

local flask = TalkAction("!flask", "!vial", "/flask", "/vial")
function flask.onSay(player, words, param)
	if param == "on" then
		setNotReceive(player)
	elseif param == "off" then
		setYesReceive(player)
	elseif param == "" then
		if player:ShouldReceiveEmptyPotionFlasks() then
			setNotReceive(player)
		else
			setYesReceive(player)
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Usage: /flask [on|off]")
	end

	return true
end
flask:separator(" ")
flask:groupType("normal")
flask:register()
