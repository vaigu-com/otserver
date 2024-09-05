local dromedary_storage = Storage.SultanPrime.DromedaryCount

local dromedary = CreatureEvent("DromedaryKill")

local function playerIsInRange(player, topLeft, downRight)
	local adx = math.abs(topLeft.x - downRight.x)
	local ady = math.abs(topLeft.y - downRight.y)

	local centerPos = topLeft:Moved(adx / 2, ady / 2, 0)
	local playerPos = player:getPosition()
	local playerDx = math.abs(playerPos.x - centerPos.x)
	local playerDy = math.abs(playerPos.y - centerPos.y)
	return playerDx <= adx / 2 and playerDy < ady / 2
end

local function tryGivePlayerCredit(pos)
	local tile = Tile(pos)
	if not tile then
		return
	end
	local creature = tile:getTopCreature()
	if not creature then
		return
	end
	local player = creature:getPlayer()
	if not player then
		return
	end
	player:IncrementStorage(dromedary_storage, 1)
	player:RefreshStorage(Storage.SultanPrime.Mission02)
end

function dromedary.onDeath(creature)
	local targetMonster = creature:getMonster()
	if not targetMonster or targetMonster:getMaster() then
		return true
	end

	onDeathForDamagingPlayers(creature, function(creature, player)
		local storage_val = player:getStorageValue(Storage.SultanPrime.Questline)
		if storage_val ~= 6 then
			return true
		end

		local topLeft = CAMEL_FARM_ANCHOR:Moved(SULTAN_PRIME_CAMEL_FARM.topLeft)
		local downRight = CAMEL_FARM_ANCHOR:Moved(SULTAN_PRIME_CAMEL_FARM.downRight)

		if not playerIsInRange(player, topLeft, downRight) then
			return
		end

		IterateBetweenPositions(topLeft, downRight, function(context)
			tryGivePlayerCredit(context.pos)
		end)
		if player:getStorageValue(dromedary_storage) >= SULTAN_PRIME_CAMEL_FARM.requiredDromedaryCount then
			player:IncrementStorages({ Storage.SultanPrime.Mission02, Storage.SultanPrime.Questline }, 1)
		end
	end)
	return true
end

dromedary:register()
