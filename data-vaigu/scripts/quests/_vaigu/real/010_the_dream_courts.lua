local quest = Quest(LOCALIZERS)

quest
	:Storage(function() end)
	:Constant(function() end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "The Dream Courts",
			missions = {
				[Storage.TheDreamCourts.QuestLine] = {
					name = "The Dream Courts",
					description = "Find and talk to Vanys in order to help him. He stays in Summer Court in the huge forest located far south from Mirko Town.",
					states = {
						[1] = "Vanys gave you a dream talisman that you'll need to empower eight ward stones located around the world. Ward stone locations you were told about are: mountains of Pirate Island, bonebast coast in the desert, water elemental cave beneath Kongo, depths of Seacrest Serpent lair, west coast of Sybir and Barbarian camp, Nightmare Island, Buried Cathedral beneath Karaiby.",
						[2] = "Vanys let you enter the dream labyrinth. Find a way to enter the Nightmare Beast's lair and defeat him. Elven Parchment from Vanys chest may help you.",
						[3] = "You have defeated The Nightmare Beast. Talk about this to Vanys.",
						[4] = "Vanys gifted you with a traditional dream warrior outfit.",
					},
				},
				[Storage.TheDreamCourts.StrickenMission] = {
					name = "Helping of Stricken Soul",
					description = "Restore connection and open this nexus to access the buried cathedral. You need to find a way to pass the entrance in the cellar.",
					states = {
						[1] = "You successfully passed the cellar entrance. Find a way to restore the portal to the buried cathedral.",
						[2] = "You restored a portal and successfully entered the buried cathedral. Try to find and defeat the Faceless Bane. You'll need to gain some knowledge in order to enter her nest. Maybe there are some documents around...",
						[3] = "You successfully defeated the Faceless Bane.",
					},
				},
				[Storage.TheDreamCourts.WardStones.WardStones] = {
					name = "Empowered Wardstones",
					description = "Empowered Wardstones",
				},
				[Storage.TheDreamCourts.CathedralWords.CathedralWords] = {
					name = "Documents Read",
					description = "Documents Read",
				},
			},
		}
	end)
	:Mission(PH_MISSION)
	:STATE(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))
