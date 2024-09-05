local jaw = MoveEvent()

function jaw.onAddItem(moveitem, tileitem, position)
	if not moveitem then
		return false
	end
	local id = moveitem.itemid

	local playerPos = tileitem:getPosition():Moved(2, 0, -1)
	local player = Tile(playerPos):getTopCreature()
	if not player then
		return
	end
	local storageVal = player:getStorageValue(Storage.SultanPrime.Questline)
	if storageVal ~= 10 then
		return true
	end

	if not SULTAN_PRIME_RETRO_MIRKO.corpseId[id] then
		return true
	end

	moveitem:remove()
	player:setStorageValue(Storage.SultanPrime.CorpseCount, player:getStorageValue(Storage.SultanPrime.CorpseCount) + 1)
	player:RefreshStorage(Storage.SultanPrime.Mission03)
	if player:getStorageValue(Storage.SultanPrime.CorpseCount) >= SULTAN_PRIME_RETRO_MIRKO.requiredCorpseCount then
		player:setStorageValue(Storage.SultanPrime.Questline, 11)
		player:setStorageValue(Storage.SultanPrime.Mission03, 3)
	end
	return true
end

jaw:type("additem")
jaw:aid(Storage.SultanPrime.Jaw)
jaw:register()
