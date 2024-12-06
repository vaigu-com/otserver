local quest = Quest(LOCALIZERS)

quest
	:Storage(function()
		Storage.SilenceOfTheLambs = {
			TestOfStrength = 11065,
			FashionistaClothes = 11066,
			RubMeatWithLecter = 11073,
			HumanHearts = 11074,
			HumanLivers = 11075,
		}
	end)
	:Constant(function() end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "The Silence of the Lambs",
			missions = {
				[Storage.SilenceOfTheLambs.TestOfStrength] = {
					name = "The test of Strength",
					states = {
						[1] = "Lecter asked you for 5 vampire teeth.",
						[2] = "In exchange for your help, Lecter bestowed you with his old soul-extraction tool.",
					},
				},
				[Storage.SilenceOfTheLambs.FashionistaClothes] = {
					name = "Fashionista clothes",
					states = {
						[1] = "Lecter asked you to bring him 20 leathers of every kind.",
						[2] = "For your help you have been taught how to skin human carcass.",
					},
				},
				[Storage.SilenceOfTheLambs.LectersRecipe] = {
					name = "Lecter's recipe",
					states = {
						[1] = "LECTER_WANTS_HEARTS_AND_LIVERS_STATUS",
						[2] = "In exchange for this favor you have been introduced to the cannibal club. You also received their outfits.",
					},
				},
			},
		}
	end)
	:Mission(PH_MISSION)
	:STATE(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))
