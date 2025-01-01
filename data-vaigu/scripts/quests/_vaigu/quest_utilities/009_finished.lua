local quest = Quest(LOCALIZERS.NONE)

quest
	:Storage(function()
		Storage.Finished = {
			--#region Real
			DemonHelmet = NextStorage(),
			PitsofInferno = NextStorage(),
			Annihilator = NextStorage(),
			Banshee = NextStorage(),
			TheInquisition = NextStorage(),
			HeartofDestruction = NextStorage(),
			TheApeCity = NextStorage(),
			LiquidBlack = NextStorage(),
			DemonOak = NextStorage(),
			BigfootsBurden = NextStorage(),
			-- Annihilator = 4016,
			-- Annihilator = 4017,
			-- Annihilator = 4018,
			-- PitsofInferno = 4020,
			-- PitsofInferno = 4021,
			FirstArena = NextStorage(),
			SecondArena = NextStorage(),
			ThirdArena = NextStorage(),
			--#endregion

			--#region Simple chest
			DwarvenLegs = NextStorage(),
			OrcFortress = NextStorage(),
			-- OrcFortress = 6024,
			-- OrcFortress = 6025,
			-- blegs = 6037
			-- warlock = 6043
			--#endregion

			--#region Old quests
			ArielsFriend = NextStorage(),
			Firestarter = NextStorage(),
			TrudnePoczatki = NextStorage(),
			Ocellatus = NextStorage(),
			SilenceOfTheLambs = NextStorage(),
			TheDreamCourts = NextStorage(),
			FerumbrasAscendant = NextStorage(),
			TopChef = NextStorage(),
			SciezkaDruida = NextStorage(),
			--#endregion

			--#region 2022
			TheaterOfCheapThrills = NextStorage(),
			IkeaForTheBold = NextStorage(),
			SettledDownFishmonger = NextStorage(),
			PathOfTheUndead = NextStorage(),
			AssassinsCreedSquurvaali = NextStorage(),
			ImRestingHere = NextStorage(),
			ChesterTheDwarf = NextStorage(),
			CaveExplorerOnShield = NextStorage(),
			DesertQuestOne = NextStorage(),
			SultanPrime = NextStorage(),
			--#endregion

			--#region 2024
			DesertQuestTwo = NextStorage(),
			ProdigalSon = NextStorage(),
			SafetyAndOccupationalHygiene = NextStorage(),
			ThreeSramatiansAndTheDragon = NextStorage(),
			FourActTragedy = NextStorage(),
			PerIustitiaAdAstra = NextStorage(),
			KingOfRatsHQ = NextStorage(),
			--#endregion
		}
	end)
	:Register()
