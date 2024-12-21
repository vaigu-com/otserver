local quest = Quest(LOCALIZERS.NONE)

quest
	:Storage(function()
		Storage.Finished = {
			--#region Real
			DemonHelmet = 2493,
			PitsofInferno = 4019,
			Annihilator = 4015,
			Banshee = 6065,
			TheInquisition = 12177,
			HeartofDestruction = 15009,
			TheApeCity = 15008,
			LiquidBlack = 15011,
			DemonOak = 15005,
			BigfootsBurden = 15013,
			-- Annihilator = 4016,
			-- Annihilator = 4017,
			-- Annihilator = 4018,
			-- PitsofInferno = 4020,
			-- PitsofInferno = 4021,
			FirstArena = 4028,
			SecondArena = 4029,
			ThirdArena = 4030,
			--#endregion

			--#region Simple chest
			DwarvenLegs = 6010,
			OrcFortress = 6023,
			-- OrcFortress = 6024,
			-- OrcFortress = 6025,
			-- blegs = 6037
			-- warlock = 6043
			--#endregion

			--#region Old quests
			ArielsFriend = 11001,
			Firestarter = 15000,
			TrudnePoczatki = 15002,
			Ocellatus = 15003,
			SilenceOfTheLambs = 15004,
			TheDreamCourts = 15006,
			FerumbrasAscendant = 15007,
			TopChef = 15010,
			SciezkaDruida = 15012,
			--#endregion

			--#region 2022
			TheaterOfCheapThrills = 15021,
			IkeaForTheBold = 15014,
			SettledDownFishmonger = 15015,
			PathOfTheUndead = 15020,
			AssassinsCreedSquurvaali = 15017,
			ImRestingHere = 15018,
			ChesterTheDwarf = 15019,
			CaveExplorerOnShield = 15027,
			DesertQuestOne = 15028,
			SultanPrime = 15030,
			--#endregion

			--#region 2024
			DesertQuestTwo = 15029,
			ProdigalSon = 15031,
			SafetyAndOccupationalHygiene = 15022,
			ThreeSramatiansAndTheDragon = 15023,
			FourActTragedy = 15024,
			PerIustitiaAdAstra = 15025,
			KingOfRatsHQ = 15026,
			--#endregion
		}
	end)
	:Register()
