local creatureevent = CreatureEvent("ShattererDeath")

function creatureevent.onDeath(creature)
	local spectators = Game.getSpectators(Position(7198, 1754, 14), false, false, 30, 30, 30, 30)
	for i = 1, #spectators do
		local spec = spectators[i]
		if spec:isPlayer() then
			spec:teleportTo(Position(7186, 1742, 15))
			spec:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			spec:setStorageValue(Storage.Ferumbras.ShattererEntry, 1)
		end
	end
	return true
end

creatureevent:register()
