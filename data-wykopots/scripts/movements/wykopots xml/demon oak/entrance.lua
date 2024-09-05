local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValue(Storage.DemonOak.Done) >= 1 then
		player:teleportTo(DEMON_OAK_KICK_POSITION)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end

	if player:getLevel() < 120 then
		player:say("HAHA, NIE JESTES TEGO WART!", TALKTYPE_MONSTER_YELL, false, player, DEMON_OAK_POSITION)
		player:teleportTo(DEMON_OAK_KICK_POSITION)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end

	--if player:getStorageValue(Storage.DemonOak.Squares) == 5 and player:getItemCount(9388) > 0 and #Game.getSpectators(DEMON_OAK_POSITION, false, true, 9, 9, 6, 6) == 0 then
	if player:getItemCount(9388) > 0 and #Game.getSpectators(DEMON_OAK_POSITION, false, true, 9, 9, 6, 6) == 0 then
		player:teleportTo(DEMON_OAK_ENTER_POSITION)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:setStorageValue(Storage.DemonOak.Progress, 1)
		player:removeItem(9388, 1)

		player:say("OCZEKIWALEM CIE! CHODZ TU A DOSTANIESZ CZEGO CHCIALES!", TALKTYPE_MONSTER_YELL, false, player, DEMON_OAK_POSITION)
	elseif player:getStorageValue(Storage.DemonOak.Done) < 1 and player:getStorageValue(Storage.DemonOak.Progress) == 2 and #Game.getSpectators(DEMON_OAK_POSITION, false, true, 9, 9, 6, 6) == 0 then
		player:teleportTo(DEMON_OAK_ENTER_POSITION)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)

		player:say("OCZEKIWALEM CIE! CHODZ TU A DOSTANIESZ CZEGO CHCIALES!", TALKTYPE_MONSTER_YELL, false, player, DEMON_OAK_POSITION)
	else
		player:teleportTo(DEMON_OAK_KICK_POSITION)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end
	return true
end

movement:type("stepin")
movement:uid(9000)
movement:register()
