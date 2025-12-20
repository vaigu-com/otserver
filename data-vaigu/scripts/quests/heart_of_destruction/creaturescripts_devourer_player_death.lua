local devourerStorage = CreatureEvent("DevourerStorage")
function devourerStorage.onDeath(player)
	player:setStorageValueByKey(14334, -1)
	player:setStorageValueByKey(14335, -1)
	player:setStorageValueByKey(14336, -1)
	player:unregisterEvent("DevourerStorage")
	return true
end

devourerStorage:register()
