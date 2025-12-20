local izcandarSummonDeath = CreatureEvent("IzcandarDeath")
function izcandarSummonDeath.onDeath(creature)
	if not creature or not creature:isMonster() then
		return true
	end
	if Game.getStorageValueByKey(Storage.IzcandarTransforming) ~= 0 then
		Game.setStorageValueByKey(Storage.IzcandarTransforming, 0)
	end
	return true
end

izcandarSummonDeath:register()
