local quest = Quest(LOCALIZERS.NONE)

quest
	:Storage(function()
		Storage.Finished = {
			--#region Real
			Annihilator = {},
			PitsOfInferno = {},
			OrcFortress = {},
			DwarvenLegs = {},

			TheInquisition = {},
			HeartOfDestruction = {},
			TheApeCity = {},
			LiquidBlack = {},
			DemonOak = {},
			BigfootsBurden = {},
			TheDreamCourts = {},

			FirstArena = {},
			SecondArena = {},
			ThirdArena = {},
			--#endregion

			--#region Simple chest
			-- OrcFortress = 6024,
			-- OrcFortress = 6025,
			-- blegs = 6037
			-- warlock = 6043
			--#endregion

			--#region Old quests
			ArielsFriend = {},
			Firestarter = {},
			SilenceOfTheLambs = {},
			FerumbrasAscendant = {},
			TopChef = {},
			--#endregion

			--#region 2022
			ImRestingHere = {},
			ChesterTheDwarf = {},
			AssassinsCreedSquurvaali = {},
			PathOfTheUndead = {},
			SultanPrime = {},
			ProdigalSon = {},
			--#endregion

			--#region Desert quest
			CaveExplorerOnShield = {},
			DesertQuestOne = {},
			DesertQuestTwo = {},
			--#endregion 2024

			--local support
			Discernment = {},
			WoodDelivery = {},
			PotionConveyorJourneyman = {},
			FreakingRats = {},
			BudgetRecycling = {},
			LostCrystalBall = {},
			Biodegradable = {},
			UnwantedGuests = {},
			TwoMarlinQuest = {},
			OcellatusXD = {},
			IKEAForTheBold = {},
			SettledDownFishmonger = {},

			-- to carry the pigs
			BeLikeSchwarzenegger = {},
			HalfTurnKick = {},
			BalancedDiet = {},
			KitzDominando = {},

			--king ot the rats
			TheaterOfCheapThrills = {},
			SafetyAndOccupationalHygiene = {},
			ThreeSramatiansAndTheDragon = {},
			FourActTragedy = {},
			PerIustitiaAdAstra = {},

			--way of the druid
			TheWayOfADruid = {},
			DeerSeason = {},
			TakenBenek = {},
			RudeEviction = {},
			SecretIngredient = {},
			SingingCrystal = {},

			--#region 2025
			AvastYe = {},
			EnterTheDrunkTank = {},
			RetroRulez = {},
			--#endregion 2025
		}
	end)
	:NoQuestlog()
	:Register()
