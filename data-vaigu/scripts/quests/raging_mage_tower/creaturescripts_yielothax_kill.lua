local yielothaxKill = CreatureEvent("YielothaxDeath")
function yielothaxKill.onDeath(creature)
	setStorageValueByKey(673003, getStorageValueByKey(673003) + 1)
	return true
end

yielothaxKill:register()
