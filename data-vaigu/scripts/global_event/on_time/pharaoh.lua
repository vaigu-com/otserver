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

		local requiredMaxRoll = 35
		local pharaoh = GlobalEvent("PharaohSummonHurghada")
		function pharaoh.onTime(interval)
			local roll = math.random(1, 100)
			if roll > requiredMaxRoll then
				return true
			end

			if SpawnLocks.PharaohHurghada:IsSet() then
				return true
			end

			local day = os.date("%A")
			local bossName = bossNames[day]
			local position = Zone("PharaohSpawnPositions"):randomPosition()
			local boss = Game.createMonster(bossName, position, true, true)

			SpawnLocks.PharaohHurghada:Set(boss)
			return true
		end

		local hour = math.random(0, 23)
		pharaoh:time("" .. hour .. ":40:00")
		pharaoh:register()
	end)
	:Register()
