local bossesData = {
	{ portalAid = 28580, bossName = "black vixen" },
	{ portalAid = 28581, bossName = "sharpclaw" },
	{ portalAid = 28582, bossName = "darkfang" },
	{ portalAid = 28583, bossName = "bloodback" },
	{ portalAid = 28584, bossName = "shadowpelt" },
}

local teleportId = 1949

local werebosses = GlobalEvent("WerecreatureBossDisplay")
function werebosses.onStartup()
	local randomBossData = table.random(bossesData)
	if not randomBossData then
		return true
	end

	Game.setStorageValueByKey(Storage.WereBoss, randomBossData.bossName)
	logger.info("Today Werecreature boss: " .. randomBossData.bossName)

	local teleport = Game.createItem(teleportId, 1, Position(6215, 1091, 6))
	teleport:setActionId(randomBossData.portalAid)
	return true
end
werebosses:register()
