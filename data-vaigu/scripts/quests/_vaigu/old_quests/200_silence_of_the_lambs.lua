local quest = Quest(LOCALIZERS.SilenceOfTheLambs)

quest
	:Storage(function()
		Storage.SilenceOfTheLambs = {
			TestOfStrength = {},
			FashionableClothes = {},
			RubMeatWithLecter = {},
			HumanHeart = {},
		}
		QuestState.SilenceOfTheLambs = {
			TestOfStrength = {
				BringTeethToLecter = 1,
				AskLecterForNewMission = 2,
			},
			FashionableClothes = {
				BringLeatherToLecter = 1,
				AskLecterForNewMission = 2,
			},
			RubMeatWithLecter = {
				BringHeartsToLecter = 1,
			},
		}
	end)
	:Constant(function()
		QuestKeyItems.SilenceOfTheLambs = {
			HumanHeart = {
				id = 5943,
				key = Storage.SilenceOfTheLambs.HumanHeart,
			},
		}
	end)
	:Questlog(function(localizer)
		table.insert(Questlog, {
			name = "The Silence of the Lambs",
			localizer = localizer,
			missions = {
				{
					name = "The test of Strength",
					storage = Storage.SilenceOfTheLambs.TestOfStrength,
					states = {
						[QuestState.SilenceOfTheLambs.TestOfStrength.BringTeethToLecter] = "Lecter asked you for 5 vampire teeth.",
						[QuestState.SilenceOfTheLambs.TestOfStrength.AskLecterForNewMission] = "Ask Lecter for a new mission.",
						[MISSION_FINISHED] = "In exchange for your help, Lecter bestowed you with his old soul-extraction tool.",
					},
				},
				{
					name = "Fashionable clothes",
					storage = Storage.SilenceOfTheLambs.FashionableClothes,
					states = {
						[QuestState.SilenceOfTheLambs.FashionableClothes.BringLeatherToLecter] = "Lecter asked you to bring him 20 leathers of every kind.",
						[QuestState.SilenceOfTheLambs.FashionableClothes.AskLecterForNewMission] = "Ask Lecter for a new mission.",
						[MISSION_FINISHED] = "For your help you have been taught how to skin human carcass.",
					},
				},
				{
					name = "Rub Meat With Lecter",
					storage = Storage.SilenceOfTheLambs.RubMeatWithLecter,
					states = {
						[QuestState.SilenceOfTheLambs.RubMeatWithLecter.BringHeartsToLecter] = "LECTER_WANTS_HUMAN_HEARTS_STATUS",
						[MISSION_FINISHED] = "In exchange for this favor you have been introduced to the cannibal club. You also received their outfits.",
					},
				},
			},
		})
	end)
	:Mission(Storage.SilenceOfTheLambs.TestOfStrength)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("Lecter", {
				[{ "mission", "misja" }] = {
					text = "I love human meat. Why don't you sell me your family for some soup? Or maybe would you like to be my assistant?\nNevermind, firstly you need to prove you are worthy. Then I will give you my old tool which I used to use before I have enjoyed human meat. Bring me 5 vampire teeth please, they are very good for making needles. Go now, otherwise I will get you.",
					nextState = {
						[Storage.SilenceOfTheLambs.TestOfStrength] = QuestState.SilenceOfTheLambs.TestOfStrength.BringTeethToLecter,
					},
				},
			})
	end)
	:State(function()
		return QuestState.SilenceOfTheLambs.TestOfStrength.BringTeethToLecter,
			QuestFactory.Dialog("Lecter", {
				[{ "mission", "misja" }] = {
					text = "You did your task very well, you will use these tools properly for sure. Come back to me when you have decided you want to know the real taste.",
					textNoRequiredItems = "Why are you coming back without vampire teeth? Should I be taking yours instead?\nCome back when you have proven that you are worthy of using this tool.",
					expReward = 50000,
					requiredItems = {
						{ id = 9685, count = 5 },
					},
					rewards = {
						{ id = 5942 },
					},
					nextState = {
						[Storage.SilenceOfTheLambs.TestOfStrength] = QuestState.SilenceOfTheLambs.TestOfStrength.AskLecterForNewMission,
					},
				},
			})
	end)
	:State(function()
		return QuestState.SilenceOfTheLambs.TestOfStrength.AskLecterForNewMission,
			QuestFactory.Dialog("Lecter", {
				[{ "mission", "misja" }] = {
					text = "So you want to help me again? Listen, recently I've been sewing a little bit, but human skin itself its not enough.\nI will need some different colours and materials. Bring me 20 pieces of {skin} of each type.\nIf you do that I will teach you everything about skinning.",
					nextState = {
						[Storage.SilenceOfTheLambs.TestOfStrength] = MISSION_FINISHED,
						[Storage.SilenceOfTheLambs.FashionableClothes] = QuestState.SilenceOfTheLambs.FashionableClothes.BringLeatherToLecter,
					},
				},
			})
	end)
	:Mission(Storage.SilenceOfTheLambs.FashionableClothes)
	:State(function()
		return QuestState.SilenceOfTheLambs.FashionableClothes.BringLeatherToLecter,
			QuestFactory.Dialog("Lecter", {
				[{ "mission", "misja" }] = {
					text = "Yes! Now I have a proper assortment. Maybe I will sew something for you.\nAbout skinning... it didn't go very well. I assume it was your first time skinning.\nRemember, you must start cutting from armpit and cut straight down.\nSo if you know now how to skin people, go and train a little bit. If you want anything else just come back to me for different task.",
					textNoRequiredItems = "You don't have all of the skins. I need 2 skins from green and red dragon, lizard, minotaur, orc and crocodile.",
					expReward = 300000,
					reqiredItems = {
						{ id = 5876, count = 2 },
						{ id = 5877, count = 2 },
						{ id = 5878, count = 2 },
						{ id = 5948, count = 2 },
						{ id = 10279, count = 2 },
						{ id = 11479, count = 2 },
					},
					nextState = {
						[Storage.SilenceOfTheLambs.FashionableClothes] = QuestState.SilenceOfTheLambs.FashionableClothes.AskLecterForNewMission,
					},
				},
			})
	end)
	:State(function()
		return QuestState.SilenceOfTheLambs.FashionableClothes.AskLecterForNewMission,
			QuestFactory.Dialog("Lecter", {
				[{ "mission", "misja" }] = {
					text = "Ahh yes, something to do? I'm going for annual meeting for cannibals and I need to prepare some meals, so I won't come empty handed.\nSo If you know secret skinning techniques already you can help me to gather ingredients. Bring me 15 human hearts.",
					nextState = {
						[Storage.SilenceOfTheLambs.FashionableClothes] = QuestState.SilenceOfTheLambs.RubMeatWithLecter.BringHeartsToLecter,
					},
				},
			})
	end)
	:Mission(Storage.SilenceOfTheLambs.RubMeatWithLecter)
	:State(function()
		return QuestState.SilenceOfTheLambs.RubMeatWithLecter.BringHeartsToLecter,
			QuestFactory.Dialog("Lecter", {
				[{ "mission", "misja" }] = {
					text = "You need to be more careful, some of them are really creased..\nWait, that one is a liver and it looks like it belonged to an alcoholic. Despite that I'm inviting you to the cannibals club. Take this uniform! Take also my vest in gratitude, I'm not using it anymore.",
					textNoRequiredItems = "Come back when you get 15 hearts",
					expReward = 500000,
					requiredItems = {
						{ id = QuestKeyItems.SilenceOfTheLambs.HumanHeart.id, count = 15, key = QuestKeyItems.SilenceOfTheLambs.HumanHeart.key },
					},
					rewards = {
						{ id = 17829 },
					},
					outfitRewards = {
						{ outfit = 366, addons = 0 },
						{ outfit = 367, addons = 0 },
					},
					nextState = {
						[Storage.SilenceOfTheLambs.RubMeatWithLecter] = MISSION_FINISHED,
						[Storage.Finished.SilenceOfTheLambs] = MISSION_FINISHED,
					},
				},
			})
	end)
	:Register()
