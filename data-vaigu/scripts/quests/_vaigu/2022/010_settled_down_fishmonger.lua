local quest = Quest(LOCALIZERS)

quest
	:Storage(function()
		Storage.SettledDownFishmonger = {
			Mission01 = 11086,
			Mission02 = 11087,
			Mission03 = 11088,
			FajtlapaFloat = 11087,
			FajtlapaReel = 11088,
			FajtlapaStool = 11089,
			FajtlapaItems = 11090,
			Bigos = 11091,
		}
	 end)
	:Constant(function() end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Settled down Fishmonger",
			missions = {
				[Storage.SettledDownFishmonger.Mission01] = {
					name = "Stagnation",
					states = {
						[1] = "Anon's father is waiting for his order.",
						[2] = "You helped Anon's father recover his long-awaited package. Ask him for new mission now.",
					},
				},
				[Storage.SettledDownFishmonger.Mission02] = {
					name = "Milksop",
					states = {
						[1] = "Anon's father needs help finding some old junk he carried with him for fishing. Search all boats, piers, and swamps around Mirko Town for any found items.",
						[2] = "You helped Anon's father collect his lost tools.",
					},
				},
				[Storage.SettledDownFishmonger.Mission03] = {
					name = "Stew for Trouble",
					states = {
						[1] = "Anon's father received his table in a deplorable state, ask how you can improve his mood.",
						[2] = "Anon's father reacted strongly to the fact that someone destroyed his little table. Bring some of his favorite dishes, and he might calm down. Anon's father mentioned that he loves Rotworm Stew.",
						[3] = "You helped Anon's father with all the troubles. Now, go to his son for your reward.",
						[4] = "You have received a reward from the Fisherman Son. You gained the ability to purchase Shimmer Swimmer.",
					},
				},
			},
		}
	end)
	:Mission(PH_MISSION)
	:STATE(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))
