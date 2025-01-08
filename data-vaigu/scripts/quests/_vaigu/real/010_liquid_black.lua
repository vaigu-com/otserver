--dialogs are in old system
local quest = Quest(LOCALIZERS.LiquidBlack)

quest
	:Storage(function()
		Storage.LiquidBlack = {
			Visitor = {},
		}
		QuestState.LiquidBlack = {
			FindUseForCoordinates = 1,
			TalkToMezamir = 2,
			MezamirLetYouUseShortcut = 3,
		}
	end)
	:Constant(function() end)
	:Questlog(function()
		table.insert(Quests, {
			name = "Liquid Black",
			missions = {
				{
					name = "Visitor",
					storage = Storage.LiquidBlack.Visitor,
					states = {
						[QuestState.LiquidBlack.FindUseForCoordinates] = "You have found notes and coordinates. Try to find out what they are for.", --3af check if using chest put you in this state
						[QuestState.LiquidBlack.TalkToMezamir] = "You got teleported to Mezamir by a strange teleporter. Ask him about this machine.",
						[QuestState.LiquidBlack.MezamirLetYouUseShortcut] = "Mezamir let you dive into the place he tried to discover years ago. Find a large staircase heading underwater on Pirate Island and find out what's below.",
						[MISSION_FINISHED] = "You have found a shortcut to the deeplings' underwater base.",
					},
				},
			},
		})
	end)
	:Register()
