local function notifyPlayerCanGetFreeBless(player)
	if getPlayerLanguage(player) == "PL" then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Do " .. MAX_LVL_TO_GET_FREE_BLESS .. " poziomu mozesz otrzymac darmowe blogoslawienstwa. Zglos sie do Ksiedza Natanka, a cie poblogoslawi.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can receive free blessings until " .. MAX_LVL_TO_GET_FREE_BLESS .. " level. Ask Father Natanek and we will surely help you.")
	end
	player:getPosition():sendMagicEffect(CONST_ME_HOLYDAMAGE)
	return LOGIN_OK
end

local creatureevent = CreatureEvent("freebless")
function creatureevent.onLogin(player)
	if player:getLevel() > MAX_LVL_TO_GET_FREE_BLESS then
		return
	end
	notifyPlayerCanGetFreeBless(player)
	return LOGIN_OK
end
creatureevent:register()
