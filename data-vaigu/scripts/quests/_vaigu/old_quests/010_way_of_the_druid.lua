local quest = Quest(LOCALIZERS)

quest
	:Storage(function()
		Storage.WayOfTheDruid = {
			CouncilOfDruids = 11007,
			DeerSeason = 11008,
			TakenBenek = 11017,
			RudeEviction = 11061,
			SandLock = 11062,
			WaterLock = 11063,
			FlowerLock = 11064,
			SecretIngredient = 11067,
			OrnuldMedicine = 11068,
			SingingCrystal = 11069,
		}
	end)
	:Constant(function() end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "The Way of a Druid",
			missions = {
				[Storage.WayOfTheDruid.CouncilOfDruids] = {
					name = "The Council of Druids",
					states = {
						[1] = "You met one of the druids, if you helped him, he would tell you about the Council.",
						[2] = "You helped the first druid. This is the beginning of your journey to become one of them. Find the remaining druid, and provide them with your help.",
						[3] = "The Mother Nature is watching, and she is cherishing as you helped two of the druids.",
						[4] = "Your efforts induced The Mother Nature let you gather water from well at the great tree.",
						[5] = "You drew water from well at the sacred tree. Now try to find the next druid.",
						[6] = "Your kindness goes a long way, you helped four druids so far.",
						[7] = "You helped all the druids, and you have been introduced to their Council. Now you can harvest a blossom of the Griffinclaw plant, which grows inside a great tree.",
					},
				},
				[Storage.WayOfTheDruid.DeerSeason] = {
					name = "Deer Season",
					states = {
						[1] = "Radaghast asked you to burn down the hunters' stock of wood. This should prove to help a lot of animals to survive during the hunting season.",
						[2] = "You managed to burn down the stock of wood in the hunters' village. Make haste and tell about this to Radaghast.",
						[3] = "Radaghast handed you a slingshot for your help, also he erranded you to help other druids from the council he told you about.",
					},
				},
				[Storage.WayOfTheDruid.TakenBenek] = {
					name = "Taken: Benek",
					states = {
						[1] = "Estep is Wailing since orcs taken his Wolf companion.",
						[2] = "The wolf has been freed, deliver a good message to Estep.",
						[3] = "Estep handed over this knife in his gratitude.",
					},
				},
				[Storage.WayOfTheDruid.RudeEviction] = {
					name = "Rude eviction",
					states = {
						[1] = "SandNigger asked you to help him reclaim his secret spell.",
						[2] = "You managed to find and combust the spell, come back to Sandnigger.",
						[3] = "For your kind deed, you have been granted The Lion Amulet.",
					},
				},
				[Storage.WayOfTheDruid.SecretIngredient] = {
					name = "The secret ingredient",
					states = {
						[1] = "Mundral asked you to get the medicine for his sick pet. You can ask Ornuld for it.",
						[2] = "Turn out that Mundral belongs to the Druid Council. He put in a good word to his druid friends and he gifted you with bamboo leaves.",
					},
				},
				[Storage.WayOfTheDruid.OrnuldMedicine] = {
					name = "The Ornuld's medicine",
					states = {
						[1] = "Ornuld wishes to have a one wyrm egg. If you manage to do this favor, he will reward you with the medicine.",
						[2] = "You found the wyrm's egg, hand it to Ornuld.",
						[3] = "Ornuld gave you the medicine in exchange for the wyrm's egg.",
					},
				},
				[Storage.WayOfTheDruid.SingingCrystal] = {
					name = "The Singing Crystal",
					states = {
						[1] = "Malfurion is in need of an ice crystal fragment for his experiment.",
						[2] = "You managed to gather a bunch of crystal, go back to Malfurion.",
						[3] = "For your help, Malfurion gave you a gift.",
					},
				},
			},
		}
	end)
	:Mission(PH_MISSION)
	:STATE(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))
