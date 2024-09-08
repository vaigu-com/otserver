local config = {
	[60008] = { pos = Position(7526, 1723, 13), storage = Storage.Ferumbras.Plagirath48 }, --
	[60009] = { pos = Position(7399, 1774, 11), storage = Storage.Ferumbras.Zamulosh48 }, --
	[60010] = { pos = Position(7312, 1695, 14), storage = Storage.Ferumbras.Mazoran48 }, --
	[60011] = { pos = Position(7168, 1794, 14), storage = Storage.Ferumbras.Razzagorn48 }, --
	[60012] = { pos = Position(7239, 1694, 13), storage = Storage.Ferumbras.Ragiaz48 }, --
	[60013] = { pos = Position(7241, 1934, 11), storage = Storage.Ferumbras.Tarbaz48 }, --
	[60014] = { pos = Position(7258, 1892, 13), storage = Storage.Ferumbras.Shulgrax48 }, --
	[60015] = { pos = Position(7545, 1800, 14), storage = Storage.Ferumbras.FerumbrasMortal48 }, --
}

local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local targetPosition = config[item.actionid]
	if not targetPosition then
		return true
	end

	if targetPosition then
		player:teleportTo(targetPosition.pos) -- lever room
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)

		--[[if player:getStorageValue(targetPosition.storage) > os.time() then -- jak zabilismy bosa w ciagu 48h
			player:teleportTo(Position(7097, 1713, 12)) -- rozdroze
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			--player:sendCancelMessage("Kolejny raz bosa pokonac mozesz za "..Game.getStorageValue(targetPosition.storage) - os.time()..".")
			if targetPosition == 60015 then
				player:say('Bosa pokonac mozesz raz na 5 dni.', TALKTYPE_MONSTER_SAY)
			else
				player:say('Bosa pokonac mozesz raz na 20 godzin.', TALKTYPE_MONSTER_SAY)
			end
		else
			player:teleportTo(targetPosition.pos) -- lever room
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		end]]
	end
	return true
end
movement:type("stepin")
movement:aid(60008, 60009, 60010, 60011, 60012, 60013, 60014, 60015)
movement:register()
