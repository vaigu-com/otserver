local coffin = Action()

function coffin.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not target then
		return false
	end
	local storageVal = player:getStorageValue(Storage.SultanPrime.Questline)
	if storageVal ~= 9 then
		return true
	end

	Game.createItem(2121, 1, toPosition)
	player:setStorageValue(Storage.SultanPrime.CoffinCount, player:getStorageValue(Storage.SultanPrime.CoffinCount) + 1)
	player:RefreshStorage(Storage.SultanPrime.Mission03)
	player:RefreshStorage(Storage.SultanPrime.Questline)

	if (player:getStorageValue(Storage.SultanPrime.CoffinCount)) == SULTAN_PRIME_RETRO_MIRKO.requiredCoffinCount then
		player:setStorageValue(Storage.SultanPrime.CorpseCount, 0)
		player:setStorageValue(Storage.SultanPrime.Questline, 10)
		player:setStorageValue(Storage.SultanPrime.Mission03, 2)
	end
	return true
end

coffin:aid(Storage.SultanPrime.Coffin)
coffin:register()
