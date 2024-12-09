local quest = Quest(LOCALIZERS)

quest
	:Storage(function()
		Storage.IKEAForTheBold = {
			Mission01 = 11073,
			Mission02 = 11073,
			AnonsFatherAsked = 11073,
			MilesAsked = 11082,
		}
	end)
	:Constant(function() end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "IKEA for the BOLD",
			missions = {
				[Storage.LocalSupport.IKEAForTheBold.Mission01] = {
					name = "The Stocktaking",
					states = {
						[1] = "Commissioner Fisher has mentioned that Komor needs help.",
						[2] = "Komor needs help dealing with the disappearing furniture from his warehouse.",
						[3] = "Komor let you ask Gypsy if he knows anything about the theft of the furniture.",
						[4] = "Try to find the thief; he's possibly hiding in the sewers.",
						[5] = "You found the thief, but he managed to get away. Try to look around his hideout.",
						[6] = "You found a list of stolen items; the thief has apparently stolen more than just furniture. Go to Komor and give him the list.",
						[7] = "You helped Komor and got rewarded for that. You have started the new mission 'Needle in a Haystack'.",
					},
				},
				[Storage.LocalSupport.IKEAForTheBold.Mission02] = {
					name = "Needle in a Haystack",
					states = {
						[1] = "You helped Komor find his stolen furniture. Get your reward from the floor above if you haven't already. Visit Komor again to find out what he found on the list.",
						[2] = "Komor asked you to consult Commissioner Fisher about the thief.",
						[3] = "Fish asked you to track down the thief. Perhaps someone from nearby saw where he ran away?",
						[4] = "Find the bandit camp and see if they have anything to do with it.",
						[5] = "Ask the bandit leader about the furniture thief.",
						[6] = "Everything indicates that the thief is trying to smuggle items and hide in the steppes. The bandit leader suggested where you should go now.",
						[7] = "You have defeated the Lumberjack Domino, look around his hiding place.",
						[8] = "From now on, you can use his boat. Report to Commissioner Fisher.",
						[9] = "You finished the plot of Lumberjack Domino, from now on you can sail his boat from the bandit camp to the south of the steppes.",
					},
				},
			},
		}
	end)
	:Mission(PH_MISSION)
	:State(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))
