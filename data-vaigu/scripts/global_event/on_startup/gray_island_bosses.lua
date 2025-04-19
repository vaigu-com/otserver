local teleportId = 1949

local bossesData = {
	{ bossName = "Tanjis", bossSpawnPosition = Position(6912, 2486, 11), teleportToBossRoomPosition = Position(6913, 2500, 11), teleportToBossRoomDestination = Position(6905, 2472, 11), key = 28574 },
	{ bossName = "Jaul", bossSpawnPosition = Position(6810, 2513, 11), teleportToBossRoomPosition = Position(6823, 2521, 11), teleportToBossRoomDestination = Position(6811, 2502, 11), key = 28575 },
	{ bossName = "Obujos", bossSpawnPosition = Position(6696, 2497, 11), teleportToBossRoomPosition = Position(6703, 2487, 11), teleportToBossRoomDestination = Position(6685, 2494, 11), key = 28576 },
}

local grayIslandBosses = GlobalEvent("GrayIslandBossesDisplay")
function grayIslandBosses.onStartup()
	local randomBossData = table.random(bossesData)
	if not randomBossData then
		return true
	end
	Game.setStorageValueByKey(Storage.DeeplingBoss, randomBossData.bossName)
	logger.info("Today Deepling boss: " .. randomBossData.bossName)
	local item = Game.createItem(teleportId, 1, randomBossData.teleportToBossRoomPosition)
	if item then
		item:setKey(randomBossData.key)
	end
	return true
end
grayIslandBosses:register()
