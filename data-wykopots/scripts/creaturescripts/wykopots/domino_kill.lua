local dominoDeath = CreatureEvent("DominoDeath")
function dominoDeath.onDeath(creature)
	creature:getPosition():sendMagicEffect(CONST_ME_POFF)
	setGlobalStorageValue(GlobalStorage.DominoAlive, 0)

	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValue(Storage.IKEAdlazuchwalych.RemanentMain) == 3 then
			player:setStorageValue(Storage.IKEAdlazuchwalych.RemanentMain, 4)
			player:setStorageValue(Storage.IKEAdlazuchwalych.TakeBall, 1)
		end
	end)
	return true
end
dominoDeath:register()

local dominoDeath2 = CreatureEvent("Domino2Death")
function dominoDeath2.onDeath(creature)
	setGlobalStorageValue(GlobalStorage.Domino2Alive, 0)
	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValue(Storage.IKEAdlazuchwalych.RemanentMain) == 11 then
			player:setStorageValue(Storage.IKEAdlazuchwalych.RemanentMain, 12)
			player:setStorageValue(Storage.IKEAdlazuchwalych.TakeKey, 1)
		end
	end)
	return true
end
dominoDeath2:register()
