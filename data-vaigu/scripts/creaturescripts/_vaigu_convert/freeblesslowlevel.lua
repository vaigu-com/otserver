local freeBlessMaxLevel = 35

local creatureevent = CreatureEvent("freebless")

function creatureevent.onLogin(player)
	if player:getLevel() <= freeBlessMaxLevel then
		--[[for i = 2, 6 do
				if not player:hasBlessing(i) then
					player:addBlessing(i, 1)
				end
			end]]
		if getPlayerLanguage(player) == "PL" then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Do " .. freeBlessMaxLevel .. " poziomu otrzymujesz darmowe blogoslawienstwa.")
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You receive free blessings until " .. freeBlessMaxLevel .. " level.")
		end
		player:getPosition():sendMagicEffect(CONST_ME_HOLYDAMAGE)
	end
	return true
end

creatureevent:register()
