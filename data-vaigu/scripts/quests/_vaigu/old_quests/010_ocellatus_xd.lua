local quest = Quest(LOCALIZERS)

quest
	:Storage(function()
		Storage.OcellatusXD = { Tickets = 11041 }
	end)
	:Constant(function() end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Ocellatus Xddd",
			missions = {
				[Storage.OcellatusXD] = {
					name = "Tickets",
					states = {
						[1] = "Recover the match tickets whose have been stolen from Ocellatus.",
						[2] = "You found the Tickets in a bandits tent.",
						[3] = "You gave tickets back to Ocellatus.",
						[4] = "Ocellatus asks you to bring him specific food. Ask Pewter for help.",
						[5] = "U brang food to Ocellatus. In his gratitude, he gave you outfit and let you sail his boat.",
					},
				},
			},
		}
	end)
	:Mission(PH_MISSION)
	:STATE(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))
