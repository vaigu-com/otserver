local lodkaKaiman = Action()

function lodkaKaiman.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if isPlayerPzLocked(player) then
		doCreatureSay(player, "Nie mozesz tedy uciec!", TALKTYPE_ORANGE_1)
		return false
	else
		fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
		local destination = Position(6478, 989, 7)
		player:teleportTo(destination)
		destination:sendMagicEffect(CONST_ME_TELEPORT)
	end
end

lodkaKaiman:aid(11080)
lodkaKaiman:register()

local lodkaKaimanBack = Action()

function lodkaKaimanBack.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if isPlayerPzLocked(player) then
		doCreatureSay(player, "Nie mozesz tedy uciec!", TALKTYPE_ORANGE_1)
		return false
	else
		fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
		local destination = Position(6232, 1034, 7)
		player:teleportTo(destination)
		destination:sendMagicEffect(CONST_ME_TELEPORT)
	end
end

lodkaKaimanBack:aid(11081)
lodkaKaimanBack:register()
