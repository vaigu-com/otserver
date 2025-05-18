Storage.DailyGuaranteedSilverToken = {}

local function tryRegisterDailyTokenGranting(monsterName)
	local monsterType = MonsterType(monsterName)
	if not monsterType then
		return
	end

	monsterType:registerEvent("DailyGuaranteedSilverTokenDeath")
end

local function hasSilverTokenInLoot(monsterTypeData)
	if not monsterTypeData.loot then
		return false
	end

	for _, itemData in pairs(monsterTypeData.loot) do
		if itemData.name == "silver token" or itemData.id == 22516 then
			return true
		end
	end

	return false
end

local dailyGuaranteedSilverToken = GlobalEvent("DailyGuaranteedSilverTokenInit")
function dailyGuaranteedSilverToken.onStartup()
	local monsterTypesData = MonsterTypeRepository:Get()
	for monsterName, monsterTypeData in pairs(monsterTypesData) do
		if hasSilverTokenInLoot(monsterTypeData) then
			tryRegisterDailyTokenGranting(monsterName)
		end
	end
end
dailyGuaranteedSilverToken:register()

local oneSilverToken = { id = 22516, count = 1 }

local dailyGuaranteedSilverTokenDeath = CreatureEvent("DailyGuaranteedSilverTokenDeath")
function dailyGuaranteedSilverTokenDeath.onDeath(creature, _corpse, _lastHitKiller, mostDamageKiller)
	onDeathForDamagingPlayers(creature, function(creature, player)
		local playerCooldownState = player:getStorageValueByKey(Storage.DailyGuaranteedSilverToken)
		if playerCooldownState > os.time() then
			return
		end
		if player:TryAddItems({ oneSilverToken }) then
			player:setStorageValueByKey(Storage.DailyGuaranteedSilverToken, NextWednesdayEpochTime())
		end
	end)
	return true
end
dailyGuaranteedSilverTokenDeath:register()
