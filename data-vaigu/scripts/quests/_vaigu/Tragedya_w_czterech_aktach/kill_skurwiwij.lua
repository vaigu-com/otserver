local updateStorages = {
	[Storage.FourActTragedy.Questline] = 14,
	[Storage.FourActTragedy.Mission05] = 2,
}

local skurwiwijDeath = CreatureEvent("SkurwiwijDeath")
function skurwiwijDeath.onDeath(creature)
	if not creature or not creature:isMonster() then
		return true
	end
	onDeathForDamagingPlayers(creature, function(creature, player)
		local storage_val = player:getStorageValue(Storage.FourActTragedy.Questline)
		if storage_val ~= 13 then
			return true
		end
		player:UpdateStorages(updateStorages)
	end)

	local deathPos = creature:getPosition()

	local corpse = Game.createItem(18021, 1, deathPos)
	corpse:setActionId(Storage.FourActTragedy.Rewards.GrazynaCore)
	corpse:setUniqueId(1000)
	return true
end

skurwiwijDeath:register()
