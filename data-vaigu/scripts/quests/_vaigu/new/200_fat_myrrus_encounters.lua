local quest = Quest(LOCALIZERS.FatMyrrusEncounters)

quest
	:Storage(function()
		Storage.FatMyrrusEncounters = {
			Mission01 = {},
		}
		QuestTopics.FatMyrrusEncounters = {
			SayEncounterName = NextTopic(),
		}
	end)
	:Constant(function()
		QuestConstants.FatMyrrusEncounters = {
			EncounterNames = {
				Kraken = "Kraken",
				Zul_Szczurow = "Zul Szczurow",
				HFPX = "HF-P/X",
				King_of_the_Crypt = "King of the Crypt",
				Pol = "Pol",
				Skurwiwij = "Skurwiwij",
				Ruk_ca_Maw = "Ruk'ca Maw",
			},
		}
	end)
	:NoQuestlog()
	:Mission(Storage.FatMyrrusEncounters.Mission01)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("Fat Myrrus", {
				[{ "encounters", "bosses", "boss", "bossami" }] = {
					text = "I didnt throw my life away for video games just to give away those informations for free. Bring me a {cake} and i will tell you all you need to know about any encounter.",
				},
				[{ "cake", "ciasto" }] = {
					text = "Alright, i can help you with your {encounter} now.",
					textNoRequiredItems = "Come back with a cake. Also, i dont want any toppings on it.",
					nextState = {
						[Storage.FatMyrrusEncounters.Mission01] = MISSION_FINISHED,
					},
					requiredItems = { { id = 6277 } },
				},
			})
	end)
	:State(function()
		return MISSION_FINISHED, QuestFactory.Dialog("Fat Myrrus", {
			[{ "encounters", "bosses", "boss", "bossami", "encounter" }] = {
				text = "LIST_ENCOUNTERS",
				nextTopic = QuestTopics.FatMyrrusEncounters.SayEncounterName,
			},
			[{ ANY_MESSAGE }] = {
				text = "ENCOUNTER_DESCRIPTION",
				requiredTopic = QuestTopics.FatMyrrusEncounters.SayEncounterName,
			},
		})
	end)
	:Register()
