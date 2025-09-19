local pseudoQuest = Quest(LOCALIZERS.NONE)
pseudoQuest
	:NoQuestlog()
	:Constant(function()
		SpawnLocks.PharaohHurghada = SpawnLock()
	end)
	:Script(function()
		local bossNames = {
			["Monday"] = "Ashmunrah",
			["Tuesday"] = "Dipthrah",
			["Wednesday"] = "Mahrdis",
			["Thursday"] = "Omruc",
			["Friday"] = "Rahemos",
			["Saturday"] = "Thalas",
			["Sunday"] = "Vashresamun",
		}

		local pharaohSpawnPositions = Zone("PharaohSpawnPositions")
		local pharaoh = GlobalEvent("PharaohSummonHurghada")
		function pharaoh.onTime(interval)
			if SpawnLocks.PharaohHurghada:IsSet() then
				return true
			end

			local chosenSpawnPosition = pharaohSpawnPositions:randomPosition()
			local day = os.date("%A")
			local bossName = bossNames[day]
			local boss = Game.createMonster(bossName, chosenSpawnPosition, true, true)

			SpawnLocks.PharaohHurghada:Set(boss)
			return true
		end

		local hour = math.random(0, 23)
		pharaoh:time("" .. hour .. ":40:00")
		pharaoh:register()
	end)
	:Register()
