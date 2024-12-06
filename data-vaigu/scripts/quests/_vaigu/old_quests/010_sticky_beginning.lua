local quest = Quest(LOCALIZERS)

quest
	:Storage(function()
		Storage.StickyBeginning = {
			Discernment = 11019,
			TrollskyAsked = 11020,
			FstabAsked = 11021,
			LebesgueAsked = 11022,
			PostmanAsked = 11023,
			MadameAsked = 11024,
			WalmartAsked = 11025,
			KomorAsked = 11026,
			DiggerAsked = 11027,
			JackAsked = 11028,
			GypsyAsked = 11029,

			WoodDelivery = 11030,
			NarroStages = 11031,
			RewardState = 11032,
		}
	end)
	:Constant(function() end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Sticky Beginning",
			missions = {
				[Storage.StickyBeginning.Discernment] = {
					name = "Discernment",
					states = {
						[1] = "Find Commissioner Fisher and ask for a mission.",
						[2] = "Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 0/10.",
						[3] = "Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 1/10.",
						[4] = "Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 2/10.",
						[5] = "Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 3/10.",
						[6] = "Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 4/10.",
						[7] = "Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 5/10.",
						[8] = "Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 6/10.",
						[9] = "Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 7/10.",
						[10] = "Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 8/10.",
						[11] = "Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 9/10.",
						[12] = "Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 10/10.",
					},
				},
				[Storage.StickyBeginning.WoodDelivery] = {
					name = "Wood Delivery",
					states = {
						[1] = "Go to Knurowo's port and find out what happened to the wood delivery.",
						[2] = "Woody is sure that the wood was shipped on a caravan leaving Knurowo. He asked you to investigate this.",
						[3] = "Tell Ryba that Waski and his mafia stole all of the wood delivery.",
						[4] = "Commissioner Fisher ordered you to recover the stolen wood, but he also warned you about the Waski's mafia.",
						[5] = "Waski gave up, and he is going to let Officer Ryba take the wood back. Report back to Ryba.",
						[6] = "Your merits earned you a special reward. Officer Ryba sent you to Trollsky, where you can receive your reward.",
					},
				},
			},
		}
	end)
	:Mission(PH_MISSION)
	:STATE(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))
