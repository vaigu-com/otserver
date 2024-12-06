local dominoDeath = CreatureEvent("DominoDeath")
function dominoDeath.onDeath(creature)
	creature:getPosition():sendMagicEffect(CONST_ME_POFF)
	setGlobalStorageValue(GlobalStorage.DominoAlive, 0)

	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValue(Storage.IKEAForTheBold.State) == 3 then
			player:setStorageValue(Storage.IKEAForTheBold.State, 4)
			player:setStorageValue(Storage.IKEAForTheBold.TakeBall, 1)
		end
	end)
	return true
end
dominoDeath:register()

local dominoDeath2 = CreatureEvent("Domino2Death")
function dominoDeath2.onDeath(creature)
	setGlobalStorageValue(GlobalStorage.Domino2Alive, 0)
	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValue(Storage.IKEAForTheBold.State) == 11 then
			player:setStorageValue(Storage.IKEAForTheBold.State, 12)
			player:setStorageValue(Storage.IKEAForTheBold.TakeKey, 1)
		end
	end)
	return true
end
dominoDeath2:register()
