local quest = Quest(LOCALIZERS.NONE)

quest
	:Storage(function()
		Storage.Finished = {
			--#region Real
			DemonHelmet = {},
			PitsofInferno = {},
			Annihilator = {},
			Banshee = {},
			TheInquisition = {},
			HeartofDestruction = {},
			TheApeCity = {},
			LiquidBlack = {},
			DemonOak = {},
			BigfootsBurden = {},
			-- Annihilator = 4016,
			-- Annihilator = 4017,
			-- Annihilator = 4018,
			-- PitsofInferno = 4020,
			-- PitsofInferno = 4021,
			FirstArena = {},
			SecondArena = {},
			ThirdArena = {},
			--#endregion

			--#region Simple chest
			DwarvenLegs = {},
			OrcFortress = {},
			-- OrcFortress = 6024,
			-- OrcFortress = 6025,
			-- blegs = 6037
			-- warlock = 6043
			--#endregion

			--#region Old quests
			ArielsFriend = {},
			Firestarter = {},
			TrudnePoczatki = {},
			Ocellatus = {},
			SilenceOfTheLambs = {},
			TheDreamCourts = {},
			FerumbrasAscendant = {},
			TopChef = {},
			WayOfTheDruid = {},
			--#endregion

			--#region 2022
			TheaterOfCheapThrills = {},
			IkeaForTheBold = {},
			SettledDownFishmonger = {},
			PathOfTheUndead = {},
			AssassinsCreedSquurvaali = {},
			ImRestingHere = {},
			ChesterTheDwarf = {},
			CaveExplorerOnShield = {},
			DesertQuestOne = {},
			SultanPrime = {},
			--#endregion

			--#region 2024
			DesertQuestTwo = {},
			ProdigalSon = {},
			SafetyAndOccupationalHygiene = {},
			ThreeSramatiansAndTheDragon = {},
			FourActTragedy = {},
			PerIustitiaAdAstra = {},
			KingOfRatsHQ = {},
			--#endregion
		}
	end)
	:NoQuestlog()
	:Register()
