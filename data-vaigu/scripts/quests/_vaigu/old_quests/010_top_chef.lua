local quest = Quest(LOCALIZERS)

quest
	:Storage(function()
		Storage.TopChef = {
			State = NextStorage(),
			CanMakeAllDishes = NextStorage(),
		}
	end)
	:Constant(function() end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Top Chef",
			missions = {
				[Storage.TopChef.State] = {
					name = "Top Chef",
					description = "TOP_CHEF_MISSION_DESCRIPTION",
				},
			},
		}
	end)
	:Mission(PH_MISSION)
	:STATE(PH_STATE, QuestFactory.Dialog("PH_NAME", {}))
