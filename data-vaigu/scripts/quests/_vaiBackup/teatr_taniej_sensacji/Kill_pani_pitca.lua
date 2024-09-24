	:MonsterEvent(function()
local storages = {
	Storage.TheaterOfCheapThrills.Questline,
	Storage.TheaterOfCheapThrills.Mission03,
}

local pitcaDeath = CreatureEvent("PitcaDeath")
function pitcaDeath.onDeath(creature)
	if not creature or not creature:isMonster() then
		return true
	end
	Game.setStorageValue(Storage.TheaterOfCheapThrills.Spawns.MissPizza, 0)
	onDeathForDamagingPlayers(creature, function(creature, player)
		local storage_val = player:getStorageValue(Storage.TheaterOfCheapThrills.Mission03)
		if storage_val ~= 2 then
			return true
		end
		player:IncrementStorages(storages, 1)
	end)
	return true
end

pitcaDeath:register()
end)
