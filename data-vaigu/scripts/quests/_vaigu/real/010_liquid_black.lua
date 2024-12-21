--dialogs are in old system
local quest = Quest(LOCALIZERS.LiquidBlack)

quest
	:Storage(function()
		Storage.LiquidBlack = {
			Visitor = NextStorage(),
		}
		QuestState.LiquidBlack = {
			FindUseForCoordinates = 1,
			TalkToMezamir = 2,
			MezamirLetYouUseShortcut = 3,
		}
	end)
	:Constant(function() end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Liquid Black",
			missions = {
				[Storage.LiquidBlack.Visitor] = {
					name = "Visitor",
					states = {
						[2] = "You have found notes and coordinates. Try to find out what they are for.",
						[3] = "You got teleported to Mezamir by a strange teleporter. Ask him about this machine.",
						[4] = "Mezamir let you dive into the place he tried to discover years ago. Find a large staircase heading underwater on Pirate Island and find out what's below.",
						[MISSION_FINISHED] = "You have found a shortcut to the deeplings' underwater base.",
					},
				},
			},
		}
	end)
	:Mission(PH_MISSION)
	:Register()
