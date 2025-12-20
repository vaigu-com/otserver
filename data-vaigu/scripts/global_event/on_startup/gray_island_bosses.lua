local bossesData = {
	{ bossName = "Tanjis", teleportToBossRoomPosition = Position(33648, 31261, 11) },
	{ bossName = "Jaul", teleportToBossRoomPosition = Position(33558, 31282, 11) },
	{ bossName = "Obujos", teleportToBossRoomPosition = Position(33438, 31248, 11) },
}

local grayIslandBosses = GlobalEvent("GrayIslandBossesInit")
function grayIslandBosses.onStartup()
	local randomBossData = table.random(bossesData)
	if not randomBossData then
		return true
	end
	Game.setStorageValueByKey(Storage.DeeplingBoss, randomBossData.bossName)
	logger.info("Today Deepling boss: " .. randomBossData.bossName)

	for _, bossData in pairs(bossesData) do
		if bossData ~= randomBossData then
			local portal = bossData.teleportToBossRoomPosition:GetItemById(1949)
			if portal then
				portal:remove()
			end
		end
	end
	return true
end
grayIslandBosses:register()
