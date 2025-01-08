local dominoDeath = CreatureEvent("DominoDeath")
function dominoDeath.onDeath(creature)
	creature:getPosition():sendMagicEffect(CONST_ME_POFF)
	setStorageValueByKey(Storage.DominoAlive, 0)

	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValueByKey(Storage.IKEAForTheBold.State) == 3 then
			player:setStorageValueByKey(Storage.IKEAForTheBold.State, 4)
			player:setStorageValueByKey(Storage.IKEAForTheBold.TakeBall, 1)
		end
	end)
	return true
end
dominoDeath:register()

local dominoDeath2 = CreatureEvent("Domino2Death")
function dominoDeath2.onDeath(creature)
	setStorageValueByKey(Storage.Domino2Alive, 0)
	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValueByKey(Storage.IKEAForTheBold.State) == 11 then
			player:setStorageValueByKey(Storage.IKEAForTheBold.State, 12)
			player:setStorageValueByKey(Storage.IKEAForTheBold.TakeKey, 1)
		end
	end)
	return true
end
dominoDeath2:register()
