local weekDayToBossName = {
	["Monday"] = "Maxxenius",
	["Tuesday"] = "Alptramun",
	["Wednesday"] = "Izcandar the Banished",
	["Thursday"] = "Plagueroot",
	["Friday"] = "Malofur Mangrinder",
	["Saturday"] = nil,
	["Sunday"] = nil,
}

local dreambosses = GlobalEvent("DreamCourtDailyBossDisplay")
function dreambosses.onStartup()
	local day = weekDayToBossName[os.date("%A")]
	local bossName = weekDayToBossName[day] or table.random(weekDayToBossName)
	Game.setStorageValueByKey(Storage.DreamBoss, bossName)
end
dreambosses:register()
