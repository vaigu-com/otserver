local quest = Quest(LOCALIZERS)

quest
	:Storage(function()
		Storage.Firestarter = {
			Mission01 = 11009,
			Mission02 = 11010,
			Mission03 = 11011,
			Firebug = 11012
			-- 11012-11016 kwiatki
		}
	end)
	:Constant(function() end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Firestarter",
			missions = {
				[Storage.Firestarter.Mission01] = {
					name = "Mission 1: Fiery Beginnings",
					states = {
						[1] = "Hymel asked you to burn down the herbs he left on his house on north side of MikroTown.",
						[2] = "You burnt the herbs, now talk again with Hymel.",
						[3] = "Hymel gave you an incendiary firebug. From now on you can buy more firebugs from him.",
					},
				},
				[Storage.Firestarter.Mission02] = {
					name = "Mission 2: Little Treat",
					states = {
						[1] = "Hymel want to mischief the local guards, by setting an old tree on fire. You can find it near their resting camp.",
						[2] = "You did it, the guards didn't even notice, go back and see Hymel.",
						[3] = "In return for your help, Hymel gave you the staff of a real reefer.",
					},
				},
				[Storage.Firestarter.Mission03] = {
					name = "Mission 3: How High",
					states = {
						[1] = "Hymel told you about how he and his mates once sowed 5 mysterious herbs all around MirkoTown. Unfortunately he doesn't remember where exactly they did sow them. They look like usual red flowers. Find them and set them ablaze with firebug.",
						[2] = "The smell of weed is now around the whole city, you managed to burn all the flowers.",
						[3] = "Hymel declared you a true pyromaniac and gave you his arsonist weapon.",
					},
				},
			},
		}
	end)
	:Mission(Storage.Firestarter.Mission01)
	:State(
		QUEST_NOT_STARTED,
		QuestFactory.Dialog("Hymel", {
			[{ GREET }] = {
				text = "Yo, |PLAYERNAME|! You want to {smoke} some?",
			},
			[{ "zajrac", "smoke", "mission", "misja" }] = {
				text = "Ohh Yes, I would burn something, maybe those rats from Mirkotown? They evicted me for my pyrotechnic tendencies. ...\nWanna set somethin' on fire?",
			},
			[{ "yes", "tak" }] = {
				text = "If you want to play a little bit, go and burn some weed which I left in my house. Better for me if guards won't find it otherwise I'll have to run away. ...\n\nI can't show myself in the city, my cottage is located in the north of the city, you will recognize it immediately. ...\n\nHave this {fire bug}, you'll need it.",
				nextState = {
					[Storage.ArielsFriend.HumbleRequest] = QuestState.ArielsFriend.HumbleRequest.BurnWeedInHouse,
				},
				rewards = {
					{ id = 5467, aid = Storage.Firestarter.Firebug},
				},
			},
		})
	)
	:State(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))
	:State(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))
	:Mission(Storage.ArielsFriend.HumbleRequest)
	:State(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))
	:State(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))
	:Mission(Storage.ArielsFriend.HumbleRequest)
	:State(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))
	:State(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))
	:State(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))
