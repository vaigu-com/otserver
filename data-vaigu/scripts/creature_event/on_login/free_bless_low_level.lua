function GrantFreeBlessLowLevel(player)
	if player:getLevel() > MAX_LVL_TO_GET_FREE_BLESS then
		return
	end

	for i = 2, 6 do
		if not player:hasBlessing(i) then
			player:addBlessing(i, 1)
		end
	end

	if getPlayerLanguage(player) == "PL" then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Do " .. MAX_LVL_TO_GET_FREE_BLESS .. " poziomu mozesz otrzymac darmowe blogoslawienstwa. Zglos sie do Ksiedza Natanka, a cie poblogoslawi.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can receive free blessings until " .. MAX_LVL_TO_GET_FREE_BLESS .. " level. Ask Father Natanek for help.")
	end
	player:getPosition():sendMagicEffect(CONST_ME_HOLYDAMAGE)
	return LOGIN_OK
end

local creatureevent = CreatureEvent("freebless")
function creatureevent.onLogin(player)
	GrantFreeBlessLowLevel(player)
	return LOGIN_OK
end
creatureevent:register()
