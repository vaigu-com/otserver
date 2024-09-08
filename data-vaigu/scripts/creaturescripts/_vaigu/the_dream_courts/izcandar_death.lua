local izcandarSummonDeath = CreatureEvent("IzcandarDeath")
function izcandarSummonDeath.onDeath(creature)
	if not creature or not creature:isMonster() then
		return true
	end
	if Game.getStorageValue(GlobalStorage.IzcandarTransforming) ~= 0 then
		Game.setStorageValue(GlobalStorage.IzcandarTransforming, 0)
	end
	return true
end

izcandarSummonDeath:register()
