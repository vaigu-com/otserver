local config = {
	teleportId = 1949,
	days = {
		[1] = { 28580 }, -- black vixen
		[2] = { 28581 }, -- sharpclaw
		[3] = { 28582 }, -- darkfang
		[4] = { 28583 }, -- bloodback
		[5] = { 28584 }, -- shadowpelt
	},
}

local werebosses = GlobalEvent("were boss creatures")
function werebosses.onStartup()
	local rand = math.random(1, 5)
	Game.setStorageValue(GlobalStorage.WereBoss, rand)
	local bossNames = {
		[1] = "black vixen",
		[2] = "sharpclaw",
		[3] = "darkfang",
		[4] = "bloodback",
		[5] = "shadowpelt",
	}

	if bossNames[rand] then
		logger.info("WereCreature boss: " .. bossNames[rand])
	end
	local day = config.days[rand]
	if day then
		local item = Game.createItem(config.teleportId, 1, Position(6215, 1091, 6))
		if item then
			if not item:isTeleport() then
				item:remove()
				return false
			end
			item:setActionId(day[1])
		end
	end
	return true
end

werebosses:register()
