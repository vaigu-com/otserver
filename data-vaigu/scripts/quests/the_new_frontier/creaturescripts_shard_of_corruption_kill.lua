local TheNewFrontier = Storage.Quest.U8_54.TheNewFrontier

local shardOfCorruptionKill = CreatureEvent("ShardOfCorruptionDeath")

function shardOfCorruptionKill.onDeath(creature)
	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValueByKey(TheNewFrontier.Questline) == 11 then
			player:setStorageValueByKey(TheNewFrontier.Questline, 12)
		end
	end)
	return true
end

shardOfCorruptionKill:register()
