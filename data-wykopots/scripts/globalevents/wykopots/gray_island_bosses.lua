local config = {
	teleportId = 1949,
	days = {
		[1] = { Position(7000, 987, 11), Position(7000, 980, 11), 28574 }, -- tanjis {x = 7000, y = 987, z = 11}{x = 7000, y = 980, z = 11}
		[2] = { Position(6910, 1008, 11), Position(6897, 989, 11), 28575 }, -- jaul {x = 6910, y = 1008, z = 11}{x = 6897, y = 989, z = 11}{x = 6999, y = 988, z = 11}
		[3] = { Position(6791, 973, 9), Position(6772, 980, 9), 28576 }, -- obujos {x = 6791, y = 973, z = 9}{x = 6772, y = 980, z = 9}{x = 6791, y = 974, z = 9}
	},
}

local gray = GlobalEvent("gray island bosses")
function gray.onStartup()
	local rand = math.random(1, 3)
	Game.setStorageValue(GlobalStorage.DeeplingBoss, rand)
	local bossNames = {
		[1] = "Tanjis",
		[2] = "Jaul",
		[3] = "Obujos",
	}

	if bossNames[rand] then
		logger.info("Deepling boss: " .. bossNames[rand])
	end
	local day = config.days[rand]
	if day then
		local item = Game.createItem(config.teleportId, 1, day[1])
		if item then
			if not item:isTeleport() then
				item:remove()
				return false
			end
			item:setActionId(day[3])
		end
	end
	return true
end

gray:register()
